# OAuth Implicit Flow

> **OAuth 2.0 Implicit Grant Type và Profile Linking**
> 
> Các labs trong phần này tập trung vào lỗ hổng liên quan đến Implicit Flow và việc link profile trong OAuth 2.0.

## Giới thiệu

Implicit Grant Type là một trong những flow của OAuth 2.0, được thiết kế để đơn giản và nhanh chóng. Tuy nhiên, chính sự đơn giản này cũng tạo ra các lỗ hổng bảo mật nếu không được triển khai cẩn thận.

## Labs

### [Authentication bypass via OAuth implicit flow](implicit-flow.md)
Khai thác lỗ hổng trong implicit grant type để bypass authentication và truy cập tài khoản khác.

### [Forced OAuth profile linking](profile-linking.md)
Lợi dụng lỗ hổng CSRF trong quá trình link profile OAuth để chiếm quyền tài khoản admin.
