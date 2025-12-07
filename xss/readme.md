# Cross-site Scripting (XSS)

## Lỗ hổng Cross-site Scripting (XSS)

Cross-site Scripting (XSS) là lỗ hổng cho phép attacker inject malicious scripts vào web pages được xem bởi users khác. Attacker có thể:
- Đánh cắp session tokens, cookies
- Thực hiện actions thay mặt victim
- Đọc/modify nội dung trang web
- Phishing và social engineering

![Cách XSS hoạt động](xss-work.png)

Thông thường, để kiểm tra XSS người ta dùng `alert()` hoặc `print()` để trigger popup.

## Các loại XSS

XSS được chia thành 3 loại chính:

### **Reflected XSS**
Malicious script được truyền qua HTTP request và phản hồi ngay lập tức trong response. Không được lưu trữ.

**Ví dụ:** `https://vulnerable.com/search?q=<script>alert(1)</script>`

### **Stored XSS** 
Malicious script được lưu vào database và hiển thị cho mọi user truy cập. Nguy hiểm hơn Reflected XSS.

**Ví dụ:** Comment, profile bio, forum posts

### **DOM-based XSS**
Lỗ hổng xảy ra ở client-side khi JavaScript xử lý data không an toàn từ DOM sources (URL, localStorage, etc.)

## Labs - Danh sách các bài thực hành

### 1. Reflected XSS
[Các lab về Reflected XSS](./reflected-xss/readme.md)

#### HTML Context
- [Reflected XSS with nothing encoded](./reflected-xss/html-context-nothing-encoded.md)
- [Reflected XSS with most tags and attributes blocked](./reflected-xss/html-context-tags-blocked.md)
- [Reflected XSS with all tags blocked except custom ones](./reflected-xss/html-context-custom-tags.md)
- [Reflected XSS with event handlers and href blocked](./reflected-xss/event-handlers-href-blocked.md)
- [Reflected XSS with some SVG markup allowed](./reflected-xss/svg-markup-allowed.md)
- [Reflected XSS with angle brackets HTML-encoded](./reflected-xss/angle-brackets-encoded.md)
- [Reflected XSS in canonical link tag](./reflected-xss/canonical-link-tag.md)

#### JavaScript Context
- [Reflected XSS with single quote and backslash escaped](./reflected-xss/js-single-quote-escaped.md)
- [Reflected XSS with angle brackets encoded](./reflected-xss/js-angle-brackets-encoded.md)
- [Reflected XSS with all encoded and escaped](./reflected-xss/js-all-encoded-escaped.md)

### 2. Stored XSS
[Các lab về Stored XSS](./stored-xss/readme.md)

*Coming soon...*

### 3. DOM-based XSS
*Coming soon...*

## Cách phòng chống XSS

### Input Validation & Output Encoding
- **Encode output**: HTML encode `< > " ' &` khi hiển thị user input
- **Context-aware encoding**: HTML context khác JavaScript context khác URL context
- **Validate input**: Whitelist allowed characters
- **Sanitize HTML**: Nếu cho phép HTML, dùng library như DOMPurify

### Content Security Policy (CSP)
Sử dụng CSP headers để restrict nguồn scripts có thể chạy:
```
Content-Security-Policy: script-src 'self' https://trusted.cdn.com
```

### HTTPOnly & Secure Cookies
- Set `HttpOnly` flag để JavaScript không đọc được cookies
- Set `Secure` flag để cookies chỉ gửi qua HTTPS

### Framework Protection
Modern frameworks như React, Angular, Vue tự động escape output. Tuy nhiên vẫn cần cẩn thận với:
- `dangerouslySetInnerHTML` (React)
- `bypassSecurityTrustHtml` (Angular)
- `v-html` (Vue)

## Tài nguyên tham khảo

- [PortSwigger XSS Guide](https://portswigger.net/web-security/cross-site-scripting)
- [OWASP XSS Prevention Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Cross_Site_Scripting_Prevention_Cheat_Sheet.html)
- [XSS Filter Evasion Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/XSS_Filter_Evasion_Cheat_Sheet.html)
