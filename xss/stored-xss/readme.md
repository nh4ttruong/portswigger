sdaaaaaaaaaaaaaaaaa


## Khai thác lỗ hổng Reflected XSS <a name="exploit"></a>

Như đã nói ở phần ví dụ, người ta thường dùng *alert()* để kiểm tra xem website có dính XSS hay không. Bên cạnh đó, để chắc chắn hơn lỗi XSS đến từ chính website đó, người ta sẽ dùng payload `alert(document.domain)` để hiển thị pop-up cho ra domain của website.

Bây giờ thì cùng thực hiện "khai thác" lỗ hổng này:

### Lab: Exploiting cross-site scripting to steal cookies <a name="steal-cookie"></a>