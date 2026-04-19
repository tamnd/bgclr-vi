<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<inttypes.h>` Các phép chuyển đổi số nguyên thêm {#inttypes}

[i[`inttypes.h` header file]i]

|Hàm|Mô tả|
|--------|----------------------|
|[`imaxabs()`](#man-imaxabs)|Tính giá trị tuyệt đối của một `intmax_t`|
|[`imaxdiv()`](#man-imaxdiv)|Tính thương và số dư của các `intmax_t`|
|[`strtoimax()`](#man-strtoimax)|Chuyển string sang kiểu `intmax_t`|
|[`strtoumax()`](#man-strtoimax)|Chuyển string sang kiểu `uintmax_t`|
|[`wcstoimax()`](#man-wcstoimax)|Chuyển wide string sang kiểu `intmax_t`|
|[`wcstoumax()`](#man-wcstoimax)|Chuyển wide string sang kiểu `uintmax_t`|

Header này làm các phép chuyển đổi sang số nguyên cỡ lớn nhất, chia
với số nguyên cỡ lớn nhất, và cũng cung cấp format specifier cho
[`printf()`](#man-printf) và [`scanf()`](#man-scanf) cho một loạt
kiểu được định nghĩa trong [`<stdint.h>`](#stdint).

Header [`<stdint.h>`](#stdint) được include bởi header này.

## Macro

Mấy macro này là để giúp
[`printf()`](#man-printf) và [`scanf()`](#man-scanf) khi bạn dùng một
kiểu như `int_least16_t`... bạn dùng format specifier gì?

Bắt đầu với `printf()`---mấy macro này bắt đầu bằng `PRI` rồi theo
sau là format specifier mà bạn thường dùng cho kiểu đó. Cuối cùng,
thêm số bit.

Ví dụ, format specifier cho số nguyên 64-bit là `PRId64`---chữ `d` là
vì thường bạn in số nguyên với `"%d"`.

Một số nguyên không dấu 16-bit có thể được in với `PRIu16`.

Mấy macro này mở rộng thành string literal. Ta có thể tận dụng việc C
tự động nối các string literal kề nhau và dùng các specifier này như
sau:

``` {.c .numberLines}
#include <stdio.h>     // cho printf()
#include <inttypes.h>

int main(void)
{
    int16_t x = 32;

    printf("The value is %" PRId16 "!\n", x);
}
```

Không có gì ma thuật xảy ra ở dòng 8 bên trên đâu. Thật vậy, nếu tôi
in giá trị của macro:

``` {.c}
printf("%s\n", PRId16);
```

ta nhận được cái này trên hệ của tôi:

``` {.default}
hd
```

là một format specifier của `printf()` có nghĩa "số nguyên có dấu
ngắn".

Nên quay lại dòng 8, sau khi nối string literal, nó y hệt như tôi đã
gõ:

``` {.c .numberLines startFrom="8"}
    printf("The value is %hd!\n", x);
