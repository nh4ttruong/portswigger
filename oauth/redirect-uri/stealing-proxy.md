# Lab: Stealing OAuth access tokens via a proxy page

**Link:** [https://portswigger.net/web-security/oauth/lab-oauth-stealing-oauth-access-tokens-via-a-proxy-page](https://portswigger.net/web-security/oauth/lab-oauth-stealing-oauth-access-tokens-via-a-proxy-page)

![OAuth-stealing-proxy-page](oauth-stealing-proxy/lab.jpg)

## Phân tích

Bài này cũng khá giống với bài bên trên, audit website thì ta có thể thấy ở mỗi post đều có chức năng bình luận và bình luận cái gì cũng được:

![Test comment](oauth-stealing-proxy/comment.jpg)

Đến đây, sau khi tham khảo payload, mình đã thử sử dụng payload như sau:

![Payload](oauth-stealing-proxy/payload.jpg)

Store và View Exploit thì thấy ta đã có một iframe comment như lab:

![View Exploit](oauth-stealing-proxy/view-exploit.jpg)

## Khai thác

Đến đây coi như xong, ta Delivery exploit code sau đó check log để get token:

![Get token](oauth-stealing-proxy/log.jpg)

Send token bằng request **/me**:

![Exploit](oauth-stealing-proxy/exploit.jpg)

Như vậy, ta đã có được API của administrator, submit thôi:

![API key](oauth-stealing-proxy/solved.jpg)
