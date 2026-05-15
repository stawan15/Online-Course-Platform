# 🎓 Online Course Platform (OCP)

ระบบจัดการคอร์สเรียนออนไลน์แบบครบวงจร พัฒนาด้วย Ruby on Rails 8.1.3 

![Home Page Screen](public/screenshots/home_page.png)
<img width="1919" height="964" alt="image" src="https://github.com/user-attachments/assets/7e97774f-181c-4fa2-9f6e-b54346ef357e" />
<img width="1919" height="964" alt="image" src="https://github.com/user-attachments/assets/524eb3c0-735f-4eac-b6d9-c29db34ba4dc" />
<img width="1919" height="964" alt="image" src="https://github.com/user-attachments/assets/681ef6c7-7236-421f-bcce-73d54d15c99a" />
<img width="1919" height="964" alt="image" src="https://github.com/user-attachments/assets/662a900e-c8a1-4ae0-a9ce-71b72a582ae8" />
<img width="1919" height="964" alt="image" src="https://github.com/user-attachments/assets/2343632d-f281-46ab-81ef-14eb0dd7b864" />




## 🌟 ฟีเจอร์หลัก (Key Features)

- **ระบบจัดการคอร์สเรียน (Course Management):** สร้าง แก้ไข และจัดการเนื้อหาคอร์สเรียนได้อย่างง่ายดาย
- **บทเรียนและสื่อมัลติมีเดีย (Lessons & Media):** รองรับบทเรียนรูปเแบบวิดีโอ (YouTube integration) 
- **ระบบแบบทดสอบ (Quiz System):** ทดสอบความรู้หลังเรียนด้วยระบบ Quiz ที่บันทึกคะแนนและประวัติการสอบ
- **การจัดการบทบาทผู้ใช้ (Role-based Access Control):** 
  - **Admin:** ดูแลภาพรวมระบบและจัดการผู้ใช้
  - **Instructor:** สร้างและจัดการคอร์สเรียนของตนเอง
  - **Student:** ลงทะเบียนเรียนและทำแบบทดสอบ
- **ระบบกู้คืนข้อมูล (Soft Deletes & Restore):** ป้องกันข้อมูลสูญหายด้วยระบบ Paranoia และ PaperTrail สำหรับตรวจสอบประวัติการแก้ไข

## 🛠 เทคโนโลยีที่ใช้ (Tech Stack)

- **Backend:** Ruby on Rails 8.1.3
- **Frontend:** Tailwind CSS (Modern & Utility-first)
- **Database:** SQLite3
- **Authentication:** Devise
- **Authorization:** CanCanCan & Rolify
- **Asset Pipeline:** Propshaft & Importmap
- **Auditing:** PaperTrail & Paranoia

## 🚀 การติดตั้งและเริ่มใช้งาน (Installation & Setup)

### 1. โคลนโปรเจกต์
```bash
git clone [repository-url]
cd Online-Course-Platform
```

### 2. ติดตั้ง Dependencies
```bash
bundle install
```

### 3. เตรียมฐานข้อมูลและข้อมูลสาธิต (Seed Data)
```bash
bin/rails db:prepare db:seed
```

### 4. รันระบบในโหมด Development
```bash
bin/dev
```
ระบบจะเปิดใช้งานที่ `http://localhost:3000`

## 👤 บัญชีผู้ใช้สำหรับทดสอบ (Demo Accounts)

ทุกบัญชีใช้รหัสผ่านเดียวกันคือ: `password123`

| บทบาท (Role) | อีเมล (Email) |
| :--- | :--- |
| **Admin** | `admin@example.com` |
| **Instructor** | `teacher@example.com` |
| **Student** | `student@example.com` |

---
