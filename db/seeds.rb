# =============================================================
# seeds.rb — Online Course Platform Demo Data
# =============================================================

puts "🧹 Cleaning up database..."
QuizSubmission.delete_all
Enrollment.with_deleted.delete_all
Quiz.with_deleted.delete_all
Lesson.with_deleted.delete_all
Course.with_deleted.delete_all
Profile.with_deleted.delete_all
Role.delete_all
User.with_deleted.delete_all

# =============================================================
# USERS — Admin
# =============================================================
puts "👑 Creating Admin..."
admin = User.create!(
  email: "admin@example.com",
  password: "password123",
  password_confirmation: "password123",
  name: "Somchai Admin",
  role: "admin"
)
admin.add_role :admin
admin.create_profile!(bio: "ผู้ดูแลระบบสูงสุด จัดการบัญชีผู้ใช้และการเข้าถึงระบบทั้งหมด")

# =============================================================
# USERS — Instructors
# =============================================================
puts "👨‍🏫 Creating Instructors..."
teacher1 = User.create!(
  email: "teacher@example.com",
  password: "password123",
  password_confirmation: "password123",
  name: "Ajarn Somsri",
  role: "instructor"
)
teacher1.add_role :instructor
teacher1.create_profile!(bio: "เชี่ยวชาญด้าน Software Engineering และ Web Development ประสบการณ์สอน 10 ปี")

teacher2 = User.create!(
  email: "teacher2@example.com",
  password: "password123",
  password_confirmation: "password123",
  name: "Ajarn Wanchai",
  role: "instructor"
)
teacher2.add_role :instructor
teacher2.create_profile!(bio: "ผู้เชี่ยวชาญด้าน Data Science และ Machine Learning มีประสบการณ์ในอุตสาหกรรมกว่า 8 ปี")

# =============================================================
# USERS — Students
# =============================================================
puts "🎓 Creating Students..."
students_data = [
  { email: "student@example.com",  name: "Nong Nat",   bio: "นักเรียนสาย IT ที่มีความกระตือรือร้นและตั้งใจเรียน" },
  { email: "student2@example.com", name: "Nong Ploy",  bio: "สนใจทางด้าน Frontend Development" },
  { email: "student3@example.com", name: "Nong Beam",  bio: "มุ่งมั่นพัฒนาทักษะ Backend กับ Ruby on Rails" },
  { email: "student4@example.com", name: "Nong May",   bio: "ชอบวิเคราะห์ข้อมูล อยากเป็น Data Analyst" },
  { email: "student5@example.com", name: "Nong Tarn",  bio: "สนใจ UI/UX Design และ Tailwind CSS" },
  { email: "student6@example.com", name: "Nong Pete",  bio: "กำลังเรียนรู้ Full-stack Development" }
]

students = students_data.map do |s|
  u = User.create!(
    email: s[:email],
    password: "password123",
    password_confirmation: "password123",
    name: s[:name],
    role: "student"
  )
  u.add_role :student
  u.create_profile!(bio: s[:bio])
  u
end

# =============================================================
# COURSES
# =============================================================
puts "📚 Creating Courses..."

course1 = Course.create!(
  title: "Ruby on Rails Bootcamp 2026",
  description: "คอร์สเรียนตั้งแต่เริ่มต้นจนถึงระดับสูงของการพัฒนา Web Application ด้วย Ruby on Rails พร้อม Workshop สร้างแอปพลิเคชันจริงเต็มรูปแบบ ครอบคลุม MVC, ActiveRecord, และ RESTful Routing",
  user: teacher1
)

course2 = Course.create!(
  title: "Frontend Mastery with Tailwind CSS",
  description: "เรียนรู้การตกแต่งหน้าเว็บให้สวยงามด้วย Tailwind CSS แบบ Utility-first เจาะลึกการจัด Layout, Responsive Design, และการสร้าง Component ที่นำกลับมาใช้ใหม่ได้",
  user: teacher1
)

course3 = Course.create!(
  title: "Python for Data Science",
  description: "เรียนรู้ภาษา Python สำหรับการวิเคราะห์ข้อมูล ครอบคลุม NumPy, Pandas, Matplotlib และการสร้างโมเดล Machine Learning เบื้องต้น เหมาะสำหรับผู้เริ่มต้นจนถึงระดับกลาง",
  user: teacher2
)

course4 = Course.create!(
  title: "Database Design & SQL Fundamentals",
  description: "ทำความเข้าใจหลักการออกแบบฐานข้อมูลเชิงสัมพันธ์ (Relational Database) เรียนรู้คำสั่ง SQL ตั้งแต่พื้นฐาน การ JOIN ตาราง การ Normalize ข้อมูล และการออกแบบ ER Diagram",
  user: teacher1
)

