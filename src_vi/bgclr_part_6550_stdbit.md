<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<stdbit.h>` Các Hàm Liên Quan Đến Bit {#stdbit}

[i[`stdbit.h` header file]i]

Header file này cùng với toàn bộ các hàm bên trong đều là mới trong C23!

Lưu ý: không có compiler nào của tôi hỗ trợ cái này, nên toàn bộ code
chưa được kiểm thử!

|Hàm|Mô tả|
|-------------------------|------------------------------------------|
|[`stdc_bit_ceil()`](#man-stdc_bit_ceil)|Trả về lũy thừa của 2 nhỏ nhất không nhỏ hơn một số|
|[`stdc_bit_floor()`](#man-stdc_bit_floor)|Trả về lũy thừa của 2 lớn nhất không lớn hơn một số|
|[`stdc_bit_width()`](#man-stdc_bit_width)|Trả về số bit cần dùng để lưu một giá trị|
|[`stdc_count_ones()`](#man-stdc_count_ones)|Đếm số bit 1 trong một số unsigned|
|[`stdc_count_zeros()`](#man-stdc_count_zeros)|Đếm số bit 0 trong một số unsigned|
|[`stdc_first_leading_one()`](#man-stdc_first_leading_one)|Tìm bit 1 đầu tiên từ phía trước trong một số unsigned|
|[`stdc_first_leading_zero()`](#man-stdc_first_leading_zero)|Tìm bit 0 đầu tiên từ phía trước trong một số unsigned|
|[`stdc_first_trailing_one()`](#man-stdc_first_trailing_one)|Tìm bit 1 đầu tiên từ phía sau trong một số unsigned|
|[`stdc_first_trailing_zero()`](#man-stdc_first_trailing_zero)|Tìm bit 0 đầu tiên từ phía sau trong một số unsigned|
|[`stdc_has_single_bit()`](#man-stdc_has_single_bit)|Kiểm tra xem một số nguyên unsigned có đúng một bit được set không|
|[`stdc_leading_ones()`](#man-stdc_leading_ones)|Đếm số 1 đầu (đếm số 1 đầu) trong một số unsigned|
|[`stdc_leading_zeros()`](#man-stdc_leading_zeros)|Đếm số 0 đầu (đếm số 0 đầu) trong một số unsigned|
|[`stdc_trailing_ones()`](#man-stdc_trailing_ones)|Đếm số 1 cuối (đếm số 1 cuối) trong một số unsigned|
|[`stdc_trailing_zeros()`](#man-stdc_trailing_zeros)|Đếm số 0 cuối (đếm số 0 cuối) trong một số unsigned|

## Macro Kiểm Tra Sự Tồn Tại

Vì đây là một tính năng mới, bạn có thể kiểm tra sự tồn tại của nó
bằng cách đảm bảo macro `__STDC_VERSION_STDBIT_H__`
[i[`__STDC_VERSION_STDBIT_H__` macro]] tồn tại và có giá trị là
`202311L` hoặc lớn hơn.

## Các Macro Endian {#endianess-macros}

[i[Endianess]<]
[i[`__STDC_ENDIAN_NATIVE__` macro]<]
[i[`__STDC_ENDIAN_BIG__` macro]<]
[i[`__STDC_ENDIAN_LITTLE__` macro]<]

Header file này định nghĩa một số macro có thể dùng để xác định
_endian_ của hệ thống. (Nghĩa là, trong một giá trị nhiều byte, byte
đầu tiên có biểu diễn phần có trọng số lớn nhất của giá trị không, hay
nhỏ nhất? Hay chẳng phải cái nào?)

Có hai giá trị khác nhau cho các endian đã định nghĩa là
`__STDC_ENDIAN_BIG__` và `__STDC_ENDIAN_LITTLE__`.

Ngoài ra, còn có một macro `__STDC_ENDIAN_NATIVE__` (native endian)
cho bạn biết endian của _hệ thống này_. Bạn có thể so sánh nó với hai
macro kia để xem mình đang có gì. Nếu nó không bằng cái nào trong hai,
thì chắc bạn đang ở trên một hệ thống mixed-endian nào đó.

Thử xem hệ thống này là gì nào:

``` {.c}
#include <stdio.h>
#include <stdbit.h>

