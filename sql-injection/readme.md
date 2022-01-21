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

## SQLi Lab theo chủ đề

Để hiểu rõ hơn về SQLi, cùng nhau thực hiện các bài lab về SQLi thoiiiii

Xem nhanh các phần:
- [SQLi để lấy dữ liệu ẩn và phá vỡ logic website](#sqli-basic)
- [SQLi UNION attack](#union-attack)
- [Kiểm tra database với SQLi](#examining-database)
- [Blind SQL Injection - Khi "người mù" tấn công website](#blind-sqli)
- [Một số cách để nhận dạng lỗ hổng SQLi](#prevent-sqli)

Let's get started!

## SQLi để lấy dữ liệu ẩn và phá vỡ logic website <a name="sqli-basic"></a>

Hai vấn đề này được xem là những vấn đề cơ bản nhất trong tấn công SQLi.

*MỤC LỤC:*
- [Lab: SQL injection vulnerability in WHERE clause allowing retrieval of hidden data](#retriving-data)
- [Lab: SQL injection vulnerability allowing login bypass](#login-bypass)

### Lab: SQL injection vulnerability in WHERE clause allowing retrieval of hidden data <a name="retriving-data"></a>

Đường dẫn đến lab [ở đây](https://portswigger.net/web-security/sql-injection/lab-retrieve-hidden-data)

Bài lab này yêu cầu ta thực hiện SQLi để show tất cả các sản phẩm ra trong khi hiển thị một category bất kỳ.

`Payload của mình: "https://ac5b1feb1e123a53c0fc5396006d00c3.web-security-academy.net/filter?category=Clothing%2c+shoes+and+accessories%27+OR+1=1--"`

Có thể hiểu rằng, server sẽ query câu lệnh kiểu: 

`SELECT * FROM products WHERE category = 'Clothing%2c+shoes+and+accessories' OR 1=1--

Sau "--" thì tất cả sẽ bị comment lại và không thể thực thi. Kết quả với câu query:

![Solved retriving hidden data](sql-injection/basic-attack/solved-retriving-data.jpg)

### Lab: SQL injection vulnerability allowing login bypass <a name="login-bypass"></a>

Đường dẫn đến lab [ở đây](https://portswigger.net/web-security/sql-injection/lab-login-bypass)

Bài lab này yêu cầu ta thực hiện bypass một cổng đăng nhập của website. Đây là một ví dụ rất thường thấy về lỗ hổng SQLi.

Thông thường, ở một cổng đăng nhập, khi người dùng nhập vào 2 ô là username và password rồi click đăng nhập, server sẽ thực hiện một query đến database để xác thực thông tin đó với câu query kiểu:

`SELECT * FROM users WHERE username = 'tuilanhattruong' AND password = 'nhattruonghehe'`

Như vậy, dựa vào cấu trúc của câu query như vậy, ta có thể dễ dàng thêm, xóa hoặc sửa câu query để bypass được cổng này (nếu server không triển khai bảo mật SQLi)

Mình sẽ test thử cổng đăng nhập với `administrator:1 or 1=1--`. Tất nhiên là không thể login được. Mình sẽ sử dụng Burp để send request và kiểm tra payload của mình khi đăng nhập như thế nào. Sau khi kiểm tra, mình thấy được request khi login như sau:

![Solved retriving hidden data](sql-injection/basic-attack/test-query-login.jpg)

Thử cách khác, vậy tại sao ta không thử bypass bằng cách ngăn server xác thực mật khẩu bằng cách nhét "--" vào sau **username**. Mình sẽ type trực tiếp vào ô username luôn và password có thể điền bất cứ gì cũng được:

![Bypass login](sql-injection/basic-attack/sqli-bypass-login.jpg)

Kết quả là:

![Solved SQLi bypass login](sql-injection/basic-attack/solved-sqli-bypass-login.jpg)

## SQLi UNION attack <a name="union-attack"></a>

SQLi UNION attack là phương pháp SQLi sử dụng keyword "UNION" để truy vấn đến database dựa vào một truy vấn khác. Từ đó, dẫn đến khiến website show ra những thông tin ẩn hoặc khiến database bị sai khiến bởi những truy vấn hợp lệ.

*MỤC LỤC:*
- [Lab: SQL injection UNION attack, determining the number of columns returned by the query](#union-attack-null-value)
- [Lab: SQL injection UNION attack, finding a column containing text](#union-attack-finding-column)
- [Lab: SQL injection UNION attack, retrieving data from other tables](#union-attack-get-data-from-other-tables)
- [Lab: SQL injection UNION attack, retrieving multiple values in a single column](#union-attack-retrieving-multiple-value)
- [Lab: SQL injection UNION attack, retrieving multiple values in a single column](#union-attack-retrieving-multiple-value)

### Lab: SQL injection UNION attack, determining the number of columns returned by the query <a name="union-attack-null-value"></a>

Đường dẫn đến lab [ở đây](https://portswigger.net/web-security/sql-injection/union-attacks/lab-determine-number-of-columns)

Bài lab yêu cầu ta xác định số cột trả về khi tiêm SQL để server trả về một hàng có giá trị null.

Payload: `https://ac391ffa1e25ddc4c0e95d60001300d6.web-security-academy.net/filter?category=Lifestyle%27+UNION+SELECT+NULL,NULL,NULL--`

Kết quả:

![Solved SQLi union attack with null value](sql-injection/sqli-union-attack/solved-union-attack-null-value.jpg)

### Lab: SQL injection UNION attack, finding a column containing text <a name="union-attack-finding-column"></a>

Đường dẫn đến lab [ở đây](https://portswigger.net/web-security/sql-injection/union-attacks/lab-find-column-containing-text)

Ở lab này, mình cần phải tìm được chuỗi theo yêu cầu của lab **'BVuEQu'**.

`Payload: "https://ac861f221ec2cb3cc0b71c46008a00b5.web-security-academy.net/filter?category=Gifts%27+UNION+SELECT+NULL,%27BVuEQu%27,NULL--"`

![Solved SQLi finding column](sql-injection/sqli-union-attack/solved-union-attack-finding-column.jpg)

Với UNION Attack, ta có thể tìm một cột chưa giá trị loại "string" bằng cách thử chèn đoạn string cần tìm vào:

`UNION SELECT {string_can_tim},NULL,NULL--`

{string_can_tim} có thể nằm ở bất kỳ cột nào trong database, do đó hãy thử vận may của mình bạn nhé, biết đâu những từ khóa thông dụng có thể cho ta xem được hết cả database của cột cần tìm.

### Lab: SQL injection UNION attack, retrieving data from other tables <a name="union-attack-get-data-from-other-tables"></a>

Đường dẫn đến lab [ở đây](https://portswigger.net/web-security/sql-injection/union-attacks/lab-retrieve-data-from-other-tables)

Trong lab này, website chứa một table với tên là "users". Việc của mình là tìm account của admin và login.

Sử dụng UNION SELECT với payload, ta dễ dàng retrieve được data của bảng users:

![Database từ users table](sql-injection/sqli-union-attack/database-users-table.jpg)
'
`Payload: "https://ac1c1fcf1ef5e8c8c0a17e340047008c.web-security-academy.net/filter?category=Accessories%27+UNION+SELECT+username,password+FROM+users--"`

![Solved SQLi finding other table](sql-injection/sqli-union-attack/solved-union-attack-finding-other-table.jpg)

### Lab: SQL injection UNION attack, retrieving multiple values in a single column <a name="union-attack-retrieving-multiple-value"></a>

Đường dẫn đến lab [ở đây](https://portswigger.net/web-security/sql-injection/union-attacks/lab-retrieve-multiple-values-in-single-column)

Website chứa một table với tên là "users". Việc của mình là tìm account của admin và login.

Đầu tiên, mình đã biết trước là trong bảng users đã có 2 cột là username và password. Nhưng khi mình query thông thường thì bị lỗi server. Do vậy mình cần phải tìm cách khác.

![Payload dò cột lần 1](sql-injection/sqli-union-attack/multi-value-test1.jpg)

Mình thử với `Payload: "Gifts' UNION SELECT NULL,username FROM users--"`, thì được:

![Payload dò cột lần 2](sql-injection/sqli-union-attack/multi-value-test2.jpg)

Như vậy, có thể sử dụng cách này cùng với cách nối username và password lại để tìm username và password của database.

![Exploit thành công](sql-injection/sqli-union-attack/exploit-multi-value.jpg)

Mình thử với `Payload: "Gifts' UNION SELECT NULL,username ||'-'|| password FROM users--`

![Solveds](sql-injection/sqli-union-attack/solved-union-attack-multi-value-in-column.jpg)

## Kiểm tra database với SQLi <a name="examining-database"></a>

Khi tấn công SQLi, chúng ta cần phải biết những thông tin cơ bản về website, database để có được những chiến lược cụ thể như cách tiếp cận, syntax,.... Những bài lab dưới đây sẽ minh họa điều này.

*MỤC LỤC:*
- [Lab: SQL injection attack, querying the database type and version on Oracle](#oracle-database-type)
- [Lab: SQL injection attack, querying the database type and version on MySQL and Microsoft](#mysql-database-type)
- [Lab: SQL injection attack, listing the database contents on non-Oracle databases](#listing-non-oracle)
- [Lab: SQL injection attack, listing the database contents on Oracle](#listing-oracle)

### Lab: SQL injection attack, querying the database type and version on Oracle <a name="oracle-database-type"></a>

Đường dẫn đến lab [ở đây](https://portswigger.net/web-security/sql-injection/examining-the-database/lab-querying-database-version-oracle)

Lab này yêu cầu ta bắt database nói ra loại database và version của nó.

Database của lab này chính là Oracle và việc của ta là làm sao để server trả về theo yêu cầu.

Trong Oracle, built-in table có tên là dual, do vậy, ta có thể dò cột bằng cách gọi FROM đến bảng dual.

![Dò cột bảng dual](sql-injection/slqi-examining-database/call-dual-table.jpg)

Đến đây, với [cheat sheet](https://portswigger.net/web-security/sql-injection/cheat-sheet), ta có thể biết được các câu query mẫu để lấy thông tin database. Từ đó, dễ dàng SQLi ở challenge này.

`Payload: "Gifts' UNION SELECT NULL,banner FROM v$version--"`

![Solved](sql-injection/slqi-examining-database/solved-oracle-version.jpg)

### Lab: SQL injection attack, querying the database type and version on MySQL and Microsoft <a name="mysql-database-type"></a>

Đường dẫn đến lab [ở đây](https://portswigger.net/web-security/sql-injection/examining-the-database/lab-querying-database-version-mysql-microsoft)

Lab này tương tự Lab về [Oracle datable](#oracle-database-type) ở trên nhưng lần này là với Microsoft và MySQL database.

Database lần này cũng gồm 2 cột sau khi thử:

`Payload: "Gifts' UNION SELECT NULL,NULL#"`

Tuy vậy, lúc đầu mình thử ký tự "#" thì server báo lỗi. Hên sao mình nhớ đến HTML Encoding và chuyển nó thành "%23" thì oke.

`Payload: "Gifts' UNION SELECT NULL,@@version#"`

![Solved](sql-injection/slqi-examining-database/solved-mysql-version.jpg)

### Lab: SQL injection attack, listing the database contents on non-Oracle databases <a name="listing-non-oracle"></a>

Đường dẫn đến lab [ở đây](https://portswigger.net/web-security/sql-injection/examining-the-database/lab-listing-database-contents-non-oracle)

Lab này yêu cầu ta tìm kiếm account của admin để login. Tuy vậy, ta chưa biết database loại nào mà chỉ biết nó không phải là Oracle mà thôi. Đầu tiên, mình sẽ dò số cột trong database:

![Dò số cột của database](sql-injection/slqi-examining-database/probe-database.jpg)

Ta thấy, có 2 cột trong database này. Tiếp tục, mình sẽ dò version của database này:

`Payload: "Pets' UNION SELECT NULL,version()--"`

![Dò version của database](sql-injection/slqi-examining-database/probe-version-database.jpg)

Đến đây, ta đã biết nó là PostgreSQL 11.14. Ta sẽ sử dụng query `SELECT null,table_name FROM information_schema.tables` để show các bảng trong database này.

![Show các bảng trong database](sql-injection/slqi-examining-database/show-tables.jpg)

Trong các bảng, có 2 bảng có thể chứa thông tin tài khoản của các user đó chính là *users_atqsuh* và *pg_user*. Mình sẽ chọn cái đầu tiên để đi sâu xem có gì trong đó, nếu không có thì quay lại thoiii :v. Trước tiên, mình sẽ cần show các cột trong bảng *users_atqsuh*:

`Payload: "Pets' UNION SELECT null,column_name FROM information_schema.columns WHERE table_name='users_atqsuh'--"`

![Show chi tiết cột](sql-injection/slqi-examining-database/show-detail-column.jpg)

Đến đây, mình đã biết được rằng thông tin tài khoản và mật khẩu sẽ được lưu vào 2 cột đó chính là *username_cipszl* và *password_mhklnf*. Giờ thì query nó ra thôi:

![Query account](sql-injection/slqi-examining-database/query-account.jpg)

Có tài khoản xong thì login và solved:

![Solved](sql-injection/slqi-examining-database/solve-listing-database.jpg)

### Lab: SQL injection attack, listing the database contents on Oracle <a name="listing-oracle"></a>

Đường dẫn đến lab [ở đây](https://portswigger.net/web-security/sql-injection/examining-the-database/lab-listing-database-contents-oracle)

Bài này thì tương tự bài [non-Oracle ở trên](#listing-non-oracle). Do đó, mình sẽ làm tương tự.

`Payload: "Gifts' UNION SELECT null,table_name FROM all_tables--"`

![Show all table](sql-injection/slqi-examining-database/users-table-oracle.jpg)

`Payload: "Gifts' UNION SELECT null,column_name FROM all_tab_columns WHERE table_name='USERS_TXZJUA'--"`

![show-detail-table-oracle](sql-injection/slqi-examining-database/show-detail-table-oracle.jpg)

`Payload: "Gifts' UNION SELECT USERNAME_TPLFRU,PASSWORD_DHDRXQ FROM USERS_TXZJUA--"`

![show account](sql-injection/slqi-examining-database/show-account-oracle.jpg)

Và solve rồi nè:

![Solved](sql-injection/slqi-examining-database/solved-listing-oracle-database.jpg)

## Blind SQL Injection - Khi "người mù" tấn công website <a name="blind-sqli"></a>

Blind SQL Injection cho phép attack có thể sử dụng những chức năng khác của SQL để trigger, tìm kiếm và suy luận từ những response từ server mà không cần dựa vào bất kỳ lỗ hổng nào khác. Do vậy, nó được gọi là Bline - "mù".

*MỤC LỤC:*
- [Lab: Blind SQL injection with conditional responses](#blind-conditional-responses)
- [Lab: Blind SQL injection with conditional errors](#blind-conditional-error)
- [Lab: Blind SQL injection with time delays](#time-delays)
- [Lab: Blind SQL injection with time delays and information retrieval](#time-delays-info-retrieval)

### Lab: Blind SQL injection with conditional responses <a name="blind-conditional-responses"></a>

Đường dẫn đến lab [ở đây](https://portswigger.net/web-security/sql-injection/blind/lab-conditional-responses)

Bài lab này được thiết kế để ta attack bằng phương pháp Blind SQLi. Nó chứa một cái gọi là tracking cookie để phân tích và kiểm soát cookie người dùng. *Bên cạnh đó, khi query thì không gì được trả về nếu điều kiện sai hoặc lỗi ngoại trừ khi mình query đúng thì nó sẽ trả về chuỗi "Welcome back"*. Bên cạnh đó, nó chứa một bảng users với 2 cột là username và password. Lab yêu cầu ta chiếm quyền kiểm soát administrator.

Mở Burp lên và kiểm tra request khi filter category thì mình sẽ thấy một tham số là TrackingId.

![TrackingId trong request](sql-injection/blind-conditional-res/blind-sqli/tracking-id.jpg)

Bây giờ, mình sẽ thử test điều kiền khi lồng toán tử vào chỗ này:

![Test condition](sql-injection/blind-sqli/blind-conditional-res/test-condition-res.jpg)

Như vậy, có thể thấy, mình sẽ có thể Blind SQLi ở đây để dò ra thông tin cần tìm (password). Giờ thì mình sẽ thử dò thử xem có account với username là "administrator" hay không:

![Dò account admin](sql-injection/blind-sqli/blind-conditional-res/probe-table-and-admin-user.jpg)

Tada, website chứa account admin đó rồi (cái này lab cũng có đề cập nhưng mà mình kiếm thử). Giờ thì đến công đoạn tìm password. Trước tiên, mình sẽ dùng **LENGTH()** để kiểm tra xem password có độ dài bao nhiêu. Sau khi dò với operator **>** và **<** một lúc thì mình đã xác định được `LENGTH(password)=20`:

![Dò account admin](sql-injection/blind-sqli/blind-conditional-res/find-length-password.jpg)

Đến đây, mình sẽ phải dò từng ký tự trong password (20 lần) để có thể ghép lại thành password cần tìm với payload: `Payload: "TrackingId=G4M7YunBTBgfypfH' AND (SELECT SUBSTRING(password,{vi-tri-do},1) FROM users WHERE username='administrator' AND LENGTH(password)=20)='{ky-tu-can-do}"`. Mình đã biết rằng, khi điều kiện SQL đúng thì website sẽ trả về string "Welcome back!", do vậy, mình sẽ brute-force nó bằng Burp Intruder. Sau đây là một vài setting trước khi brute-force:
- Chỉnh chế độ về Cluster-bomb để có thể tùy chỉnh vị trí payload brute-force
- Thêm khóa vào vị trí cần brute-force với nút "Add $". Khóa đầu tiên mình để là vị trí trong password (1-20) và khóa thứ hai là ký tự trong password.

![Setting cluster-bomb mode](sql-injection/blind-sqli/blind-conditional-res/bruteforce.jpg)

- Tạo danh sách các ký tự có thể có trong password (a-Z, 0-9) cho lần lượt 2 khóa như ảnh trên.

![Payload list trước khi brute-force](sql-injection/blind-sqli/blind-conditional-res/intruder-payload-options.jpg)

- Tạo điều kiện trả về khi tìm đúng ký tự với điều kiện là "Welcome back!"

![Tạo điều kiện trả về](sql-injection/blind-sqli/blind-conditional-res/intruder-grep.jpg)

- Click "Start attack" và chờ thôi

![Trong khi bruteforce](sql-injection/blind-sqli/blind-conditional-res/while-bruteforce.jpg)

Sau 2 - 3 tiếng bruteforce, mình đã có được những kết quả trả về match với "Welcome back!". Công việc giờ là sắp xếp lại thành một chuỗi theo thứ tự thôi:

![Kết quả bruteforce](sql-injection/blind-sqli/blind-conditional-res/finish-bruteforce.jpg)

Chuỗi password mà mình đã sắp xếp: `Password: 3n2xxm4cprzjuiim5hpi`

Submit và solved challenge rồi nè:

![Solved](sql-injection/blind-sqli/blind-conditional-res/solved.jpg)

### Lab: Blind SQL injection with conditional errors <a name="blind-conditional-error"></a>

Đường dẫn đến lab [ở đây](https://portswigger.net/web-security/sql-injection/blind/lab-conditional-errors)

Lab này cũng khá giống với bài [conditonal response](#blind-conditional-responses). Đại khái, nếu bài lab trước ta có thể dựa vào phản hồi "Welcome back!" để suy luận ra đúng ký tự password thì ở lab này, ta sẽ phải dựa vào lỗi phản hồi để có thể suy luận. Vì vậy, mình sẽ làm nhanh hehe:

Xác định database:

![Xác định database](sql-injection/blind-sqli/blind-conditional-error/define-database.jpg)

Xác định độ dài password (length=20):

![Xác định độ dài password](sql-injection/blind-sqli/blind-conditional-error/length-password.jpg)

Kết quả bruteforce:

![Kết quả bruteforce](sql-injection/blind-sqli/blind-conditional-error/finish-bruteforce.jpg)

Password sau khi ghép lại: `i1xcr4zruhfc78onms06`. Và solved challenge:

![KSolved](sql-injection/blind-sqli/blind-conditional-error/solved.jpg)

### Lab: Blind SQL injection with time delays <a name="time-delays"></a>

Đường dẫn đến lab [ở đây](https://portswigger.net/web-security/sql-injection/blind/lab-time-delays)

Trong lab này, chúng ta cần khiến cho server bị delay 10 giây. Với blind SQLi, ta có thể sử dụng **time delays** trong các câu query.

![SQli time delay cheat-sheet](sql-injection/blind-sqli/blind-time-delays/time-delays-table.jpg)

Bằng bảng cheat-sheet trên, mình đã biết thử và thấy được database này là PostgreSQL. Do vậy, lab khá nhanh khi mình chỉ cần concat TrackingId với câu truy vấn bằng payload sau đây:

![SQli time delay cheat-sheet](sql-injection/blind-sqli/blind-time-delays/payload.jpg)

Sau đó, kiểm tra browser và solved lab thooiiiii:

![KSolved](sql-injection/blind-sqli/blind-time-delays/solved.jpg)

### Lab: Blind SQL injection with time delays and information retrieval <a name="time-delays-info-retrieval"></a>

Đường dẫn đến lab [ở đây](https://portswigger.net/web-security/sql-injection/blind/lab-time-delays-info-retrieval)

Như tên của nó, bài lab này yêu cầu ta thực hiện blind SQLi cùng với time delays để leak tài khoản administrator từ database. Lab này đại khái là sự kết hợp của [Blind SQLi conditional responses](#blind-conditional-responses) và [Blind SQli time delays](#time-delays). Do vậy, theo hướng đó thì làm khá nhanh khi mình chỉ cần thay đổi cách bruteforce.

Đầu tiên, xác định database để lựa syntax đúng:

![Xác định database](sql-injection/blind-sqli/blind-time-delays-info-retrivial/define-database.jpg)

Bằng cách đó, mình biết rằng database lần này là PortgreSQL. Sau đó, tới công đoạn setup bruteforce. Lần này, mình không thể dùng "grep match" của Intruder vì phản hồi trả về là không có gì cả. Do vậy, mình sẽ sử dụng Resource Pool để setup thời gian timeout cho mỗi request:

![Tạo resource pool](sql-injection/blind-sqli/blind-time-delays-info-retrivial/resource-pool.jpg)

Và bắt đầu bruteforce thôi. Sau một khoản thời gian không ngắn, mình đã tìm được password: `6lunhbudoihu7km8zku1`.

Submit và solved lab hehe:

![Solved](sql-injection/blind-sqli/blind-time-delays-info-retrivial/solved.jpg)

## Một số cách để nhận dạng lỗ hổng SQLi <a name="prevent-sqli"></a>
- Thử với ký tự `'`
- Thử thay đổi cấu trúc syntax
- Thử bằng toán tử boolean
- Trigger time delay