course5 = Course.create!(
  title: "Git & GitHub Workflow for Teams",
  description: "เชี่ยวชาญการใช้ Git สำหรับการทำงานเป็นทีม ครอบคลุม Branching Strategy, Pull Request, Code Review, Merge Conflicts และ CI/CD Pipeline เบื้องต้น",
  user: teacher2
)

# =============================================================
# LESSONS
# =============================================================
puts "📖 Creating Lessons..."

# --- Course 1: Ruby on Rails ---
c1_lessons = [
  {
    title: "Introduction to MVC Architecture",
    description: "ทำความเข้าใจโมเดล MVC (Model-View-Controller) ที่ Rails ใช้เป็นแกนหลัก เรียนรู้วิธีการทำงานร่วมกันระหว่างทั้งสามส่วน"
  },
  {
    title: "ActiveRecord & Database Migrations",
    description: "การจัดการฐานข้อมูลเบื้องต้น การเขียน Migrations เพื่อสร้างตาราง และการใช้ ActiveRecord Query Interface"
  },
  {
    title: "RESTful Routing & Controllers",
    description: "เรียนรู้แนวคิด REST, การกำหนด routes ในไฟล์ routes.rb และการสร้าง Controller actions (CRUD) ที่ถูกต้อง"
  },
  {
    title: "Authentication with Devise",
    description: "ติดตั้งและกำหนดค่า Devise Gem เพื่อจัดการระบบ Login / Signup ลงใน Rails Application"
  },
  {
    title: "Authorization with CanCanCan",
    description: "ควบคุมสิทธิ์การเข้าถึงข้อมูลของผู้ใช้แต่ละ Role ด้วย CanCanCan Gem และ Ability Class"
  }
]

c1_lesson_records = c1_lessons.map { |l| course1.lessons.create!(l) }

# --- Course 2: Tailwind CSS ---
c2_lessons = [
  {
    title: "Utility Classes vs Semantic CSS",
    description: "เปรียบเทียบข้อดีและข้อเสียของการเขียน CSS ทั้งสองแบบ เพื่อให้เห็นภาพว่าทำไม Tailwind CSS ถึงเป็นที่นิยม"
  },
  {
    title: "Flexbox & Grid Layout with Tailwind",
    description: "ฝึกจัดวาง Layout ที่ซับซ้อนได้อย่างง่ายดายด้วย Flexbox และ CSS Grid ผ่าน Tailwind Utility Classes"
  },
  {
    title: "Responsive Design & Breakpoints",
    description: "ออกแบบเว็บให้รองรับหน้าจอทุกขนาดตั้งแต่ Mobile ไปจนถึง Desktop ด้วย Breakpoint Prefixes ของ Tailwind"
  },
  {
    title: "Dark Mode & Custom Theming",
    description: "เปิดใช้งาน Dark Mode ใน Tailwind CSS และกำหนดค่าสี, Font, และ Spacing ของโปรเจกต์ผ่าน tailwind.config.js"
  }
]

c2_lesson_records = c2_lessons.map { |l| course2.lessons.create!(l) }

# --- Course 3: Python for Data Science ---
c3_lessons = [
  {
    title: "Python Basics for Data Analysis",
    description: "ทบทวนและเรียนรู้พื้นฐาน Python ที่จำเป็นสำหรับ Data Science เช่น List, Dictionary, Loop และ Function"
  },
  {
    title: "Data Manipulation with Pandas",
    description: "ใช้ Pandas Library จัดการ DataFrame: การกรองข้อมูล, การรวม (merge/join), และการรวมกลุ่ม (groupby)"
  },
  {
    title: "Data Visualization with Matplotlib & Seaborn",
    description: "สร้างกราฟและ Chart ต่างๆ เพื่อนำเสนอข้อมูลในรูปแบบที่เข้าใจง่ายด้วย Matplotlib และ Seaborn"
  }
]

c3_lesson_records = c3_lessons.map { |l| course3.lessons.create!(l) }

# --- Course 4: Database Design ---
c4_lessons = [
  {
    title: "Relational Database Concepts",
    description: "ทำความเข้าใจแนวคิดพื้นฐานของฐานข้อมูลเชิงสัมพันธ์ เช่น Primary Key, Foreign Key, และ Relationship ประเภทต่างๆ"
  },
  {
    title: "SQL SELECT & JOIN Queries",
    description: "ฝึกเขียนคำสั่ง SELECT ขั้นสูงรวมถึง INNER JOIN, LEFT JOIN, และ Subquery เพื่อดึงข้อมูลจากหลายตาราง"
  }
]

