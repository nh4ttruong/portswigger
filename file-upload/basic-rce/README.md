# File Upload - Basic RCE Techniques

> **Remote Code Execution (RCE) qua File Upload**
> 
> Các labs trong phần này tập trung vào các kỹ thuật cơ bản để khai thác RCE thông qua lỗ hổng file upload.

## Giới thiệu

RCE (Remote Code Execution) là một trong những lỗ hổng nguy hiểm nhất trong bảo mật web. Khi kết hợp với file upload vulnerabilities, attacker có thể:
- Upload web shell lên server
- Thực thi code tùy ý
- Đọc file nhạy cảm
- Chiếm quyền kiểm soát server

## Labs

### [Remote code execution via web shell upload](rce-webshell.md)
Lab cơ bản nhất về file upload RCE - server không có bất kỳ validation nào.

### [Web shell upload via Content-Type restriction bypass](content-type-bypass.md)
Bypass validation Content-Type để upload web shell lên server.

### [Web shell upload via path traversal](path-traversal.md)
Sử dụng path traversal để upload file vào thư mục có thể thực thi code.