int main(void)
{
    switch(__STDC_ENDIAN_NATIVE__) {
        case __STDC_ENDIAN_BIG__:
            puts("Big-endian!");
            break;

        case __STDC_ENDIAN_LITTLE__:
            puts("Little-endian!");
            break;

        default:
            puts("Other-endian!");
    }
}
```
[i[Endianess]>]
[i[`__STDC_ENDIAN_NATIVE__` macro]>]
[i[`__STDC_ENDIAN_BIG__` macro]>]
[i[`__STDC_ENDIAN_LITTLE__` macro]>]

## Cấu Trúc Chung Của Các Hàm Này

Tất cả các hàm trong header này đều đi theo một khuôn mẫu chuẩn, nên
ta cũng nên điểm qua một lần ở đây ngay từ đầu để khỏi dài dòng lê thê
về sau.

Mỗi hàm đều có sáu dạng thần thánh, tùy theo các kiểu liên quan.

Trước hết, chúng chỉ làm việc trên các kiểu số nguyên unsigned, nên ta
gạt chuyện đó ra khỏi đầu luôn.

Và chúng _phần lớn_ sẽ trả về `unsigned int`.

Và chúng đi theo hai dạng con: dạng type-specific và dạng
type-generic.

Ta nhìn dạng type-specific trước. Ta sẽ dùng hàm đếm số bit 0 đầu
trong một giá trị làm ví dụ. Đây:

``` {.c}
unsigned int stdc_leading_zeros_uc(unsigned char value);
unsigned int stdc_leading_zeros_us(unsigned short value);
unsigned int stdc_leading_zeros_ui(unsigned int value);
unsigned int stdc_leading_zeros_ul(unsigned long value);
unsigned int stdc_leading_zeros_ull(unsigned long long value);
```

Ôi chao. OK, ta có gì nào?

Để tránh ô nhiễm namespace, tất cả đều bắt đầu bằng `stdc_`.

Còn mấy cái `uc`, `us`, `ull`, v.v. thì sao? Chúng tương ứng với kiểu
của tham số, bạn sẽ thấy nếu để ý một chút.

|Hậu tố|Kiểu tham số|
|-|-|
|`_uc`|`unsigned char`|
|`_us`|`unsigned short`|
|`_ui`|`unsigned int`|
|`_ul`|`unsigned long`|
|`_ull`|`unsigned long long`|

Nhưng khoan! Còn nữa!

Mỗi họ hàm này trong header còn có một biến thể _generic_.

Lại lấy `count_leading_zeros` làm ví dụ, có một phiên bản không cần
chỉ định kiểu, nó chỉ là tên hàm không có hậu tố nào.

``` {.c}
generic_return_type stdc_leading_zeros(generic_value_type value);
```

Trong ví dụ đó, các chữ `generic_return_type` và `generic_value_type`
**không** phải là từ khóa C. Chúng chỉ là placeholder để báo cho bạn
biết chỗ đó cần thay bằng thứ đúng.

``` {.c}
unsigned short x = 3490;

unsigned int a = stdc_leading_zeros(x);
auto b = stdc_leading_zeros(1234);
```

Các hàm generic làm việc với tất cả các kiểu unsigned, không tính
`bool`.

[[manbreak]]
## `stdc_leading_zeros()` {#man-stdc_leading_zeros}

[i[`stdc_leading_zeros()` function]i]

Đếm số 0 đầu (đếm số 0 đầu) trong một số unsigned

### Synopsis {.unnumbered .unlisted}

Mới trong C23!

``` {.c}
#include <stdbit.h>

unsigned int stdc_leading_zeros_uc(unsigned char value);
unsigned int stdc_leading_zeros_us(unsigned short value);
unsigned int stdc_leading_zeros_ui(unsigned int value);
unsigned int stdc_leading_zeros_ul(unsigned long value);
unsigned int stdc_leading_zeros_ull(unsigned long long value);

