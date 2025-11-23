# OAuth Redirect URI Vulnerabilities

> **Khai thác lỗ hổng trong xác thực redirect_uri**
> 
> Các labs trong phần này tập trung vào việc khai thác lỗ hổng liên quan đến redirect_uri trong OAuth 2.0.

## Giới thiệu

Redirect URI là một thành phần quan trọng trong OAuth 2.0 flow. Nếu server không xác thực đúng cách redirect_uri, attacker có thể:
- Hijack authorization code
- Đánh cắp access tokens
- Chiếm quyền tài khoản người dùng

## Labs

### [OAuth account hijacking via redirect_uri](hijacking.md)
Khai thác lỗ hổng xác thực redirect_uri để hijack authorization code và chiếm tài khoản admin.

### [Stealing OAuth access tokens via an open redirect](stealing-redirect.md)
Sử dụng path traversal kết hợp với open redirect để leak access tokens của nạn nhân.

### [Stealing OAuth access tokens via a proxy page](stealing-proxy.md)
Lợi dụng trang proxy để đánh cắp OAuth access tokens thông qua iframe injection.
