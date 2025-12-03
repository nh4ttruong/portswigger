# Lab: Reflected XSS into a JavaScript string with single quote and backslash escaped

**Lab URL:** [PortSwigger Lab](https://portswigger.net/web-security/cross-site-scripting/contexts/lab-javascript-string-single-quote-backslash-escaped)

## Mô tả

Lab này yêu cầu ta dùng trick để bypass bằng dấu "'" và "/", "\" của website.

## Phân tích

Test thử thanh search của Lab và check source code:

![Source code](js-single-quote/source.png)

Ta thấy, script của website sẽ như sau:

```javascript
<script>
    var searchTerms = '123';
    document.write('<img src="/resources/images/tracker.gif?searchTerms='+encodeURIComponent(searchTerms)+'">');
</script>
```

`encodeURIComponent()` trong Javascript sẽ mã hóa tất cả các ký tự ngoại trừ `- _ . ! ~ * ' ( )`. Do vậy, mình đã thử nhiều cái những vẫn bị encode đưa vào `document.write`.

Nhưng mà, ta có thể chèn `</script>` vô để khóa cái `searchTerms` lại và chèn thêm script tùy ý vào mà đúng không =))))

## Khai thác

Payload: `</script><script>alert(1)</script>`

## Kết quả

![Solved](js-single-quote/solved.png)
