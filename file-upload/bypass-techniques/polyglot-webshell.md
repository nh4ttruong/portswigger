# Lab: Remote code execution via polyglot web shell upload

**Link:** [https://portswigger.net/web-security/file-upload/lab-file-upload-remote-code-execution-via-polyglot-web-shell-upload](https://portswigger.net/web-security/file-upload/lab-file-upload-remote-code-execution-via-polyglot-web-shell-upload)

![Lab](./polyglot-webshell/lab.jpg)

## Giới thiệu

Để tăng mức độ bảo mật cho hệ thống, các server thay vì xác thực Content-Type thì nó sẽ xác thực nội dung của file. Ví dụ, các file hình ảnh JPEG luôn bắt đầu bằng chuỗi bytes `FF D8 FF`.

Bài lab này sẽ thử thách ta bypass mà không thể thay đổi extension của file.

## Phân tích

Thử upload 1.php lên server và kết quả trả về:

![Thử upload 1.php](./polyglot-webshell/error.jpg)

Ta có thể tải bất kỳ tệp nào lên server nhưng phải thỏa mãn nó là hình ảnh (PNG/JPG) vì nó là avatar mà. Server sẽ xác thực signature của file như ví dụ mình nêu trên. Do đó, ta sẽ sử dụng trick để "ép" 1 file chứa RCE code thành 1 file thỏa điều kiện của server.

## Khai thác

[exiftool](https://github.com/exiftool/exiftool) là một trong những công cụ tối ưu hỗ trợ việc thay đổi metadata của file. Ta sẽ sử dụng nó để thay đổi "dấu hiệu" trong file để làm server nghĩ rằng đó là một file hình ảnh và ta sẽ thêm `-Comment="<?php echo 'START ' . file_get_contents('/home/carlos/secret') . ' END'; ?>"` vào file exploit.php mà exiftool sẽ tạo ra:

![Sử dụng exiftool](./polyglot-webshell/create-polygot.jpg)

Upload [exploit.php](./polyglot-webshell/exploit.php) lên server:

![Upload exploit.php lên server](./polyglot-webshell/upload.jpg)

Server không chặn việc ta tải lên nữa rồi =)))). GET bí mật bằng cách cho nó thực thi thôi:

![Lab](./polyglot-webshell/bypass.jpg)

Và submit bí mật:

![Submit](./polyglot-webshell/solved.jpg)
