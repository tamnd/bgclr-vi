<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<stdint.h>` Thêm Kiểu Integer {#stdint}

[i[`stdint.h` header file]i]

Header này cho ta quyền truy cập (có thể) các kiểu có số bit cố
định, hoặc, ít ra, các kiểu có ít nhất từng đó bit.

Nó cũng cho ta mấy macro tiện tay.

## Integer Kích Thước Cụ Thể

Có ba nhóm kiểu chính được định nghĩa ở đây, có dấu và không dấu:

* Integer chính xác một kích thước (`int`_N_`_t`, `uint`_N_`_t`)
* Integer ít nhất một kích thước (`int_least`_N_`_t`,
  `uint_least`_N_`_t`)
* Integer ít nhất một kích thước và nhanh hết mức có thể
  (`int_fast`_N_`_t`, `uint_fast`_N_`_t`)

Chỗ _N_ xuất hiện, bạn thay vào số bit, thường là bội của 8, ví dụ
`uint16_t`.

Các kiểu sau được đảm bảo có định nghĩa:

[i[`int_leastN_t` types]i]
[i[`int_fastN_t` types]i]

``` {.c}
int_least8_t      uint_least8_t
int_least16_t     uint_least16_t
int_least32_t     uint_least32_t
int_least64_t     uint_least64_t

int_fast8_t       uint_fast8_t
int_fast16_t      uint_fast16_t
int_fast32_t      uint_fast32_t
int_fast64_t      uint_fast64_t
```

Những cái còn lại là tùy chọn, nhưng bạn có thể sẽ có luôn các kiểu
sau, chúng được yêu cầu khi hệ thống có integer đúng kích thước đó
không có padding và dùng biểu diễn two's-complement... đây là
trường hợp với Mac, PC và cả đống hệ thống khác. Tóm lại, bạn nhiều
khả năng có sẵn mấy cái này:

[i[`intN_t` types]i]

``` {.c}
int8_t      uint8_t
int16_t     uint16_t
int32_t     uint32_t
int64_t     uint64_t
```

Số bit khác cũng có thể được hỗ trợ nếu implementation muốn làm
chuyện điên rồ.

Ví dụ:

``` {.c}
#include <stdint.h>