```

Đây là bảng mọi macro bạn có thể dùng cho format specifier của
`printf()`... thay số bit vào _N_, thường là 8, 16, 32, hoặc 64.

[i[`PRIdn` macros]i] [i[`PRIdLEASTn` macros]i] [i[`PRIdFASTn` macros]i] [i[`PRIdMAX` macro]i] [i[`PRIdPTR` macro]i]
[i[`PRIin` macros]i] [i[`PRIiLEASTn` macros]i] [i[`PRIiFASTn` macros]i] [i[`PRIiMAX` macro]i] [i[`PRIiPTR` macro]i]
[i[`PRIon` macros]i] [i[`PRIoLEASTn` macros]i] [i[`PRIoFASTn` macros]i] [i[`PRIoMAX` macro]i] [i[`PRIoPTR` macro]i]
[i[`PRIun` macros]i] [i[`PRIuLEASTn` macros]i] [i[`PRIuFASTn` macros]i] [i[`PRIuMAX` macro]i] [i[`PRIuPTR` macro]i]
[i[`PRIxn` macros]i] [i[`PRIxLEASTn` macros]i] [i[`PRIxFASTn` macros]i] [i[`PRIxMAX` macro]i] [i[`PRIxPTR` macro]i]
[i[`PRIXn` macros]i] [i[`PRIXLEASTn` macros]i] [i[`PRIXFASTn` macros]i] [i[`PRIXMAX` macro]i] [i[`PRIXPTR` macro]i]

--------- -------------- ------------- --------- ---------
`PRId`_N_ `PRIdLEAST`_N_ `PRIdFAST`_N_ `PRIdMAX` `PRIdPTR`
`PRIi`_N_ `PRIiLEAST`_N_ `PRIiFAST`_N_ `PRIiMAX` `PRIiPTR`
`PRIo`_N_ `PRIoLEAST`_N_ `PRIoFAST`_N_ `PRIoMAX` `PRIoPTR`
`PRIu`_N_ `PRIuLEAST`_N_ `PRIuFAST`_N_ `PRIuMAX` `PRIuPTR`
`PRIx`_N_ `PRIxLEAST`_N_ `PRIxFAST`_N_ `PRIxMAX` `PRIxPTR`
`PRIX`_N_ `PRIXLEAST`_N_ `PRIXFAST`_N_ `PRIXMAX` `PRIXPTR`
--------- -------------- ------------- --------- ---------

Để ý lần nữa là chữ chữ thường ở giữa đại diện cho các format
specifier thông thường bạn truyền cho `printf()`: `d`, `i`, `o`, `u`,
`x`, và `X`.

Và ta có một bộ macro tương tự cho `scanf()` để đọc các kiểu này:

[i[`SCNdn` macros]i] [i[`SCNdLEASTn` macros]i] [i[`SCNdFASTn` macros]i] [i[`SCNdMAX` macro]i] [i[`SCNdPTR` macro]i]
[i[`SCNin` macros]i] [i[`SCNiLEASTn` macros]i] [i[`SCNiFASTn` macros]i] [i[`SCNiMAX` macro]i] [i[`SCNiPTR` macro]i]
[i[`SCNon` macros]i] [i[`SCNoLEASTn` macros]i] [i[`SCNoFASTn` macros]i] [i[`SCNoMAX` macro]i] [i[`SCNoPTR` macro]i]
[i[`SCNun` macros]i] [i[`SCNuLEASTn` macros]i] [i[`SCNuFASTn` macros]i] [i[`SCNuMAX` macro]i] [i[`SCNuPTR` macro]i]
[i[`SCNxn` macros]i] [i[`SCNxLEASTn` macros]i] [i[`SCNxFASTn` macros]i] [i[`SCNxMAX` macro]i] [i[`SCNxPTR` macro]i]

--------- -------------- ------------- --------- ---------
`SCNd`_N_ `SCNdLEAST`_N_ `SCNdFAST`_N_ `SCNdMAX` `SCNdPTR`
`SCNi`_N_ `SCNiLEAST`_N_ `SCNiFAST`_N_ `SCNiMAX` `SCNiPTR`
`SCNo`_N_ `SCNoLEAST`_N_ `SCNoFAST`_N_ `SCNoMAX` `SCNoPTR`
`SCNu`_N_ `SCNuLEAST`_N_ `SCNuFAST`_N_ `SCNuMAX` `SCNuPTR`
`SCNx`_N_ `SCNxLEAST`_N_ `SCNxFAST`_N_ `SCNxMAX` `SCNxPTR`
--------- -------------- ------------- --------- ---------

Quy tắc là với mỗi kiểu được định nghĩa trong `<stdint.h>` sẽ có các
macro `printf()` và `scanf()` tương ứng được định nghĩa ở đây.

[[manbreak]]
## `imaxabs()` {#man-imaxabs}

[i[`imaxabs()` function]i]

Tính giá trị tuyệt đối của một `intmax_t`

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <inttypes.h>

intmax_t imaxabs(intmax_t j);
```

### Mô tả {.unnumbered .unlisted}

Khi bạn cần giá trị tuyệt đối của kiểu số nguyên lớn nhất trên hệ
thống, đây là hàm dành cho bạn.

Spec ghi chú rằng nếu giá trị tuyệt đối của số không biểu diễn được,
hành vi là undefined. Chuyện này xảy ra nếu bạn thử lấy giá trị tuyệt
đối của số âm nhỏ nhất có thể trên hệ thống biểu diễn bù hai (two's
complement).

### Giá trị trả về {.unnumbered .unlisted}

Trả về giá trị tuyệt đối của đầu vào, $|j|$.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <inttypes.h>

int main(void)
{
    intmax_t j = -3490;

    printf("%jd\n", imaxabs(j));    // 3490
}
```

### Xem thêm {.unnumbered .unlisted}

[`fabs()`](#man-fabs)


[[manbreak]]
## `imaxdiv()` {#man-imaxdiv}

[i[`imaxdiv()` function]i]

Tính thương và số dư của các `intmax_t`

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <inttypes.h>

imaxdiv_t imaxdiv(intmax_t numer, intmax_t denom);
```

### Mô tả {.unnumbered .unlisted}

Khi bạn muốn làm phép chia nguyên và lấy số dư trong cùng một phép,
hàm này sẽ làm cho bạn.

Nó tính `numer/denom` và `numer%denom` rồi trả về kết quả trong một
struct kiểu `imaxdiv_t`.

Struct này có hai field kiểu `imaxdiv_t`, `quot` và `rem`, mà bạn
dùng để lấy các giá trị mong muốn.

### Giá trị trả về {.unnumbered .unlisted}

Trả về một `imaxdiv_t` chứa thương và số dư của phép toán.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <inttypes.h>

