# Lab: SQL injection UNION attack, retrieving multiple values in a single column

**Lab URL:** [PortSwigger Lab](https://portswigger.net/web-security/union-attacks/lab-retrieve-multiple-values-in-single-column)

## Mô tả

Website chứa một table với tên là "users". Việc của mình là tìm account của admin và login.

## Phân tích

Đầu tiên, mình đã biết trước là trong bảng users đã có 2 cột là username và password. Nhưng khi mình query thông thường thì bị lỗi server. Do vậy mình cần phải tìm cách khác.

![Payload dò cột lần 1](sqli-union-attack/multi-value-test1.jpg)

Mình thử với `Payload: "Gifts' UNION SELECT NULL,username FROM users--"`, thì được:

![Payload dò cột lần 2](sqli-union-attack/multi-value-test2.jpg)

Như vậy, có thể sử dụng cách này cùng với cách nối username và password lại để tìm username và password của database.

## Khai thác

![Exploit thành công](sqli-union-attack/exploit-multi-value.jpg)

Mình thử với `Payload: "Gifts' UNION SELECT NULL,username ||'-'|| password FROM users--`

## Kết quả

![Solved](sqli-union-attack/solved-union-attack-multi-value-in-column.jpg)
