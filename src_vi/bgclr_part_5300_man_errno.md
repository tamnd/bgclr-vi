<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<errno.h>` Thông tin Lỗi {#errno}

[i[`errno.h` header file]i]

|Biến|Mô tả|
|-|-|
|[`errno`](#man-errno)|Giữ trạng thái lỗi của lời gọi gần nhất|

Header này định nghĩa duy nhất một biến^[Thật ra nó chỉ cần là
modifiable lvalue, nên không nhất thiết là biến. Nhưng bạn cứ xem nó
như biến cũng được.], `errno`, có thể kiểm tra để xem đã xảy ra lỗi
hay chưa.

`errno` được set thành `0` lúc khởi động, nhưng không có hàm thư viện
nào set nó về `0`. Nếu bạn chỉ dựa vào nó để kiểm tra lỗi, set nó về
`0` trước khi gọi rồi kiểm tra sau đó. Không chỉ vậy, nếu không có
lỗi, mọi hàm thư viện sẽ để giá trị `errno` nguyên không đổi.

Tuy nhiên, thông thường bạn sẽ nhận được tín hiệu lỗi nào đó từ hàm
được gọi rồi mới kiểm tra `errno` để xem chuyện gì đã sai.

Cái này thường dùng chung với [`perror()`](#man-perror) để lấy một
thông báo lỗi dạng con người đọc được ứng với lỗi cụ thể.

Mẹo An Toàn Quan Trọng: Đừng bao giờ tự tạo biến của riêng bạn tên
là `errno`---đó là undefined behavior.

Chú ý là spec C chỉ định nghĩa vài ba giá trị mà `errno` có thể nhận.
[fl[Unix định nghĩa thêm kha
khá|https://man.archlinux.org/man/errno.3.en]], [fl[Windows cũng
vậy|https://docs.microsoft.com/en-us/cpp/c-runtime-library/errno-constants?view=msvc-160]].

[[manbreak]]
## `errno` {#man-errno}

[i[`errno` variable]i]

Giữ trạng thái lỗi của lời gọi gần nhất

### Synopsis {.unnumbered .unlisted}

``` {.c}
errno   // Kiểu không xác định, nhưng gán được
```

### Mô tả {.unnumbered .unlisted}

Cho biết trạng thái lỗi của lời gọi gần nhất (chú ý không phải mọi
lời gọi đều set giá trị này).

|Giá trị|Mô tả|
|-|-|
|`0`|Không lỗi|
|`EDOM`|Lỗi miền xác định (từ toán)|
|`EILSEQ`|Lỗi encoding (từ chuyển đổi ký tự)|
|`ERANGE`|Lỗi miền giá trị (từ toán)|

Nếu bạn đang làm một loạt hàm toán, bạn có thể gặp `EDOM` hoặc
`ERANGE`.

Với các hàm chuyển đổi ký tự multibyte/wide, bạn có thể thấy
`EILSEQ`.

Và hệ thống của bạn có thể định nghĩa thêm bao nhiêu giá trị khác mà
`errno` có thể nhận, tất cả đều bắt đầu bằng chữ `E`.

Chuyện Vui: bạn có thể dùng `EDOM`, `EILSEQ`, và `ERANGE` với các chỉ
thị preprocessor như `#ifdef`. Nhưng thật lòng, tôi không chắc bạn
sẽ làm vậy để làm gì ngoài việc kiểm tra sự tồn tại của chúng.

<!--
### Return Value {.unnumbered .unlisted}
-->

### Ví dụ {.unnumbered .unlisted}

Đoạn sau in ra thông báo lỗi, vì truyền `2.0` vào `acos()` là ngoài
miền xác định của hàm.

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>
#include <errno.h>

int main(void)
{
    double x;

    errno = 0;       // Đảm bảo clear trước khi gọi

    x = acos(2.0);   // Đối số không hợp lệ cho acos()

    if (errno == EDOM)
        perror("acos");
    else
        printf("Answer is %f\n", x);

    return 0;
}
```

Output:

``` {.default}
acos: Numerical argument out of domain
```

Đoạn sau in ra thông báo lỗi (trên hệ của tôi), vì truyền `1e+30` vào
`exp()` tạo ra kết quả ngoài miền giá trị của `double`.

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>
#include <errno.h>

int main(void)
{
    double x;

    errno = 0;       // Đảm bảo clear trước khi gọi

    x = exp(1e+30);  // Truyền vào số quá khổng lồ

    if (errno == ERANGE)
        perror("exp");
    else
        printf("Answer is %f\n", x);

    return 0;
}
```

Output:

``` {.default}
exp: Numerical result out of range
```

Ví dụ này thử chuyển một ký tự không hợp lệ sang ký tự rộng (wide),
thất bại. Nó set `errno` thành `EILSEQ`. Rồi ta dùng `perror()` để in
ra thông báo lỗi.

``` {.c .numberLines}
#include <stdio.h>
#include <string.h>
#include <wchar.h>
#include <errno.h>
#include <locale.h>

int main(void)
{
	setlocale(LC_ALL, "");

    char *bad_str = "\xff";  // Có lẽ là char không hợp lệ ở locale này
    wchar_t wc;
    size_t result;
    mbstate_t ps;

    memset(&ps, 0, sizeof ps);

    result = mbrtowc(&wc, bad_str, 1, &ps);

    if (result == (size_t)(-1))
        perror("mbrtowc");  // mbrtowc: Illegal byte sequence
    else
        printf("Converted to L'%lc'\n", wc);

    return 0;
}
```

Output:

``` {.default}
mbrtowc: Invalid or incomplete multibyte or wide character
```

### Xem thêm {.unnumbered .unlisted}

[`perror()`](#man-perror),
[`mbrtoc16()`](#man-mbrtoc16),
[`c16rtomb()`](#man-c16rtomb),
[`mbrtoc32()`](#man-mbrtoc16),
[`c32rtomb()`](#man-c16rtomb),
[`fgetwc()`](#man-getwc),
[`fputwc()`](#man-putwc),
[`mbrtowc()`](#man-mbrtowc),
[`wcrtomb()`](#man-wcrtomb),
[`mbsrtowcs()`](#man-mbsrtowcs),
[`wcsrtombs()`](#man-wcsrtombs),
[`<math.h>`](#math),
