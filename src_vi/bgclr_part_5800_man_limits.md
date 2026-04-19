<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<limits.h>` Giới Hạn Số {#limits}

[i[`limits.h` header file]i]

Lưu ý quan trọng: "minimum magnitude" (độ lớn tối thiểu) trong bảng
bên dưới là giá trị tối thiểu mà spec yêu cầu. Rất có khả năng giá
trị trên hệ thống xịn xò của bạn còn vượt xa những con số đó.

[i[`CHAR_BIT` macro]i]
[i[`SCHAR_MIN` macro]i]
[i[`SCHAR_MAX` macro]i]
[i[`UCHAR_MAX` macro]i]
[i[`CHAR_MIN` macro]i]
[i[`CHAR_MAX` macro]i]
[i[`MB_LEN_MAX` macro]i]
[i[`SHRT_MIN` macro]i]
[i[`SHRT_MAX` macro]i]
[i[`USHRT_MAX` macro]i]
[i[`INT_MIN` macro]i]
[i[`INT_MAX` macro]i]
[i[`UINT_MAX` macro]i]
[i[`LONG_MIN` macro]i]
[i[`LONG_MAX` macro]i]
[i[`ULONG_MAX` macro]i]
[i[`LLONG_MIN` macro]i]
[i[`LLONG_MAX` macro]i]
[i[`ULLONG_MAX` macro]i]

|Macro|Độ lớn tối thiểu|Mô tả|
|-----|----------|-----------------------|
|`CHAR_BIT`|`8`|Số bit trong một byte|
|`SCHAR_MIN`|`-127`|Giá trị nhỏ nhất của `signed char`|
|`SCHAR_MAX`|`127`|Giá trị lớn nhất của `signed char`|
|`UCHAR_MAX`|`255`|Giá trị lớn nhất của `unsigned char`^[Giá trị nhỏ nhất của `unsigned char` là `0`. Với `unsigned short` và `unsigned long` cũng vậy. Hay bất kỳ kiểu unsigned nào, cũng thế.]|
|`CHAR_MIN`|`0` hoặc `SCHAR_MIN`|Xem chi tiết bên dưới|
|`CHAR_MAX`|`SCHAR_MAX` hoặc `UCHAR_MAX`|Xem chi tiết bên dưới|
|`MB_LEN_MAX`|`1`|Số byte tối đa trong một ký tự multibyte ở bất cứ locale nào|
|`SHRT_MIN`|`-32767`|Giá trị nhỏ nhất của `short`|
|`SHRT_MAX`|`32767`|Giá trị lớn nhất của `short`|
|`USHRT_MAX`|`65535`|Giá trị lớn nhất của `unsigned short`|
|`INT_MIN`|`-32767`|Giá trị nhỏ nhất của `int`|
|`INT_MAX`|`32767`|Giá trị lớn nhất của `int`|
|`UINT_MAX`|`65535`|Giá trị lớn nhất của `unsigned int`|
|`LONG_MIN`|`-2147483647`|Giá trị nhỏ nhất của `long`|
|`LONG_MAX`|`2147483647`|Giá trị lớn nhất của `long`|
|`ULONG_MAX`|`4294967295`|Giá trị lớn nhất của `unsigned long`|
|`LLONG_MIN`|`-9223372036854775807`|Giá trị nhỏ nhất của `long long`|
|`LLONG_MAX`|`9223372036854775807`|Giá trị lớn nhất của `long long`|
|`ULLONG_MAX`|`18446744073709551615`|Giá trị lớn nhất của `unsigned long long`|

## `CHAR_MIN` và `CHAR_MAX`

Với `CHAR_MIN` và `CHAR_MAX`, mọi thứ phụ thuộc vào việc kiểu `char`
mặc định trên hệ bạn là signed hay unsigned. Nhớ là C để tùy
implementation quyết định chuyện đó chứ? Không nhớ? Thật đấy.

Vậy nếu nó là signed, `CHAR_MIN` và `CHAR_MAX` có giá trị giống như
`SCHAR_MIN` và `SCHAR_MAX`.

Còn nếu nó là unsigned, `CHAR_MIN` và `CHAR_MAX` giống `0` và
`UCHAR_MAX`.

Tiện thể: bạn có thể biết lúc runtime hệ có `char` signed hay
unsigned bằng cách kiểm tra xem `CHAR_MIN` có bằng `0` không.

``` {.c .numberLines}
#include <stdio.h>
#include <limits.h>

