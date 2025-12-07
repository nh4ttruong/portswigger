# OAuth 2.0 Authentication Vulnerabilities

## OAuth là gì?

Có bao giờ bạn thắc mắc tại sao các website cho phép **Sign in with Google**, **Sign in with GitHub**?

![Ví dụ về OAuth](oauth-example.jpg)

Đó chính là OAuth/OAuth 2.0 - một protocol cho phép website sử dụng chức năng xác thực của một service khác (như Google, Facebook, GitHub) mà không cần user chia sẻ password.

## Cách OAuth 2.0 hoạt động

OAuth 2.0 là trung gian giao tiếp giữa 3 bên:
- **Resource Owner** (User): Chủ sở hữu data
- **Client Application**: Website muốn truy cập data
- **OAuth Provider**: Service cung cấp OAuth (Google, Facebook, etc.)

### Quy trình cơ bản (4 bước)

1. **Client Application** yêu cầu quyền truy cập một phần data của user
2. **User** đăng nhập vào OAuth Provider và đồng ý cấp quyền
3. **Client Application** nhận **access token** từ OAuth Provider
4. **Client Application** dùng token để gọi API và lấy data của user

### OAuth Grant Types

- **Authorization Code**: Secure nhất, dành cho server-side apps
- **Implicit**: Đơn giản hơn nhưng kém an toàn, dành cho client-side apps
- **Client Credentials**: Dành cho machine-to-machine
- **Resource Owner Password**: Ít được khuyến khích dùng

## Các lỗ hổng phổ biến

### Phía Client Application
- ❌ Không validate `state` parameter → CSRF
- ❌ Tin tưởng hoàn toàn data từ OAuth Provider
- ❌ Implement sai grant type flow

### Phía OAuth Provider
- ❌ Không validate `redirect_uri` đúng cách
- ❌ Không kiểm tra `client_id` 
- ❌ Lỗ hổng trong scope validation
- ❌ Token leakage qua Referer header

### Phía User
- ❌ Phishing - đăng nhập vào fake OAuth Provider
- ❌ Malicious apps yêu cầu quá nhiều permissions

## Labs - Danh sách các bài thực hành

### 1. Implicit Flow Vulnerabilities
[Các lab về lỗ hổng trong Implicit Flow](./implicit-flow/README.md)

- [Lab: Authentication bypass via OAuth implicit flow](./implicit-flow/implicit-flow.md)
- [Lab: Forced OAuth profile linking](./implicit-flow/profile-linking.md)

### 2. Redirect URI Vulnerabilities
[Các lab về lỗ hổng Redirect URI](./redirect-uri/README.md)

- [Lab: OAuth account hijacking via redirect_uri](./redirect-uri/hijacking.md)
- [Lab: Stealing OAuth access tokens via an open redirect](./redirect-uri/stealing-redirect.md)
- [Lab: Stealing OAuth access tokens via a proxy page](./redirect-uri/stealing-proxy.md)

## Cách phòng chống

### OAuth Provider (Authorization Server)

✅ **Validate redirect_uri nghiêm ngặt**
- Exact match hoặc whitelist cụ thể
- Không cho phép wildcards trong domain
- Kiểm tra cả protocol (https://)

✅ **Implement state parameter**
- Generate random, unique value mỗi request
- Validate khi nhận callback

✅ **Token security**
- Short-lived access tokens
- Refresh tokens với rotation
- Bind tokens to client

### Client Application

✅ **Luôn dùng state parameter** để chống CSRF

✅ **Validate tokens**
- Verify signature nếu dùng JWT
- Check expiration time
- Validate issuer và audience

✅ **Redirect URI best practices**
- Register exact URIs với provider
- Không dùng wildcard redirects
- Validate redirect_uri ở backend

✅ **Scope principle**
- Chỉ request scopes cần thiết
- Hiển thị rõ permissions cho user

### User

✅ Check URL trước khi login (phishing)
✅ Review app permissions định kỳ
✅ Revoke access của apps không dùng

## Impact của OAuth vulnerabilities

- 🔴 **Account takeover**: Chiếm tài khoản victim
- 🔴 **Data leakage**: Đọc private data của user
- 🟠 **Unauthorized actions**: Thực hiện actions thay mặt user
- 🟡 **Privacy violation**: Thu thập data không đồng ý

## Tài nguyên tham khảo

- [PortSwigger OAuth Authentication](https://portswigger.net/web-security/oauth)
- [OAuth 2.0 Security Best Practices](https://datatracker.ietf.org/doc/html/draft-ietf-oauth-security-topics)
- [OAuth 2.0 RFC 6749](https://datatracker.ietf.org/doc/html/rfc6749)