generic_return_type stdc_leading_zeros(generic_value_type value);
```

### Mô tả {.unnumbered .unlisted}

Hàm này trả về số bit 0 ở đầu của một giá trị nhất định, tính từ bit
có trọng số lớn nhất. Con số này sẽ bị ảnh hưởng bởi kích thước của
tham số.

### Giá trị trả về {.unnumbered .unlisted}

Trả về số bit 0 ở đầu.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdbit.h>

int main(void)
{
    unsigned int value = 3490;
    unsigned int count = stdc_leading_zeros_ui(value);

    printf("%u\n", count);

    unsigned long long value2 = 3490;
    auto count2 = stdc_leading_zeros(value2);

    printf("%u\n", count2);
}
```

### Xem thêm {.unnumbered .unlisted}

[`stdc_leading_ones()`](#man-stdc_leading_ones),
[`stdc_trailing_zeros()`](#man-stdc_trailing_zeros)

[[manbreak]]
## `stdc_leading_ones()` {#man-stdc_leading_ones}

[i[`stdc_leading_ones()` function]i]

Đếm số 1 đầu (đếm số 1 đầu) trong một số unsigned

### Synopsis {.unnumbered .unlisted}

Mới trong C23!

``` {.c}
#include <stdbit.h>

unsigned int stdc_leading_ones_uc(unsigned char value);
unsigned int stdc_leading_ones_us(unsigned short value);
unsigned int stdc_leading_ones_ui(unsigned int value);
unsigned int stdc_leading_ones_ul(unsigned long value);
unsigned int stdc_leading_ones_ull(unsigned long long value);

generic_return_type stdc_leading_ones(generic_value_type value);
```

### Mô tả {.unnumbered .unlisted}

Hàm này trả về số bit 1 ở đầu của một giá trị nhất định, tính từ bit
có trọng số lớn nhất. Con số này sẽ bị ảnh hưởng bởi kích thước của
tham số.

### Giá trị trả về {.unnumbered .unlisted}

Trả về số bit 1 ở đầu.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdbit.h>

int main(void)
{
    unsigned int value = 3490;
    unsigned int count = stdc_leading_ones_ui(value);

    printf("%u\n", count);

    unsigned long long value2 = 3490;
    auto count2 = stdc_leading_ones(value2);

    printf("%u\n", count2);
}
```

### Xem thêm {.unnumbered .unlisted}

[`stdc_leading_zeros()`](#man-stdc_leading_zeros),
[`stdc_trailing_ones()`](#man-stdc_trailing_ones)

[[manbreak]]
## `stdc_trailing_zeros()` {#man-stdc_trailing_zeros}

[i[`stdc_trailing_zeros()` function]i]

Đếm số 0 cuối (đếm số 0 cuối) trong một số unsigned

### Synopsis {.unnumbered .unlisted}

Mới trong C23!

``` {.c}
#include <stdbit.h>

unsigned int stdc_trailing_zeros_uc(unsigned char value);
unsigned int stdc_trailing_zeros_us(unsigned short value);
unsigned int stdc_trailing_zeros_ui(unsigned int value);
unsigned int stdc_trailing_zeros_ul(unsigned long value);
unsigned int stdc_trailing_zeros_ull(unsigned long long value);

generic_return_type stdc_trailing_zeros(generic_value_type value);
```

### Mô tả {.unnumbered .unlisted}

Hàm này trả về số bit 0 ở cuối của một giá trị nhất định, tính từ bit
có trọng số nhỏ nhất. Con số này sẽ bị ảnh hưởng bởi kích thước của
tham số.

### Giá trị trả về {.unnumbered .unlisted}

Trả về số bit 0 ở cuối.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdbit.h>

int main(void)
{
    unsigned int value = 3490;
    unsigned int count = stdc_trailing_zeros_ui(value);

    printf("%u\n", count);

    unsigned long long value2 = 3490;
    auto count2 = stdc_trailing_zeros(value2);

    printf("%u\n", count2);
}
```

### Xem thêm {.unnumbered .unlisted}

[`stdc_trailing_ones()`](#man-stdc_trailing_ones),
[`stdc_leading_zeros()`](#man-stdc_leading_zeros)

[[manbreak]]
## `stdc_trailing_ones()` {#man-stdc_trailing_ones}

[i[`stdc_trailing_ones()` function]i]

Đếm số 1 cuối (đếm số 1 cuối) trong một số unsigned

### Synopsis {.unnumbered .unlisted}

Mới trong C23!

``` {.c}
#include <stdbit.h>

unsigned int stdc_trailing_ones_uc(unsigned char value);
unsigned int stdc_trailing_ones_us(unsigned short value);
unsigned int stdc_trailing_ones_ui(unsigned int value);
unsigned int stdc_trailing_ones_ul(unsigned long value);
unsigned int stdc_trailing_ones_ull(unsigned long long value);

generic_return_type stdc_trailing_ones(generic_value_type value);
```

### Mô tả {.unnumbered .unlisted}

Hàm này trả về số bit 1 ở cuối của một giá trị nhất định, tính từ bit
có trọng số nhỏ nhất. Con số này sẽ bị ảnh hưởng bởi kích thước của
tham số.

### Giá trị trả về {.unnumbered .unlisted}

Trả về số bit 1 ở cuối.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdbit.h>

int main(void)
{
    unsigned int value = 3490;
    unsigned int count = stdc_trailing_ones_ui(value);

    printf("%u\n", count);

    unsigned long long value2 = 3490;
    auto count2 = stdc_trailing_ones(value2);

    printf("%u\n", count2);
}
```

### Xem thêm {.unnumbered .unlisted}

[`stdc_trailing_zeros()`](#man-stdc_trailing_zeros),
[`stdc_leading_ones()`](#man-stdc_leading_ones)

[[manbreak]]
## `stdc_first_leading_zero()` {#man-stdc_first_leading_zero}

[i[`stdc_first_leading_zero()` function]i]

Tìm bit 0 đầu tiên từ phía trước trong một số unsigned

### Synopsis {.unnumbered .unlisted}

Mới trong C23!

``` {.c}
#include <stdbit.h>

unsigned int stdc_first_leading_zero_uc(unsigned char value);
unsigned int stdc_first_leading_zero_us(unsigned short value);
unsigned int stdc_first_leading_zero_ui(unsigned int value);
unsigned int stdc_first_leading_zero_ul(unsigned long value);
unsigned int stdc_first_leading_zero_ull(unsigned long long value);

generic_return_type stdc_first_leading_zero(generic_value_type value);
```

### Mô tả {.unnumbered .unlisted}

Hàm này tìm chỉ số (index) của bit 0 đầu tiên từ phía trước trong một
số. Chỉ số được đánh từ `1` là vị trí bit có trọng số lớn nhất (bit
bên trái nhất). (Có thể cái này khác với cách bạn vẫn quen đánh số chỉ
số bit.)

Nó đánh theo cơ số 1 để bạn có thể dùng nhanh giá trị trả về như một
biểu thức Boolean để xem có tìm thấy bit 0 hay không.

### Giá trị trả về {.unnumbered .unlisted}

Trả về chỉ số bắt đầu từ 1, tính từ bit có trọng số lớn nhất, của bit
0 đầu tiên trong `value`, hoặc `0` nếu không có bit 0 nào.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <limits.h>
#include <stdbit.h>

int main(void)
{
    unsigned int value = UINT_MAX;
    unsigned int index = stdc_first_leading_zero_ui(value);

    printf("%u\n", index);

    unsigned long long value2 = UINT_MAX >> 2;
    auto index2 = stdc_first_leading_zero(value2);

    printf("%u\n", index2);
}
```

### Xem thêm {.unnumbered .unlisted}

[`stdc_first_leading_one()`](#man-stdc_first_leading_one),
[`stdc_first_trailing_zero()`](#man-stdc_first_trailing_zero)

[[manbreak]]
## `stdc_first_leading_one()` {#man-stdc_first_leading_one}

[i[`stdc_first_leading_one()` function]i]

Tìm bit 1 đầu tiên từ phía trước trong một số unsigned

### Synopsis {.unnumbered .unlisted}

Mới trong C23!

``` {.c}
#include <stdbit.h>

unsigned int stdc_first_leading_one_uc(unsigned char value);
unsigned int stdc_first_leading_one_us(unsigned short value);
unsigned int stdc_first_leading_one_ui(unsigned int value);
unsigned int stdc_first_leading_one_ul(unsigned long value);
unsigned int stdc_first_leading_one_ull(unsigned long long value);

generic_return_type stdc_first_leading_one(generic_value_type value);
```

### Mô tả {.unnumbered .unlisted}

Hàm này tìm chỉ số của bit 1 đầu tiên từ phía trước trong một số. Chỉ
số được đánh từ `1` là vị trí bit có trọng số lớn nhất (bit bên trái
nhất). (Có thể cái này khác với cách bạn vẫn quen đánh số chỉ số
bit.)

Nó đánh theo cơ số 1 để bạn có thể dùng nhanh giá trị trả về như một
biểu thức Boolean để xem có tìm thấy bit 1 hay không.

### Giá trị trả về {.unnumbered .unlisted}

Trả về chỉ số bắt đầu từ 1, tính từ bit có trọng số lớn nhất, của bit
1 đầu tiên trong `value`, hoặc `0` nếu không có bit 1 nào.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <limits.h>
#include <stdbit.h>

int main(void)
{
    unsigned int value = UINT_MAX;
    unsigned int index = stdc_first_leading_one_ui(value);

    printf("%u\n", index);

    unsigned long long value2 = UINT_MAX >> 2;
    auto index2 = stdc_first_leading_one(value2);

    printf("%u\n", index2);
}
```

### Xem thêm {.unnumbered .unlisted}

[`stdc_first_leading_zero()`](#man-stdc_first_leading_zero),
[`stdc_first_trailing_one()`](#man-stdc_first_trailing_one)

[[manbreak]]
## `stdc_first_trailing_zero()` {#man-stdc_first_trailing_zero}

[i[`stdc_first_trailing_zero()` function]i]

Tìm bit 0 đầu tiên từ phía sau trong một số unsigned

### Synopsis {.unnumbered .unlisted}

Mới trong C23!

``` {.c}
#include <stdbit.h>

unsigned int stdc_first_trailing_zero_uc(unsigned char value);
unsigned int stdc_first_trailing_zero_us(unsigned short value);
unsigned int stdc_first_trailing_zero_ui(unsigned int value);
unsigned int stdc_first_trailing_zero_ul(unsigned long value);
unsigned int stdc_first_trailing_zero_ull(unsigned long long value);

generic_return_type stdc_first_trailing_zero(generic_value_type value);
```

### Mô tả {.unnumbered .unlisted}

Hàm này tìm chỉ số của bit 0 đầu tiên từ phía sau trong một số. Chỉ
số được đánh từ `1` là vị trí bit có trọng số lớn nhất (bit bên trái
nhất). (Có thể cái này khác với cách bạn vẫn quen đánh số chỉ số
bit.)

Nó đánh theo cơ số 1 để bạn có thể dùng nhanh giá trị trả về như một
biểu thức Boolean để xem có tìm thấy bit 0 hay không.

### Giá trị trả về {.unnumbered .unlisted}

Trả về chỉ số bắt đầu từ 1, tính từ bit có trọng số lớn nhất, của bit
0 đầu tiên trong `value`, hoặc `0` nếu không có bit 0 nào.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <limits.h>
#include <stdbit.h>

int main(void)
{
    unsigned int value = UINT_MAX;
    unsigned int index = stdc_first_trailing_zero_ui(value);

    printf("%u\n", index);

    unsigned long long value2 = UINT_MAX >> 2;
    auto index2 = stdc_first_trailing_zero(value2);

    printf("%u\n", index2);
}
```

### Xem thêm {.unnumbered .unlisted}

[`stdc_first_leading_zero()`](#man-stdc_first_leading_zero),
[`stdc_first_trailing_one()`](#man-stdc_first_trailing_one)

[[manbreak]]
## `stdc_first_trailing_one()` {#man-stdc_first_trailing_one}

[i[`stdc_first_trailing_one()` function]i]

Tìm bit 1 đầu tiên từ phía sau trong một số unsigned

### Synopsis {.unnumbered .unlisted}

Mới trong C23!

``` {.c}
#include <stdbit.h>

unsigned int stdc_first_trailing_one_uc(unsigned char value);
unsigned int stdc_first_trailing_one_us(unsigned short value);
unsigned int stdc_first_trailing_one_ui(unsigned int value);
unsigned int stdc_first_trailing_one_ul(unsigned long value);
unsigned int stdc_first_trailing_one_ull(unsigned long long value);

generic_return_type stdc_first_trailing_one(generic_value_type value);
```

### Mô tả {.unnumbered .unlisted}

Hàm này tìm chỉ số của bit 1 đầu tiên từ phía sau trong một số. Chỉ
số được đánh từ `1` là vị trí bit có trọng số lớn nhất (bit bên trái
nhất). (Có thể cái này khác với cách bạn vẫn quen đánh số chỉ số
bit.)

Nó đánh theo cơ số 1 để bạn có thể dùng nhanh giá trị trả về như một
biểu thức Boolean để xem có tìm thấy bit 1 hay không.

### Giá trị trả về {.unnumbered .unlisted}

Trả về chỉ số bắt đầu từ 1, tính từ bit có trọng số lớn nhất, của bit
1 đầu tiên trong `value`, hoặc `0` nếu không có bit 1 nào.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <limits.h>
#include <stdbit.h>

int main(void)
{
    unsigned int value = UINT_MAX;
    unsigned int index = stdc_first_trailing_one_ui(value);

    printf("%u\n", index);

    unsigned long long value2 = UINT_MAX >> 2;
    auto index2 = stdc_first_trailing_one(value2);

    printf("%u\n", index2);
}
```

### Xem thêm {.unnumbered .unlisted}

[`stdc_first_leading_one()`](#man-stdc_first_leading_one),
[`stdc_first_trailing_zero()`](#man-stdc_first_trailing_zero)

[[manbreak]]
## `stdc_count_zeros()` {#man-stdc_count_zeros}

[i[`stdc_count_zeros()` function]i]

Đếm số bit 0 trong một số unsigned

### Synopsis {.unnumbered .unlisted}

Mới trong C23!

``` {.c}
#include <stdbit.h>

unsigned int stdc_count_zeros_uc(unsigned char value);
unsigned int stdc_count_zeros_us(unsigned short value);
unsigned int stdc_count_zeros_ui(unsigned int value);
unsigned int stdc_count_zeros_ul(unsigned long value);
unsigned int stdc_count_zeros_ull(unsigned long long value);

generic_return_type stdc_count_zeros(generic_value_type value);
```

### Mô tả {.unnumbered .unlisted}

Hàm này trả về số bit 0 trong một giá trị nhất định. Con số này sẽ bị
ảnh hưởng bởi kích thước của tham số.

### Giá trị trả về {.unnumbered .unlisted}

Trả về số bit 0.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdbit.h>

int main(void)
{
    unsigned int value = 3490;
    unsigned int count = stdc_count_zeros_ui(value);

    printf("%u\n", count);

    unsigned long long value2 = 123456;
    auto count2 = stdc_count_zeros(value2);

    printf("%u\n", count2);
}
```

### Xem thêm {.unnumbered .unlisted}

[`stdc_count_ones()()`](#man-stdc_count_ones),
[`stdc_leading_zeros()()`](#man-stdc_leading_zeros),
[`stdc_trailing_zeros()()`](#man-stdc_trailing_zeros)

[[manbreak]]
## `stdc_count_ones()` {#man-stdc_count_ones}

[i[`stdc_count_ones()` function]i]

Đếm số bit 1 (population count / popcount --- đếm số bit 1) trong một
số unsigned

### Synopsis {.unnumbered .unlisted}

Mới trong C23!

``` {.c}
#include <stdbit.h>

unsigned int stdc_count_ones_uc(unsigned char value);
unsigned int stdc_count_ones_us(unsigned short value);
unsigned int stdc_count_ones_ui(unsigned int value);
unsigned int stdc_count_ones_ul(unsigned long value);
unsigned int stdc_count_ones_ull(unsigned long long value);

generic_return_type stdc_count_ones(generic_value_type value);
```

### Mô tả {.unnumbered .unlisted}

Hàm này trả về số bit 1 trong một giá trị nhất định. Con số này sẽ bị
ảnh hưởng bởi kích thước của tham số.

### Giá trị trả về {.unnumbered .unlisted}

Trả về số bit 1.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdbit.h>

int main(void)
{
    unsigned int value = 3490;
    unsigned int count = stdc_count_ones_ui(value);

    printf("%u\n", count);

    unsigned long long value2 = 123456;
    auto count2 = stdc_count_ones(value2);

    printf("%u\n", count2);
}
```

### Xem thêm {.unnumbered .unlisted}

[`stdc_count_zeros()()`](#man-stdc_count_zeros),
[`stdc_leading_ones()()`](#man-stdc_leading_ones),
[`stdc_trailing_ones()()`](#man-stdc_trailing_ones)


[[manbreak]]
## `stdc_has_single_bit()` {#man-stdc_has_single_bit}

[i[`stdc_has_single_bit()` function]i]

Kiểm tra xem một số nguyên unsigned có đúng một bit được set không

### Synopsis {.unnumbered .unlisted}

Mới trong C23!

``` {.c}
#include <stdbit.h>

bool stdc_has_single_bit_uc(unsigned char value);
bool stdc_has_single_bit_us(unsigned short value);
bool stdc_has_single_bit_ui(unsigned int value);
bool stdc_has_single_bit_ul(unsigned long value);
bool stdc_has_single_bit_ull(unsigned long long value);

bool stdc_has_single_bit(generic_value_type value);
```

### Mô tả {.unnumbered .unlisted}

Các hàm này trả về true nếu có đúng một bit bằng `1` trong `value`
unsigned.

Nếu true, nó cũng có nghĩa là `value` là một lũy thừa của 2 (lũy thừa
của 2).

### Giá trị trả về {.unnumbered .unlisted}

Trả về true nếu `value` có đúng một bit được set bằng `1`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdbit.h>

int main(void)
{
    unsigned int value = 0b0001000;
    unsigned int result = stdc_has_single_bit_ui(value);

    printf("%d\n", result);    // 1

    unsigned long long value2 = 0b000011000
    auto result2 = stdc_has_single_bit(value2);

    printf("%d\n", result2);   // 0
}
```

<!--
### See Also {.unnumbered .unlisted}

[`example()`](#man-example),
-->

[[manbreak]]
## `stdc_bit_width()` {#man-stdc_bit_width}

[i[`stdc_bit_width()` function]i]

Trả về số bit (bit width / độ rộng bit) cần dùng để lưu một giá trị

### Synopsis {.unnumbered .unlisted}

Mới trong C23!

``` {.c}
#include <stdbit.h>

unsigned int stdc_bit_width_uc(unsigned char value);
unsigned int stdc_bit_width_us(unsigned short value);
unsigned int stdc_bit_width_ui(unsigned int value);
unsigned int stdc_bit_width_ul(unsigned long value);
unsigned int stdc_bit_width_ull(unsigned long long value);

generic_return_type stdc_bit_width(generic_value_type value);
```

### Mô tả {.unnumbered .unlisted}

Cho một giá trị số nguyên unsigned, số bit nhỏ nhất cần dùng để lưu
nó là bao nhiêu? Đó là câu hỏi mà hàm này trả lời.

### Giá trị trả về {.unnumbered .unlisted}

Trả về số bit cần dùng để lưu một `value` dương. Trả về `0` nếu
`value` truyền vào là `0`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdbit.h>

int main(void)
{
    unsigned int value = 0b0001000;
    unsigned int result = stdc_bit_width_ui(value);

    printf("%d\n", result);    // 4

    unsigned long long value2 = 0b000011010
    auto result2 = stdc_bit_width(value2);

    printf("%d\n", result2);   // 5
}
```

<!--
### See Also {.unnumbered .unlisted}

[`example()`](#man-example),
-->

[[manbreak]]
## `stdc_bit_floor()` {#man-stdc_bit_floor}

[i[`stdc_bit_floor()` function]i]

Trả về lũy thừa của 2 (lũy thừa của 2) lớn nhất không lớn hơn một số

### Synopsis {.unnumbered .unlisted}

Mới trong C23!

``` {.c}
#include <stdbit.h>

unsigned char stdc_bit_floor_uc(unsigned char value);
unsigned short stdc_bit_floor_us(unsigned short value);
unsigned int stdc_bit_floor_ui(unsigned int value);
unsigned long stdc_bit_floor_ul(unsigned long value);
unsigned long long stdc_bit_floor_ull(unsigned long long value);

generic_value_type stdc_bit_floor(generic_value_type value);
```

### Mô tả {.unnumbered .unlisted}

Hàm này trả về lũy thừa của 2 lớn nhất không lớn hơn `value`.

Nói cách khác, "nhỏ hơn hoặc bằng" `value`.

Nói cách khác, làm tròn xuống (floor) đến lũy thừa của 2 gần nhất.

Nói cách khác, trả về giá trị của bit được set cao nhất trong một số.

Ví dụ:
|`value`|Giá trị trả về|
|-|-|
|`0b101`|`0b100`|
|`0b1000`|`0b1000`|
|`0b100101`|`0b100000`|

### Giá trị trả về {.unnumbered .unlisted}

Trả về lũy thừa của 2 lớn nhất không lớn hơn `value`. Trả về `0` nếu
`value` là `0`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdbit.h>

int main(void)
{
    unsigned int value = 0b0001000;
    unsigned int result = stdc_bit_floor_ui(value);

    printf("%b\n", result);    // 1000

    unsigned long long value2 = 0b000011010
    auto result2 = stdc_bit_floor(value2);

    printf("%b\n", result2);   // 10000
}
```

### Xem thêm {.unnumbered .unlisted}

[`stdc_bit_ceil()`](#man-stdc_bit_ceil)

[[manbreak]]
## `stdc_bit_ceil()` {#man-stdc_bit_ceil}

[i[`stdc_bit_ceil()` function]i]

Trả về lũy thừa của 2 nhỏ nhất không nhỏ hơn một số

### Synopsis {.unnumbered .unlisted}

Mới trong C23!

``` {.c}
#include <stdbit.h>

unsigned char stdc_bit_ceil_uc(unsigned char value);
unsigned short stdc_bit_ceil_us(unsigned short value);
unsigned int stdc_bit_ceil_ui(unsigned int value);
unsigned long stdc_bit_ceil_ul(unsigned long value);
unsigned long long stdc_bit_ceil_ull(unsigned long long value);

generic_value_type stdc_bit_ceil(generic_value_type value);
```

### Mô tả {.unnumbered .unlisted}

Hàm này trả về lũy thừa của 2 nhỏ nhất không nhỏ hơn `value`.

Nói cách khác, "lớn hơn hoặc bằng" `value`.

Nói cách khác, làm tròn lên (ceil) đến lũy thừa của 2 gần nhất.

Ví dụ:
|`value`|Giá trị trả về|
|-|-|
|`0b101`|`0b1000`|
|`0b1000`|`0b1000`|
|`0b100101`|`0b1000000`|

Nếu kết quả không vừa với kiểu trả về, hành vi là không xác định
(undefined).

### Giá trị trả về {.unnumbered .unlisted}

Trả về lũy thừa của 2 nhỏ nhất không nhỏ hơn `value`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdbit.h>

int main(void)
{
    unsigned int value = 0b0001000;
    unsigned int result = stdc_bit_ceil_ui(value);

    printf("%b\n", result);    // 1000

    unsigned long long value2 = 0b000011010
    auto result2 = stdc_bit_ceil(value2);

    printf("%b\n", result2);   // 100000
}
```

### Xem thêm {.unnumbered .unlisted}

[`stdc_bit_floor()`](#man-stdc_bit_floor)

<!--
[[manbreak]]
## `example()` {#man-example}

[i[`example()` function]i]

### Synopsis {.unnumbered .unlisted}

New in C23!

``` {.c}
```

### Description {.unnumbered .unlisted}

### Return Value {.unnumbered .unlisted}

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
```
-->
