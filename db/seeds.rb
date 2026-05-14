puts "Cleaning up database..."
QuizSubmission.delete_all
Enrollment.with_deleted.delete_all
Quiz.with_deleted.delete_all
Lesson.with_deleted.delete_all
Course.with_deleted.delete_all
Profile.with_deleted.delete_all
Role.delete_all
User.with_deleted.delete_all

puts "Creating Admin..."
admin = User.create!(email: "admin@example.com", password: "password123", password_confirmation: "password123", name: "Somchai Admin", role: "admin")
admin.add_role :admin
admin.create_profile!(bio: "ผู้ดูแลระบบสูงสุด จัดการบัญชีผู้ใช้และการเข้าถึงระบบทั้งหมด")

puts "Creating Instructor..."
teacher = User.create!(email: "teacher@example.com", password: "password123", password_confirmation: "password123", name: "Ajarn Somsri", role: "instructor")
teacher.add_role :instructor
teacher.create_profile!(bio: "เชี่ยวชาญด้าน Software Engineering เเละ Web Development ประสบการณ์สอน 10 ปี")

puts "Creating Student..."
student = User.create!(email: "student@example.com", password: "password123", password_confirmation: "password123", name: "Nong Nat", role: "student")
student.add_role :student
student.create_profile!(bio: "นักเรียนสาย IT ที่มีความกระตือรือร้นและตั้งใจเรียน")

student2 = User.create!(email: "student2@example.com", password: "password123", password_confirmation: "password123", name: "Nong Ploy", role: "student")
student2.add_role :student
student2.create_profile!(bio: "สนใจทางด้าน Frontend Development")

puts "Creating Courses..."
course1 = Course.create!(
  title: "Ruby on Rails Bootcamp 2026",
  description: "คอร์สเรียนตั้งแต่เริ่มต้นจนถึงระดับสูงของการพัฒนา Web Application ด้วย Ruby on Rails พร้อม Workshop สร้างแอปพลิเคชันจริงเต็มรูปแบบ ครอบคลุม MVC, ActiveRecord, และ RESTful Routing",
  user: teacher
)

course2 = Course.create!(
  title: "Frontend Mastery with Tailwind CSS",
  description: "เรียนรู้การตกแต่งหน้าเว็บให้สวยงามด้วย Tailwind CSS แบบ Utility-first เจาะลึกการจัด Layout, Responsive Design, และการสร้าง Component ที่นำกลับมาใช้ใหม่ได้",
  user: teacher
)

puts "Creating Lessons..."
# Course 1 Lessons
c1_l1 = course1.lessons.create!(
  title: "Introduction to MVC Architecture",
  description: "ทำความเข้าใจโมเดล MVC (Model-View-Controller) ที่ Rails ใช้เป็นแกนหลัก เรียนรู้วิธีการทำงานร่วมกันระหว่างทั้งสามส่วนเพื่อให้แอปพลิเคชันทำงานได้"
)
c1_l2 = course1.lessons.create!(
  title: "ActiveRecord & Database Migrations",
  description: "การจัดการฐานข้อมูลเบื้องต้น การเขียน Migrations เพื่อสร้างตาราง และการใช้ ActiveRecord Query Interface เพื่อดึงข้อมูล"
)

# Course 2 Lessons
c2_l1 = course2.lessons.create!(
  title: "Utility Classes vs Semantic CSS",
  description: "เปรียบเทียบข้อดีและข้อเสียของการเขียน CSS ทั้งสองแบบ เพื่อให้เห็นภาพว่าทำไม Tailwind CSS ถึงเป็นที่นิยม"
)

puts "Creating Quizzes..."
q1 = c1_l1.quizzes.create!(question: "MVC ย่อมาจากคำว่าอะไร? และหน้าที่ของแต่ละส่วนคืออะไรแบบสั้นๆ")
q2 = c1_l1.quizzes.create!(question: "ไฟล์เส้นทาง (Routes) ในเฟรมเวิร์ก Ruby on Rails ถูกเก็บไว้ในโฟลเดอร์หรือไฟล์ใด?")
c2_l1.quizzes.create!(question: "อธิบายข้อดีของการใช้ Utility-First CSS แบบสั้นๆ มาอย่างน้อย 3 ข้อ")

puts "Creating Enrollments..."
Enrollment.create!(user: student, course: course1)
Enrollment.create!(user: student, course: course2)
Enrollment.create!(user: student2, course: course1)

puts "Creating Submissions..."
QuizSubmission.create!(user: student, quiz: q1, answer: "Model (คุมข้อมูล), View (คุมหน้าตา), Controller (คุมลอจิกรับส่งคำสั่ง)")

puts "Seed Data loaded successfully! ✅"
