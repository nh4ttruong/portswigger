# File Upload Vulnerabilities

## Lỗ hổng file upload

Lỗ hổng file upload là một loại lỗ hổng có mức độ nghiêm trọng cao. Nó được xảy ra khi một web server cho phép người dùng đăng tải một tệp lên filesystems mà không qua những bước xác thực (tên, loại tệp, nội dung, kích thước,...) hoặc hệ thống bị lỗi khi xác thực.

Khi đó, attacker có thể lợi dụng lỗ hổng này để tấn công hệ thống bằng các phương pháp khác nhau, đặc biệt là là RCE (remote code execution), khiến hệ thống của bạn vào trạng thái nguy hiểm.

## Hai tác động chính

Hai tác động chính của lỗ hổng này bao gồm:
- Hệ thống xác thực sai cách và bỏ qua những xác thực quan trọng
- Những ràng buộc được thiết lập thực thi khi tệp đã tải lên hệ thống

Bên cạnh đó, một trong những trường hợp xấu nhất có thể xảy ra đó là hệ thống cho phép thực thi các tệp "có thể thực thi" (như .php hoặc .jsp). Điều này vô tình cho phép attacker tải lên các đoạn code như webshell và kiểm soát hoàn toàn hệ thống của mình.

## Các trường hợp có thể xảy ra

Trong thực tế, các công ty, tổ chức thường kiểm soát rất tốt lỗ hổng này và tự tin vào khả năng xác thực hệ thống của họ. Tuy vậy, khi triển khai 'block' nó thì vẫn có thể tồn tại những trường hợp có thể khiến hệ thống của bạn mắc lỗi này:

- Đơn giản nhất, bạn quên xác thực các loại tệp, nội dung, kích thước,.... của tệp được tải lên
- Bạn tạo blacklist để chặn các loại tệp nguy hiểm nhưng không xác thực những loại **extensions lạ** (ví dụ: .nh4ttruong, .heheattacker,...)
- Web server của bạn an toàn nhưng **không nhất quán** khiến attacker có thể sử dụng để **'path traversal'**
- Hệ thống của bạn bị 'thọt' dẫn đến bị bypass dễ dàng bằng các thủ thuật của attacker

## Labs - Thực hành

### Basic RCE Labs

[Các lab về RCE cơ bản](./basic-rce/README.md)

- Lab: Remote code execution via web shell upload
- Lab: Web shell upload via Content-Type restriction bypass
- Lab: Web shell upload via path traversal

### Bypass Techniques

[Các kỹ thuật bypass filter](./bypass-techniques/README.md)

- Lab: Web shell upload via extension blacklist bypass
- Lab: Web shell upload via obfuscated file extension
- Lab: Remote code execution via polyglot web shell upload

### Advanced Techniques

[Kỹ thuật nâng cao - Race Condition](./advanced-techniques/README.md)

- Lab: Web shell upload via race condition

## Note

### Các cách tấn công khác

Ngoài sử dụng RCE code, file upload còn có thể bị tấn công bằng các thủ thuật như:
- Tải mã độc bằng ở client-side: Như các lỗ hổng store XSS
- Khai thác lỗ hổng trong việc phân tích cú pháp của tệp: Như XXE Injection attacks
- Sử dụng method PUT để upload file

### Một vài cách ngăn chặn

- Sử dụng whitelist thay vì blacklist
- Đảm bảo filename không chứa chuỗi con để server có thể hiểu được đó là một tệp hoặc một chuỗi (tránh path traversal)
- Đổi tên tệp đã tải lên để tránh đụng độ có thể khiến tệp hiện có bị ghi đè
- Không cho phép file tải lên mà không qua bước xác thực, sau đó, chuyển qua nơi lưu trữ chính
