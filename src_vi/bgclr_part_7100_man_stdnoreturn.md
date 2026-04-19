<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<stdnoreturn.h>` Macro Cho Hàm Không Trả Về {#stdnoreturn}

[i[`stdnoreturn.h` header file]i]

Header này cung cấp một macro [i[`noreturn` macro]i] `noreturn` là
bí danh tiện tay cho `_Noreturn`.

Dùng macro này để báo cho compiler biết một hàm sẽ không bao giờ
trả về chỗ gọi. Undefined behavior nếu hàm được đánh dấu như vậy
mà vẫn trả về.

Ví dụ sử dụng:

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>
#include <stdnoreturn.h>

noreturn void foo(void) // Hàm này không bao giờ nên return!
{
    printf("Happy days\n");

    exit(1);            // Và nó không return--nó exit ở đây!
}

int main(void)
{
    foo();
}
```

Có vậy thôi.
