# Lab: Forced OAuth profile linking

**Link:** [https://portswigger.net/web-security/oauth/lab-oauth-forced-oauth-profile-linking](https://portswigger.net/web-security/oauth/lab-oauth-forced-oauth-profile-linking)

![Lab implicit-flow](./oauth-profile-linking/lab.jpg)

## Giới thiệu

Trong bài này, mình sẽ cần login vào tài khoản bằng OAuth thay vì là tài khoản và mật khẩu thông thường. Lab cũng nói là sử dụng CSRF để khai thác.

## Phân tích

Tương tự như các bài lab, ta thử login bằng tài khoản được cung cấp, sau đó link với OAuth

![Login bằng tài khoản được cung cấp](./oauth-profile-linking/login.jpg)

Sau đó, sử dụng tài khoản *peter.wiener:hotdog* để link với social account

![Link với OAuth](./oauth-profile-linking/attach.jpg)

Đến đây, ta sẽ phân tích Proxy History xem những gì đã xảy ra. Mình phát hiện được request thứ 53 là một request để link tài khoản social với tài khoản dạng */auth...*

![Request xác thực](./oauth-profile-linking/auth-history.jpg)

Như lab đã đề cập, bài này sẽ liên quan đến CSRF, do vậy, khi xem kỹ request này thì tham số *state* không được sử dụng.

Tham số *state* là một tham số có nhiệm vụ mã hóa thông tin mà bạn cần. Sau đó, bạn sẽ sử dụng một giá trị random đó để xác thực lúc nhận được phản hồi. Tham số này rất quan trọng để tránh CSRF attack nhưng trong request trên thì người ta lại không dùng. Đến đây thì mình sẽ lợi dụng tính thiếu xác thực này để khai thác nó.

## Khai thác

Trong proxy history, ở request thứ 66, ta có thể thấy được 1 request dạng */oauth-linking=?code...*. Request này có vẻ như yêu cầu xác thực với code để hoàn tất quá trình login bằng OAuth. Và với vai trò như vậy thì có nghĩa code này sẽ chỉ được sử dụng 1 lần. Dựa vào đây mình có thể nhờ nó để có thể đánh lừa server bằng cách trộm nó nhưng không sử dụng nó, có nghĩa là nó vẫn còn hiệu lực và mình có thể khai thác bằng cách đánh lừa *exploit server* mà lab đã cung cấp để login as admin.

![Code linking](./oauth-profile-linking/code.jpg)

Okay, đến đây ta thực hiện login lại từ đầu và link với social account 1 lần nữa, nhưng đến bước *Continue* sau khi link với social account thì ta sẽ drop nó để hủy request (có nghĩa là đợi server gửi code cho mình xong mình sẽ qua cầu rút ván =)))).

![Stolen code](./oauth-profile-linking/stolen-code.jpg)

Đây là code mà mình đã trộm được. Bây giờ, mình sẽ vào exploit server để khai thác. Bởi vì server sẽ đọc tất cả những gì mà mình gửi do vậy, mình sẽ gửi đi 1 iframe để đánh lừa hệ thống với code mình trộm được ban nãy. Mình sẽ copy nguyên cái request chứa mã xác thực nãy chưa dùng và gắn nó vào src:

![Stolen code](./oauth-profile-linking/iframe-body-request.jpg)

Sau đó, mình send nó và reload lại page và click vào Admin Panel thì mình sẽ thấy được 2 nút delete quyền lực:

![Stolen code](./oauth-profile-linking/admin.jpg)

Đến đây thì bai bai chú Carlos và thế là solved!

![Stolen code](./oauth-profile-linking/solved.jpg)

## Kết luận

Tóm lại, OAuth sẽ có nhiều option để thiết lập, do vậy, khi thiếu state khi trao đổi thông tin từ server và client thì sẽ là một mối nguy hiểm liên quan đến lỗ hổng CSRF.
