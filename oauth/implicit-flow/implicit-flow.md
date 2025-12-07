# Lab: Authentication bypass via OAuth implicit flow

**Link:** [https://portswigger.net/web-security/oauth/lab-oauth-authentication-bypass-via-oauth-implicit-flow](https://portswigger.net/web-security/oauth/lab-oauth-authentication-bypass-via-oauth-implicit-flow)

![Lab implicit-flow](oauth-implicit-flow/lab.jpg)

## OAuth Implicit Grant Type

Đối với *Implicit grant type*, đây là một cách xác thực kiểu ngầm hiểu và nhanh chóng. Chính vì nó nhanh nên dễ có lỗi. Tổng quan qua thì flow của nó như sau:

1. **Authorization request** - Xác thực yêu cầu: Khi người dùng yêu cầu login bằng OAuth, website sẽ request đến OAuth Service
2. **User consent** - Người dùng chấp thuận: Người dùng sẽ click để đồng ý với request login bằng OAuth
3. **Access token grant** - Cấp mã token để truy cập: Sau khi user đồng ý request, OAuth Service sẽ chuyển hướng đến trình duyệt của user. Nhưng thay vì nó gửi theo một mã xác thực thì "implicit grant type" nó gửi luôn cái token thông qua request. Sau đó, Client Application phải lấy thông tin đó và cấp truy cập
4. **API call** - Gọi API: Sau khi có được access token, Client Application gọi một API đến OAuth Service thông qua trình duyệt để request thông tin người dùng */userinfo*
5. **Resource grant** - Cấp quyền truy cập tài nguyên: Server sẽ xác thực token đối với Client Application đang ở phiên đó. Nếu đúng thì nó sẽ phản hồi bằng cách request tài nguyên dữ liệu của user dựa trên token và Client Application có thể sử dụng thông tin, data đó của user.

## Mục tiêu

Bài lab này yêu cầu ta thực hiện login với tài khoản social media và cố gắng truy cập vào bằng tài khoản email *carlos@carlos-montoya.net*

## Giải pháp

Lab đã cung cấp sẵn tài khoản của chú Wiener rồi và chúng ta sẽ truy cập thử vào tài khoản này rồi sử dụng Burp Suite để kiểm tra HTTP Proxy xem điều gì xảy ra nhé!

![Login bằng tài khoản của chú Wiener](oauth-implicit-flow/loginasdefault.jpg)

Sau khi login vào tài khoản của chú Wiener, mình kiểm tra HTTP Proxy thì nó ghi lại log như sau:

![HTTP proxy](oauth-implicit-flow/httpproxy.jpg)

Ở request thứ 58, xuất hiện request đến OAuth Service */auth/...* để xác thực thông tin user đến (host của nó là oauth-acb....)

Check xuống thì ta có thể thấy ở request 68, server đang thực hiện phản hồi bằng cách POST */authenticate* đến host Client Service để thông báo là "à token đó đúng rồi đó, bạn có thể truy cập tài nguyên của user rồi đó"

![Token của phiên](oauth-implicit-flow/gettoken.jpg)

Okay, đến đây thì mình đã có access token, một cái mã để truy cập cho phiên làm việc. Vậy thì mình sẽ dựa vào cái này để đánh lừa server là ông chú Carlos đang truy cập với email của ổng. Vì với "implicit grant type" không có bước nào nó xác thực lại thông tin request của bên OAuth cả mà nó theo 1 flow qua lại sau khi user đã đồng ý login bằng OAuth.

Ta thực hiện đổi "email" của chú Wiener thành của chú Carlos và POST request lên server:

![Gửi request](oauth-implicit-flow/loginascarlos.jpg)

Cuối cùng, ta thực hiện reload lại trình duyệt và kiểm tra thì đã solved được lab cũng như truy cập thành công tài khoản của chú Carlos yêu dấu.

![Solved](oauth-implicit-flow/solved.jpg)

**Note:** Nếu reload mà không thấy được solve thì bạn có thể sử dụng chức năng [*Request to browser*](./oauth-implicit-flow/note.jpg) để chọn phiên làm việc của cái request POST đã sửa email nhé!
