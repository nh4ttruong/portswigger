# SQL Injection - Basic Attacks

Hai vấn đề này được xem là những vấn đề cơ bản nhất trong tấn công SQLi.

## Labs

- [Lab: SQL injection vulnerability in WHERE clause allowing retrieval of hidden data](./retrieval-hidden-data.md)
- [Lab: SQL injection vulnerability allowing login bypass](./login-bypass.md)

## Tổng quan

SQL Injection cơ bản tập trung vào việc khai thác các lỗ hổng đơn giản trong việc xử lý input của ứng dụng web. Hai kỹ thuật chính là:

1. **Retrieval of Hidden Data**: Sử dụng SQLi để hiển thị dữ liệu ẩn bằng cách thêm điều kiện `OR 1=1` vào query
2. **Login Bypass**: Bypass xác thực đăng nhập bằng cách comment phần password check với `--`
