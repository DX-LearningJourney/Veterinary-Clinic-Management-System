Chào bạn, dưới góc độ là một giảng viên môn **Requirement Analysis & Design (RAD) / Software Engineering**, tôi phân tích và định hướng cho bạn về mặt kiến trúc hệ thống (System Architecture Evolution) qua 3 câu hỏi của bạn như sau:

---

### 1. Có Tái Sử Dụng Được File [`docs/database/schema.sql`](file:///e:/RAD_Final/docs/database/schema.sql) Không?

> **CÂU TRẢ LỜI: TÁI SỬ DỤNG ĐƯỢC 100% (Hoàn toàn nguyên vẹn, không cần sửa đổi dù chỉ 1 dòng).**

#### 💡 Cơ sở lý thuyết & thực tiễn:
- **Nguyên lý Tách biệt Quan tâm (Separation of Concerns - SoC):** Trong kiến trúc phần mềm chuẩn (N-Tier Architecture), tầng **Persistence Layer (RDBMS)** hoàn toàn độc lập với tầng **Presentation Layer (Web UI)**.
- Toàn bộ 23 bảng đã được chúng ta thiết kế chuẩn hóa (3NF), khóa ngoại (`FOREIGN KEY`), chỉ mục (`INDEX`), ràng buộc toàn vẹn (`CONSTRAINTS`) và lưu đồ quan hệ chặt chẽ.
- Cho dù Frontend của bạn chạy bằng **Thymeleaf**, chuyển sang **Next.js**, **React SPA**, hay làm thêm **Mobile App (Flutter / React Native)**, thì cấu trúc bảng, kiểu dữ liệu, quan hệ 1-N, N-N của `vetcare_db` trong `schema.sql` vẫn là **Single Source of Truth** về dữ liệu của doanh nghiệp.

---

### 2. Đánh Giá Lựa Chọn Next.js vs. Tech Stack Khác Để Tái Sử Dụng Code Java Hiện Tại

Hiện tại, mã nguồn Java của chúng ta trong `src/vetcare-api/` được viết theo kiến trúc phân tầng chuẩn (**Layered Architecture**):
$$\text{Controller} \longrightarrow \text{Service} \longrightarrow \text{Repository} \longrightarrow \text{JPA Entity (Model)}$$

#### 🔄 Mức độ tái sử dụng mã nguồn Java:
Nếu tách Frontend ra làm riêng, bạn tái sử dụng được **khoảng 85% – 90% toàn bộ code Java**:
- **Tái sử dụng 100%:** Toàn bộ 22 Entity (`User`, `Pet`, `Appointment`, `MedicalRecord`...), 9 Enums, 17 Repositories, và toàn bộ 6 Services xử lý nghiệp vụ phức tạp (kiểm tra trùng lịch, tính tiền, trừ kho, vắc-xin).
- **Chỉ cần thay đổi 10% – 15%:** 
  1. Thay các `@Controller` (trả về file HTML Thymeleaf) bằng `@RestController` (trả về JSON dạng `ResponseEntity<ApiResponse<T>>`).
  2. Cấu hình Spring Security chuyển từ session cookie truyền thống sang **Stateless JWT Authentication** hoặc HttpOnly Cookie.
  3. Bật cấu hình `CorsFilter` để cho phép domain của Next.js gọi vào.

#### ⚖️ Bảng So Sánh Lựa Chọn Frontend Stack:

| Tiêu Chí | Phương Án A: **Next.js (App Router)** | Phương Án B: **Vite + React (SPA thuần)** |
|---|---|---|
| **Độ phù hợp bài toán** | ⭐ **Rất cao (Khuyên dùng)** | ⭐ **Khá cao** |
| **SEO & Marketing** | **Cực mạnh** (Server-Side Rendering - SSR), rất cần cho trang giới thiệu phòng khám, bảng giá dịch vụ, tra cứu thông tin bệnh lý của thú cưng. | Kém (Client-Side Rendering), chỉ tải về file index.html trống. |
| **Khả năng tái sử dụng Java** | Cao (Next.js gọi REST API sang Spring Boot). | Cao (React gọi REST API sang Spring Boot). |
| **Tốc độ tải trang & UX** | Mượt mà với Server Components & Streaming. | Tốt sau khi bundle JS ban đầu đã tải xong. |
| **Độ phức tạp hạ tầng** | Cần môi trường chạy Node.js (Vercel, Docker). | Rất nhẹ, chỉ cần Nginx hoặc Cloudflare Pages host file tĩnh. |

> 🎯 **Lời khuyên của Giảng viên:** 
> - **Lựa chọn Next.js là hoàn toàn chính xác và hiện đại.** 
> - Mô hình chuẩn nhất là: **Next.js đóng vai trò Frontend Client** $\longleftrightarrow$ **Spring Boot đóng vai trò Core Business REST API**. Tuyệt đối **không nên** dùng tính năng Route Handlers của Next.js để viết code logic nghiệp vụ hay kết nối DB trực tiếp, vì sẽ làm lãng phí toàn bộ nền tảng Java vững chắc mà bạn đã xây dựng.

---

### 3. Tổ Chức Thư Mục Dự Án (Folder Organization) Khi Mở Rộng Next.js

Để quản lý dự án khoa học và dễ bàn giao, bạn nên chuyển sang mô hình **Monorepo** (Backend và Frontend nằm chung trong một repository gốc, chia thành các workspace rõ ràng):

