# File Upload - Bypass Techniques

> **Kỹ thuật bypass validation trong file upload**
> 
> Các labs trong phần này tập trung vào việc bypass các cơ chế validation khác nhau.

## Giới thiệu

Các hệ thống thường triển khai nhiều lớp bảo vệ để ngăn chặn file upload attacks:
- Blacklist các extension nguy hiểm
- Kiểm tra file signature/magic bytes
- Validate file content

Tuy nhiên, nếu không được implement cẩn thận, các cơ chế này đều có thể bị bypass.

## Labs

### [Web shell upload via extension blacklist bypass](blacklist-bypass.md)
Bypass blacklist extension bằng cách upload file .htaccess để thêm extension mới.

### [Web shell upload via obfuscated file extension](obfuscated-extensions.md)
Sử dụng null byte (%00) để bypass validation extension.

### [Remote code execution via polyglot web shell upload](polyglot-webshell.md)
Tạo polyglot file - vừa là image hợp lệ vừa chứa PHP code để bypass file signature validation.