int main(void)
{
    intmax_t numer = INTMAX_C(3490);
    intmax_t denom = INTMAX_C(17);

    imaxdiv_t r = imaxdiv(numer, denom);

    printf("Quotient: %jd, remainder: %jd\n", r.quot, r.rem);
}
```

Output:

``` {.default}
Quotient: 205, remainder: 5
```

### Xem thêm {.unnumbered .unlisted}

[`remquo()`](#man-remquo)

[[manbreak]]
## `strtoimax()` `strtoumax()` {#man-strtoimax}

[i[`strtoimax()` function]i]
[i[`strtoumax()` function]i]

Chuyển string sang kiểu `intmax_t` và `uintmax_t`

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <inttypes.h>

intmax_t strtoimax(const char * restrict nptr, char ** restrict endptr,
                   int base);

uintmax_t strtoumax(const char * restrict nptr, char ** restrict endptr,
                   int base);
```

### Mô tả {.unnumbered .unlisted}

Mấy cái này hoạt động y hệt họ hàm [`strtol()`](#man-strtol), chỉ
khác là trả về `intmax_t` hoặc `uintmax_t`.

Xem trang tham chiếu [`strtol()`](#man-strtol) để biết chi tiết.

### Giá trị trả về {.unnumbered .unlisted}

Trả về string đã chuyển dưới dạng `intmax_t` hoặc `uintmax_t`.

Nếu kết quả nằm ngoài miền giá trị, giá trị trả về sẽ là `INTMAX_MAX`,
`INTMAX_MIN`, hoặc `UINTMAX_MAX`, tuỳ trường hợp. Và biến `errno` sẽ
được set thành `ERANGE`.

### Ví dụ {.unnumbered .unlisted}

Ví dụ sau chuyển một số cơ số 10 sang `intmax_t`. Rồi nó thử chuyển
một số cơ số 2 không hợp lệ, bắt lỗi.

``` {.c .numberLines}
#include <stdio.h>
#include <inttypes.h>

int main(void)
{
    intmax_t r;
    char *endptr;

    // Số cơ số 10 hợp lệ
    r = strtoimax("123456789012345", &endptr, 10);

    if (*endptr != '\0')
        printf("Invalid digit: %c\n", *endptr);
    else
        printf("Value is %jd\n", r);
    
    // Số nhị phân sau chứa chữ số không hợp lệ
    r = strtoimax("0100102010101101", &endptr, 2);

    if (*endptr != '\0')
        printf("Invalid digit: %c\n", *endptr);
    else
        printf("Value is %jd\n", r);
}
```

Output:

``` {.default}
Value is 123456789012345
Invalid digit: 2
```

### Xem thêm {.unnumbered .unlisted}

[`strtol()`](#man-strtol),
[`errno`](#errno)


[[manbreak]]
## `wcstoimax()` `wcstoumax()` {#man-wcstoimax}

[i[`wcstoimax()` function]i]
[i[`wcstoumax()` function]i]

Chuyển wide string sang kiểu `intmax_t` và `uintmax_t`

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stddef.h> // cho wchar_t
#include <inttypes.h>

intmax_t wcstoimax(const wchar_t * restrict nptr,
                   wchar_t ** restrict endptr, int base);

uintmax_t wcstoumax(const wchar_t * restrict nptr,
                    wchar_t ** restrict endptr, int base);
```

### Mô tả {.unnumbered .unlisted}

Mấy cái này hoạt động y hệt họ hàm [`wcstol()`](#man-wcstol), chỉ
khác là trả về `intmax_t` hoặc `uintmax_t`.

Xem trang tham chiếu [`wcstol()`](#man-wcstol) để biết chi tiết.

### Giá trị trả về {.unnumbered .unlisted}

Trả về wide string đã chuyển dưới dạng `intmax_t` hoặc `uintmax_t`.

Nếu kết quả nằm ngoài miền giá trị, giá trị trả về sẽ là `INTMAX_MAX`,
`INTMAX_MIN`, hoặc `UINTMAX_MAX`, tuỳ trường hợp. Và biến `errno` sẽ
được set thành `ERANGE`.

### Ví dụ {.unnumbered .unlisted}

Ví dụ sau chuyển một số cơ số 10 sang `intmax_t`. Rồi nó thử chuyển
một số cơ số 2 không hợp lệ, bắt lỗi.

``` {.c .numberLines}
#include <wchar.h>
#include <inttypes.h>

int main(void)
{
    intmax_t r;
    wchar_t *endptr;

    // Số cơ số 10 hợp lệ
    r = wcstoimax(L"123456789012345", &endptr, 10);

    if (*endptr != '\0')
        wprintf(L"Invalid digit: %lc\n", *endptr);
    else
        wprintf(L"Value is %jd\n", r);
    
    // Số nhị phân sau chứa chữ số không hợp lệ
    r = wcstoimax(L"0100102010101101", &endptr, 2);

    if (*endptr != '\0')
        wprintf(L"Invalid digit: %lc\n", *endptr);
    else
        wprintf(L"Value is %jd\n", r);
}
```

``` {.default}
Value is 123456789012345
Invalid digit: 2
```

### Xem thêm {.unnumbered .unlisted}

[`wcstol()`](#man-wcstol),
[`errno`](#errno)

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