c4_lesson_records = c4_lessons.map { |l| course4.lessons.create!(l) }

# --- Course 5: Git & GitHub ---
c5_lessons = [
  {
    title: "Git Fundamentals: Commit, Branch, Merge",
    description: "เริ่มต้นใช้งาน Git ตั้งแต่ git init, commit, การสร้าง Branch และการ Merge กลับสู่ main branch"
  },
  {
    title: "Pull Requests & Code Review",
    description: "เรียนรู้การสร้าง Pull Request บน GitHub, การรีวิวโค้ดเพื่อน และการ Resolve Merge Conflicts"
  }
]

c5_lesson_records = c5_lessons.map { |l| course5.lessons.create!(l) }

# =============================================================
# QUIZZES
# =============================================================
puts "❓ Creating Quizzes..."

# Course 1 Quizzes
quiz_data = [
  # c1_l1
  [ c1_lesson_records[0], "MVC ย่อมาจากคำว่าอะไร? และหน้าที่ของแต่ละส่วนคืออะไรแบบสั้นๆ" ],
  [ c1_lesson_records[0], "ไฟล์ routes.rb ในเฟรมเวิร์ก Rails ถูกเก็บไว้ที่ไหน และมีหน้าที่อะไร?" ],
  [ c1_lesson_records[0], "ส่วน View ใน MVC คือส่วนไหน ทำหน้าที่อะไรในแอปพลิเคชัน?" ],
  # c1_l2
  [ c1_lesson_records[1], "ActiveRecord คืออะไร? และมีประโยชน์อย่างไรในการพัฒนา Rails Application?" ],
  [ c1_lesson_records[1], "คำสั่ง rails db:migrate ทำหน้าที่อะไร? ต่างจาก rails db:schema:load อย่างไร?" ],
  [ c1_lesson_records[1], "จงเขียนตัวอย่าง Migration เพื่อสร้างตาราง users ที่มี columns: name (string), email (string), age (integer)" ],
  # c1_l3
  [ c1_lesson_records[2], "RESTful ย่อมาจากอะไร? หลักการของ REST มีอะไรบ้าง?" ],
  [ c1_lesson_records[2], "HTTP Methods ได้แก่ GET, POST, PATCH, DELETE ใช้ทำอะไรใน RESTful API?" ],
  # c1_l4
  [ c1_lesson_records[3], "Devise คืออะไร? และทำไมถึงนิยมใช้ใน Rails Application?" ],
  [ c1_lesson_records[3], "ต้องเพิ่ม Helper ใดใน Controller เพื่อบังคับให้ User Login ก่อนเข้าถึงหน้าเว็บ?" ],
  # c1_l5
  [ c1_lesson_records[4], "CanCanCan ทำงานอย่างไร? ต่างจากการเขียน if/else ตรวจสอบ Role เองอย่างไร?" ],
  [ c1_lesson_records[4], "Ability Class ใน CanCanCan ใช้ทำอะไร? ยกตัวอย่างการกำหนดสิทธิ์ให้ admin" ],
  # Course 2 Quizzes
  [ c2_lesson_records[0], "อธิบายข้อดีของการใช้ Utility-First CSS แบบสั้นๆ มาอย่างน้อย 3 ข้อ" ],
  [ c2_lesson_records[1], "จงอธิบายความแตกต่างระหว่าง flex และ grid ใน CSS พร้อมตัวอย่างการใช้งาน" ],
  [ c2_lesson_records[2], "Breakpoints หลักของ Tailwind CSS มีอะไรบ้าง? (sm, md, lg, xl, 2xl) แต่ละตัวใช้ pixel เท่าไหร่?" ],
  [ c2_lesson_records[3], "วิธีเปิด Dark Mode ใน Tailwind CSS ทำอย่างไร? ต้องแก้ไขไฟล์อะไรบ้าง?" ],
  # Course 3 Quizzes
  [ c3_lesson_records[0], "อธิบายความแตกต่างระหว่าง List และ Dictionary ใน Python พร้อมตัวอย่าง" ],
  [ c3_lesson_records[1], "Pandas DataFrame คืออะไร? และวิธีการสร้าง DataFrame จาก Dictionary ทำอย่างไร?" ],
  [ c3_lesson_records[2], "ความแตกต่างระหว่าง Matplotlib และ Seaborn คืออะไร? ควรเลือกใช้ตัวไหนในสถานการณ์ใด?" ],
  # Course 4 Quizzes
  [ c4_lesson_records[0], "Primary Key และ Foreign Key คืออะไร? และต่างกันอย่างไร?" ],
  [ c4_lesson_records[1], "อธิบายความแตกต่างระหว่าง INNER JOIN และ LEFT JOIN พร้อมตัวอย่าง" ],
  # Course 5 Quizzes
  [ c5_lesson_records[0], "git commit และ git push ต่างกันอย่างไร? แต่ละคำสั่งทำอะไร?" ],
  [ c5_lesson_records[1], "Pull Request คืออะไร? มีขั้นตอนการสร้างและ Merge อย่างไรบน GitHub?" ]
]

