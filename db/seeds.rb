# สร้าง User ที่เป็น Instructor
instructor = User.create!(email: 'teacher@example.com', password: 'password', role: 'instructor')
instructor.create_instructor_profile(bio: 'เชี่ยวชาญด้าน Ruby on Rails')

# สร้าง Course
course = Course.create!(title: 'Basic RoR', description: 'เรียนรู้พื้นฐาน', user: instructor)

# สร้าง Lesson ให้ Course นั้น
lesson = course.lessons.create!(title: 'Introduction to MVC')

# สร้าง Quiz ให้ Lesson
lesson.quizzes.create!(question: 'MVC ย่อมาจากอะไร?')
