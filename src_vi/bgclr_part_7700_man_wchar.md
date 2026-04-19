<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<wchar.h>` Xử Lý Wide Character {#wchar}

[i[`wchar.h` header file]i]

|Hàm|Mô tả|
|------|-------------------------|
|[`btowc()`](#man-btowc)|Chuyển ký tự một byte sang wide character|
|[`fgetwc()`](#man-getwc)|Lấy một wide character từ một wide stream|
|[`fgetws()`](#man-fgetws)|Đọc một wide string từ một wide stream|
|[`fputwc()`](#man-putwc)|Ghi một wide character ra một wide stream|
|[`fputws()`](#man-fputws)|Ghi một wide string ra một wide stream|
|[`fwide()`](#man-fwide)|Lấy hoặc đặt orientation của stream|
|[`fwprintf()`](#man-wprintf)|Xuất wide có định dạng ra một wide stream|
|[`fwscanf()`](#man-wscanf)|Nhập wide có định dạng từ một wide stream|
|[`getwchar()`](#man-getwc)|Lấy một wide character từ `stdin`|
|[`getwc()`](#man-getwc)|Lấy một wide character từ `stdin`|
|[`mbrlen()`](#man-mbrlen)|Tính số byte của một ký tự multibyte kiểu restartable|
|[`mbrtowc()`](#man-mbrtowc)|Chuyển multibyte sang wide character kiểu restartable|
|[`mbsinit()`](#man-mbsinit)|Kiểm tra một `mbstate_t` có đang ở conversion state ban đầu không|
|[`mbsrtowcs()`](#man-mbsrtowcs)|Chuyển chuỗi multibyte sang chuỗi wide character kiểu restartable|
|[`putwchar()`](#man-putwc)|Ghi một wide character ra `stdout`|
|[`putwc()`](#man-putwc)|Ghi một wide character ra `stdout`|
|[`swprintf()`](#man-wprintf)|Xuất wide có định dạng ra một wide string|
|[`swscanf()`](#man-wscanf)|Nhập wide có định dạng từ một wide string|
|[`ungetwc()`](#man-ungetwc)|Đẩy một wide character trở lại input stream|
|[`vfwprintf()`](#man-wprintf)|Xuất wide có định dạng variadic ra một wide stream|
|[`vfwscanf()`](#man-wscanf)|Nhập wide có định dạng variadic từ một wide stream|
|[`vswprintf()`](#man-wprintf)|Xuất wide có định dạng variadic ra một wide string|
|[`vswscanf()`](#man-wscanf)|Nhập wide có định dạng variadic từ một wide string|
|[`vwprintf()`](#man-wprintf)|Xuất wide có định dạng variadic|
|[`vwscanf()`](#man-wscanf)|Nhập wide có định dạng variadic|
|[`wcscat()`](#man-wcscat)|Nối wide string kiểu nguy hiểm|
|[`wcschr()`](#man-wcschr)|Tìm một wide character trong một wide string|
|[`wcscmp()`](#man-wcscmp)|So sánh wide string|
|[`wcscoll()`](#man-wcscoll)|So sánh hai wide string có tính đến locale|
|[`wcscpy()`](#man-wcscpy)|Copy một wide string kiểu nguy hiểm|
|[`wcscspn()`](#man-wcsspn)|Đếm các ký tự không thuộc tập bắt đầu từ đầu một wide string|
|[`wcsftime()`](#man-wcsftime)|Xuất ngày giờ có định dạng|
|[`wcslen()`](#man-wcslen)|Trả về độ dài của một wide string|
|[`wcsncat()`](#man-wcscat)|Nối wide string an toàn hơn|
|[`wcsncmp()`](#man-wcscmp)|So sánh wide string, giới hạn độ dài|
|[`wcsncpy()`](#man-wcscpy)|Copy một wide string an toàn hơn|
|[`wcspbrk()`](#man-wcspbrk)|Tìm một wide character trong một tập ở một wide string|
|[`wcsrchr()`](#man-wcschr)|Tìm một wide character trong một wide string từ cuối|
|[`wcsrtombs()`](#man-wcsrtombs)|Chuyển chuỗi wide character sang chuỗi multibyte kiểu restartable|
|[`wcsspn()`](#man-wcsspn)|Đếm các ký tự thuộc một tập ở đầu một wide string|
|[`wcsstr()`](#man-wcsstr)|Tìm một wide string trong một wide string khác|
|[`wcstod()`](#man-wcstod)|Chuyển một wide string sang `double`|
|[`wcstof()`](#man-wcstod)|Chuyển một wide string sang `float`|
|[`wcstok()`](#man-wcstok)|Tách token một wide string|
|[`wcstold()`](#man-wcstod)|Chuyển một wide string sang `long double`|
|[`wcstoll()`](#man-wcstol)|Chuyển một wide string sang `long long`|
|[`wcstol()`](#man-wcstol)|Chuyển một wide string sang `long`|
|[`wcstoull()`](#man-wcstol)|Chuyển một wide string sang `unsigned long long`|
|[`wcstoul()`](#man-wcstol)|Chuyển một wide string sang `unsigned long`|
|[`wcsxfrm()`](#man-wcsxfrm)|Biến đổi một wide string để so sánh dựa trên locale|
|[`wctob()`](#man-btowc)|Chuyển một wide character sang ký tự một byte|
|[`wctombr()`](#man-wcrtomb)|Chuyển wide sang multibyte kiểu restartable|
|[`wmemcmp()`](#man-wcscmp)|So sánh wide character trong bộ nhớ|
|[`wmemcpy()`](#man-wmemcpy)|Copy bộ nhớ wide character|
|[`wmemmove()`](#man-wmemcpy)|Copy bộ nhớ wide character, có thể đè nhau|
|[`wprintf()`](#man-wprintf)|Xuất wide có định dạng|
|[`wscanf()`](#man-wscanf)|Nhập wide có định dạng|

Đây là các biến thể wide character của những hàm có trong
[`<stdio.h>`](#stdio).

Nhớ là bạn không được mix-and-match các hàm xuất multibyte (như
[`printf()`](#man-printf)) với các hàm xuất wide character (như
[`wprintf()`](#man-wprintf)). Output stream có một _orientation_ (định
hướng) hoặc là multibyte hoặc là wide, được đặt ngay lời gọi I/O đầu
tiên lên stream đó. (Hoặc có thể đặt bằng [`fwide()`](#man-fwide).)

Nên chọn một trong hai và bám lấy nó.

Bạn có thể đặc tả wide character constant và string literal bằng cách
thêm tiền tố `L` ở đầu:

``` {.c}
wchar_t *s = L"Hello, world!";
wchar_t c = L'B';
```

Header này cũng giới thiệu kiểu `wint_t` được các hàm I/O ký tự dùng.
Đây là kiểu có thể giữ bất kỳ wide character đơn nào, và _cũng_ giữ
được macro `WEOF` để báo wide end-of-file.

## Hàm Restartable

Cuối cùng, vài lời về các hàm "restartable" có trong đây. Khi
conversion đang diễn ra, một số encoding yêu cầu C phải theo dõi một
ít _state_ (trạng thái) về tiến độ conversion cho đến thời điểm đó.

Với nhiều hàm, C dùng một biến nội bộ cho state đó, dùng chung giữa
các lời gọi hàm. Vấn đề là nếu bạn viết code đa luồng, state này có
thể bị các luồng khác dẫm đạp.

Để tránh chuyện đó, mỗi luồng cần tự giữ state của riêng nó trong
một biến kiểu opaque [i[`mbstate_t` type]i] `mbstate_t`. Và các hàm
"restartable" cho phép bạn truyền state đó vào để mỗi luồng dùng biến
của riêng mình.

[[manbreak]]
## `wprintf()`, `fwprintf()`, `swprintf()` {#man-wprintf}

[i[`wprintf()` function]i]
[i[`fwprintf()` function]i]
[i[`swprintf()` function]i]

Xuất có định dạng với một wide string

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>   // For fwprintf()
#include <wchar.h>

int wprintf(const wchar_t * restrict format, ...);

int fwprintf(FILE * restrict stream, const wchar_t * restrict format, ...);

int swprintf(wchar_t * restrict s, size_t n,
             const wchar_t * restrict format, ...);
```

### Description {.unnumbered .unlisted}