quizzes = quiz_data.map do |lesson, question|
  lesson.quizzes.create!(question: question)
end

# =============================================================
# ENROLLMENTS
# =============================================================
puts "📋 Creating Enrollments..."

# student[0] = Nong Nat — ลงทะเบียนคอร์ส 1, 2
Enrollment.create!(user: students[0], course: course1)
Enrollment.create!(user: students[0], course: course2)
# student[1] = Nong Ploy — ลงทะเบียนคอร์ส 1, 2
Enrollment.create!(user: students[1], course: course1)
Enrollment.create!(user: students[1], course: course2)

# student[2] = Nong Beam — ลงทะเบียนคอร์ส 1, 4
Enrollment.create!(user: students[2], course: course1)
Enrollment.create!(user: students[2], course: course4)

# student[3] = Nong May — ลงทะเบียนคอร์ส 3
Enrollment.create!(user: students[3], course: course3)
Enrollment.create!(user: students[3], course: course4)

# student[4] = Nong Tarn — ลงทะเบียนคอร์ส 2, 5
Enrollment.create!(user: students[4], course: course2)
Enrollment.create!(user: students[4], course: course5)

# student[5] = Nong Pete — ลงทะเบียนคอร์ส 1, 3, 5
Enrollment.create!(user: students[5], course: course1)
Enrollment.create!(user: students[5], course: course3)
Enrollment.create!(user: students[5], course: course5)

# =============================================================
# QUIZ SUBMISSIONS (ตัวอย่างคำตอบ)
# =============================================================
puts "✍️  Creating Quiz Submissions..."

QuizSubmission.create!(user: students[0], quiz: quizzes[0],
  answer: "M = Model ดูแลข้อมูลและ Business Logic\nV = View แสดงผล UI ให้ผู้ใช้\nC = Controller รับ Request จาก User แล้วประสาน Model กับ View")

QuizSubmission.create!(user: students[0], quiz: quizzes[1],
  answer: "ไฟล์ routes.rb อยู่ในโฟลเดอร์ config/ ใช้กำหนด URL pattern และผูกกับ Controller action")

QuizSubmission.create!(user: students[1], quiz: quizzes[0],
  answer: "MVC = Model View Controller\n- Model = จัดการข้อมูลและ Business Logic\n- View = หน้าตาเว็บไซต์\n- Controller = ตัวกลางจัดการ Request/Response")

QuizSubmission.create!(user: students[1], quiz: quizzes[12],
  answer: "1. เขียน HTML น้อยลง ไม่ต้องตั้งชื่อ Class เอง\n2. ปรับแต่ง Responsive ได้ง่ายด้วย sm: md: lg:\n3. ไม่มี CSS ซ้ำซ้อน ลดขนาดไฟล์")

QuizSubmission.create!(user: students[2], quiz: quizzes[3],
  answer: "ActiveRecord คือ ORM (Object-Relational Mapping) ของ Rails ช่วยให้เราโต้ตอบกับฐานข้อมูลผ่าน Ruby Object โดยไม่ต้องเขียน SQL เปล่าๆ")

QuizSubmission.create!(user: students[5], quiz: quizzes[21],
  answer: "git commit บันทึก snapshot ของโค้ดลง local repository\ngit push ส่ง commit ขึ้น remote repository บน GitHub")

puts ""
puts "✅ Seed Data loaded successfully!"
puts "──────────────────────────────────"
puts "  👑 Admin:       1 คน  (admin@example.com)"
puts "  👨‍🏫 Instructors: 2 คน  (teacher@/teacher2@)"
puts "  🎓 Students:    6 คน  (student~student6@)"
puts "  📚 Courses:     5 คอร์ส"
puts "  📖 Lessons:    #{Lesson.count} บทเรียน"
puts "  ❓ Quizzes:    #{Quiz.count} ข้อ"
puts "  📋 Enrollment: #{Enrollment.count} รายการ"
puts "  ✍️  Submissions: #{QuizSubmission.count} รายการ"
puts "  🔑 Password สำหรับทุก account: password123"
puts "──────────────────────────────────"
