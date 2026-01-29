Tuần 1:
<img width="1919" height="1199" alt="image" src="https://github.com/user-attachments/assets/8288beda-bee4-45b3-96e5-31956816e088" />


## Bài tập thực hành kiểm thử với JUnit

### Chủ đề
Phân tích dữ liệu điểm số học sinh.

### Mục tiêu
- Viết kiểm thử tự động bằng JUnit 5.
- Thực hành viết test case theo các nhóm: bình thường, biên, và dữ liệu không hợp lệ.

### Cấu trúc thư mục
Thư mục bài làm đặt trong `unit-test/`:
- `unit-test/src/`: mã nguồn Java
- `unit-test/test/`: mã nguồn kiểm thử đơn vị (JUnit)
- `unit-test/pom.xml`: cấu hình Maven để chạy JUnit 5 với cấu trúc `src/` và `test/` theo đề bài

### Mô tả yêu cầu
Lớp `StudentAnalyzer` có 2 phương thức:
- `countExcellentStudents(List<Double> scores)`:
  - Đếm số điểm hợp lệ (0..10) đạt loại Giỏi (>= 8.0)
  - Bỏ qua điểm < 0 hoặc > 10 (dữ liệu sai)
  - Nếu danh sách rỗng trả về 0
- `calculateValidAverage(List<Double> scores)`:
  - Tính điểm trung bình của các điểm hợp lệ (0..10)
  - Nếu danh sách rỗng hoặc không có điểm hợp lệ trả về 0

### Kết quả kiểm thử

- Đã chạy kiểm thử bằng JUnit Platform Console Standalone.
- Kết quả: 10/10 test PASSED.

Tuần 3:
Video: D:\KiemThuPhanMem\KiemThuPhanMem\cypress-exercise\cypress\videos
Screenshots: D:\KiemThuPhanMem\KiemThuPhanMem\cypress-exercise\cypress\screenshots
