# SQL Injection - Blind SQLi

Blind SQL Injection cho phép attack có thể sử dụng những chức năng khác của SQL để trigger, tìm kiếm và suy luận từ những response từ server mà không cần dựa vào bất kỳ lỗ hổng nào khác. Do vậy, nó được gọi là Blind - "mù".

## Labs

- [Lab: Blind SQL injection with conditional responses](./conditional-responses.md)
- [Lab: Blind SQL injection with conditional errors](./conditional-errors.md)
- [Lab: Blind SQL injection with time delays](./time-delays.md)
- [Lab: Blind SQL injection with time delays and information retrieval](./time-delays-info-retrieval.md)

## Tổng quan

Blind SQLi techniques:
- **Conditional Responses**: Dựa vào sự khác biệt trong response để suy luận
- **Conditional Errors**: Trigger lỗi có điều kiện để xác định thông tin
- **Time Delays**: Sử dụng time delay để xác nhận query
- **Time Delays + Info Retrieval**: Kết hợp time delay với brute force để trích xuất dữ liệu
