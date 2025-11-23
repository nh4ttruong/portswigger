# SQL Injection - Examining Database

Khi tấn công SQLi, chúng ta cần phải biết những thông tin cơ bản về website, database để có được những chiến lược cụ thể như cách tiếp cận, syntax,.... Những bài lab dưới đây sẽ minh họa điều này.

## Labs

- [Lab: SQL injection attack, querying the database type and version on Oracle](./oracle-version.md)
- [Lab: SQL injection attack, querying the database type and version on MySQL and Microsoft](./mysql-version.md)
- [Lab: SQL injection attack, listing the database contents on non-Oracle databases](./non-oracle-listing.md)
- [Lab: SQL injection attack, listing the database contents on Oracle](./oracle-listing.md)

## Tổng quan

Examining database giúp attacker:
- Xác định loại và version của database
- Liệt kê các bảng trong database
- Xem cấu trúc của các bảng
- Trích xuất dữ liệu quan trọng
