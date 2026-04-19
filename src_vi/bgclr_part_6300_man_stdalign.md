<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<stdalign.h>` Macro Cho Alignment {#stdalign}

[i[`stdalign.h` header file]i]

Nếu bạn đang code thứ gì đó low-level như một memory allocator giao
tiếp với OS, bạn có thể cần header này. Nhưng hầu hết dev C trải cả
sự nghiệp mà chưa bao giờ dùng nó.

[flw[_Alignment_|Data_structure_alignment]] là về bội số của địa chỉ
mà object có thể được lưu. Object có thể lưu ở bất kỳ địa chỉ nào?
Hay phải là địa chỉ chia hết cho 2? Hay 8? Hay 16?

|Tên|Mô tả
|-|-|
|[`alignas()`](#man-alignas)|Chỉ định alignment, expand thành `_Alignas`|
|[`alignof()`](#man-alignof)|Lấy alignment, expand thành `_Alignof`|

Hai macro bổ sung sau được định nghĩa bằng `1`:

[i[`__alignas_is_defined` macro]i]
[i[`__alignof_is_defined` macro]i]

``` {.c}
__alignas_is_defined
__alignof_is_defined
```

Ghi chú nhanh: các alignment lớn hơn của `max_align_t` được gọi là
_overalignment_ và là implementation-defined.


## `alignas()` `_Alignas()` {#man-alignas}

[i[`alignas()` alignment specifier]i]
[i[`_Alignas()` alignment specifier]i]

Bắt biến phải có một alignment nhất định

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdalign.h>

alignas(type-name)
alignas(constant-expression)
```

``` {.c}
_Alignas(type-name)
_Alignas(constant-expression)
```

### Mô tả {.unnumbered .unlisted}

Dùng _alignment specifier_ này để bắt buộc alignment cho biến cụ
thể. Ví dụ, ta có thể khai báo `c` là `char`, nhưng align giống như
nó là `int`:

``` {.c}
char alignas(int) c;
```

Bạn cũng có thể đặt biểu thức integer hằng vào đó. Compiler có lẽ
sẽ áp limit lên giá trị mà biểu thức này có thể nhận. Lũy thừa nhỏ
của 2 (1, 2, 4, 8, và 16) thường là đặt cược an toàn.

``` {.c}
char alignas(8) c;   // align theo ranh giới 8-byte
```

Cho tiện, bạn cũng có thể chỉ định `0` nếu muốn alignment mặc định
(như thể bạn không nói `alignas()` gì cả):

``` {.c}
char alignas(0) c;   // dùng alignment mặc định cho kiểu này
```

<!--
### Return Value {.unnumbered .unlisted}
-->

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdalign.h>
#include <stdio.h>     // for printf()
#include <stddef.h>    // for max_align_t

int main(void)
{
    int i, j;
    char alignas(max_align_t) a, b;
    char alignas(int) c, d;
    char e, f;

    printf("i: %p\n", (void *)&i);
    printf("j: %p\n\n", (void *)&j);
    printf("a: %p\n", (void *)&a);
    printf("b: %p\n\n", (void *)&b);
    printf("c: %p\n", (void *)&c);
    printf("d: %p\n\n", (void *)&d);
    printf("e: %p\n", (void *)&e);
    printf("f: %p\n", (void *)&f);
}
```

Output trên hệ của tôi bên dưới. Chú ý sự khác biệt giữa các cặp
giá trị.

* `i` và `j`, đều là `int`, align theo ranh giới 4-byte.
* `a` và `b` bị bắt về ranh giới của kiểu `max_align_t`, tức mỗi 16
  byte trên hệ của tôi.
* `c` và `d` bị bắt về cùng alignment với `int`, tức 4 byte, giống
  như `i` và `j`.
* `e` và `f` không có alignment chỉ định, nên chúng được lưu với
  alignment mặc định là 1 byte.

``` {.default}
i: 0x7ffee7dfb4cc    <-- difference of 4 bytes
j: 0x7ffee7dfb4c8

a: 0x7ffee7dfb4c0    <-- difference of 16 bytes
b: 0x7ffee7dfb4b0

c: 0x7ffee7dfb4ac    <-- difference of 4 bytes
d: 0x7ffee7dfb4a8

e: 0x7ffee7dfb4a7    <-- difference of 1 byte
f: 0x7ffee7dfb4a6
```

### Xem thêm {.unnumbered .unlisted}

[`alignof`](#man-alignof),
[`max_align_t`](#man-max_align_t),
[`memalignment()`](#man-memalignment)

[[manbreak]]
## `alignof()` `_Alignof()` {#man-alignof}

[i[`alignof()` operator]i]
[i[`_Alignof()` operator]i]

Lấy alignment của một kiểu

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdalign.h>

alignof(type-name)
```

``` {.c}
_Alignof(type-name)
```

### Mô tả {.unnumbered .unlisted}

Biểu thức này eval thành một giá trị kiểu `size_t` cho biết
alignment của một kiểu cụ thể trên hệ của bạn.

### Giá trị trả về {.unnumbered .unlisted}

Trả về giá trị alignment, tức là địa chỉ bắt đầu của object kiểu đã
cho phải ở ranh giới chia hết cho số này.

### Ví dụ {.unnumbered .unlisted}

In ra alignment của đủ loại kiểu khác nhau.

``` {.c .numberLines}
#include <stdalign.h>
#include <stdio.h>     // for printf()
#include <stddef.h>    // for max_align_t

struct t {
    int a;
    char b;
    float c;
};

int main(void)
{
    printf("char       : %zu\n", alignof(char));
    printf("short      : %zu\n", alignof(short));
    printf("int        : %zu\n", alignof(int));
    printf("long       : %zu\n", alignof(long));
    printf("long long  : %zu\n", alignof(long long));
    printf("double     : %zu\n", alignof(double));
    printf("long double: %zu\n", alignof(long double));
    printf("struct t   : %zu\n", alignof(struct t));
    printf("max_align_t: %zu\n", alignof(max_align_t));
}
```

Output trên hệ của tôi:

``` {.default}
char       : 1
short      : 2
int        : 4
long       : 8
long long  : 8
double     : 8
long double: 16
struct t   : 16
max_align_t: 16
```

### Xem thêm {.unnumbered .unlisted}

[`alignas`](#man-alignas),
[`max_align_t`](#man-max_align_t),
[`memalignment()`](#man-memalignment)

<!--
[[manbreak]]
## `example()` `example()` `example()` {#man-example}

### Synopsis {.unnumbered .unlisted}

``` {.c}
```

### Description {.unnumbered .unlisted}

### Return Value {.unnumbered .unlisted}

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
```

### See Also {.unnumbered .unlisted}

[`example()`](#man-example),
-->
