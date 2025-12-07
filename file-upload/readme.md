# File Upload Vulnerabilities

## Lỗ hổng file upload

Lỗ hổng file upload là một loại lỗ hổng có mức độ nghiêm trọng cao. Nó xảy ra khi một web server cho phép người dùng đăng tải một tệp lên filesystem mà không qua những bước xác thực (tên, loại tệp, nội dung, kích thước,...) hoặc hệ thống bị lỗi khi xác thực.

Khi đó, attacker có thể lợi dụng lỗ hổng này để tấn công hệ thống bằng các phương pháp khác nhau, đặc biệt là RCE (Remote Code Execution), khiến hệ thống của bạn vào trạng thái nguy hiểm.

## Tác động của lỗ hổng

Hai tác động chính của lỗ hổng này:
- Hệ thống xác thực sai cách và bỏ qua những xác thực quan trọng
- Những ràng buộc được thiết lập thực thi không đúng khi tệp đã tải lên hệ thống

Trường hợp xấu nhất là hệ thống cho phép thực thi các tệp nguy hiểm (như .php, .jsp, .aspx). Điều này cho phép attacker tải lên webshell và kiểm soát hoàn toàn server.

## Các trường hợp có thể xảy ra

Trong thực tế, các công ty, tổ chức thường kiểm soát lỗ hổng này. Tuy nhiên, vẫn có thể tồn tại các trường hợp:

- Quên xác thực các loại tệp, nội dung, kích thước
- Tạo blacklist nhưng không xác thực **extensions lạ** (ví dụ: .phtml, .php5)
- Web server **không nhất quán** khiến attacker có thể **path traversal**
- Hệ thống bị bypass dễ dàng bằng các thủ thuật của attacker (null byte, double extension, polyglot files)

## Labs - Danh sách các bài thực hành

### 1. Basic RCE Labs
[Các lab về RCE cơ bản](./basic-rce/README.md)

- [Lab: Remote code execution via web shell upload](./basic-rce/rce-webshell.md)
- [Lab: Web shell upload via Content-Type restriction bypass](./basic-rce/content-type-bypass.md)
- [Lab: Web shell upload via path traversal](./basic-rce/path-traversal.md)

### 2. Bypass Techniques
[Các kỹ thuật bypass validation](./bypass-techniques/README.md)

- [Lab: Web shell upload via extension blacklist bypass](./bypass-techniques/blacklist-bypass.md)
- [Lab: Web shell upload via obfuscated file extension](./bypass-techniques/obfuscated-extensions.md)
- [Lab: Remote code execution via polyglot web shell upload](./bypass-techniques/polyglot-webshell.md)

### 3. Advanced Techniques
[Kỹ thuật nâng cao - Race Condition](./advanced-techniques/README.md)

- [Lab: Web shell upload via race condition](./advanced-techniques/race-condition.md)

## Cách phòng chống

### Các best practices

- Sử dụng **whitelist** thay vì blacklist cho phép extensions
- Đảm bảo filename không chứa ký tự đặc biệt (tránh path traversal)
- Đổi tên tệp đã tải lên để tránh conflict và bypass
- Không cho phép tệp được thực thi trực tiếp từ upload directory
- Validate file content, không chỉ dựa vào extension
- Lưu trữ uploaded files ngoài webroot nếu có thể
- Sử dụng separate domain cho user-uploaded content

### Các cách tấn công khác

Ngoài RCE, file upload còn có thể bị khai thác để:
- Stored XSS: Upload file HTML/SVG chứa JavaScript
- XXE Injection: Upload file XML chứa external entity
- DoS: Upload file quá lớn
- Path Traversal: Overwrite file hệ thống

## Tài nguyên tham khảo

- [PortSwigger File Upload Vulnerabilities](https://portswigger.net/web-security/file-upload)
- [OWASP File Upload Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/File_Upload_Cheat_Sheet.html)
