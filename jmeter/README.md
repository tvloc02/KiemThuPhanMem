# Kiểm thử hiệu năng với JMeter (Bài 3)

## Website được kiểm thử
- URL: https://en.wikipedia.org

## Mục tiêu
- Thực hiện kiểm thử hiệu năng bằng JMeter với 3 kịch bản tải khác nhau.
- Thu thập và phân tích các chỉ số: Response Time, Throughput, Error Rate.

## File nộp bài
- `performance_test_wikipedia.jmx`: Test plan JMeter (3 Thread Group)
- `results/`: chứa file CSV / ảnh chụp Summary Report sau khi chạy

## Chạy bằng CLI (đã tạo sẵn)
- Cài JMeter portable (tải về từ Apache, không commit lên repo):
  - `powershell -ExecutionPolicy Bypass -File .\tools\setup-jmeter.ps1`
- Chạy test plan và sinh kết quả:
  - `powershell -ExecutionPolicy Bypass -File .\tools\run-jmeter.ps1`
  - Kết quả sẽ sinh trong `jmeter/results/`:
    - `jmeter-*.jtl` (log kết quả)
    - `report-*/index.html` (HTML report, thư mục này đã được ignore để tránh đẩy lên GitHub)
- Tính nhanh chỉ số để điền báo cáo:
  - `powershell -ExecutionPolicy Bypass -File .\tools\analyze-jmeter.ps1`

## Cá nhân hoá tham số
Trong file `.jmx` có biến (User Defined Variables):
- `DOMAIN` (mặc định: `en.wikipedia.org`)
- `PATH_HOME` (mặc định: `/wiki/Main_Page`)
- `PATH_PAGE1` (mặc định: `/wiki/Software_testing`)
- `PATH_PAGE2` (mặc định: `/wiki/Performance_testing`)

Bạn có thể đổi các path cho phù hợp (ví dụ trang con bạn muốn test).

## Thiết kế kịch bản kiểm thử
### Thread Group 1: Kịch bản cơ bản
- Threads: 10
- Ramp-up: 10s
- Loop Count: 5
- Hành vi: GET trang chủ (`PATH_HOME`)

### Thread Group 2: Kịch bản tải nặng
- Threads: 50
- Ramp-up: 30s
- Loop Count: 3
- Hành vi:
  - GET trang chủ (`PATH_HOME`)
  - GET 1 trang con (`PATH_PAGE1`)

### Thread Group 3: Kịch bản tuỳ chỉnh
- Threads: 20
- Ramp-up: 10s
- Duration: 60s (Scheduler bật)
- Hành vi:
  - GET `PATH_PAGE1`
  - GET `PATH_PAGE2`

## Lưu ý tránh rate-limit
Mỗi Thread Group đã có `Constant Timer` (think time) để giảm tần suất request.

## Hướng dẫn chạy
1. Cài JMeter (Apache JMeter) và mở JMeter.
2. File > Open > chọn `jmeter/performance_test_wikipedia.jmx`.
3. Để chạy từng kịch bản riêng:
   - Disable 2 Thread Group còn lại (Right click > Disable).
   - Run > Start.
4. Mở Listener `Summary Report` để xem kết quả.
5. Xuất kết quả:
   - Chụp màn hình Summary Report, lưu vào `jmeter/results/`.
   - Hoặc lưu file `.csv` từ Summary Report (Save Table Data).

## Báo cáo kết quả (điền sau khi chạy)
### Kết quả TG1
- Avg Response Time (ms): 190.68
- Throughput (req/s): 4.17
- Error Rate (%): 0

### Kết quả TG2
- Avg Response Time (ms): 347.15
- Throughput (req/s): 8.57
- Error Rate (%): 0

### Kết quả TG3
- Avg Response Time (ms): 200.92
- Throughput (req/s): 15.36
- Error Rate (%): 0

## Nhận xét
- 
