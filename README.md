# Robot Framework API Test Automation (DummyJSON API)

โปรเจกต์ทดสอบ RESTful API อัตโนมัติด้วย **Robot Framework (`RequestsLibrary`)** ร่วมกับการทำ CI Pipeline บน **GitHub Actions**

## ขอบเขตการทดสอบ (Test Coverage)
- **CRUD Operations:** ทดสอบการดึงข้อมูล (`GET`), สร้างผู้ใช้งานใหม่ (`POST`), แก้ไขข้อมูล (`PUT`), และลบผู้ใช้งาน (`DELETE`)
- **Positive & Negative Scenarios:** ตรวจสอบ HTTP Status Codes (`200 OK`, `201 Created`, `400 Bad Request`, `404 Not Found`) และตรวจสอบความถูกต้องของ JSON Response Payload
- **Authentication & API Chaining:** ทดสอบการ Login เพื่อรับ `accessToken` และนำมาแนบใน `Authorization: Bearer <token>` Header เพื่อเรียกใช้งาน Protected Endpoint (`/auth/me`)
- **Modular Structure:** แยก Reusable Keywords และ Variables ไว้ในไฟล์ `.resource`

## โครงสร้างโปรเจกต์
```text
robot-framework-api-automation/
├── .github/workflows/
│   └── api-tests.yml
├── resources/
│   └── common_api.resource
├── tests/
│   └── api_test.robot
├── .gitignore
├── requirements.txt
└── README.md
