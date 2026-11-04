Dưới đây là hướng dẫn chi tiết từng bước để khởi chạy dự án **VetCare Pro** trên máy của bạn (sử dụng **MySQL** và **Java Spring Boot**):

---

## 🛠️ 1. Yêu cầu môi trường (Prerequisites)

Đảm bảo máy tính đã cài đặt các công cụ sau:
1. **Java Development Kit (JDK):** Phiên bản **Java 17** trở lên.  
   *(Kiểm tra bằng lệnh: `java -version`)*
2. **Maven:** Phiên bản 3.8+ (hoặc dùng Maven tích hợp sẵn trong IntelliJ IDEA / Eclipse).  
   *(Kiểm tra bằng lệnh: `mvn -v`)*
3. **MySQL Server:** Phiên bản 8.0 trở lên (đang chạy cổng mặc định `3306`).  
   *(Có thể dùng MySQL Workbench, Navicat, DBeaver hoặc XAMPP/Laragon)*

---

## 🗄️ 2. Bước 1: Khởi tạo Cơ sở dữ liệu (MySQL)

### Cách 1: Sử dụng MySQL Command Line Client
Mở Terminal / PowerShell hoặc MySQL Command Line Client và chạy các lệnh:

```bash
# Đăng nhập MySQL (nhập mật khẩu root khi được hỏi)
mysql -u root -p
```

Trong MySQL prompt, lần lượt nạp file `schema.sql` và `sample-data.sql`:
```sql
-- 1. Tạo CSDL và toàn bộ 23 bảng
source e:/RAD_Final/docs/database/schema.sql;

-- 2. Nạp dữ liệu mẫu thực tế
source e:/RAD_Final/demo/sample-data.sql;
```