int main(void)
{
    printf("chars are %ssigned\n", CHAR_MIN == 0? "un": "");
}
```

Trên hệ của tôi, `char` là signed.

## Chọn Kiểu Cho Đúng

Nếu bạn muốn siêu portable, hãy chọn một kiểu mà bảng bên trên đảm
bảo ít nhất đủ to như bạn cần.

Nói vậy chứ, khá nhiều code---vì tốt hơn hoặc (khả năng cao hơn)
tệ hơn---giả định rằng `int` là 32-bit, trong khi thực ra spec chỉ
đảm bảo 16-bit thôi.

Nếu bạn cần kích thước bit được đảm bảo, xem các kiểu `int_leastN_t`
trong [`<stdint.h>`](#stdint).

## Còn Two's Complement Thì Sao?

Nếu bạn tinh mắt và lại có hiểu biết sẵn về chủ đề này, bạn có thể
đã nghĩ tôi viết sai giá trị nhỏ nhất của các macro bên trên.

"`short` đi từ `32767` tới `-32767`? Chẳng phải nó phải tới `-32768`
à?"

Không, tôi viết đúng rồi. Spec liệt kê độ lớn tối thiểu cho các
macro đó, và một số hệ thống cổ lỗ có thể đã dùng cách encode khác
cho số signed mà chỉ đi xa được tới đó.

Hầu như mọi hệ thống hiện đại đều dùng [flw[Two's
Complement|Two%27s_complement]] (bù hai) cho số signed, và với kiểu
đó `short` sẽ đi từ `32767` tới `-32768`. Hệ của bạn chắc cũng vậy.

## Chương Trình Demo

Đây là chương trình in ra giá trị các macro:

``` {.c .numberLines}
#include <stdio.h>
#include <limits.h>

int main(void)
{
    printf("CHAR_BIT = %d\n", CHAR_BIT);
    printf("SCHAR_MIN = %d\n", SCHAR_MIN);
    printf("SCHAR_MAX = %d\n", SCHAR_MAX);
    printf("UCHAR_MAX = %d\n", UCHAR_MAX);
    printf("CHAR_MIN = %d\n", CHAR_MIN);
    printf("CHAR_MAX = %d\n", CHAR_MAX);
    printf("MB_LEN_MAX = %d\n", MB_LEN_MAX);
    printf("SHRT_MIN = %d\n", SHRT_MIN);
    printf("SHRT_MAX = %d\n", SHRT_MAX);
    printf("USHRT_MAX = %u\n", USHRT_MAX);
    printf("INT_MIN = %d\n", INT_MIN);
    printf("INT_MAX = %d\n", INT_MAX);
    printf("UINT_MAX = %u\n", UINT_MAX);
    printf("LONG_MIN = %ld\n", LONG_MIN);
    printf("LONG_MAX = %ld\n", LONG_MAX);
    printf("ULONG_MAX = %lu\n", ULONG_MAX);
    printf("LLONG_MIN = %lld\n", LLONG_MIN);
    printf("LLONG_MAX = %lld\n", LLONG_MAX);
    printf("ULLONG_MAX = %llu\n", ULLONG_MAX);
}
```

Trên hệ Intel 64-bit của tôi với clang, output là:

``` {.default}
CHAR_BIT = 8
SCHAR_MIN = -128
SCHAR_MAX = 127
UCHAR_MAX = 255
CHAR_MIN = -128
CHAR_MAX = 127
MB_LEN_MAX = 6
SHRT_MIN = -32768
SHRT_MAX = 32767
USHRT_MAX = 65535
INT_MIN = -2147483648
INT_MAX = 2147483647
UINT_MAX = 4294967295
LONG_MIN = -9223372036854775808
LONG_MAX = 9223372036854775807
ULONG_MAX = 18446744073709551615
LLONG_MIN = -9223372036854775808
LLONG_MAX = 9223372036854775807
ULLONG_MAX = 18446744073709551615
```

Có vẻ hệ của tôi dùng encoding two's-complement cho số signed,
`char` là signed, và `int` là 32-bit.
