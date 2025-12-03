# XSS - Reflected XSS

Reflected XSS xảy ra khi một website có chức năng search và filter với URL như sau: `https://insecure-website.com/search?term=gift`. Nếu website dính Reflected XSS, attacker có thể lợi dụng để tấn công bằng cách truyền vào `term` parameter dạng: `https://insecure-website.com/search?term=<script>alert("Hehe website is hacked")</script>`.

## HTML Context Labs

- [Reflected XSS with nothing encoded](./html-context-nothing-encoded.md)
- [Reflected XSS with most tags and attributes blocked](./html-context-tags-blocked.md)
- [Reflected XSS with all tags blocked except custom ones](./html-context-custom-tags.md)
- [Reflected XSS with event handlers and href blocked](./event-handlers-href-blocked.md)
- [Reflected XSS with some SVG markup allowed](./svg-markup-allowed.md)
- [Reflected XSS with angle brackets HTML-encoded](./angle-brackets-encoded.md)
- [Reflected XSS in canonical link tag](./canonical-link-tag.md)

## JavaScript Context Labs

- [Reflected XSS with single quote and backslash escaped](./js-single-quote-escaped.md)
- [Reflected XSS with angle brackets encoded](./js-angle-brackets-encoded.md)
- [Reflected XSS with all encoded and escaped](./js-all-encoded-escaped.md)

## Tổng quan

Reflected XSS techniques bao gồm:
- Bypass HTML encoding
- Bypass tag/attribute filtering
- Sử dụng custom tags và SVG
- Escape từ JavaScript context
- Trigger qua event handlers