### Cách 2: Sử dụng MySQL Workbench / DBeaver / Navicat
1. Mở tool quản lý DB và kết nối vào MySQL localhost.
2. Mở file [`e:\RAD_Final\docs\database\schema.sql`](file:///e:/RAD_Final/docs/database/schema.sql) $\rightarrow$ Nhấn **Execute (Chạy toàn bộ script)** để tạo database `vetcare_db` và 23 bảng.
3. Mở tiếp file [`e:\RAD_Final\demo\sample-data.sql`](file:///e:/RAD_Final/demo/sample-data.sql) $\rightarrow$ Nhấn **Execute** để nạp tài khoản, thú cưng, lịch hẹn, bệnh án và hóa đơn mẫu.

---

## ⚙️ 3. Bước 2: Cấu hình kết nối Spring Boot

Mở file cấu hình: [`e:\RAD_Final\src\vetcare-api\src\main\resources\application.properties`](file:///e:/RAD_Final/src/vetcare-api/src/main/resources/application.properties)

Kiểm tra thông tin tài khoản MySQL của bạn:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/vetcare_db?createDatabaseIfNotExist=true&useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
# Điền đúng username và password MySQL của máy bạn:
spring.datasource.username=root
spring.datasource.password=root   <--- (Đổi thành password MySQL của máy bạn nếu khác)
```

---

## 🚀 4. Bước 3: Khởi chạy Ứng dụng Java Spring Boot

### Cách 1: Sử dụng dòng lệnh (Terminal / PowerShell)

1. Mở PowerShell hoặc Command Prompt và di chuyển vào thư mục code:
   ```powershell
   cd e:\RAD_Final\src\vetcare-api
   ```

2. Build và khởi động ứng dụng:
   ```powershell
   mvn spring-boot:run
   ```
   *(Nếu đã đóng gói ra file JAR thì chạy: `mvn clean package -DskipTests` sau đó `java -jar target/vetcare-api-0.0.1-SNAPSHOT.jar`)*

### Cách 2: Mở bằng IntelliJ IDEA / Eclipse / VS Code
1. Mở **IntelliJ IDEA** $\rightarrow$ Chọn **File > Open** $\rightarrow$ Trỏ tới thư mục `e:\RAD_Final\src\vetcare-api` (chọn file `pom.xml` $\rightarrow$ Open as Project).
2. Chờ Maven tải các thư viện (Spring Boot, Hibernate, Thymeleaf, Lombok...).
3. Tìm đến file [`VetCareApplication.java`](file:///e:/RAD_Final/src/vetcare-api/src/main/java/com/vetcare/VetCareApplication.java) (trong package `com.vetcare`).
4. Nhấn nút **Run** (biểu tượng tam giác xanh ▶️) để khởi chạy.

Khi console xuất hiện dòng:
```text
Tomcat started on port 8080 (http) with context path ''
Started VetCareApplication in X.XXX seconds
```
$\rightarrow$ **Ứng dụng đã khởi chạy thành công!** 🎉

---

## 🌐 5. Bước 4: Truy cập Web & Kịch bản Demo thực tế

Mở trình duyệt web (Chrome, Edge, Firefox) và truy cập:  
👉 **`http://localhost:8080/login`**

### 🔑 Danh sách tài khoản đăng nhập mẫu:
Tất cả tài khoản đều có mật khẩu mặc định là: **`password123`**

| Vai trò (Role) | Tên đăng nhập | Chức năng demo chính |
|---|---|---|
| **Bác sĩ thú y (Veterinarian)** | `dr_minh` hoặc `dr_linh` | Tiếp nhận bệnh nhân $\rightarrow$ Khám bệnh ghi form SOAP $\rightarrow$ Ghi sổ tiêm chủng |
| **Lễ tân (Receptionist)** | `recep_hoa` | Quản lý lịch hẹn $\rightarrow$ Check-in bệnh nhân $\rightarrow$ Xuất hóa đơn & Thu tiền |
| **Quản trị viên (Admin)** | `admin` | Xem tổng quan Dashboard, kiểm soát danh mục & số liệu |
| **Chủ thú cưng (Pet Owner)** | `owner_jane` hoặc `owner_david` | Xem danh sách thú cưng của mình |

---

## 🎬 6. Luồng Demo 5 Chức Năng Cốt Lõi (Live Demo Script)

1. **D-01 (Đăng nhập):** Nhập `dr_minh` / `password123` $\rightarrow$ Chuyển thẳng vào **Dashboard** hiển thị thống kê tổng quan (Thú cưng, Lịch khám hôm nay, Thuốc sắp hết kho).
2. **D-02 (Hồ sơ thú cưng):** Vào menu **Thú cưng** (`/pets`) $\rightarrow$ Thêm mới hoặc xem chi tiết bé *Milo* $\rightarrow$ Thấy banner cảnh báo màu đỏ nổi bật: `⚠️ Dị ứng thuốc kháng sinh nhóm Penicillin`.
3. **D-03 (Điều phối lịch hẹn):** Vào menu **Lịch hẹn** (`/appointments`) $\rightarrow$ Đặt lịch mới hoặc bấm **Check-in** cho ca khám đang ở trạng thái `CONFIRMED`.
4. **D-04 (Khám bệnh SOAP & Tiêm phòng):**
   - Với ca khám đã `CHECKED_IN`, nhấn nút **Khám SOAP** (`/medical-records/new`).
   - Điền sinh hiệu (cân nặng, thân nhiệt), ghi triệu chứng S/O/A/P, chẩn đoán ICD-10 $\rightarrow$ Nhấn **Lưu bệnh án** $\rightarrow$ Hệ thống tự động đánh dấu lịch hẹn thành `COMPLETED`.
   - Vào menu **Tiêm phòng** (`/vaccinations`) $\rightarrow$ Ghi nhận mũi tiêm vaccine kèm ngày tiêm nhắc lại.
5. **D-05 (Xuất hóa đơn & Thanh toán):**
   - Bấm **Xuất Hóa Đơn** từ ca khám vừa hoàn tất $\rightarrow$ Hệ thống tự động tính phí dịch vụ.
   - Chọn phương thức thanh toán (*Tiền mặt / Chuyển khoản QR / Thẻ*) $\rightarrow$ Nhấn **Xác nhận thu tiền** $\rightarrow$ Hóa đơn chuyển trạng thái `PAID` thành công!