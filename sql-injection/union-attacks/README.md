# SQL Injection - UNION Attacks

SQLi UNION attack là phương pháp SQLi sử dụng keyword "UNION" để truy vấn đến database dựa vào một truy vấn khác. Từ đó, dẫn đến khiến website show ra những thông tin ẩn hoặc khiến database bị sai khiến bởi những truy vấn hợp lệ.

## Labs

- [Lab: SQL injection UNION attack, determining the number of columns](./determining-columns.md)
- [Lab: SQL injection UNION attack, finding a column containing text](./finding-column-text.md)
- [Lab: SQL injection UNION attack, retrieving data from other tables](./retrieving-other-tables.md)
- [Lab: SQL injection UNION attack, retrieving multiple values in a single column](./multiple-values-single-column.md)

## Tổng quan

UNION attack cho phép attacker:
- Xác định số cột trong query gốc
- Tìm cột chứa dữ liệu dạng text
- Truy xuất dữ liệu từ các bảng khác
- Kết hợp nhiều giá trị trong một cột
