# Lab: SQL injection vulnerability allowing login bypass

**Lab URL:** [PortSwigger Lab](https://portswigger.net/web-security/lab-login-bypass)

## Mô tả

Bài lab này yêu cầu ta thực hiện bypass một cổng đăng nhập của website. Đây là một ví dụ rất thường thấy về lỗ hổng SQLi.

## Phân tích

Thông thường, ở một cổng đăng nhập, khi người dùng nhập vào 2 ô là username và password rồi click đăng nhập, server sẽ thực hiện một query đến database để xác thực thông tin đó với câu query kiểu:

```sql
SELECT * FROM users WHERE username = 'tuilanhattruong' AND password = 'nhattruonghehe'
```

Như vậy, dựa vào cấu trúc của câu query như vậy, ta có thể dễ dàng thêm, xóa hoặc sửa câu query để bypass được cổng này (nếu server không triển khai bảo mật SQLi)

## Khai thác

Mình sẽ test thử cổng đăng nhập với `administrator:1 or 1=1--`. Tất nhiên là không thể login được. Mình sẽ sử dụng Burp để send request và kiểm tra payload của mình khi đăng nhập như thế nào. Sau khi kiểm tra, mình thấy được request khi login như sau:

![Solved retriving hidden data](./basic-attack/test-query-login.jpg)

Thử cách khác, vậy tại sao ta không thử bypass bằng cách ngăn server xác thực mật khẩu bằng cách nhét "--" vào sau **username**. Mình sẽ type trực tiếp vào ô username luôn và password có thể điền bất cứ gì cũng được:

![Bypass login](./basic-attack/sqli-bypass-login.jpg)

## Kết quả

![Solved SQLi bypass login](./basic-attack/solved-sqli-bypass-login.jpg)
