# syntax=docker/dockerfile:1
# check=error=true

# Dockerfile นี้ถูกออกแบบมาสำหรับ production ไม่ใช่ development ใช้กับ Kamal หรือ build แล้วรันด้วยตัวเอง:
# docker build -t ocp .
# docker run -d -p 80:80 -e RAILS_MASTER_KEY=<ค่าจาก config/master.key> --name ocp ocp

# ตรวจสอบให้แน่ใจว่า RUBY_VERSION ตรงกับรุ่น Ruby ใน .ruby-version
ARG RUBY_VERSION=3.2.2
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# แอป Rails อยู่ที่โฟลเดอร์นี้
WORKDIR /rails

# ติดตั้งแพ็กเกจพื้นฐาน
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips sqlite3 && \
    ln -s /usr/lib/$(uname -m)-linux-gnu/libjemalloc.so.2 /usr/local/lib/libjemalloc.so && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# ตั้งค่าตัวแปรสภาพแวดล้อมสำหรับ production และเปิดใช้งาน jemalloc เพื่อลดการใช้หน่วยความจำและการตอบสนองที่เร็วขึ้น
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development" \
    LD_PRELOAD="/usr/local/lib/libjemalloc.so"

# ขั้นตอน build แบบใช้แล้วทิ้ง (Throw-away build stage) เพื่อลดขนาดของ image สุดท้าย
FROM base AS build

# ติดตั้งแพ็กเกจที่จำเป็นสำหรับการ build gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libvips libyaml-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# ติดตั้ง application gems
COPY vendor/* ./vendor/
COPY Gemfile Gemfile.lock ./

RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    # ปิดการทำงานแบบขนานเพื่อหลีกเลี่ยงบั๊ก QEMU
    bundle exec bootsnap precompile -j 1 --gemfile

# คัดลอกโค้ดของแอปพลิเคชัน
COPY . .

# Precompile โค้ด bootsnap เพื่อให้แอปพลิเคชันเริ่มทำงานได้เร็วขึ้น
RUN bundle exec bootsnap precompile -j 1 app/ lib/

# Precompiling assets สำหรับ production โดยไม่ต้องใช้ secret RAILS_MASTER_KEY
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# ขั้นตอนสุดท้ายสำหรับ app image
FROM base

# รันและเป็นเจ้าของไฟล์รันไทม์เท่านั้นในฐานะผู้ใช้ที่ไม่ใช่ root เพื่อความปลอดภัย
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash
USER 1000:1000

# คัดลอกไฟล์ที่สร้างเสร็จแล้ว: gems และแอปพลิเคชัน
COPY --chown=rails:rails --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --chown=rails:rails --from=build /rails /rails

# Entrypoint สำหรับเตรียมฐานข้อมูล
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# เริ่มต้นเซิร์ฟเวอร์ผ่าน Thruster เป็นค่าเริ่มต้น
EXPOSE 80
CMD ["./bin/thrust", "./bin/rails", "server"]
