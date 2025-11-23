# OAuth 2.0 Authentication Vulnerabilities

## OAuth là gì?

Trước khi bắt đầu, có bao giờ bạn thắc mắc rằng tại sao [Gitlab](https://gitlab.com) lại cho phép *Sign in* bằng các website/framework khác (Google, Github, Twitter...)?

![Ví dụ về OAuth](oauth-example.jpg)

Từ lúc mình biết đến chức năng **quick sign in** này thì mình có thắc mắc như vậy và cái đó chính là OAuth/OAuth2.0 trên các website.

Hiểu đơn giản rằng, OAuth sẽ cho phép một website sử dụng chức năng ủy quyền tài khoản của user với tài khoản ở một website khác. Với OAuth, người dùng có thể tinh chỉnh dữ liệu nào họ muốn chia sẻ thay vì phải giao toàn quyền kiểm soát tài khoản của họ cho bên thứ ba. Cơ chế này rất hay và tiện ích khi người dùng có thể sử dụng một tài khoản và đăng nhập trên nhiều nền tảng khác nhau.

OAuth và OAuth 2.0 là hai phiên bản khác nhau và OAuth 2.0 không được phát triển trên source của OAuth. Theo mình thấy thì nó khá hay ho và hữu ích. Tuy vậy, nó cũng tồn tại các "khe hở" khiến nó có thể bị attacker lợi dụng.

## OAuth 2.0

OAuth 2.0 được phát triển như một cách để chia sẻ kết nối với khối dữ liệu nhất định giữa các ứng dụng với nhau. Nó là trung gian giao tiếp giữa 3 bên bao gồm: chủ sở hữu data (data owner), ứng dụng khách (client application) và nhà cung cấp OAuth (OAuth provider).

### Cách OAuth 2.0 hoạt động

Để OAuth hoạt động thì có nhiều cách khác nhau và chúng thường được biết đến là 2 loại "flows" hoặc "grant types".

Tổng quan mà nói thì nó sẽ hoạt động chủ yếu theo 4 giai đoạn sau:

1. Client Application yêu cầu kết nối đến một vùng dữ liệu nào đó của user. Trong yêu cầu đó thì cũng chỉ cụ thể là sẽ sử dụng loại OAuth nào và cách kết nối ra sao.
2. Người dùng đăng nhập vào dịch vụ OAuth sau đó đồng ý các yêu cầu của Client Application
3. Client Application nhận được một **unique access token** để nó chứng minh là nó có quyền kết nối đến data (user cho phép ở trên).
4. Client Application sử dụng token để khiến API nạp dữ liệu liên quan từ server.

### Một vài lỗ hổng với OAuth/OAuth2

**Ở phía Client Application:**
- Lỗ hổng triển khai không đúng cách xác nhận (grant type) ở client application
- Lỗ hổng CSRF

**Ở phía OAuth service:**
- Bị leak mã ủy quyền (authorization code) và mã truy cập (access token)
  - Xác thực redirect_uri không đúng luật
  - Bị đánh cắp mã và mã thông báo truy cập qua trang proxy
- Lỗ hổng xác thực phạm vị (scope validation)
- Không kiểm tra việc người dùng đăng ký

**Ở phía user:**
- Bị leak hoặc tấn công máy tính
- Đăng nhập vào các trang có mã độc

## Labs - Thực hành

### Implicit Flow Vulnerabilities

[Các lab về lỗ hổng trong Implicit Flow](./implicit-flow/README.md)

- Lab: Authentication bypass via OAuth implicit flow
- Lab: Forced OAuth profile linking

### Redirect URI Vulnerabilities

[Các lab về lỗ hổng Redirect URI](./redirect-uri/README.md)

- Lab: OAuth account hijacking via redirect_uri
- Lab: Stealing OAuth access tokens via an open redirect
- Lab: Stealing OAuth access tokens via a proxy page

## Vậy làm thế nào để ngăn chặn OAuth authentication vuln?

**Từ phía nhà cung cấp:**
- Tạo whitelist cho **redirect_uris** để xác thực các request dẫn đến redirect website
- Sử dụng tham số **state** tạo giá trị ngẫu nhiên để xác thực
- Server cần xác thực các phiên và client_id

**Từ phía client application:**
- Cần hiểu rõ cách OAuth hoạt động để tránh các lỗi thường gặp
- Sử dụng **state** dù hoàn cảnh nào
- Gửi redirect_uri đến /authentication và cả /token endpoint
- Và nhiều cách khác phù hợp theo từng hoàn cảnh sử dụng
