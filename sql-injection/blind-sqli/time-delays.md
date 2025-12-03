# Lab: Blind SQL injection with time delays

**Lab URL:** [PortSwigger Lab](https://portswigger.net/web-security/blind/lab-time-delays)

## Mô tả

Trong lab này, chúng ta cần khiến cho server bị delay 10 giây. Với blind SQLi, ta có thể sử dụng **time delays** trong các câu query.

## Phân tích

![SQLi time delay cheat-sheet](blind-time-delays/time-delays-table.jpg)

Bằng bảng cheat-sheet trên, mình đã biết thử và thấy được database này là PostgreSQL. Do vậy, lab khá nhanh khi mình chỉ cần concat TrackingId với câu truy vấn bằng payload sau đây:

## Khai thác

![SQLi time delay cheat-sheet](blind-time-delays/payload.jpg)

## Kết quả

Sau đó, kiểm tra browser và solved lab thooiiiii:

![Solved](blind-time-delays/solved.jpg)
