# Lab: SQL injection attack, querying the database type and version on Oracle

**Lab URL:** [PortSwigger Lab](https://portswigger.net/web-security/examining-the-database/lab-querying-database-version-oracle)

## Mô tả

Lab này yêu cầu ta bắt database nói ra loại database và version của nó.

Database của lab này chính là Oracle và việc của ta là làm sao để server trả về theo yêu cầu.

## Phân tích

Trong Oracle, built-in table có tên là dual, do vậy, ta có thể dò cột bằng cách gọi FROM đến bảng dual.

![Dò cột bảng dual](./sqli-examining-database/call-dual-table.jpg)

Đến đây, với [cheat sheet](https://portswigger.net/web-security/cheat-sheet), ta có thể biết được các câu query mẫu để lấy thông tin database. Từ đó, dễ dàng SQLi ở challenge này.

## Khai thác

`Payload: "Gifts' UNION SELECT NULL,banner FROM v$version--"`

## Kết quả

![Solved](./sqli-examining-database/solved-oracle-version.jpg)