Đây là các phiên bản wide của [`printf()`](#man-printf),
[`fprintf()](#man-printf), và [`sprintf()`](#man-printf).

Xem các trang đó để biết cách dùng cụ thể.

Chúng giống hệt nhau trừ cái `format` string là một chuỗi wide
character thay vì một chuỗi multibyte.

Và `swprintf()` thì tương tự `snprintf()` ở chỗ cả hai đều nhận kích
thước của mảng đích làm tham số.

Một chuyện nữa: precision đặc tả cho một `%s` specifier tương ứng với
số wide character được in, không phải số byte. Nếu bạn biết khác biệt
nào khác, báo tôi.

### Return Value {.unnumbered .unlisted}

Trả về số wide character đã xuất, hoặc `-1` nếu có lỗi.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <wchar.h>

int main(void)
{
    char *mbs = "multibyte";
    wchar_t *ws = L"wide";

    wprintf(L"We're all wide for %s and %ls!\n", mbs, ws);

    double pi = 3.14159265358979;
    wprintf(L"pi = %f\n", pi);
}
```

Output:

``` {.default}
We're all wide for multibyte and wide!
pi = 3.141593
```

### See Also {.unnumbered .unlisted}

[`printf()`](#man-printf),
[`vwprintf()`](#man-vwprintf)

[[manbreak]]
## `wscanf()` `fwscanf()` `swscanf()` {#man-wscanf}

[i[`wscanf()` function]i]
[i[`fwscanf()` function]i]
[i[`swscanf()` function]i]

Scan một wide stream hoặc wide string để nhập có định dạng

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>  // for fwscanf()
#include <wchar.h>

int wscanf(const wchar_t * restrict format, ...);

int fwscanf(FILE * restrict stream, const wchar_t * restrict format, ...);

int swscanf(const wchar_t * restrict s, const wchar_t * restrict format, ...);
```

### Description {.unnumbered .unlisted}

Đây là các biến thể wide của [`scanf()`](#man-scanf),
[`fscanf()`](#man-scanf), và [`sscanf()`](#man-scanf).

Xem trang [`scanf()`](#man-scanf) để biết mọi chi tiết.

### Return Value {.unnumbered .unlisted}

Trả về số mục scan được thành công, hoặc `EOF` nếu có lỗi input nào đó.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <wchar.h>

int main(void)
{
    int quantity;
    wchar_t item[100];

    wprintf(L"Enter \"quantity: item\"\n");
    
    if (wscanf(L"%d:%99ls", &quantity, item) != 2)
        wprintf(L"Malformed input!\n");
    else
        wprintf(L"You entered: %d %ls\n", quantity, item);
}
```

Output (với input là `12: apples`):

``` {.default}
Enter "quantity: item"
12: apples
You entered: 12 apples
```

### See Also {.unnumbered .unlisted}

[`scanf()`](#man-scanf),
[`vwscanf()`](#man-vwscanf)

[[manbreak]]
## `vwprintf()` `vfwprintf()` `vswprintf()` {#man-vwprintf}

[i[`vwprintf()` function]i]
[i[`vfwprintf()` function]i]
[i[`vswprintf()` function]i]

Các biến thể của `wprintf()` dùng danh sách tham số biến thiên (`va_list`)

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>   // For vfwprintf()
#include <stdarg.h>
#include <wchar.h>

int vwprintf(const wchar_t * restrict format, va_list arg);

int vswprintf(wchar_t * restrict s, size_t n,
              const wchar_t * restrict format, va_list arg); 

int vfwprintf(FILE * restrict stream, const wchar_t * restrict format,
              va_list arg);
```

### Description {.unnumbered .unlisted}

Các hàm này là biến thể wide character của các hàm
[`vprintf()`](#man-vprintf). Bạn có thể [xem trang tham khảo
đó](#man-vprintf) để biết thêm chi tiết.

### Return Value {.unnumbered .unlisted}

Trả về số wide character đã lưu, hoặc một giá trị âm nếu có lỗi.

### Example {.unnumbered .unlisted}

Trong ví dụ này, chúng ta tự làm phiên bản riêng của `wprintf()` tên
là `wlogger()` để chấm timestamp vào output. Để ý rằng các lời gọi
`wlogger()` có đủ hết những thứ hay ho của `wprintf()`.

``` {.c .numberLines}
#include <stdarg.h>
#include <wchar.h>
#include <time.h>

int wlogger(wchar_t *format, ...)
{
    va_list va;
    time_t now_secs = time(NULL);
    struct tm *now = gmtime(&now_secs);

    // In timestamp theo định dạng "YYYY-MM-DD hh:mm:ss : "
    wprintf(L"%04d-%02d-%02d %02d:%02d:%02d : ",
        now->tm_year + 1900, now->tm_mon + 1, now->tm_mday,
        now->tm_hour, now->tm_min, now->tm_sec);

    va_start(va, format);
    int result = vwprintf(format, va);
    va_end(va);

    wprintf(L"\n");

    return result;
}

int main(void)
{
    int x = 12;
    float y = 3.2;

    wlogger(L"Hello!");
    wlogger(L"x = %d and y = %.2f", x, y);
}
```

Output:

``` {.default}
2021-03-30 04:25:49 : Hello!
2021-03-30 04:25:49 : x = 12 and y = 3.20
```

### See Also {.unnumbered .unlisted}

[`printf()`](#man-printf),
[`vprintf()`](#man-vprintf)


[[manbreak]]
## `vwscanf()`, `vfwscanf()`, `vswscanf()` {#man-vwscanf}

[i[`vwscanf()` function]i]
[i[`vfwscanf()` function]i]
[i[`vswscanf()` function]i]

Các biến thể của `wscanf()` dùng danh sách tham số biến thiên (`va_list`)

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>   // For vfwscanf()
#include <stdarg.h>
#include <wchar.h>

int vwscanf(const wchar_t * restrict format, va_list arg);

int vfwscanf(FILE * restrict stream, const wchar_t * restrict format,
             va_list arg); 

int vswscanf(const wchar_t * restrict s, const wchar_t * restrict format,
             va_list arg);
```

### Description {.unnumbered .unlisted}

Đây là các đối tác wide của tập hàm [`vscanf()`](#man-vscanf). Xem
[trang tham khảo của chúng để biết chi tiết](#man-vscanf).

### Return Value {.unnumbered .unlisted}

Trả về số mục scan được thành công, hoặc `EOF` nếu có lỗi input nào đó.

### Example {.unnumbered .unlisted}

Tôi phải thú nhận là tôi vắt óc mãi mới nghĩ ra bao giờ thì bạn muốn
dùng cái này. Ví dụ hay nhất tôi tìm được là [fl[một cái trên Stack
Overflow|https://stackoverflow.com/questions/17017331/c99-vscanf-for-dummies/17018046#17018046]]
kiểm tra lỗi cho giá trị trả về từ `scanf()` so với giá trị kỳ vọng.
Một biến thể của cái đó ở dưới.

``` {.c .numberLines}
#include <stdarg.h>
#include <wchar.h>
#include <assert.h>

int error_check_wscanf(int expected_count, wchar_t *format, ...)
{
    va_list va;

    va_start(va, format);
    int count = vwscanf(format, va);
    va_end(va);

    // Dòng này sẽ làm chương trình crash nếu điều kiện sai:
    assert(count == expected_count);

    return count;
}

int main(void)
{
    int a, b;
    float c;

    error_check_wscanf(3, L"%d, %d/%f", &a, &b, &c);
    error_check_wscanf(2, L"%d", &a);
}
```

### See Also {.unnumbered .unlisted}

[`wscanf()`](#man-wscanf)

[[manbreak]]
## `getwc()` `fgetwc()` `getwchar()` {#man-getwc}

[i[`getwc()` function]i]
[i[`fgetwc()` function]i]
[i[`getwchar()` function]i]

Lấy một wide character từ một input stream

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>   // For getwc() and fgetwc()
#include <wchar.h>

wint_t getwchar(void);

wint_t getwc(FILE *stream);

wint_t fgetwc(FILE *stream);
```

### Description {.unnumbered .unlisted}

Đây là các biến thể wide của [`fgetc()`](#man-getc).

`fgetwc()` và `getwc()` giống hệt nhau, chỉ khác `getwc()` có thể được
hiện thực dưới dạng macro và được phép evaluate `stream` nhiều lần.

`getwchar()` giống hệt `getwc()` với `stream` là `stdin`.

Tôi chẳng hiểu sao bạn lại dùng `getwc()` thay vì `fgetwc()`, nhưng
nếu ai biết thì báo tôi một tiếng.

### Return Value {.unnumbered .unlisted}

Trả về wide character tiếp theo trong input stream. Trả về `WEOF` ở
end-of-file hoặc khi có lỗi.

Nếu có lỗi I/O, cờ lỗi cũng được đặt trên stream.

Nếu gặp byte sequence không hợp lệ, `errno` được đặt thành `ILSEQ`.

### Example {.unnumbered .unlisted}

Đọc tất cả ký tự từ một file, chỉ xuất ra những chữ 'b' nó tìm thấy
trong file:

``` {.c .numberLines}
#include <stdio.h>
#include <wchar.h>

int main(void)
{
    FILE *fp;
    wint_t c;

    fp = fopen("datafile.txt", "r"); // error check this!

    // this while-statement assigns into c, and then checks against EOF:

    while((c = fgetc(fp)) != WEOF) 
        if (c == L'b')
            fputwc(c, stdout);

    fclose(fp);
}
```

### See Also {.unnumbered .unlisted}

[`fputwc`](#man-putwc),
[`fgetws`](#man-fgetws),
[`errno`](#errno)

[[manbreak]]
## `fgetws()` {#man-fgetws}

[i[`fgetws()` function]i]

Đọc một wide string từ một file

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>
#include <wchar.h>

wchar_t *fgetws(wchar_t * restrict s, int n, FILE * restrict stream);
```

### Description {.unnumbered .unlisted}

Đây là phiên bản wide của [`fgets()`](#man-gets). Xem [trang tham
khảo của nó để biết chi tiết](#man-gets).

Một ký tự wide `NUL` được dùng để kết thúc chuỗi.

### Return Value {.unnumbered .unlisted}

Trả về `s` nếu thành công, hoặc con trỏ `NULL` nếu end-of-file hoặc có lỗi.

### Example {.unnumbered .unlisted}

Ví dụ sau đây đọc từng dòng từ một file và đánh số vào đầu mỗi dòng:

``` {.c .numberLines}
#include <stdio.h>
#include <wchar.h>

#define BUF_SIZE 1024

int main(void)
{
    FILE *fp;
    wchar_t buf[BUF_SIZE];

    fp = fopen("textfile.txt", "r"); // error check this!

    int line_count = 0;

    while ((fgetws(buf, BUF_SIZE, fp)) != NULL) 
        wprintf(L"%04d: %ls", ++line_count, buf);

    fclose(fp);
}
```

Output ví dụ cho một file có các dòng (không có số đã thêm):

``` {.default}
0001: line 1
0002: line 2
0003: something
0004: line 4
```

### See Also {.unnumbered .unlisted}

[`fgetwc()`](#man-getwc),
[`fgets()`](#man-gets)

[[manbreak]]
## `putwchar()` `putwc()` `fputwc()` {#man-putwc}

[i[`putwchar()` function]i]
[i[`putwc()` function]i]
[i[`fputwc()` function]i]

Ghi một wide character đơn ra console hoặc ra file

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>   // For putwc() and fputwc()
#include <wchar.h>

wint_t putwchar(wchar_t c);

wint_t putwc(wchar_t c, FILE *stream);

wint_t fputwc(wchar_t c, FILE *stream);
```

### Description {.unnumbered .unlisted}

Đây là các tương đương wide character của nhóm hàm
['fputc()'](#man-putc). Bạn có thể tìm thêm thông tin ['ở phần tham
khảo đó'](#man-putc).

`fputwc()` và `putwc()` giống hệt nhau, chỉ khác `putwc()` có thể
được hiện thực dưới dạng macro và được phép evaluate `stream` nhiều lần.

`putwchar()` giống hệt `putwc()` với `stream` là `stdin`.

Tôi chẳng hiểu sao bạn lại dùng `putwc()` thay vì `fputwc()`, nhưng
nếu ai biết thì báo tôi một tiếng.

### Return Value {.unnumbered .unlisted}

Trả về wide character đã ghi, hoặc `WEOF` nếu có lỗi.

Nếu là lỗi I/O, cờ lỗi sẽ được đặt cho stream.

Nếu là lỗi encoding, `errno` sẽ được đặt thành `EILSEQ`.

### Example {.unnumbered .unlisted}

Đọc tất cả ký tự từ một file, chỉ xuất ra những chữ 'b' nó tìm thấy
trong file:

``` {.c .numberLines}
#include <stdio.h>
#include <wchar.h>

int main(void)
{
    FILE *fp;
    wint_t c;

    fp = fopen("datafile.txt", "r"); // error check this!

    // this while-statement assigns into c, and then checks against EOF:

    while((c = fgetc(fp)) != WEOF) 
        if (c == L'b')
            fputwc(c, stdout);

    fclose(fp);
}
```

### See Also {.unnumbered .unlisted}

[`fgetwc()`](#man-getwc),
[`fputc()`](#man-putc),
[`errno`](#errno)

[[manbreak]]
## `fputws()` {#man-fputws}

[i[`fputws()` function]i]

Ghi một wide string ra một file

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>
#include <wchar.h>

int fputws(const wchar_t * restrict s, FILE * restrict stream);
```

### Description {.unnumbered .unlisted}

Đây là phiên bản wide của [`fputs()`](#man-puts).

Truyền vào một wide string và một output stream, và nó sẽ được ghi ra.

### Return Value {.unnumbered .unlisted}

Trả về một giá trị không âm nếu thành công, hoặc `EOF` nếu có lỗi.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <wchar.h>

int main(void)
{
    fputws(L"Hello, world!\n", stdout);
}
```

### See Also {.unnumbered .unlisted}

[`fputwc()`](#man-putwc)
[`fputs()`](#man-puts)

[[manbreak]]
## `fwide()` {#man-fwide}

[i[`fwide()` function]i]

Lấy hoặc đặt orientation của stream

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>
#include <wchar.h>

int fwide(FILE *stream, int mode);
```

### Description {.unnumbered .unlisted}

Stream có thể là wide-oriented (nghĩa là các hàm wide đang được dùng)
hoặc byte-oriented (các hàm multibyte thường đang được dùng). Hoặc,
trước khi orientation được chọn, thì là unoriented.

Có hai cách đặt orientation cho một stream unoriented:

* Ngầm: chỉ cần dùng một hàm như `printf()` (byte oriented) hoặc
  `wprintf()` (wide oriented), và orientation sẽ được đặt.

* Tường minh: dùng hàm này để đặt.

Bạn có thể đặt orientation cho stream bằng cách truyền các số khác
nhau vào `mode`:

|`mode`|Mô tả|
|-|-|
|`0`|Không thay đổi orientation|
|`-1`|Đặt stream thành byte-oriented|
|`1`|Đặt stream thành wide-oriented|

(Tôi nói `-1` và `1` ở đó, nhưng thực ra có thể là bất kỳ số dương
hay âm nào.)

Hầu hết mọi người chọn các hàm wide hoặc byte (`printf()` hoặc
`wprintf()`) và cứ xài, không bao giờ dùng `fwide()` để đặt
orientation.

Và một khi orientation đã được đặt, bạn không đổi được. Nên bạn cũng
chẳng dùng `fwide()` cho việc đó được.

Vậy dùng nó để làm gì?

Bạn có thể _kiểm tra_ xem một stream đang ở orientation nào bằng cách
truyền `0` vào `mode` và kiểm tra giá trị trả về.

### Return Value {.unnumbered .unlisted}

Trả về số lớn hơn 0 nếu stream là wide-oriented.

Trả về số nhỏ hơn 0 nếu stream là byte-oriented.

Trả về 0 nếu stream là unoriented.

### Example {.unnumbered .unlisted}

Ví dụ đặt thành byte-oriented:

``` {.c .numberLines}
#include <stdio.h>
#include <wchar.h>

int main(void)
{
    printf("Hello world!\n");  // Ngầm đặt thành byte

    int mode = fwide(stdout, 0);

    printf("Stream is %s-oriented\n", mode < 0? "byte": "wide");
}
```

Output:

``` {.default}
Hello world!
Stream is byte-oriented
```

Ví dụ đặt thành wide-oriented:

``` {.c .numberLines}
#include <stdio.h>
#include <wchar.h>

int main(void)
{
    wprintf(L"Hello world!\n");  // Ngầm đặt thành wide

    int mode = fwide(stdout, 0);

    wprintf(L"Stream is %ls-oriented\n", mode < 0? L"byte": L"wide");
}
```

Output:

``` {.default}
Hello world!
Stream is wide-oriented
```

<!--
### See Also {.unnumbered .unlisted}

[`example()`](#man-example),
-->

[[manbreak]]
## `ungetwc()` {#man-ungetwc}

[i[`ungetwc()` function]i]

Đẩy một wide character trở lại input stream

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>
#include <wchar.h>

wint_t ungetwc(wint_t c, FILE *stream);
```

### Description {.unnumbered .unlisted}

Đây là biến thể wide character của [`ungetc()`](#man-ungetc).

Nó làm điều ngược với [`fgetwc()`](#man-getwc), đẩy một ký tự trở lại
input stream.

Spec bảo đảm bạn làm được chuyện này một lần liên tiếp. Có thể bạn
làm được nhiều lần hơn, nhưng tuỳ implementation. Nếu gọi quá nhiều
lần mà không có lời đọc xen vào, có thể sẽ trả về lỗi.

Đặt vị trí file sẽ huỷ mọi ký tự đã được `ungetwc()` đẩy vào mà chưa
đọc lại.

Cờ end-of-file sẽ được xoá sau một lời gọi thành công.

### Return Value {.unnumbered .unlisted}

Trả về giá trị của ký tự đã đẩy nếu thành công, hoặc `WEOF` nếu thất bại.

### Example {.unnumbered .unlisted}

Ví dụ này đọc một dấu câu, rồi mọi thứ sau nó cho đến dấu câu tiếp
theo. Nó trả về dấu câu dẫn đầu và lưu phần còn lại vào một chuỗi.

``` {.c .numberLines}
#include <stdio.h>
#include <wctype.h>
#include <wchar.h>

wint_t read_punctstring(FILE *fp, wchar_t *s)
{
    wint_t origpunct, c;
    
    origpunct = fgetwc(fp);

    if (origpunct == WEOF)  // trả về EOF khi end-of-file
        return WEOF;

    while (c = fgetwc(fp), !iswpunct(c) && c != WEOF)
        *s++ = c;  // lưu vào chuỗi

    *s = L'\0'; // nul-terminate chuỗi

    // nếu đọc được dấu câu cuối cùng, ungetc nó để lần sau fgetc
    // lấy lại được:
    if (iswpunct(c))
        ungetwc(c, fp);

    return origpunct;
}

int main(void)
{
    wchar_t s[128];
    wint_t c;

    while ((c = read_punctstring(stdin, s)) != WEOF) {
        wprintf(L"%lc: %ls\n", c, s);
    }
}
```

Sample Input:

``` {.default}
!foo#bar*baz
```

Sample output:

``` {.default}
!: foo
#: bar
*: baz
```

### See Also {.unnumbered .unlisted}

[`fgetwc()`](#man-getwc),
[`ungetc()`](#man-ungetc)

[[manbreak]]
## `wcstod()` `wcstof()` `wcstold()` {#man-wcstod}

[i[`wcstod()` function]i]
[i[`wcstof()` function]i]
[i[`wcstold()` function]i]

Chuyển một wide string sang số dấu phẩy động

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wchar.h>

double wcstod(const wchar_t * restrict nptr, wchar_t ** restrict endptr);

float wcstof(const wchar_t * restrict nptr, wchar_t ** restrict endptr);

long double wcstold(const wchar_t * restrict nptr, wchar_t ** restrict endptr);
```

### Description {.unnumbered .unlisted}

Đây là các đối tác wide của họ hàm [`strtod()`](#man-strtod). Xem
[trang tham khảo của chúng để biết chi tiết](#man-strtod).

### Return Value {.unnumbered .unlisted}

Trả về chuỗi đã được chuyển sang giá trị dấu phẩy động.

Trả về `0` nếu không có số hợp lệ trong chuỗi.

Khi overflow, trả về `HUGE_VAL`, `HUGE_VALF`, hoặc `HUGE_VALL` với
dấu thích hợp tuỳ kiểu trả về, và `errno` được đặt thành `ERANGE`.

Khi underflow, trả về một số không lớn hơn số dương normalized nhỏ
nhất, có dấu thích hợp. Implementation _có thể_ đặt `errno` thành
`ERANGE`.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>

int main(void)
{
    wchar_t *inp = L"   123.4567beej";
    wchar_t *badchar;

    double val = wcstod(inp, &badchar);

    wprintf(L"Converted string to %f\n", val);
    wprintf(L"Encountered bad characters: %ls\n", badchar);

    val = wcstod(L"987.654321beej", NULL);
    wprintf(L"Ignoring bad chars: %f\n", val);

    val = wcstod(L"11.2233", &badchar);

    if (*badchar == L'\0')
        wprintf(L"No bad chars: %f\n", val);
    else
        wprintf(L"Found bad chars: %f, %ls\n", val, badchar);
}
```

Output:

``` {.default}
Converted string to 123.456700
Encountered bad characters: beej
Ignoring bad chars: 987.654321
No bad chars: 11.223300
```

### See Also {.unnumbered .unlisted}

[`wcstol()`](#man-wcstol),
[`strtod()`](#man-strtod),
[`errno`](#errno)

[[manbreak]]
## `wcstol()` `wcstoll()` `wcstoul()` `wcstoull()` {#man-wcstol}

[i[`wcstol()` function]i]
[i[`wcstoll()` function]i]
[i[`wcstoul()` function]i]
[i[`wcstoull()` function]i]

Chuyển một wide string sang giá trị số nguyên

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wchar.h>

long int wcstol(const wchar_t * restrict nptr,
                wchar_t ** restrict endptr, int base);

long long int wcstoll(const wchar_t * restrict nptr,
                      wchar_t ** restrict endptr, int base);

unsigned long int wcstoul(const wchar_t * restrict nptr,
                          wchar_t ** restrict endptr, int base);

unsigned long long int wcstoull(const wchar_t * restrict nptr,
                                wchar_t ** restrict endptr, int base);
```

### Description {.unnumbered .unlisted}

Đây là các đối tác wide của họ hàm [`strtol()`](#man-strtol), nên xem
[trang tham khảo của chúng để biết chi tiết](#man-strtol).

### Return Value {.unnumbered .unlisted}

Trả về giá trị số nguyên của chuỗi.

Nếu không tìm được gì, trả về `0`.

Nếu kết quả nằm ngoài phạm vi, giá trị trả về là một trong `LONG_MIN`,
`LONG_MAX`, `LLONG_MIN`, `LLONG_MAX`, `ULONG_MAX` hoặc `ULLONG_MAX`,
tuỳ trường hợp. Và `errno` được đặt thành `ERANGE`.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>

int main(void)
{
    // All output in decimal (base 10)

    wprintf(L"%ld\n", wcstol(L"123", NULL, 0));     // 123
    wprintf(L"%ld\n", wcstol(L"123", NULL, 10));    // 123
    wprintf(L"%ld\n", wcstol(L"101010", NULL, 2));  // binary, 42
    wprintf(L"%ld\n", wcstol(L"123", NULL, 8));     // octal, 83
    wprintf(L"%ld\n", wcstol(L"123", NULL, 16));    // hex, 291

    wprintf(L"%ld\n", wcstol(L"0123", NULL, 0));    // octal, 83
    wprintf(L"%ld\n", wcstol(L"0x123", NULL, 0));   // hex, 291

    wchar_t *badchar;
    long int x = wcstol(L"   1234beej", &badchar, 0);

    wprintf(L"Value is %ld\n", x);                  // Value is 1234
    wprintf(L"Bad chars at \"%ls\"\n", badchar);    // Bad chars at "beej"
}
```

Output:

``` {.default}
123
123
42
83
291
83
291
Value is 1234
Bad chars at "beej"
```

### See Also {.unnumbered .unlisted}

[`wcstod()`](#man-wcstod),
[`strtol()`](#man-strtol),
[`errno`](#errno),
[`wcstoimax()`](#man-wcstoimax),
[`wcstoumax()`](#man-wcstoimax)

[[manbreak]]
## `wcscpy()` `wcsncpy()` {#man-wcscpy}

[i[`wcscpy()` function]i]
[i[`wcsncpy()` function]i]

Copy một wide string

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wchar.h>

wchar_t *wcscpy(wchar_t * restrict s1, const wchar_t * restrict s2);

wchar_t *wcsncpy(wchar_t * restrict s1,
                 const wchar_t * restrict s2, size_t n);
```

### Description {.unnumbered .unlisted}

Đây là các phiên bản wide của [`strcpy()`](#man-strcpy) và
[`strncpy()`](#man-strcpy).

Chúng copy một chuỗi đến khi gặp wide NUL. Hoặc, với phiên bản an
toàn hơn `wcsncpy()`, đến đó hoặc đến khi `n` wide character đã
được copy.

Nếu chuỗi trong `s1` ngắn hơn `n`, `wcsncpy()` sẽ đệm `s2` bằng các
wide NUL character cho đến khi chạm wide character thứ `n`.

Dù `wcsncpy()` an toàn hơn vì nó sẽ không bao giờ chạy vượt cuối `s2`
(giả sử bạn đặt `n` đúng), nó vẫn không an toàn nếu không tìm thấy
NUL trong `n` ký tự đầu của `s1`. Trong trường hợp đó, `s2` sẽ không
được NUL-terminate. Luôn đảm bảo `n` lớn hơn độ dài chuỗi `s1`!

### Return Value {.unnumbered .unlisted}

Trả về `s1`.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>

int main(void)
{
    wchar_t *s1 = L"Hello!";
    wchar_t s2[10];

    wcsncpy(s2, s1, 10);

    wprintf(L"\"%ls\"\n", s2);  // "Hello!"
}
```

### See Also {.unnumbered .unlisted}

[`wmemcpy()`](#man-wmemcpy),
[`wmemmove()`](#man-wmemcpy)
[`strcpy()`](#man-strcpy),
[`strncpy()`](#man-strcpy)

[[manbreak]]
## `wmemcpy()` `wmemmove()` {#man-wmemcpy}

[i[`wmemcpy()` function]i]
[i[`wmemmove()` function]i]

Copy wide character

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wchar.h>

wchar_t *wmemcpy(wchar_t * restrict s1,
                 const wchar_t * restrict s2, size_t n);

wchar_t *wmemmove(wchar_t *s1, const wchar_t *s2, size_t n);
```

### Description {.unnumbered .unlisted}

Đây là các phiên bản wide của [`memcpy()`](#man-memcpy) và
[`memmove()`](#man-memcpy).

Chúng copy `n` wide character từ `s2` vào `s1`.

Chúng giống nhau trừ chuyện `wmemmove()` được bảo đảm hoạt động với
các vùng nhớ đè nhau, còn `wmemcpy()` thì không.

### Return Value {.unnumbered .unlisted}

Cả hai hàm đều trả về con trỏ `s1`.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>

int main(void)
{
    wchar_t s[100] = L"Goats";
    wchar_t t[100];

    wmemcpy(t, s, 6);       // Copy bộ nhớ không đè nhau

    wmemmove(s + 2, s, 6);  // Copy bộ nhớ đè nhau

    wprintf(L"s is \"%ls\"\n", s);
    wprintf(L"t is \"%ls\"\n", t);
}
```

Output:

``` {.default}
s is "GoGoats"
t is "Goats"
```

### See Also {.unnumbered .unlisted}

[`wcscpy()`](#man-wcscpy),
[`wcsncpy()`](#man-wcscpy),
[`memcpy()`](#man-memcpy),
[`memmove()`](#man-memcpy)

[[manbreak]]
## `wcscat()` `wcsncat()` {#man-wcscat}

[i[`wcscat()` function]i]
[i[`wcsncat()` function]i]

Nối wide string

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wchar.h>

wchar_t *wcscat(wchar_t * restrict s1, const wchar_t * restrict s2);

wchar_t *wcsncat(wchar_t * restrict s1,
                 const wchar_t * restrict s2, size_t n);
```

### Description {.unnumbered .unlisted}

Đây là các biến thể wide của [`strcat()`](#man-strcat) và
[`strncat()`](#man-strcat).

Chúng nối `s2` vào cuối `s1`.

Chúng giống nhau trừ `wcsncat()` cho bạn chọn giới hạn số wide
character được nối.

Lưu ý `wcsncat()` luôn thêm một NUL terminator vào cuối, kể cả khi
`n` ký tự đã được nối. Nên nhớ chừa chỗ cho cái đó.

### Return Value {.unnumbered .unlisted}

Cả hai hàm đều trả về con trỏ `s1`.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>

int main(void)
{
    wchar_t dest[30] = L"Hello";
    wchar_t *src = L", World!";
    wchar_t numbers[] = L"12345678";

    wprintf(L"dest before strcat: \"%ls\"\n", dest); // "Hello"

    wcscat(dest, src);
    wprintf(L"dest after strcat:  \"%ls\"\n", dest); // "Hello, world!"

    wcsncat(dest, numbers, 3); // strcat 3 ký tự đầu của numbers
    wprintf(L"dest after strncat: \"%ls\"\n", dest); // "Hello, world!123"
}
```

### See Also {.unnumbered .unlisted}

[`strcat()`](#man-strcat),
[`strncat()`](#man-strcat)

[[manbreak]]
## `wcscmp()`, `wcsncmp()`, `wmemcmp()` {#man-wcscmp}

[i[`wcscmp()` function]i]
[i[`wcsncmp()` function]i]
[i[`wmemcmp()` function]i]

So sánh wide string hoặc bộ nhớ

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wchar.h>

int wcscmp(const wchar_t *s1, const wchar_t *s2);

int wcsncmp(const wchar_t *s1, const wchar_t *s2, size_t n);

int wmemcmp(const wchar_t *s1, const wchar_t *s2, size_t n);

```

### Description {.unnumbered .unlisted}

Đây là các biến thể wide của [`memcmp()`](#man-strcmp),
[`strcmp()`](#man-strcmp), và [`strncmp()`](#man-strcmp).

`wcscmp()` và `wcsncmp()` đều so sánh chuỗi đến ký tự NUL.

`wcsncmp()` còn thêm hạn chế là chỉ so sánh `n` ký tự đầu.

`wmemcmp()` giống `wcsncmp()` trừ chuyện nó không dừng ở NUL.

So sánh được thực hiện dựa trên giá trị ký tự (có thể (hoặc không)
là Unicode code point của nó).

### Return Value {.unnumbered .unlisted}

Trả về 0 nếu cả hai vùng bằng nhau.

Trả về một số âm nếu vùng `s1` trỏ tới nhỏ hơn `s2`.

Trả về một số dương nếu vùng `s1` trỏ tới lớn hơn `s2`.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>

int main(void)
{
    wchar_t *s1 = L"Muffin";
    wchar_t *s2 = L"Muffin Sandwich";
    wchar_t *s3 = L"Muffin";

    wprintf(L"%d\n", wcscmp(L"Biscuits", L"Kittens")); // <0 since 'B' < 'K'
    wprintf(L"%d\n", wcscmp(L"Kittens", L"Biscuits")); // >0 since 'K' > 'B'

    if (wcscmp(s1, s2) == 0)
        wprintf(L"This won't get printed because the strings differ\n");

    if (wcscmp(s1, s3) == 0)
        wprintf(L"This will print because s1 and s3 are the same\n");

    // hơi lạ...nhưng nếu các chuỗi giống nhau, nó sẽ trả về 0,
    // mà 0 cũng có thể hiểu là "false". Not-false là "true",
    // nên (!wcscmp()) sẽ là true nếu các chuỗi giống nhau. Vâng,
    // lạ thật, nhưng bạn thấy hoài ngoài kia nên cứ quen dần đi:

    if (!wcscmp(s1, s3))
        wprintf(L"The strings are the same!\n");

    if (!wcsncmp(s1, s2, 6))
        wprintf(L"The first 6 characters of s1 and s2 are the same\n");
}
```

Output:

``` {.default}
-1
1
This will print because s1 and s3 are the same
The strings are the same!
The first 6 characters of s1 and s2 are the same
```

### See Also {.unnumbered .unlisted}

[`wcscoll()`](#man-wcscoll),
[`memcmp()`](#man-strcmp),
[`strcmp()`](#man-strcmp),
[`strncmp()`](#man-strcmp)

[[manbreak]]
## `wcscoll()` {#man-wcscoll}

[i[`wcscoll()` function]i]

So sánh hai wide string có tính đến locale

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wchar.h>

int wcscoll(const wchar_t *s1, const wchar_t *s2);
```

### Description {.unnumbered .unlisted}

Đây là phiên bản wide của [`strcoll()`](#man-strcoll). Xem [`trang
tham khảo đó`](#man-strcoll) để biết chi tiết.

Cái này chậm hơn `wcscmp()`, nên chỉ dùng khi bạn cần so sánh theo
locale.

### Return Value {.unnumbered .unlisted}

Trả về 0 nếu cả hai vùng bằng nhau trong locale này.

Trả về một số âm nếu vùng `s1` trỏ tới nhỏ hơn `s2` trong locale này.

Trả về một số dương nếu vùng `s1` trỏ tới lớn hơn `s2` trong locale
này.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>
#include <locale.h>

int main(void)
{
    setlocale(LC_ALL, "");

    // Nếu source character set không hỗ trợ "é" trong chuỗi thì
    // có thể thay bằng `\u00e9`, Unicode code point của "é".

    wprintf(L"%d\n", wcscmp(L"é", L"f"));   // Reports é > f, yuck.
    wprintf(L"%d\n", wcscoll(L"é", L"f"));  // Reports é < f, yay!
}
```

### See Also {.unnumbered .unlisted}

[`wcscmp()`](#man-wcscmp),
[`wcsxfrm()`](#man-wcsxfrm),
[`strcoll()`](#man-strcoll)

[[manbreak]]
## `wcsxfrm()` {#man-wcsxfrm}

[i[`wcsxfrm()` function]i]

Biến đổi một wide string để so sánh dựa trên locale

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wchar.h>

size_t wcsxfrm(wchar_t * restrict s1,
               const wchar_t * restrict s2, size_t n);
```

### Description {.unnumbered .unlisted}

Đây là biến thể wide của [`strxfrm()`](#man-strxfrm). Xem [trang
tham khảo đó](#man-strxfrm) để biết chi tiết.

### Return Value {.unnumbered .unlisted}

Trả về độ dài của wide string đã biến đổi tính theo wide character.

Nếu giá trị trả về lớn hơn `n`, kết quả trong `s1` coi như bỏ, không
đoán được gì.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>
#include <locale.h>
#include <stdlib.h>

// Biến đổi một chuỗi để so sánh, trả về kết quả đã malloc'd
wchar_t *get_xfrm_str(wchar_t *s)
{
    int len = wcsxfrm(NULL, s, 0) + 1;
    wchar_t *d = malloc(len * sizeof(wchar_t));

    wcsxfrm(d, s, len);

    return d;
}

// Làm một nửa công việc của wcscoll() thường vì chuỗi thứ hai
// đến đã được biến đổi sẵn.
int half_wcscoll(wchar_t *s1, wchar_t *s2_transformed)
{
    wchar_t *s1_transformed = get_xfrm_str(s1);

    int result = wcscmp(s1_transformed, s2_transformed);

    free(s1_transformed);

    return result;
}

int main(void)
{
    setlocale(LC_ALL, "");

    // Biến đổi trước chuỗi để so sánh
    wchar_t *s = get_xfrm_str(L"éfg");

    // So sánh lặp lại với "éfg" 
    wprintf(L"%d\n", half_wcscoll(L"fgh", s));  // "fgh" > "éfg"
    wprintf(L"%d\n", half_wcscoll(L"àbc", s));  // "àbc" < "éfg"
    wprintf(L"%d\n", half_wcscoll(L"ĥij", s));  // "ĥij" > "éfg"
    
    free(s);
}
```

Output:

``` {.default}
1
-1
1
```

### See Also {.unnumbered .unlisted}

[`wcscmp()`](#man-wcscmp),
[`wcscoll()`](#man-wcscoll),
[`strxfrm()`](#man-strxfrm)

[[manbreak]]
## `wcschr()` `wcsrchr()` {#man-wcschr}

[i[`wcschr()` function]i]
[i[`wcsrchr()` function]i]

Tìm một wide character trong một wide string

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wchar.h>

// Pre-C23:

wchar_t *wcschr(const wchar_t *s, wchar_t c);

wchar_t *wcsrchr(const wchar_t *s, wchar_t c);

wchar_t *wmemchr(const wchar_t *s, wchar_t c, size_t n);

// C23:

QWchar_t *wcschr(QWchar_t *s, wchar_t c);

QWchar_t *wcsrchr(QWchar_t *s, wchar_t c);

QWchar_t *wmemchr(QWchar_t *s, wchar_t c, size_t n);
```

### Description {.unnumbered .unlisted}

Đây là các tương đương wide của [`strchr()`](#man-strchr),
[`strrchr()`](#man-strchr), và [`memchr()`](#man-strchr).

Chúng tìm wide character trong một wide string từ đầu
(`wcschr()`), từ cuối (`wcsrchr()`) hoặc tìm trong một số lượng
wide character tuỳ ý (`wmemchr()`).

### Return Value {.unnumbered .unlisted}

Cả ba hàm đều trả về con trỏ đến wide character tìm được, hoặc `NULL`
nếu không tìm thấy (buồn thật).

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>

int main(void)
{
    // "Hello, world!"
    //       ^  ^   ^
    //       A  B   C

    wchar_t *str = L"Hello, world!";
    wchar_t *p;

    p = wcschr(str, ',');       // p bây giờ trỏ đến vị trí A
    p = wcsrchr(str, 'o');      // p bây giờ trỏ đến vị trí B

    p = wmemchr(str, '!', 13);   // p bây giờ trỏ đến vị trí C

    // Lặp để tìm tất cả các chữ 'B'
    str = L"A BIG BROWN BAT BIT BEEJ";

    for(p = wcschr(str, 'B'); p != NULL; p = wcschr(p + 1, 'B')) {
        wprintf(L"Found a 'B' here: %ls\n", p);
    }
}
```

Output:

``` {.default}
Found a 'B' here: BIG BROWN BAT BIT BEEJ
Found a 'B' here: BROWN BAT BIT BEEJ
Found a 'B' here: BAT BIT BEEJ
Found a 'B' here: BIT BEEJ
Found a 'B' here: BEEJ
```

### See Also {.unnumbered .unlisted}

[`strchr()`](#man-strchr),
[`strrchr()`](#man-strchr),
[`memchr()`](#man-strchr)

[[manbreak]]
## `wcsspn()` `wcscspn()` {#man-wcsspn}

[i[`wcsspn()` function]i]
[i[`wcscspn()` function]i]

Trả về độ dài của một wide string gồm toàn các ký tự thuộc một tập
wide character, hoặc không thuộc một tập wide character

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wchar.h>

size_t wcsspn(const wchar_t *s1, const wchar_t *s2);

size_t wcscspn(const wchar_t *s1, const wchar_t *s2);
```

### Description {.unnumbered .unlisted}

Đây là các đối tác wide character của [`strspn()`] (#man-strspn) và
[`strcspn()`](#man-strspn).

Chúng tính độ dài của chuỗi `s1` trỏ tới gồm toàn các ký tự có trong
`s2`. Hoặc, với `wcscspn()`, các ký tự _không_ có trong `s2`.

### Return Value {.unnumbered .unlisted}

Độ dài của chuỗi `s1` trỏ tới gồm toàn các ký tự trong `s2` (với
`wcsspn()`) hoặc toàn các ký tự _không_ có trong `s2` (với
`wcscspn()`).

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>

int main(void)
{
    wchar_t str1[] = L"a banana";
    wchar_t str2[] = L"the bolivian navy on maneuvers in the south pacific";
    int n;

    // có bao nhiêu ký tự trong str1 trước khi gặp ký tự không phải nguyên âm?
    n = wcsspn(str1, L"aeiou");
    wprintf(L"%d\n", n);  // n == 1, just "a"

    // có bao nhiêu ký tự trong str1 trước khi gặp ký tự không phải
    // a, b, hoặc space?
    n = wcsspn(str1, L"ab ");
    wprintf(L"%d\n", n);  // n == 4, "a ba"

    // có bao nhiêu ký tự trong str2 trước khi gặp "y"?
    n = wcscspn(str2, L"y");
    wprintf(L"%d\n", n);  // n = 16, "the bolivian nav"
}
```

### See Also {.unnumbered .unlisted}

[`wcschr()`](#man-wcschr),
[`wcsrchr()`](#man-wcschr),
[`strspn()`](#man-strspn)

[[manbreak]]
## `wcspbrk()` {#man-wcspbrk}

[i[`wcspbrk()` function]i]

Tìm một wide character trong một tập ở một wide string

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wchar.h>

// Pre-C23:

wchar_t *wcspbrk(const wchar_t *s1, const wchar_t *s2);

// C23:

QWchar_t *wcspbrk(QWchar_t *s1, const wchar_t *s2);
```

### Description {.unnumbered .unlisted}

Đây là biến thể wide character của [`strpbrk()`](#man-strpbrk).

Nó tìm vị trí xuất hiện đầu tiên của bất kỳ ký tự nào trong một tập
wide character có trong một wide string.

### Return Value {.unnumbered .unlisted}

Trả về con trỏ đến ký tự đầu tiên trong chuỗi `s1` tồn tại trong
chuỗi `s2`.

Hoặc `NULL` nếu không tìm thấy ký tự nào của `s2` trong `s1`.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>

int main(void)
{
    //  p trỏ vào đây sau wcspbrk
    //                  v
    wchar_t *s1 = L"Hello, world!";
    wchar_t *s2 = L"dow!";  // Match bất kỳ ký tự nào trong đây

    wchar_t *p = wcspbrk(s1, s2);  // p trỏ vào chữ o

    wprintf(L"%ls\n", p);  // "o, world!"
}
```

### See Also {.unnumbered .unlisted}

[`wcschr()`](#man-wcschr),
[`wmemchr()`](#man-wcschr),
[`strpbrk()`](#man-strpbrk)

[[manbreak]]
## `wcsstr()` {#man-wcsstr}

[i[`wcsstr()` function]i]

Tìm một wide string trong một wide string khác

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wchar.h>

// Pre-C23:

wchar_t *wcsstr(const wchar_t *s1, const wchar_t *s2);

// C23:

QWchar_t *wcsstr(QWchar_t *s1, const wchar_t *s2);
```

### Description {.unnumbered .unlisted}

Đây là biến thể wide của [`strstr()`](#man-strstr).

Nó tìm vị trí một chuỗi con trong một chuỗi.

### Return Value {.unnumbered .unlisted}

Trả về con trỏ đến vị trí trong `s1` có chứa `s2`.

Hoặc `NULL` nếu không tìm thấy `s2` trong `s1`.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>

int main(void)
{
    wchar_t *str = L"The quick brown fox jumped over the lazy dogs.";
    wchar_t *p;

    p = wcsstr(str, L"lazy");
    wprintf(L"%ls\n", p == NULL? L"null": p); // "lazy dogs."

    // p sẽ là NULL sau đoạn này, vì chuỗi "wombat" không có trong str:
    p = wcsstr(str, L"wombat");
    wprintf(L"%ls\n", p == NULL? L"null": p); // "null"
}
```

### See Also {.unnumbered .unlisted}

[`wcschr()`](#man-wcschr),
[`wcsrchr()`](#man-wcschr),
[`wcsspn()`](#man-wcsspn),
[`wcscspn()`](#man-wcsspn),
[`strstr()`](#man-strstr)

[[manbreak]]
## `wcstok()` {#man-wcstok}

[i[`wcstok()` function]i]

Tách token một wide string

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wchar.h>
wchar_t *wcstok(wchar_t * restrict s1, const wchar_t * restrict s2,
                wchar_t ** restrict ptr); 
```

### Description {.unnumbered .unlisted}

Đây là phiên bản wide của [`strtok()`](#man-strtok).

Và, cũng như nó, nó chỉnh sửa chuỗi `s1`. Nên hãy copy nó ra trước
nếu muốn giữ chuỗi gốc.

Một khác biệt quan trọng là `wcstok()` có thể threadsafe vì bạn truyền
vào con trỏ `ptr` trỏ đến state hiện tại của quá trình biến đổi. Cái
này được khởi tạo tự động khi `s1` được truyền vào lần đầu dưới dạng
khác `NULL`. (Các lần gọi sau với `s1` là `NULL` làm state cập nhật.)

### Return Value {.unnumbered .unlisted}

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>

int main(void)
{
    // tách chuỗi thành chuỗi các từ cách nhau bởi space
    // hoặc dấu câu
    wchar_t str[] = L"Where is my bacon, dude?";
    wchar_t *token;
    wchar_t *state;

    // Lưu ý cấu trúc if-do-while sau đây rất rất rất
    // rất rất thường thấy khi dùng strtok().

    // lấy token đầu tiên (đảm bảo có token đầu tiên!)
    if ((token = wcstok(str, L".,?! ", &state)) != NULL) {
        do {
            wprintf(L"Word: \"%ls\"\n", token);

            // bây giờ, điều kiện tiếp tục của while lấy token
            // tiếp theo (bằng cách truyền NULL làm tham số đầu)
            // và tiếp tục nếu token không NULL:
        } while ((token = wcstok(NULL, L".,?! ", &state)) != NULL);
    }
}
```

Output:

``` {.default}
Word: "Where"
Word: "is"
Word: "my"
Word: "bacon"
Word: "dude"
```

### See Also {.unnumbered .unlisted}

[`strtok()`](#man-strtok)

[[manbreak]]
## `wcslen()` {#man-wcslen}

[i[`wcslen()` function]i]

Trả về độ dài của một wide string

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wchar.h>

size_t wcslen(const wchar_t *s);
```

### Description {.unnumbered .unlisted}

Đây là đối tác wide của [`strlen()`](#man-strlen).

### Return Value {.unnumbered .unlisted}

Trả về số wide character trước wide NUL terminator.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>

int main(void)
{
    wchar_t *s = L"Hello, world!"; // 13 ký tự

    // in "The string is 13 characters long.":

    wprintf(L"The string is %zu characters long.\n", wcslen(s));
}
```

### See Also {.unnumbered .unlisted}

[`strlen()`](#man-strlen)

[[manbreak]]
## `wcsftime()` {#man-wcsftime}

[i[`wcsftime()` function]i]

Xuất ngày giờ có định dạng

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <time.h>
#include <wchar.h>

size_t wcsftime(wchar_t * restrict s, size_t maxsize,
                const wchar_t * restrict format,
                const struct tm * restrict timeptr);
```

### Description {.unnumbered .unlisted}

Đây là tương đương wide của [`strftime()`](#man-strftime). Xem trang
tham khảo đó để biết chi tiết.

`maxsize` ở đây là số wide character tối đa có thể có trong chuỗi
kết quả.

### Return Value {.unnumbered .unlisted}

Nếu thành công, trả về số wide character đã ghi.

Nếu thất bại vì kết quả không vừa chỗ đã cấp, trả về `0` và nội dung
của chuỗi có thể là bất kỳ thứ gì.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>
#include <time.h>

#define BUFSIZE 128

int main(void)
{
    wchar_t s[BUFSIZE];
    time_t now = time(NULL);

    // %c: in ngày theo locale hiện hành
    wcsftime(s, BUFSIZE, L"%c", localtime(&now));
    wprintf(L"%ls\n", s);   // Sun Feb 28 22:29:00 2021

    // %A: tên đầy đủ của thứ
    // %B: tên đầy đủ của tháng
    // %d: ngày trong tháng
    wcsftime(s, BUFSIZE, L"%A, %B %d", localtime(&now));
    wprintf(L"%ls\n", s);   // Sunday, February 28

    // %I: giờ (đồng hồ 12 giờ)
    // %M: phút
    // %S: giây
    // %p: AM hoặc PM
    wcsftime(s, BUFSIZE, L"It's %I:%M:%S %p", localtime(&now));
    wprintf(L"%ls\n", s);   // It's 10:29:00 PM

    // %F: ISO 8601 yyyy-mm-dd
    // %T: ISO 8601 hh:mm:ss
    // %z: ISO 8601 offset múi giờ
    wcsftime(s, BUFSIZE, L"ISO 8601: %FT%T%z", localtime(&now));
    wprintf(L"%ls\n", s);   // ISO 8601: 2021-02-28T22:29:00-0800
}
```

### See Also {.unnumbered .unlisted}

[`strftime()`](#man-strftime)

[[manbreak]]
## `btowc()` `wctob()` {#man-btowc}

[i[`btowc()` function]i]
[i[`wctob()` function]i]

Chuyển một ký tự một byte sang một wide character

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wchar.h>

wint_t btowc(int c);

int wctob(wint_t c);
```

### Description {.unnumbered .unlisted}

Các hàm này chuyển qua lại giữa ký tự một byte và wide character.

Tuy có `int` trong đây, đừng để nó đánh lừa; thực chất chúng được
chuyển thành `unsigned char` bên trong.

Các ký tự trong basic character set được đảm bảo là một byte.

### Return Value {.unnumbered .unlisted}

`btowc()` trả về ký tự một byte dưới dạng wide character. Trả về
`WEOF` nếu `EOF` được truyền vào, hoặc byte không tương ứng wide
character hợp lệ.

`wctob()` trả về wide character dưới dạng ký tự một byte. Trả về
`EOF` nếu `WEOF` được truyền vào, hoặc wide character không tương
ứng ký tự một byte hợp lệ.

Xem [`mbtowc()`](#man-mbtowc) và [`wctomb()`](#man-wctomb) để chuyển
multibyte sang wide character.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>

int main(void)
{
    wint_t wc = btowc('B');    // Chuyển byte đơn sang wide char

    wprintf(L"Wide character: %lc\n", wc);

    unsigned char c = wctob(wc);  // Chuyển ngược về byte đơn

    wprintf(L"Single-byte character: %c\n", c);
}
```

Output:

``` {.default}
Wide character: B
Single-byte character: B
```

### See Also {.unnumbered .unlisted}

[`mbtowc()`](#man-mbtowc),
[`wctomb()`](#man-wctomb)

[[manbreak]]
## `mbsinit()` {#man-mbsinit}

[i[`mbsinit()` function]i]

Kiểm tra một `mbstate_t` có đang ở conversion state ban đầu không

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wchar.h>

int mbsinit(const mbstate_t *ps);
```

### Description {.unnumbered .unlisted}

Với một conversion state cho sẵn trong biến `mbstate_t`, hàm này xác
định xem nó có đang ở conversion state ban đầu không.

### Return Value {.unnumbered .unlisted}

Trả về khác 0 nếu giá trị `ps` trỏ tới đang ở conversion state ban
đầu, hoặc nếu `ps` là `NULL`.

Trả về `0` nếu giá trị `ps` trỏ tới **không** ở conversion state ban
đầu.

### Example {.unnumbered .unlisted}

Với tôi, ví dụ này chẳng có gì thú vị, nói rằng biến `mbstate_t` luôn
luôn ở state ban đầu. Yay.

Nhưng nếu bạn có một encoding có state như 2022-JP, thử nghịch với cái
này xem có vào được state trung gian nào không.

Chương trình này có một đoạn code ở đầu báo xem encoding của locale
bạn có cần state nào không.

``` {.c .numberLines}
#include <locale.h>   // For setlocale()
#include <string.h>   // For memset()
#include <stdlib.h>   // For mbtowc()
#include <wchar.h>

int main(void)
{
    mbstate_t state;
    wchar_t wc[128];

    setlocale(LC_ALL, "");

    int is_state_dependent = mbtowc(NULL, NULL, 0);

    wprintf(L"Is encoding state dependent? %d\n", is_state_dependent);

    memset(&state, 0, sizeof state);  // Đặt về state ban đầu

    wprintf(L"In initial conversion state? %d\n", mbsinit(&state));

    mbrtowc(wc, "B", 5, &state);

    wprintf(L"In initial conversion state? %d\n", mbsinit(&state));
}
```

### See Also {.unnumbered .unlisted}

[`mbtowc()`](#man-mbtowc),
[`wctomb()`](#man-wctomb),
[`mbrtowc()`](#man-mbrtowc),
[`wcrtomb()`](#man-wcrtomb)

[[manbreak]]
## `mbrlen()` {#man-mbrlen}

[i[`mbrlen()` function]i]

Tính số byte của một ký tự multibyte, kiểu restartable

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wchar.h>

size_t mbrlen(const char * restrict s, size_t n, mbstate_t * restrict ps);
```

### Description {.unnumbered .unlisted}

Đây là phiên bản restartable của [`mblen()`](#man-mblen).

Nó xét tối đa `n` byte của chuỗi `s` xem có bao nhiêu byte trong ký
tự này.

Conversion state được lưu trong `ps`.

Hàm này không có chức năng của `mblen()` cho phép bạn truy vấn xem
encoding ký tự này có stateful không và reset state nội bộ.

### Return Value {.unnumbered .unlisted}

Trả về số byte cần cho ký tự multibyte này.

Trả về `(size_t)(-1)` nếu dữ liệu trong `s` không phải ký tự multibyte
hợp lệ.

Trả về `(size_t)(-2)` nếu dữ liệu trong `s` hợp lệ nhưng chưa đủ một
ký tự multibyte hoàn chỉnh.

### Example {.unnumbered .unlisted}

Nếu character set của bạn không hỗ trợ ký hiệu Euro "€", thay bằng
chuỗi escape Unicode `\u20ac`, ở dưới.

``` {.c .numberLines}
#include <locale.h>   // For setlocale()
#include <string.h>   // For memset()
#include <wchar.h>

int main(void)
{
    mbstate_t state;
    int len;

    setlocale(LC_ALL, "");

    memset(&state, 0, sizeof state);  // Đặt về state ban đầu

    len = mbrlen("B", 5, &state);

    wprintf(L"Length of 'B' is %d byte(s)\n", len);

    len = mbrlen("€", 5, &state);

    wprintf(L"Length of '€' is %d byte(s)\n", len);
}
```

Output:

``` {.default}
Length of 'B' is 1 byte(s)
Length of '€' is 3 byte(s)
```

### See Also {.unnumbered .unlisted}

[`mblen()`](#man-mblen)

[[manbreak]]
## `mbrtowc()` {#man-mbrtowc}

[i[`mbrtowc()` function]i]

Chuyển multibyte sang wide character kiểu restartable

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wchar.h>

size_t mbrtowc(wchar_t * restrict pwc, const char * restrict s,
               size_t n, mbstate_t * restrict ps);
```

### Description {.unnumbered .unlisted}

Đây là đối tác restartable của [`mbtowc()`](#man-mbtowc).

Nó chuyển các ký tự đơn từ multibyte sang wide, theo dõi conversion
state trong biến được `ps` trỏ tới.

Tối đa `n` byte được xét để chuyển sang một wide character.

Hai biến thể sau đây giống nhau và làm state mà `ps` trỏ tới được
đặt về conversion state ban đầu:

``` {.c}
mbrtowc(NULL, NULL, 0, &state);
mbrtowc(NULL, "", 1, &state);
```

Ngoài ra, nếu bạn chỉ quan tâm đến độ dài tính bằng byte của ký tự
multibyte, có thể truyền `NULL` cho `pwc` và không có gì được lưu
cho wide character:

``` {.c}
int len = mbrtowc(NULL, "€", 5, &state);
```

Hàm này không có chức năng của `mbtowc()` cho phép bạn truy vấn xem
encoding ký tự này có stateful không và reset state nội bộ.

### Return Value {.unnumbered .unlisted}

Nếu thành công, trả về một số dương tương ứng với số byte trong ký
tự multibyte.

Trả về `0` nếu ký tự được encode là wide NUL character.

Trả về `(size_t)(-1)` nếu dữ liệu trong `s` không phải ký tự multibyte
hợp lệ.

Trả về `(size_t)(-2)` nếu dữ liệu trong `s` hợp lệ nhưng chưa đủ một
ký tự multibyte hoàn chỉnh.

### Example {.unnumbered .unlisted}

Nếu character set của bạn không hỗ trợ ký hiệu Euro "€", thay bằng
chuỗi escape Unicode `\u20ac`, ở dưới.

``` {.c .numberLines}
#include <string.h>  // For memset()
#include <stdlib.h>  // For mbtowc()
#include <locale.h>  // For setlocale()
#include <wchar.h>

int main(void)
{
    mbstate_t state;

    memset(&state, 0, sizeof state);

    setlocale(LC_ALL, "");

    wprintf(L"State dependency: %d\n", mbtowc(NULL, NULL, 0));

    wchar_t wc;
    int bytes;

    bytes = mbrtowc(&wc, "€", 5, &state);

    wprintf(L"L'%lc' takes %d bytes as multibyte char '€'\n", wc, bytes);
}
```

Output trên máy tôi:

``` {.default}
State dependency: 0
L'€' takes 3 bytes as multibyte char '€'
```

### See Also {.unnumbered .unlisted}

[`mbtowc()`](#man-mbtowc),
[`wcrtomb()`](#man-wcrtomb)

[[manbreak]]
## `wcrtomb()` {#man-wcrtomb}

[i[`wcrtomb()` function]i]

Chuyển wide sang multibyte kiểu restartable

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wchar.h>

size_t wcrtomb(char * restrict s, wchar_t wc, mbstate_t * restrict ps);
```

### Description {.unnumbered .unlisted}

Đây là đối tác restartable của [`wctomb()`](#man-wctomb).

Nó chuyển các ký tự đơn từ wide sang multibyte, theo dõi conversion
state trong biến được `ps` trỏ tới.

Mảng đích `s` cần có kích thước tối thiểu `MB_CUR_MAX`^[Đây là một
biến, không phải macro, nên nếu bạn dùng nó để định nghĩa mảng, đó
sẽ là mảng có độ dài biến thiên (variable-length array).] byte---bạn
sẽ không nhận được thứ gì lớn hơn từ hàm này.

Lưu ý các giá trị trong mảng kết quả này sẽ không được NUL-terminate.

Nếu bạn truyền vào một wide NUL character, kết quả sẽ chứa các byte
cần thiết để phục hồi conversion state về state ban đầu, theo sau là
một NUL character, và state `ps` trỏ tới sẽ được reset về state ban
đầu:

``` {.c}
// Reset state
wcrtomb(mb, L'\0', &state)
```

Nếu bạn không quan tâm kết quả (nghĩa là bạn chỉ muốn reset state
hoặc lấy giá trị trả về), có thể làm vậy bằng cách truyền `NULL` cho
`s`:

``` {.c}
wcrtomb(NULL, L'\0', &state);                // Reset state

int byte_count = wctomb(NULL, "X", &state);  // Count bytes in 'X'
```

Hàm này không có chức năng của `wctomb()` cho phép bạn truy vấn xem
encoding ký tự này có stateful không và reset state nội bộ.

### Return Value {.unnumbered .unlisted}

Nếu thành công, trả về số byte cần để encode wide character này
trong locale hiện hành.

Nếu input là wide character không hợp lệ, `errno` sẽ được đặt thành
`EILSEQ` và hàm trả về `(size_t)(-1)`. Khi chuyện này xảy ra, conversion
state coi như bỏ, bạn cứ reset luôn cho rồi.

### Example {.unnumbered .unlisted}

Nếu character set của bạn không hỗ trợ ký hiệu Euro "€", thay bằng
chuỗi escape Unicode `\u20ac`, ở dưới.

``` {.c .numberLines}
#include <string.h>  // For memset()
#include <stdlib.h>  // For mbtowc()
#include <locale.h>  // For setlocale()
#include <wchar.h>

int main(void)
{
    mbstate_t state;

    memset(&state, 0, sizeof state);

    setlocale(LC_ALL, "");

    wprintf(L"State dependency: %d\n", mbtowc(NULL, NULL, 0));

    char mb[10] = {0};
    int bytes = wcrtomb(mb, L'€', &state);

    wprintf(L"L'€' takes %d bytes as multibyte char '%s'\n", bytes, mb);
}
```

### See Also {.unnumbered .unlisted}

[`mbrtowc()`](#man-mbrtowc),
[`wctomb()`](#man-wctomb),
[`errno`](#errno)

[[manbreak]]
## `mbsrtowcs()` {#man-mbsrtowcs}

[i[`mbsrtowcs()` function]i]

Chuyển một chuỗi multibyte sang chuỗi wide character kiểu restartable

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wchar.h>

size_t mbsrtowcs(wchar_t * restrict dst, const char ** restrict src,
                 size_t len, mbstate_t * restrict ps);
```

### Description {.unnumbered .unlisted}

Đây là phiên bản restartable của [`mbstowcs()`](#man-mbstowcs).

Nó chuyển một chuỗi multibyte sang chuỗi wide character.

Kết quả được đặt vào buffer mà `dst` trỏ tới, và con trỏ `src` được
cập nhật để chỉ ra phần chuỗi đã được tiêu thụ (trừ khi `dst` là
`NULL`).

Tối đa `len` wide character sẽ được lưu.

Hàm này cũng nhận con trỏ đến biến `mbstate_t` của riêng nó trong
`ps` để giữ conversion state.

Bạn có thể đặt `dst` thành `NULL` nếu chỉ quan tâm đến giá trị trả
về. Chuyện này có thể hữu ích khi muốn lấy số ký tự trong chuỗi
multibyte.

Trong trường hợp bình thường, chuỗi `src` sẽ được tiêu thụ đến ký tự
NUL, và kết quả sẽ được lưu vào buffer `dst`, bao gồm cả wide NUL
character. Trong trường hợp này, con trỏ được `src` trỏ tới sẽ được
đặt thành `NULL`. Và conversion state sẽ được đặt về conversion state
ban đầu.

Nếu có sự cố vì chuỗi nguồn không phải chuỗi ký tự hợp lệ, conversion
sẽ dừng và con trỏ được `src` trỏ tới sẽ được đặt thành địa chỉ ngay
sau ký tự multibyte được biến đổi thành công cuối cùng.

### Return Value {.unnumbered .unlisted}

Nếu thành công, trả về số ký tự đã được chuyển, không tính NUL
terminator.

Nếu chuỗi multibyte không hợp lệ, hàm trả về `(size_t)(-1)` và `errno`
được đặt thành `EILSEQ`.

### Example {.unnumbered .unlisted}

Ở đây chúng ta sẽ chuyển chuỗi "€5 ± π" sang chuỗi wide character:

``` {.c .numberLines}
#include <locale.h>  // For setlocale()
#include <string.h>  // For memset()
#include <wchar.h>

#define WIDE_STR_SIZE 10

int main(void)
{
    const char *mbs = "€5 ± π";  // That's the exact price range

    wchar_t wcs[WIDE_STR_SIZE];

    setlocale(LC_ALL, "");
    
    mbstate_t state;
    memset(&state, 0, sizeof state);

    size_t count = mbsrtowcs(wcs, &mbs, WIDE_STR_SIZE, &state);

    wprintf(L"Wide string L\"%ls\" is %d characters\n", wcs, count);
}
```

Output:

``` {.default}
Wide string L"€5 ± π" is 6 characters
```

Đây là một ví dụ khác dùng `mbsrtowcs()` để lấy độ dài tính theo ký
tự của một chuỗi multibyte kể cả khi chuỗi đầy ký tự multibyte. Cái
này ngược với `strlen()`, hàm trả về tổng số byte trong chuỗi.

``` {.c .numberLines}
#include <stdio.h>   // For printf()
#include <locale.h>  // For setlocale()

#include <string.h>  // For memset()
#include <stdint.h>  // For SIZE_MAX
#include <wchar.h>

size_t mbstrlen(const char *mbs)
{
    mbstate_t state;

    memset(&state, 0, sizeof state);

    return mbsrtowcs(NULL, &mbs, SIZE_MAX, &state);
}

int main(void)
{
    setlocale(LC_ALL, "");
    
    char *mbs = "€5 ± π";  // That's the exact price range

    printf("\"%s\" is %zu characters...\n", mbs, mbstrlen(mbs)); 
    printf("but it's %zu bytes!\n", strlen(mbs));
}
```

Output trên máy tôi:

``` {.default}
"€5 ± π" is 6 characters...
but it's 10 bytes!
```

### See Also {.unnumbered .unlisted}

[`mbrtowc()`](#man-mbrtowc),
[`mbstowcs()`](#man-mbstowcs),
[`wcsrtombs()`](#man-wcsrtombs),
[`strlen()`](#man-strlen),
[`errno`](#errno)

[[manbreak]]
## `wcsrtombs()` {#man-wcsrtombs}

[i[`wcsrtombs()` function]i]

Chuyển một chuỗi wide character sang chuỗi multibyte kiểu restartable

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wchar.h>

size_t wcsrtombs(char * restrict dst, const wchar_t ** restrict src,
                 size_t len, mbstate_t * restrict ps);
```

### Description {.unnumbered .unlisted}

Nếu bạn có một chuỗi wide character, bạn có thể chuyển nó sang chuỗi
ký tự multibyte trong locale hiện hành bằng hàm này.

Tối đa `len` byte dữ liệu sẽ được lưu vào buffer mà `dst` trỏ tới.
Conversion sẽ dừng ngay sau khi NUL terminator được copy, hoặc `len`
byte đã được copy, hoặc có lỗi nào khác xảy ra.

Nếu `dst` là con trỏ `NULL`, không có kết quả nào được lưu. Bạn có
thể làm vậy nếu chỉ quan tâm đến giá trị trả về (thường là số byte
chuỗi này dùng trong chuỗi multibyte, không tính NUL terminator).

Nếu `dst` không phải `NULL`, con trỏ được `src` trỏ tới sẽ được chỉnh
để cho biết bao nhiêu dữ liệu đã được copy. Nếu ở cuối nó chứa `NULL`,
nghĩa là mọi chuyện ổn. Trong trường hợp này, state `ps` sẽ được đặt
về conversion state ban đầu.

Nếu `len` đã chạm hoặc có lỗi xảy ra, nó sẽ trỏ tới địa chỉ ngay sau
`dst+len`.

### Return Value {.unnumbered .unlisted}

Nếu mọi chuyện ổn, trả về số byte cần cho chuỗi multibyte, không tính
NUL terminator.

Nếu có ký tự nào trong chuỗi không tương ứng ký tự multibyte hợp lệ
trong locale hiện hành, nó trả về `(size_t)(-1)` và `EILSEQ` được lưu
vào `errno`.


### Example {.unnumbered .unlisted}

Ở đây chúng ta sẽ chuyển chuỗi wide "€5 ± π" sang chuỗi ký tự
multibyte:

``` {.c .numberLines}
#include <locale.h>  // For setlocale()
#include <string.h>  // For memset()
#include <wchar.h>

#define MB_STR_SIZE 20

int main(void)
{
    const wchar_t *wcs = L"€5 ± π";  // That's the exact price range

    char mbs[MB_STR_SIZE];

    setlocale(LC_ALL, "");
    
    mbstate_t state;
    memset(&state, 0, sizeof state);

    size_t count = wcsrtombs(mbs, &wcs, MB_STR_SIZE, &state);

    wprintf(L"Multibyte string \"%s\" is %d bytes\n", mbs, count);
}
```

Đây là một ví dụ helper function khác `malloc()` vừa đủ bộ nhớ để giữ
chuỗi đã chuyển, rồi trả về kết quả. (Cái này về sau dĩ nhiên phải
free, để tránh leak bộ nhớ.)

``` {.c .numberLines}
#include <stdlib.h>  // For malloc()
#include <locale.h>  // For setlocale()
#include <string.h>  // For memset()
#include <stdint.h>  // For SIZE_MAX
#include <wchar.h>

char *get_mb_string(const wchar_t *wcs)
{
    setlocale(LC_ALL, "");

    mbstate_t state;
    memset(&state, 0, sizeof state);

    // Cần copy cái này vì wcsrtombs thay đổi nó
    const wchar_t *p = wcs;

    // Tính số byte cần để giữ kết quả
    size_t bytes_needed = wcsrtombs(NULL, &p, SIZE_MAX, &state);

    // Nếu chuyển chưa đủ đàng hoàng, bỏ qua
    if (bytes_needed == (size_t)(-1))
        return NULL;

    // Cấp chỗ cho kết quả
    char *mbs = malloc(bytes_needed + 1);  // +1 cho NUL terminator

    // Đặt conversion state về state ban đầu
    memset(&state, 0, sizeof state);

    // Chuyển và lưu kết quả
    wcsrtombs(mbs, &wcs, bytes_needed + 1, &state);

    // Đảm bảo mọi chuyện ổn
    if (wcs != NULL) {
        free(mbs);
        return NULL;
    }

    // Thành công!
    return mbs;
}

int main(void)
{
    char *mbs = get_mb_string(L"€5 ± π");

    wprintf(L"Multibyte result: \"%s\"\n", mbs);

    free(mbs);
}
```

### See Also {.unnumbered .unlisted}

[`wcrtomb()`](#man-wcrtomb),
[`wcstombs()`](#man-wcstombs),
[`mbsrtowcs()`](#man-mbsrtowcs),
[`errno`](#errno)

<!--
[[manbreak]]
## `example()` {#man-example}

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
