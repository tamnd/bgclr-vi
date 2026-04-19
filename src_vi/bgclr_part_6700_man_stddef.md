<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<stddef.h>` Vài Định Nghĩa Chuẩn {#stddef}

[i[`stddef.h` header file]i]

Dù tên gọi vậy, tôi hiếm khi thấy header này được include.

Nó gồm vài kiểu và macro.

|Tên|Mô tả
|-|-|
|[`ptrdiff_t`](#man-ptrdiff_t)|Integer có dấu cho hiệu giữa hai pointer|
|[`size_t`](#man-size_t)|Kiểu integer không dấu mà `sizeof` trả về|
|[`max_align_t`](#man-max_align_t)|Khai báo một kiểu với alignment lớn nhất có thể|
|[`wchar_t`](#man-wchar_t)|Kiểu ký tự rộng|
|`NULL`|Con trỏ `NULL`, được định nghĩa ở vài chỗ|
|[`offsetof`](#man-offsetof)|Lấy byte offset của trường trong `struct` hoặc `union`|

## `ptrdiff_t` {#man-ptrdiff_t}

[i[`ptrdiff_t` type]i]

Kiểu này giữ hiệu giữa hai pointer. Bạn có thể lưu kết quả này vào
kiểu khác, nhưng kiểu của kết quả phép trừ pointer là
implementation-defined; portable tối đa thì dùng `ptrdiff_t`.

``` {.c .numberLines}
#include <stdio.h>
#include <stddef.h>

int main(void)
{
	int cats[100];

	int *f = cats + 20;
	int *g = cats + 60;

	ptrdiff_t d = g - f;  // hiệu là 40

```

Và bạn có thể in nó bằng cách thêm prefix `t` vào format specifier
integer:

``` {.c .numberLines startFrom="13"}
	printf("%td\n", d);  // In thập phân: 40
	printf("%tX\n", d);  // In hex:       28
}
```

## `size_t` {#man-size_t}

[i[`size_t` type]i]

Đây là kiểu mà `sizeof` trả về và được dùng ở vài chỗ khác. Nó là
integer không dấu.

Bạn có thể in nó dùng prefix `z` trong `printf()`:

``` {.c .numberLines}
#include <stdio.h>
#include <uchar.h>
#include <string.h>
#include <stddef.h>

int main(void)
{
    size_t x;

    x = sizeof(int);

    printf("%zu\n", x);

```

Một số hàm trả về số âm cast thành `size_t` làm giá trị lỗi (như
[`mbrtoc16()`](#man-mbrtoc16)). Nếu muốn in mấy cái đó dưới dạng
giá trị âm, bạn có thể dùng `%zd`:

``` {.c .numberLines startFrom="14"}
    char16_t a;
    mbstate_t mbs;
    memset(&mbs, 0, sizeof mbs);

    x = mbrtoc16(&a, "b", 8, &mbs);

    printf("%zd\n", x);
}
```

## `max_align_t` {#man-max_align_t}

[i[`max_align_t` type]i]

Theo hiểu của tôi, cái này tồn tại để cho phép tính runtime
[flw[alignment|Data_structure_alignment]] fundamental tối đa trên
nền tảng hiện tại. Ai biết thêm công dụng khác làm ơn mail cho tôi.

Có lẽ bạn cần cái này nếu đang viết memory allocator của riêng
mình hay gì đó.

``` {.c .numberLines}
#include <stddef.h>
#include <stdio.h>      // For printf()
#include <stdalign.h>   // For alignof

int main(void)
{
    int max = alignof(max_align_t);

    printf("Maximum fundamental alignment: %d\n", max);
}
```

Trên hệ của tôi, in ra:

``` {.default}
Maximum fundamental alignment: 16
```

Xem thêm [`alignas`](#man-alignas), [`alignof`](#man-alignof).

## `wchar_t` {#man-wchar_t}

[i[`wchar_t` type]i]

Cái này tương tự `char`, chỉ khác là nó dành cho ký tự rộng (wide
character).

Đây là kiểu integer có tầm đủ lớn để giữ giá trị duy nhất cho mọi
ký tự trong mọi locale được hỗ trợ.

Giá trị `0` là ký tự `NUL` rộng.

Cuối cùng, giá trị của các hằng ký tự từ tập ký tự cơ bản sẽ bằng
với giá trị `wchar_t` tương ứng... trừ khi
`__STDC_MB_MIGHT_NEQ_WC__` được định nghĩa.

## `offsetof` {#man-offsetof}

[i[`offsetof` operator]i]

Nếu bạn có `struct` hoặc `union`, bạn có thể dùng cái này để lấy
byte offset của các trường trong kiểu đó.

Cách dùng:

``` {.c}
offsetof(type, fieldname);
```

Giá trị kết quả có kiểu `size_t`.

Đây là ví dụ in offset trường của một `struct`:

``` {.c .numberLines}
#include <stdio.h>
#include <stddef.h>

struct foo {
    int a;
    char b;
    char c;
    float d;
};

int main(void)
{
    printf("a: %zu\n", offsetof(struct foo, a));
    printf("b: %zu\n", offsetof(struct foo, b));
    printf("c: %zu\n", offsetof(struct foo, c));
    printf("d: %zu\n", offsetof(struct foo, d));
}
```

Trên hệ của tôi, output là:

``` {.default}
a: 0
b: 4
c: 5
d: 8
```

Và bạn không thể dùng `offsetof` trên bitfield, nên đừng hi vọng hão.
