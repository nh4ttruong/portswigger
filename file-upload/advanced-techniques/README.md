# File Upload - Advanced Techniques

> **Race Condition trong File Upload**
> 
> Lab trong phần này tập trung vào kỹ thuật advanced - Race Condition.

## Giới thiệu

Race Condition trong file upload xảy ra khi:
1. File được upload lên server và lưu tạm
2. Server validate file
3. Nếu file nguy hiểm, server xóa file

Nếu attacker có thể thực thi file trong khoảng thời gian giữa bước 1 và 3 (trước khi bị xóa), RCE có thể đạt được.

## Kỹ thuật

Để khai thác race condition:
- Upload file với extension hợp lệ (ví dụ: `.php.png`)
- Gửi nhiều request GET đến file đó cùng lúc
- Hy vọng một request GET sẽ thực thi trước khi server xóa file

## Lab

### [Web shell upload via race condition](race-condition.md)
Sử dụng Turbo Intruder để khai thác race condition và thực thi web shell trước khi bị xóa.