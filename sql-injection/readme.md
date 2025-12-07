# SQL Injection

## Đôi nét về SQL Injection (SQLi)?

SQLi là một lỗ hổng trên web mà attacker sẽ có thể tạo ra những query đến database của website đó. Lỗ hổng này sẽ làm những dữ liệu mà khó có thể xem được một cách bình thường trở nên bị leak.

Lỗ hổng này khá rộng. Nó có thể ảnh hưởng trực tiếp đến user data và cả web database nếu attack muốn (có thể thêm, xóa, sửa,...)

Nếu attacker có thể khai thác được SQLi thì có thể dẫn đến nhiều hệ lụy khôn lường. Ví dụ như dữ liệu bị lộ (tài khoản người dùng, thông tin cá nhân,...). Điều này trở nên hết sức phức tạp vì sẽ liên quan đến nhiều khía cạnh bảo mật trên môi trường Internet.

## Các tác động của SQLi

Để dễ hình dung hơn, SQLi có thể khiến:
- Làm lộ những dữ liệu mật
- Phá vỡ logic thực thi của web app
- Lộ những database khác (trong vùng khác vùng mà bị SQLi)
- Lộ cấu trúc của web app
- Và còn nhiều vấn đề khác mà attacker có thể sử dụng để khai thác web app của bạn

## Labs - Danh sách các bài thực hành

### 1. Basic Attacks
[Các kỹ thuật SQLi cơ bản](./basic-attacks/README.md)

- [Lab: SQL injection vulnerability in WHERE clause allowing retrieval of hidden data](./basic-attacks/retrieval-hidden-data.md)
- [Lab: SQL injection vulnerability allowing login bypass](./basic-attacks/login-bypass.md)

### 2. UNION Attacks
[Các kỹ thuật SQLi UNION attack](./union-attacks/README.md)

- [Lab: SQL injection UNION attack, determining the number of columns](./union-attacks/determining-columns.md)
- [Lab: SQL injection UNION attack, finding a column containing text](./union-attacks/finding-column-text.md)
- [Lab: SQL injection UNION attack, retrieving data from other tables](./union-attacks/retrieving-other-tables.md)
- [Lab: SQL injection UNION attack, retrieving multiple values in a single column](./union-attacks/multiple-values-single-column.md)

### 3. Examining Database
[Kỹ thuật kiểm tra và liệt kê database](./examining-database/README.md)

- [Lab: SQL injection attack, querying the database type and version on Oracle](./examining-database/oracle-version.md)
- [Lab: SQL injection attack, querying the database type and version on MySQL and Microsoft](./examining-database/mysql-version.md)
- [Lab: SQL injection attack, listing the database contents on non-Oracle databases](./examining-database/non-oracle-listing.md)
- [Lab: SQL injection attack, listing the database contents on Oracle](./examining-database/oracle-listing.md)

### 4. Blind SQL Injection
[Kỹ thuật Blind SQLi - Tấn công "mù"](./blind-sqli/README.md)

- [Lab: Blind SQL injection with conditional responses](./blind-sqli/conditional-responses.md)
- [Lab: Blind SQL injection with conditional errors](./blind-sqli/conditional-errors.md)
- [Lab: Blind SQL injection with time delays](./blind-sqli/time-delays.md)
- [Lab: Blind SQL injection with time delays and information retrieval](./blind-sqli/time-delays-info-retrieval.md)

## Một số cách để nhận dạng lỗ hổng SQLi

- Thử với ký tự `'` để kiểm tra syntax error
- Thử thay đổi cấu trúc syntax để xem phản hồi
- Thử bằng toán tử boolean (`OR 1=1`, `AND 1=2`)
- Trigger time delay để xác nhận blind SQLi
- Sử dụng UNION SELECT để trích xuất dữ liệu

## Tài nguyên tham khảo

- [PortSwigger SQL Injection Cheat Sheet](https://portswigger.net/web-security/sql-injection/cheat-sheet)
- [PortSwigger SQL Injection Learning Path](https://portswigger.net/web-security/sql-injection)

