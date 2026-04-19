<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<iso646.h>` Cách Viết Thay Thế Cho Toán Tử {#iso646}

[i[`iso646.h` header file]i]

ISO-646 là một chuẩn mã hóa ký tự rất giống ASCII. Nhưng nó thiếu vài
ký tự đáng chú ý như `|`, `^`, và `~`.

Vì đây là các toán tử hoặc thành phần của toán tử trong C, header
này định nghĩa một số macro bạn có thể dùng phòng khi bàn phím của
bạn không có những ký tự đó. (Và C++ cũng xài được cùng bộ thay thế
này.)

[i[`and` macro]i]
[i[`and_eq` macro]i]
[i[`bitand` macro]i]
[i[`bitor` macro]i]
[i[`compl` macro]i]
[i[`not` macro]i]
[i[`not_eq` macro]i]
[i[`or` macro]i]
[i[`or_eq` macro]i]
[i[`xor` macro]i]
[i[`xor_eq` macro]i]

|Toán tử|Tương đương trong `<iso646.h>`|
|-|-|
|`&&`|`and`|
|`&=`|`and_eq`|
|`&`|`bitand`|
|`|`|`bitor`|
|`~`|`compl`|
|`!`|`not`|
|`!=`|`not_eq`|
|`||`|`or`|
|`|=`|`or_eq`|
|`^`|`xor`|
|`^=`|`xor_eq`|

Điều thú vị là không có `eq` cho `==`, và `&` với `!` vẫn được đưa
vào dù chúng có trong ISO-646.

Ví dụ dùng:

``` {.c .numberLines}
#include <stdio.h>
#include <iso646.h>

int main(void)
{
    int x = 12;
    int y = 30;

    if (x == 12 and y not_eq 40)
        printf("Now we know.\n");
}
```

Cá nhân tôi chưa từng thấy file này được include, nhưng chắc thỉnh
thoảng cũng có người dùng.