```
e:\RAD_Final\
│
├── .agent/                             # Tài liệu phân tích nghiệp vụ RAD (Giữ nguyên)
│   └── workflow/
├── docs/                               # Hồ sơ thiết kế, ERD, Report (Giữ nguyên)
│   ├── database/
│   │   ├── 04_database_design.md
│   │   └── schema.sql                  # --> TÁI SỬ DỤNG 100%
│   └── uml/
├── demo/                               # Dữ liệu mẫu kiểm thử
│   └── sample-data.sql
├── figma/                              # Thiết kế UI/UX Prototype
│   └── figma-prompt.md                 # --> Dùng trực tiếp làm đặc tả cho Next.js
│
│
├── backend/                            # [ĐỔI TÊN TỪ src/vetcare-api]
│   ├── pom.xml
│   └── src/main/java/com/vetcare/
│       ├── api/                        # <-- CÁC @RestController MỚI (TRẢ JSON)
│       │   ├── AuthApiController.java
│       │   ├── PetApiController.java
│       │   ├── AppointmentApiController.java
│       │   ├── MedicalRecordApiController.java
│       │   ├── InvoiceApiController.java
│       │   ├── ServiceCatalogApiController.java
│       │   └── InventoryApiController.java
│       ├── config/
│       │   ├── SecurityConfig.java     # Cấu hình JWT & Stateless Session
│       │   └── CorsConfig.java         # Cho phép http://localhost:3000
│       ├── dto/                        # Request / Response DTO classes
│       ├── model/                      # 22 JPA Entities (TÁI SỬ DỤNG 100%)
│       ├── repository/                 # 17 JPA Repositories (TÁI SỬ DỤNG 100%)
│       └── service/                    # Business Logic Services (TÁI SỬ DỤNG 100%)
│
│
└── frontend/                           # [THƯ MỤC DỰ ÁN NEXT.JS MỚI]
    ├── package.json                    # Next.js 14/15, TailwindCSS, Lucide-react
    ├── tsconfig.json
    ├── next.config.mjs
    ├── tailwind.config.ts
    └── src/
        ├── app/                        # App Router tổ chức theo 4 User Roles
        │   ├── (public)/               # Layout công khai (SEO, Trang chủ, Dịch vụ)
        │   │   ├── page.tsx            # Landing page giới thiệu phòng khám
        │   │   └── services/page.tsx   # Xem bảng giá dịch vụ (Module J)
        │   │
        │   ├── (auth)/                 # Cổng xác thực
        │   │   └── login/page.tsx      # Khớp SCR-001 trong figma-prompt.md
        │   │
        │   ├── (portal-owner)/         # Cổng Khách hàng / Pet Owner
        │   │   ├── layout.tsx
        │   │   ├── dashboard/page.tsx  # Khớp SCR-101
        │   │   ├── my-pets/page.tsx    # Khớp SCR-102 & SCR-103
        │   │   └── booking/page.tsx    # Khớp SCR-105 (Wizard 3 bước)
        │   │
        │   └── (portal-staff)/         # Cổng Nhân viên & Bác sĩ & Admin
        │       ├── layout.tsx          # Sidebar layout
        │       ├── appointments/       # Khớp SCR-202 (Lễ tân)
        │       ├── check-in/           # Khớp SCR-204 (Tiếp nhận)
        │       ├── clinical/           # Khớp SCR-302 (Form SOAP Bác sĩ)
        │       ├── inventory/          # Khớp SCR-404 (Module K)
        │       ├── schedules/          # Khớp SCR-406 (Module I)
        │       └── billing/            # Khớp SCR-206 (Xuất hóa đơn)
        │
        ├── components/                 # Component UI tái sử dụng (Khớp Part F của Figma)
        │   ├── ui/                     # Button, Input, Modal, Badge, Toast...
        │   ├── forms/                  # SoapForm, BookingWizard, StockInModal...
        │   └── cards/                  # PetCard, AppointmentCard...
        │
        ├── lib/
        │   ├── api-client.ts           # Axios / Fetch wrapper gọi sang http://localhost:8080/api
        │   └── auth.ts                 # Quản lý Token / Cookie phiên làm việc
        │
        └── types/                      # TypeScript definitions (mapping từ Java DTOs)
            ├── pet.ts
            ├── appointment.ts
            ├── medical-record.ts
            └── invoice.ts
```

### 🚀 Sơ Đồ Kiến Trúc Luồng Hoạt Động (Architecture Flow)

```
[ Người Dùng / Trình Duyệt ]
            │
            ▼
┌───────────────────────────────┐
│     Next.js (Port 3000)       │
│  - App Router / React Server  │
│  - UI Render theo Figma Spec  │
└──────────────┬────────────────┘
               │  REST API Calls (JSON via Axios/Fetch)
               ▼
┌───────────────────────────────┐
│   Spring Boot (Port 8080)     │
│  - @RestController            │
│  - Service Layer (Nghiệp vụ)  │
│  - JPA Hibernate Repositories │
└──────────────┬────────────────┘
               │  SQL Driver (TCP 3306)
               ▼
┌───────────────────────────────┐
│    MySQL 8.x (vetcare_db)     │
│  - 23 Tables trong schema.sql │
└───────────────────────────────┘
```

Mô hình này giúp đồ án của bạn đạt chuẩn kiến trúc doanh nghiệp hiện đại: **Backend Java mạnh mẽ, an toàn, quản lý transaction tốt** kết hợp với **Frontend Next.js thời thượng, tương tác mượt mà và tối ưu SEO**.