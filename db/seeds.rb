# สร้าง User ที่เป็น Instructor
instructor = User.find_or_create_by!(email: 'teacher@example.com') do |u|
  u.password = 'password'
  u.role = 'instructor'
end
instructor.profile || instructor.create_profile(bio: 'เชี่ยวชาญด้าน Ruby on Rails')

# สร้าง Course
course = Course.find_or_create_by!(title: 'Basic RoR') do |c|
  c.description = 'เรียนรู้พื้นฐาน'
  c.user = instructor
end

# สร้าง Lesson ให้ Course นั้น
lesson = course.lessons.find_or_create_by!(title: 'Introduction to MVC')

# สร้าง Quiz ให้ Lesson
lesson.quizzes.find_or_create_by!(question: 'MVC ย่อมาจากอะไร?')