int main(void)
{
    int16_t x = 32;
    int_fast32_t y = 3490;

    // ...
```

## Các Kiểu Integer Khác

Có vài kiểu tùy chọn là integer có khả năng giữ kiểu pointer.

[i[`intptr_t` type]i]
[i[`uintptr_t` type]i]

``` {.c}
intptr_t
uintptr_t
```

Bạn có thể convert `void*` thành một trong các kiểu này, rồi trở
lại. Và các `void*` sẽ so sánh bằng nhau.

Use case là bất cứ chỗ nào bạn cần một integer đại diện cho pointer
vì lý do nào đó.

Ngoài ra, có vài kiểu tồn tại chỉ để là integer lớn nhất mà hệ của
bạn hỗ trợ:

[i[`intmax_t` type]i]
[i[`uintmax_t` type]i]

``` {.c}
intmax_t
uintmax_t
```

Fact vui: bạn có thể in các kiểu này với format specifier `"%jd"`
và `"%ju"` của [`printf()`](#man-printf).

Cũng có cả đống macro trong `<inttypes.h>`(#inttypes) bạn có thể
dùng để in bất kỳ kiểu nào ở trên.

## Macros

Các macro sau định nghĩa giá trị min và max cho các kiểu này:

[i[`INTn_MAX` macros]i]
[i[`INTn_MIN` macros]i]
[i[`UINTn_MAX` macros]i]
[i[`INT_LEASTn_MAX` macros]i]
[i[`INT_LEASTn_MIN` macros]i]
[i[`UINT_LEASTn_MAX` macros]i]
[i[`INT_FASTn_MAX` macros]i]
[i[`INT_FASTn_MIN` macros]i]
[i[`UINT_FASTn_MAX` macros]i]
[i[`INTMAX_MAX` macros]i]
[i[`INTMAX_MIN` macros]i]
[i[`UINTMAX_MAX` macros]i]
[i[`INTPTR_MAX` macros]i]
[i[`INTPTR_MIN` macros]i]
[i[`UINTPTR_MAX` macros]i]

``` {.c}
INT8_MAX           INT8_MIN           UINT8_MAX
INT16_MAX          INT16_MIN          UINT16_MAX
INT32_MAX          INT32_MIN          UINT32_MAX
INT64_MAX          INT64_MIN          UINT64_MAX

INT_LEAST8_MAX     INT_LEAST8_MIN     UINT_LEAST8_MAX
INT_LEAST16_MAX    INT_LEAST16_MIN    UINT_LEAST16_MAX
INT_LEAST32_MAX    INT_LEAST32_MIN    UINT_LEAST32_MAX
INT_LEAST64_MAX    INT_LEAST64_MIN    UINT_LEAST64_MAX

INT_FAST8_MAX      INT_FAST8_MIN      UINT_FAST8_MAX
INT_FAST16_MAX     INT_FAST16_MIN     UINT_FAST16_MAX
INT_FAST32_MAX     INT_FAST32_MIN     UINT_FAST32_MAX
INT_FAST64_MAX     INT_FAST64_MIN     UINT_FAST64_MAX

INTMAX_MAX         INTMAX_MIN         UINTMAX_MAX

INTPTR_MAX         INTPTR_MIN         UINTPTR_MAX
```

Với kiểu signed kích thước chính xác, min chính xác là $-(2^{N-1})$
và max chính xác là $2^{N-1}-1$. Và với kiểu unsigned kích thước
chính xác, max chính xác là $2^N-1$.

Với biến thể signed "least" và "fast", độ lớn và dấu của min ít
nhất là $-(2^{N-1}-1)$ và max ít nhất là $2^{N-1}-1$. Và với
unsigned, ít nhất là $2^N-1$.

`INTMAX_MAX` ít nhất là $2^{63}-1$, `INTMAX_MIN` ít nhất là
$-(2^{63}-1)$ xét về dấu và độ lớn. Và `UINTMAX_MAX` ít nhất là
$2^{64}-1$.

Cuối cùng, `INTPTR_MAX` ít nhất là $2^{15}-1$, `INTPTR_MIN` ít nhất
là $-(2^{15}-1)$ xét về dấu và độ lớn. Và `UINTPTR_MAX` ít nhất là
$2^{16}-1$.

## Giới Hạn Khác

Có một đống kiểu trong `<inttypes.h>`(#inttypes) có giới hạn được
định nghĩa ở đây. (`<inttypes.h>` include `<stdint.h>`.)

[i[`PTRDIFF_MIN` macro]i]
[i[`PTRDIFF_MAX` macro]i]
[i[`SIG_ATOMIC_MIN` macro]i]
[i[`SIG_ATOMIC_MAX` macro]i]
[i[`SIZE_MAX` macro]i]
[i[`WCHAR_MIN` macro]i]
[i[`WCHAR_MAX` macro]i]
[i[`WINT_MIN` macro]i]
[i[`WINT_MAX` macro]i]

|Macro|Mô tả|
|-|-|
|`PTRDIFF_MIN`|Giá trị min của `ptrdiff_t`|
|`PTRDIFF_MAX`|Giá trị max của `ptrdiff_t`|
|`SIG_ATOMIC_MIN`|Giá trị min của `sig_atomic_t`|
|`SIG_ATOMIC_MAX`|Giá trị max của `sig_atomic_t`|
|`SIZE_MAX`|Giá trị max của `size_t`|
|`WCHAR_MIN`|Giá trị min của `wchar_t`|
|`WCHAR_MAX`|Giá trị max của `wchar_t`|
|`WINT_MIN`|Giá trị min của `wint_t`|
|`WINT_MAX`|Giá trị max của `wint_t`|

Spec nói `PTRDIFF_MIN` về độ lớn sẽ ít nhất là -65535. Và
`PTRDIFF_MAX` với `SIZE_MAX` sẽ ít nhất là 65535.

`SIG_ATOMIC_MIN` và `MAX` sẽ hoặc là -127 và 127 (nếu signed) hoặc
0 và 255 (nếu unsigned).

Tương tự với `WCHAR_MIN` và `MAX`.

`WINT_MIN` và `MAX` sẽ hoặc là -32767 và 32767 (nếu signed) hoặc 0
và 65535 (nếu unsigned).

## Macro Để Khai Báo Hằng

Nếu bạn còn nhớ, bạn có thể chỉ định kiểu cho hằng integer:

``` {.c}
int x = 12;
long int y = 12L;
unsigned long long int z = 12ULL;
```

Bạn có thể dùng macro `INT`_N_`_C()` và `UINT`_N_`()` trong đó _N_
là `8`, `16`, `32` hoặc `64`.

[i[`INTn_C()` macros]i]

``` {.c}
uint_least16_t x = INT16_C(3490);
uint_least64_t y = INT64_C(1122334455);
```

Biến thể của mấy cái này là `INTMAX_C()` và `UINTMAX_C()`. Chúng
tạo một hằng phù hợp để lưu trong `intmax_t` hoặc `uintmax_t`.

[i[`INTMAX_C()` macro]i]
[i[`UINTMAX_C()` macro]i]

``` {.c}
intmax_t x = INTMAX_C(3490);
uintmax_t x = UINTMAX_C(1122334455);
```

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
