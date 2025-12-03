# Lab: Blind SQL injection with time delays and information retrieval

**Lab URL:** [PortSwigger Lab](https://portswigger.net/web-security/blind/lab-time-delays-info-retrieval)

## Mô tả

Như tên của nó, bài lab này yêu cầu ta thực hiện blind SQLi cùng với time delays để leak tài khoản administrator từ database. Lab này đại khái là sự kết hợp của Blind SQLi conditional responses và Blind SQLi time delays. Do vậy, theo hướng đó thì làm khá nhanh khi mình chỉ cần thay đổi cách bruteforce.

## Phân tích

Đầu tiên, xác định database để lựa syntax đúng:

![Xác định database](blind-time-delays-info-retrieval/define-database.jpg)

Bằng cách đó, mình biết rằng database lần này là PortgreSQL.

## Khai thác

Sau đó, tới công đoạn setup bruteforce. Lần này, mình không thể dùng "grep match" của Intruder vì phản hồi trả về là không có gì cả. Do vậy, mình sẽ sử dụng Resource Pool để setup thời gian timeout cho mỗi request:

![Tạo resource pool](blind-time-delays-info-retrieval/resource-pool.jpg)

Và bắt đầu bruteforce thôi. Sau một khoản thời gian không ngắn, mình đã tìm được password: `6lunhbudoihu7km8zku1`.

## Kết quả

Submit và solved lab hehe:

![Solved](blind-time-delays-info-retrieval/solved.jpg)
