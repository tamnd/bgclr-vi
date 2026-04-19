<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<stdbool.h>` Kiểu Boolean {#stdbool}

[i[`stdbool.h` header file]i]

Đây là header file nhỏ định nghĩa vài macro Boolean tiện tay. Nếu
bạn thực sự cần mấy thứ này.

[i[`bool` macro]i]
[i[`true` macro]i]
[i[`false` macro]i]

|Macro  |Mô tả                         |
|-------|------------------------------------|
|`bool` |Kiểu cho Boolean, expand thành `_Bool`|
|`true` |Giá trị true, expand thành `1`          |
|`false`|Giá trị false, expand thành `0`         |

Còn một macro nữa tôi không cho vào bảng vì tên dài ngoằng sẽ phá
nát bảng:

``` {.c}
__bool_true_false_are_defined
```

expand thành `1`.

## Ví dụ

Đây là ví dụ hết sức tầm thường để show off mấy macro này.

``` {.c .numberLines}
#include <stdio.h>
#include <stdbool.h>

int main(void)
{
    bool x;

    x = (3 > 2);

    if (x == true)
        printf("The universe still makes sense.\n");

    x = false;

    printf("x is now %d\n", x);  // 0
}
```

Output:

``` {.default}
The universe still makes sense.
x is now 0
```

## `_Bool`?

`_Bool` là sao? Sao họ không đặt luôn là `bool`?

Chà, ngoài kia có cả đống code C mà người ta đã tự định nghĩa kiểu
`bool` của riêng mình, và thêm một `bool` chính thức sẽ làm hỏng
những `typedef` đó.

Nhưng C đã reserve sẵn mọi định danh bắt đầu bằng dấu gạch dưới
theo sau là chữ cái viết hoa, nên rõ ràng cách làm là nặn ra kiểu
`_Bool` mới và xài nó.

Và, nếu bạn biết code của mình xử được, bạn có thể include header
này để lấy đống syntax ngon nghẻ này.

Một ghi chú nữa về chuyện chuyển đổi: khác với chuyển sang `int`,
thứ _duy nhất_ chuyển thành `false` trong một `_Bool` là giá trị
scalar bằng không. Bất cứ thứ gì khác không, như `-3490`, `0.12`,
hay `NaN`, đều chuyển thành `true`.
