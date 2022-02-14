# Cross-site Scripting (XSS)

## Lỗ hổng Cross-site Scripting (XSS)

Cross-site scripting (XSS) là lỗ hổng cho phép attacker tương tác, phá phách ứng dụng web để có thể đánh lừa, phá vỡ các chính sách của website, tiến hành trích xuất dữ liệu người dùng, leo thang đặc quyền... bằng các đoạn script được truyền vào các tham số, các chức năng của website.

![Cách XSS hoạt động](xss-work.png)

Thông thường, để kiểm tra xem website có dính XSS hay không thì người ta thường dùng *alert()* để gọi website cảnh báo. Hiện nay, người ta dùng thêm *print()* để check XSS vuln.

## Các loại XSS

XSS có rất nhiều loại, người ta gom nó thành 3 loại chính:
- [Reflected XSS](#relected-xss): Truyền malicious script vào HTTP request.
- [Stored XSS](#stored-xss): Liên quan đến Web database khi những malicious script có thể được attacker truyền vào các chức năng của website để tấn công.
- [DOM-based XSS](#dom-xss): Liên quan đến lỗ hổng từ phía Client khi xử lý dữ liệu từ các input trên website.

Để hiểu rõ hơn về XSS thì chúng ta sẽ bắt đầu các LAB về lỗ hổng này ^^

## Relected XSS

Khi một website có chức năng search và filter với URL như sau: `https://insecure-website.com/search?term=gift`. Nếu website dính Relflected XSS, attacker có thể lợi dụng để tấn công bằng cách truyền vào `term` parameter dạng: `https://insecure-website.com/search?term=<script>alert("Hehe website is hacked")</script>`. Điều này có nghĩa, attacker có thể thực hiện nhiều cách thức khác để tiến hành phá hoại hoặc tấn công website.

[Mình sẽ ghi chép lại LAB phần này tại đây ^^](reflected-xss/readme.md)

## Stored XSS

[Mình sẽ ghi chép lại LAB phần này tại đây ^^](stored-xss/readme.md)

## DOM-based XSS

[Mình sẽ ghi chép lại LAB phần này tại đây ^^](dom-xss/readme.md)