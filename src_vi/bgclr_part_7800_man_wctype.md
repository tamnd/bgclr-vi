<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<wctype.h>` Phân Loại và Biến Đổi Wide Character {#wctype}

[i[`wctype.h` header file]i]

|Hàm|Mô tả|
|--------|----------------------|
|[`iswalnum()`](#man-iswalnum)|Kiểm tra wide character có là chữ cái hoặc chữ số.|
|[`iswalpha()`](#man-iswalpha)|Kiểm tra wide character có là chữ cái|
|[`iswblank()`](#man-iswblank)|Kiểm tra đây có phải wide blank character|
|[`iswcntrl()`](#man-iswcntrl)|Kiểm tra đây có phải wide control character.|
|[`iswctype()`](#man-iswctype)|Xác định phân loại wide character|
|[`iswdigit()`](#man-iswdigit)|Kiểm tra wide character có là chữ số|
|[`iswgraph()`](#man-iswgraph)|Kiểm tra wide character có in được mà không phải space|
|[`iswlower()`](#man-iswlower)|Kiểm tra wide character có là chữ thường|
|[`iswprint()`](#man-iswprint)|Kiểm tra wide character có in được|
|[`iswpunct()`](#man-iswpunct)|Kiểm tra wide character có là dấu câu|
|[`iswspace()`](#man-iswspace)|Kiểm tra wide character có là whitespace|
|[`iswupper()`](#man-iswupper)|Kiểm tra wide character có là chữ hoa|
|[`iswxdigit()`](#man-iswxdigit)|Kiểm tra wide character có là chữ số hex|
|[`towctrans()`](#man-towctrans)|Chuyển wide character sang chữ hoa hoặc chữ thường|
|[`towlower()`](#man-towlower)|Chuyển wide character hoa sang chữ thường|
|[`towupper()`](#man-towupper)|Chuyển wide character thường sang chữ hoa|
|[`wctrans()`](#man-wctrans)|Hàm phụ trợ cho `towctrans()`|
|[`wctype()`](#man-wctype)|Hàm phụ trợ cho `iswctype()`|

Cái này giống [`<ctype.h>`](#ctype) nhưng dành cho wide character (ký tự
rộng).

Với nó bạn có thể kiểm tra phân loại ký tự (kiểu "ký tự này có phải
whitespace không?") hoặc làm vài chuyển đổi ký tự cơ bản (kiểu "ép ký
tự này thành chữ thường").

[[manbreak]]
## `iswalnum()` {#man-iswalnum}

[i[`iswalnum()` function]i]

Kiểm tra wide character có là chữ cái hoặc chữ số.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wctype.h>

int iswalnum(wint_t wc);
```

### Description {.unnumbered .unlisted}

Về cơ bản là kiểm tra xem một ký tự có là chữ cái (`A`-`Z` hoặc `a`-`z`)
hoặc chữ số (`0`-`9`). Nhưng vài ký tự khác cũng có thể tính là hợp lệ
tùy theo locale.

Cái này tương đương với việc kiểm tra `iswalpha()` hoặc `iswdigit()` có
true không.

### Return Value {.unnumbered .unlisted}

Trả về true nếu ký tự là chữ cái hoặc chữ số.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>
#include <wctype.h>

int main(void)
{
    //                  testing this char
    //                           v
    wprintf(L"%ls\n", iswalnum(L'a')? L"yes": L"no");  // yes
    wprintf(L"%ls\n", iswalnum(L'B')? L"yes": L"no");  // yes
    wprintf(L"%ls\n", iswalnum(L'5')? L"yes": L"no");  // yes
    wprintf(L"%ls\n", iswalnum(L'?')? L"yes": L"no");  // no
}
```

### See Also {.unnumbered .unlisted}

[`iswalpha()`](#man-iswalpha),
[`iswdigit()`](#man-iswdigit),
[`isalnum()`](#man-isalnum)

[[manbreak]]
## `iswalpha()` {#man-iswalpha}

[i[`iswalpha()` function]i]

Kiểm tra wide character có là chữ cái

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wctype.h>

int iswalpha(wint_t wc);
```

### Description {.unnumbered .unlisted}

Về cơ bản là kiểm tra một ký tự có là chữ cái (`A`-`Z` hoặc `a`-`z`).
Nhưng vài ký tự khác cũng có thể tính là hợp lệ tùy theo locale. (Nếu
ký tự khác được tính, chúng sẽ không phải ký tự điều khiển, chữ số, dấu
câu hay space.)

Cái này giống như kiểm tra `iswupper()` hoặc `iswlower()`.

### Return Value {.unnumbered .unlisted}

Trả về true nếu ký tự là chữ cái.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>
#include <wctype.h>

int main(void)
{
    //                  testing this char
    //                           v
    wprintf(L"%ls\n", iswalpha(L'a')? L"yes": L"no");  // yes
    wprintf(L"%ls\n", iswalpha(L'B')? L"yes": L"no");  // yes
    wprintf(L"%ls\n", iswalpha(L'5')? L"yes": L"no");  // no
    wprintf(L"%ls\n", iswalpha(L'?')? L"yes": L"no");  // no
}
```

### See Also {.unnumbered .unlisted}

[`iswalnum()`](#man-iswalnum),
[`isalpha()`](#man-isalpha)


[[manbreak]]
## `iswblank()` {#man-iswblank}

[i[`iswblank()` function]i]

Kiểm tra đây có phải wide blank character

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wctype.h>

int iswblank(wint_t wc);
```

### Description {.unnumbered .unlisted}

Blank character là whitespace đồng thời được dùng làm dấu ngăn từ trên
cùng một dòng. Ở locale "C", các blank character duy nhất là space và
tab.

Các locale khác có thể định nghĩa blank character khác.

### Return Value {.unnumbered .unlisted}

Trả về true nếu đây là blank character.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>
#include <wctype.h>

int main(void)
{
    //                   testing this char
    //                           v
    wprintf(L"%ls\n", iswblank(L' ')? L"yes": L"no");   // yes
    wprintf(L"%ls\n", iswblank(L'\t')? L"yes": L"no");  // yes
    wprintf(L"%ls\n", iswblank(L'\n')? L"yes": L"no");  // no
    wprintf(L"%ls\n", iswblank(L'a')? L"yes": L"no");   // no
    wprintf(L"%ls\n", iswblank(L'?')? L"yes": L"no");   // no
}
```

### See Also {.unnumbered .unlisted}

[`iswspace()`](#man-iswspace),
[`isblank()`](#man-isblank)

[[manbreak]]
## `iswcntrl()` {#man-iswcntrl}

[i[`iswcntrl()` function]i]

Kiểm tra đây có phải wide control character.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wctype.h>

int iswcntrl(wint_t wc);
```

### Description {.unnumbered .unlisted}

Spec khá trống trải ở chỗ này. Nhưng tôi cứ giả định là nó hoạt động
giống bản không-wide. Vậy thì xem bản kia.

_Control character_ (ký tự điều khiển) là ký tự không in được, phụ
thuộc locale.

Với locale "C", nghĩa là control character nằm trong khoảng 0x00 đến
0x1F (ngay trước ký tự SPACE) và 0x7F (ký tự DEL).

Về cơ bản nếu không phải ký tự ASCII in được (hoặc Unicode nhỏ hơn
128), thì đó là control character trong locale "C".

Chắc là vậy.
 
### Return Value {.unnumbered .unlisted}

Trả về true nếu đây là control character.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>
#include <wctype.h>

int main(void)
{
    //                   testing this char
    //                           v
    wprintf(L"%ls\n", iswcntrl(L'\t')? L"yes": L"no");  // yes (tab)
    wprintf(L"%ls\n", iswcntrl(L'\n')? L"yes": L"no");  // yes (newline)
    wprintf(L"%ls\n", iswcntrl(L'\r')? L"yes": L"no");  // yes (return)
    wprintf(L"%ls\n", iswcntrl(L'\a')? L"yes": L"no");  // yes (bell)
    wprintf(L"%ls\n", iswcntrl(L' ')? L"yes": L"no");   // no
    wprintf(L"%ls\n", iswcntrl(L'a')? L"yes": L"no");   // no
    wprintf(L"%ls\n", iswcntrl(L'?')? L"yes": L"no");   // no
}
```

### See Also {.unnumbered .unlisted}

[`iscntrl()`](#man-iscntrl)

[[manbreak]]
## `iswdigit()` {#man-iswdigit}

[i[`iswdigit()` function]i]

Kiểm tra wide character có là chữ số

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wctype.h>

int iswdigit(wint_t wc);
```

### Description {.unnumbered .unlisted}

Kiểm tra wide character có là chữ số (`0`-`9`).

### Return Value {.unnumbered .unlisted}

Trả về true nếu ký tự là chữ số.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>
#include <wctype.h>

int main(void)
{
    //                   testing this char
    //                           v
    wprintf(L"%ls\n", iswdigit(L'0')? L"yes": L"no");   // yes
    wprintf(L"%ls\n", iswdigit(L'5')? L"yes": L"no");   // yes
    wprintf(L"%ls\n", iswdigit(L'a')? L"yes": L"no");   // no
    wprintf(L"%ls\n", iswdigit(L'B')? L"yes": L"no");   // no
    wprintf(L"%ls\n", iswdigit(L'?')? L"yes": L"no");   // no
}
```

### See Also {.unnumbered .unlisted}

[`iswalnum()`](#man-iswalnum),
[`isdigit()`](#man-isdigit)

[[manbreak]]
## `iswgraph()` {#man-iswgraph}

[i[`iswgraph()` function]i]

Kiểm tra wide character có in được mà không phải space

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wctype.h>

int iswgraph(wint_t wc);
```

### Description {.unnumbered .unlisted}

Trả về true nếu đây là ký tự in được (không phải control) và cũng
không phải whitespace.

Về cơ bản nếu `iswprint()` true và `iswspace()` false.

### Return Value {.unnumbered .unlisted}

Trả về true nếu đây là ký tự in được mà không phải space.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>
#include <wctype.h>

int main(void)
{
    //                   testing this char
    //                           v
    wprintf(L"%ls\n", iswgraph(L'0')? L"yes": L"no");   // yes
    wprintf(L"%ls\n", iswgraph(L'a')? L"yes": L"no");   // yes
    wprintf(L"%ls\n", iswgraph(L'B')? L"yes": L"no");   // yes
    wprintf(L"%ls\n", iswgraph(L'?')? L"yes": L"no");   // yes
    wprintf(L"%ls\n", iswgraph(L' ')? L"yes": L"no");   // no
    wprintf(L"%ls\n", iswgraph(L'\n')? L"yes": L"no");  // no
}
```

### See Also {.unnumbered .unlisted}

[`iswprint()`](#man-iswprint),
[`iswspace()`](#man-iswspace),
[`isgraph()`](#man-isgraph)

[[manbreak]]
## `iswlower()` {#man-iswlower}

[i[`iswlower()` function]i]

Kiểm tra wide character có là chữ thường

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wctype.h>

int iswlower(wint_t wc);
```

### Description {.unnumbered .unlisted}

Kiểm tra một ký tự có là chữ thường, trong khoảng `a`-`z`.

Ở các locale khác, có thể có ký tự chữ thường khác. Trong mọi trường
hợp, để là chữ thường thì những điều sau phải đúng:

``` {.c}
!iswcntrl(c) && !iswdigit(c) && !iswpunct(c) && !iswspace(c)
```

### Return Value {.unnumbered .unlisted}

Trả về true nếu wide character là chữ thường.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>
#include <wctype.h>

int main(void)
{
    //                   testing this char
    //                           v
    wprintf(L"%ls\n", iswlower(L'c')? L"yes": L"no");   // yes
    wprintf(L"%ls\n", iswlower(L'0')? L"yes": L"no");   // no
    wprintf(L"%ls\n", iswlower(L'B')? L"yes": L"no");   // no
    wprintf(L"%ls\n", iswlower(L'?')? L"yes": L"no");   // no
    wprintf(L"%ls\n", iswlower(L' ')? L"yes": L"no");   // no
}
```

### See Also {.unnumbered .unlisted}

[`islower()`](#man-islower),
[`iswupper()`](#man-isupper),
[`iswalpha()`](#man-isalpha),
[`towupper()`](#man-toupper),
[`towlower()`](#man-tolower)

[[manbreak]]
## `iswprint()` {#man-iswprint}

[i[`iswprint()` function]i]

Kiểm tra wide character có in được

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wctype.h>

int iswprint(wint_t wc);
```

### Description {.unnumbered .unlisted}

Kiểm tra wide character có in được, bao gồm cả space (`' '`). Nên giống
như `isgraph()`, chỉ khác là space không bị bỏ rơi ngoài trời lạnh.

### Return Value {.unnumbered .unlisted}

Trả về true nếu wide character in được, bao gồm cả space (`' '`).

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>
#include <wctype.h>

int main(void)
{
    //                   testing this char
    //                           v
    wprintf(L"%ls\n", iswprint(L'c')? L"yes": L"no");   // yes
    wprintf(L"%ls\n", iswprint(L'0')? L"yes": L"no");   // yes
    wprintf(L"%ls\n", iswprint(L' ')? L"yes": L"no");   // yes
    wprintf(L"%ls\n", iswprint(L'\r')? L"yes": L"no");  // no
}
```

### See Also {.unnumbered .unlisted}

[`isprint()`](#man-isprint),
[`iswgraph()`](#man-iswgraph),
[`iswcntrl()`](#man-iswcntrl)

[[manbreak]]
## `iswpunct()` {#man-iswpunct}

[i[`iswpunct()` function]i]

Kiểm tra wide character có là dấu câu

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wctype.h>

int iswpunct(wint_t wc);
```

### Description {.unnumbered .unlisted}

Kiểm tra wide character có là dấu câu.

Ở bất kỳ locale nào, điều này có nghĩa là:

``` {.c}
!isspace(c) && !isalnum(c)
```

### Return Value {.unnumbered .unlisted}

True nếu wide character là dấu câu.

### Example {.unnumbered .unlisted}

Kết quả có thể khác nhau tùy locale.

``` {.c .numberLines}
#include <wchar.h>
#include <wctype.h>

int main(void)
{
    //                   testing this char
    //                           v
    wprintf(L"%ls\n", iswpunct(L',')? L"yes": L"no");   // yes
    wprintf(L"%ls\n", iswpunct(L'!')? L"yes": L"no");   // yes
    wprintf(L"%ls\n", iswpunct(L'c')? L"yes": L"no");   // no
    wprintf(L"%ls\n", iswpunct(L'0')? L"yes": L"no");   // no
    wprintf(L"%ls\n", iswpunct(L' ')? L"yes": L"no");   // no
    wprintf(L"%ls\n", iswpunct(L'\n')? L"yes": L"no");  // no
}
```

### See Also {.unnumbered .unlisted}

[`ispunct()`](#man-ispunct),
[`iswspace()`](#man-iswspace),
[`iswalnum()`](#man-iswalnum)

[[manbreak]]
## `iswspace()` {#man-iswspace}

[i[`iswspace()` function]i]

Kiểm tra wide character có là whitespace

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wctype.h>

int iswspace(wint_t wc);
```

### Description {.unnumbered .unlisted}

Kiểm tra `c` có là ký tự whitespace. Chắc là bao gồm:

* Space (`' '`)
* Formfeed (`'\f'`)
* Newline (`'\n'`)
* Carriage Return (`'\r'`)
* Horizontal Tab (`'\t'`)
* Vertical Tab (`'\v'`)

Các locale khác có thể đặc tả ký tự whitespace khác. `iswalnum()`,
`iswgraph()`, và `iswpunct()` đều false với mọi ký tự whitespace.

### Return Value {.unnumbered .unlisted}

True nếu ký tự là whitespace.

### Example {.unnumbered .unlisted}

Kết quả có thể khác nhau tùy locale.

``` {.c .numberLines}
#include <wchar.h>
#include <wctype.h>

int main(void)
{
    //                   testing this char
    //                           v
    wprintf(L"%ls\n", iswspace(L' ')? L"yes": L"no");   // yes
    wprintf(L"%ls\n", iswspace(L'\n')? L"yes": L"no");  // yes
    wprintf(L"%ls\n", iswspace(L'\t')? L"yes": L"no");  // yes
    wprintf(L"%ls\n", iswspace(L',')? L"yes": L"no");   // no
    wprintf(L"%ls\n", iswspace(L'!')? L"yes": L"no");   // no
    wprintf(L"%ls\n", iswspace(L'c')? L"yes": L"no");   // no
}
```

### See Also {.unnumbered .unlisted}

[`isspace()`](#man-isspace),
[`iswblank()`](#man-iswblank)

[[manbreak]]
## `iswupper()` {#man-iswupper}

[i[`iswupper()` function]i]

Kiểm tra wide character có là chữ hoa

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wctype.h>

int iswupper(wint_t wc);
```

### Description {.unnumbered .unlisted}

Kiểm tra một ký tự có là chữ hoa trong locale hiện tại.

Để là chữ hoa, những điều sau phải đúng:

``` {.c}
!iscntrl(c) && !isdigit(c) && !ispunct(c) && !isspace(c)
```

### Return Value {.unnumbered .unlisted}

Trả về true nếu wide character là chữ hoa.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>
#include <wctype.h>

int main(void)
{
    //                   testing this char
    //                           v
    wprintf(L"%ls\n", iswupper(L'B')? L"yes": L"no");   // yes
    wprintf(L"%ls\n", iswupper(L'c')? L"yes": L"no");   // no
    wprintf(L"%ls\n", iswupper(L'0')? L"yes": L"no");   // no
    wprintf(L"%ls\n", iswupper(L'?')? L"yes": L"no");   // no
    wprintf(L"%ls\n", iswupper(L' ')? L"yes": L"no");   // no
}
```

### See Also {.unnumbered .unlisted}

[`isupper()`](#man-isupper),
[`iswlower()`](#man-iswlower),
[`iswalpha()`](#man-iswalpha),
[`towupper()`](#man-towupper),
[`towlower()`](#man-towlower)

[[manbreak]]
## `iswxdigit()` {#man-iswxdigit}

[i[`iswxdigit()` function]i]

Kiểm tra wide character có là chữ số hex

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wctype.h>

int iswxdigit(wint_t wc);
```

### Description {.unnumbered .unlisted}

Trả về true nếu wide character là chữ số hex. Cụ thể là nếu nó thuộc
`0`-`9`, `a`-`f`, hoặc `A`-`F`.

### Return Value {.unnumbered .unlisted}

True nếu ký tự là chữ số hex.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>
#include <wctype.h>

int main(void)
{
    //                    testing this char
    //                            v
    wprintf(L"%ls\n", iswxdigit(L'B')? L"yes": L"no");   // yes
    wprintf(L"%ls\n", iswxdigit(L'c')? L"yes": L"no");   // yes
    wprintf(L"%ls\n", iswxdigit(L'2')? L"yes": L"no");   // yes
    wprintf(L"%ls\n", iswxdigit(L'G')? L"yes": L"no");   // no
    wprintf(L"%ls\n", iswxdigit(L'?')? L"yes": L"no");   // no
}
```

### See Also {.unnumbered .unlisted}

[`isxdigit()`](#man-isxdigit),
[`iswdigit()`](#man-iswdigit)

[[manbreak]]
## `iswctype()` {#man-iswctype}

[i[`iswctype()` function]i]

Xác định phân loại wide character

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wctype.h>

int iswctype(wint_t wc, wctype_t desc);
```

### Description {.unnumbered .unlisted}

Đây là con dao Thụy Sĩ của các hàm phân loại; nó gom hết mấy hàm kia
vào một.

Bạn gọi nó kiểu này:

``` {.c}
if (iswctype(c, wctype("digit")))  // or "alpha" or "space" or...
```

và nó hành xử y như bạn đã gọi:

``` {.c}
if (iswdigit(c))
```

Khác biệt là bạn có thể đặc tả kiểu matching muốn làm dưới dạng chuỗi
lúc runtime, nghe thì tiện.

`iswctype()` dựa vào giá trị trả về của lời gọi
[`wctype()`](#man-wctype) để làm việc.

Chôm từ spec, đây là các lời gọi `iswctype()` và các hàm tương đương:

|Lời gọi `iswctype()`|Tương đương hard-code|
|-|-|
|`iswctype(c, wctype("alnum"))`|`iswalnum(c)`|
|`iswctype(c, wctype("alpha"))`|`iswalpha(c)`|
|`iswctype(c, wctype("blank"))`|`iswblank(c)`|
|`iswctype(c, wctype("cntrl"))`|`iswcntrl(c)`|
|`iswctype(c, wctype("digit"))`|`iswdigit(c)`|
|`iswctype(c, wctype("graph"))`|`iswgraph(c)`|
|`iswctype(c, wctype("lower"))`|`iswlower(c)`|
|`iswctype(c, wctype("print"))`|`iswprint(c)`|
|`iswctype(c, wctype("punct"))`|`iswpunct(c)`|
|`iswctype(c, wctype("space"))`|`iswspace(c)`|
|`iswctype(c, wctype("upper"))`|`iswupper(c)`|
|`iswctype(c, wctype("xdigit"))`|`iswxdigit(c)`|

Xem [tài liệu `wctype()`](#man-wctype) để biết hàm phụ trợ đó hoạt
động ra sao.

### Return Value {.unnumbered .unlisted}

Trả về true nếu wide character `wc` khớp với lớp ký tự ở `desc`.

### Example {.unnumbered .unlisted}

Kiểm tra một phân loại ký tự nào đó khi không biết phân loại tại thời
điểm compile:

``` {.c .numberLines}
#include <stdio.h>  // for fflush(stdout)
#include <wchar.h>
#include <wctype.h>

int main(void)
{
    wchar_t c;        // Holds a single wide character (to test)
    char desc[128];   // Holds the character class

    // Get the character and classification from the user
    wprintf(L"Enter a character and character class: ");
    fflush(stdout);
    wscanf(L"%lc %s", &c, desc);

    // Compute the type from the given class
    wctype_t t = wctype(desc);

    if (t == 0)
        // If the type is 0, it's an unknown class
        wprintf(L"Unknown character class: \"%s\"\n", desc);
    else {
        // Otherwise, let's test the character and see if its that
        // classification
        if (iswctype(c, t))
            wprintf(L"Yes! '%lc' is %s!\n", c, desc);
        else
            wprintf(L"Nope! '%lc' is not %s.\n", c, desc);
    }
}
```

Output:

``` {.default}
Enter a character and character class: 5 digit
Yes! '5' is digit!

Enter a character and character class: b digit
Nope! 'b' is not digit.

Enter a character and character class: x alnum
Yes! 'x' is alnum!
```

### See Also {.unnumbered .unlisted}

[`wctype()`](#man-wctype)

[[manbreak]]
## `wctype()` {#man-wctype}

[i[`wctype()` function]i]

Hàm phụ trợ cho `iswctype()`

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wctype.h>

wctype_t wctype(const char *property);
```

### Description {.unnumbered .unlisted}

Hàm này trả về một giá trị opaque cho `property` cho trước, dùng để
truyền làm tham số thứ hai cho [`iswctype()`](#man-iswctype).

Giá trị trả về có kiểu `wctype_t`.

Các property hợp lệ trong mọi locale là:

``` {.c}
"alnum"   "alpha"   "blank"   "cntrl"
"digit"   "graph"   "lower"   "print"
"punct"   "space"   "upper"   "xdigit"
```

Các property khác có thể được định nghĩa tùy category `LC_CTYPE` của
locale hiện tại.

Xem [trang tham khảo `iswctype()`](#man-iswctype) để biết chi tiết sử
dụng.

### Return Value {.unnumbered .unlisted}

Trả về giá trị `wctype_t` tương ứng với `property` cho trước.

Nếu truyền giá trị không hợp lệ cho `property`, trả về `0`.

### Example {.unnumbered .unlisted}

Kiểm tra một phân loại ký tự nào đó khi không biết phân loại tại thời
điểm compile:

``` {.c .numberLines}
#include <stdio.h>  // for fflush(stdout)
#include <wchar.h>
#include <wctype.h>

int main(void)
{
    wchar_t c;        // Holds a single wide character (to test)
    char desc[128];   // Holds the character class

    // Get the character and classification from the user
    wprintf(L"Enter a character and character class: ");
    fflush(stdout);
    wscanf(L"%lc %s", &c, desc);

    // Compute the type from the given class
    wctype_t t = wctype(desc);

    if (t == 0)
        // If the type is 0, it's an unknown class
        wprintf(L"Unknown character class: \"%s\"\n", desc);
    else {
        // Otherwise, let's test the character and see if its that
        // classification
        if (iswctype(c, t))
            wprintf(L"Yes! '%lc' is %s!\n", c, desc);
        else
            wprintf(L"Nope! '%lc' is not %s.\n", c, desc);
    }
}
```

Output:

``` {.default}
Enter a character and character class: 5 digit
Yes! '5' is digit!

Enter a character and character class: b digit
Nope! 'b' is not digit.

Enter a character and character class: x alnum
Yes! 'x' is alnum!
```

### See Also {.unnumbered .unlisted}

[`iswctype()`](#man-iswctype)

[[manbreak]]
## `towlower()` {#man-towlower}

[i[`towlower()` function]i]

Chuyển wide character hoa sang chữ thường

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wctype.h>

wint_t towlower(wint_t wc);
```

### Description {.unnumbered .unlisted}

Nếu ký tự là chữ hoa (tức `iswupper(c)` true), hàm này trả về chữ
thường tương ứng.

Các locale khác nhau có thể có chữ hoa và chữ thường khác nhau.

### Return Value {.unnumbered .unlisted}

Nếu chữ cái `wc` là chữ hoa, phiên bản chữ thường của chữ đó sẽ được
trả về theo locale hiện tại.

Nếu chữ cái không phải chữ hoa, `wc` được trả về nguyên không đổi.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>
#include <wctype.h>

int main(void)
{
    //                  changing this char
    //                           v
    wprintf(L"%lc\n", towlower(L'B'));  // b (made lowercase!)
    wprintf(L"%lc\n", towlower(L'e'));  // e (unchanged)
    wprintf(L"%lc\n", towlower(L'!'));  // ! (unchanged)
}
```

### See Also {.unnumbered .unlisted}

[`tolower()`](#man-tolower),
[`towupper()`](#man-towupper),
[`iswlower()`](#man-iswlower),
[`iswupper()`](#man-iswupper)

[[manbreak]]
## `towupper()` {#man-towupper}

[i[`towupper()` function]i]

Chuyển wide character thường sang chữ hoa

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wctype.h>

wint_t towupper(wint_t wc);
```

### Description {.unnumbered .unlisted}

Nếu ký tự là chữ thường (tức `iswlower(c)` true), hàm này trả về chữ
hoa tương ứng.

Các locale khác nhau có thể có chữ hoa và chữ thường khác nhau.

### Return Value {.unnumbered .unlisted}

Nếu chữ cái `wc` là chữ thường, phiên bản chữ hoa của chữ đó sẽ được
trả về theo locale hiện tại.

Nếu chữ cái không phải chữ thường, `wc` được trả về nguyên không đổi.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <wchar.h>
#include <wctype.h>

int main(void)
{
    //                  changing this char
    //                           v
    wprintf(L"%lc\n", towupper(L'B'));  // B (unchanged)
    wprintf(L"%lc\n", towupper(L'e'));  // E (made uppercase!)
    wprintf(L"%lc\n", towupper(L'!'));  // ! (unchanged)
}
```

### See Also {.unnumbered .unlisted}

[`toupper()`](#man-toupper),
[`towlower()`](#man-towlower),
[`iswlower()`](#man-iswlower),
[`iswupper()`](#man-iswupper)

[[manbreak]]
## `towctrans()` {#man-towctrans}

[i[`towctrans()` function]i]

Chuyển wide character sang chữ hoa hoặc chữ thường

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wctype.h>

wint_t towctrans(wint_t wc, wctrans_t desc);
```

### Description {.unnumbered .unlisted}

Đây là con dao Thụy Sĩ của các hàm chuyển đổi ký tự; nó gom hết mấy
hàm kia vào một. Và "mấy hàm kia" ở đây nghĩa là `towupper()` và
`towlower()`, vì đó là tất cả những gì có.

Bạn gọi nó kiểu này:

``` {.c}
if (towctrans(c, wctrans("toupper")))  // or "tolower"
```

và nó hành xử y như bạn đã gọi:

``` {.c}
towupper(c);
```

Khác biệt là bạn có thể đặc tả kiểu chuyển đổi muốn làm dưới dạng
chuỗi lúc runtime, nghe thì tiện.

`towctrans()` dựa vào giá trị trả về của lời gọi
[`wctrans()`](#man-wctrans) để làm việc.

|Lời gọi `towctrans()`|Tương đương hard-code|
|-|-|
|`towctrans(c, wctrans("toupper"))`|`towupper(c)`|
|`towctrans(c, wctrans("tolower"))`|`towlower(c)`|

Xem [tài liệu `wctrans()`](#man-wctrans) để biết hàm phụ trợ đó hoạt
động ra sao.

### Return Value {.unnumbered .unlisted}

Trả về ký tự `wc` như thể đã chạy qua `towupper()` hoặc `towlower()`,
tùy giá trị của `desc`.

Nếu ký tự đã khớp sẵn với phân loại, nó được trả về nguyên xi.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>  // for fflush(stdout)
#include <wchar.h>
#include <wctype.h>

int main(void)
{
    wchar_t c;        // Holds a single wide character (to test)
    char desc[128];   // Holds the conversion type

    // Get the character and conversion type from the user
    wprintf(L"Enter a character and conversion type: ");
    fflush(stdout);
    wscanf(L"%lc %s", &c, desc);

    // Compute the type from the given conversion type
    wctrans_t t = wctrans(desc);

    if (t == 0)
        // If the type is 0, it's an unknown conversion type
        wprintf(L"Unknown conversion: \"%s\"\n", desc);
    else {
        // Otherwise, let's do the conversion
        wint_t result = towctrans(c, t);
        wprintf(L"'%lc' -> %s -> '%lc'\n", c, desc, result);
    }
}
```

Output trên máy tôi:

``` {.default}
Enter a character and conversion type: b toupper
'b' -> toupper -> 'B'

Enter a character and conversion type: B toupper
'B' -> toupper -> 'B'

Enter a character and conversion type: B tolower
'B' -> tolower -> 'b'

Enter a character and conversion type: ! toupper
'!' -> toupper -> '!'
```

### See Also {.unnumbered .unlisted}

[`wctrans()`](#man-wctrans),
[`towupper()`](#man-towupper),
[`towlower()`](#man-towlower)

[[manbreak]]
## `wctrans()` {#man-wctrans}

[i[`wctrans()` function]i]

Hàm phụ trợ cho `towctrans()`

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <wctype.h>

wctrans_t wctrans(const char *property);
```

### Description {.unnumbered .unlisted}

Đây là hàm phụ trợ để sinh tham số thứ hai cho
[`towctrans()`](#man-towctrans).

Bạn có thể truyền vào một trong hai thứ cho `property`:

* `toupper` để `towctrans()` hành xử như `towupper()`
* `tolower` để `towctrans()` hành xử như `towlower()`

### Return Value {.unnumbered .unlisted}

Nếu thành công, trả về giá trị có thể dùng làm tham số `desc` cho
`towctrans()`.

Ngược lại, nếu `property` không nhận ra, trả về `0`.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>  // for fflush(stdout)
#include <wchar.h>
#include <wctype.h>

int main(void)
{
    wchar_t c;        // Holds a single wide character (to test)
    char desc[128];   // Holds the conversion type

    // Get the character and conversion type from the user
    wprintf(L"Enter a character and conversion type: ");
    fflush(stdout);
    wscanf(L"%lc %s", &c, desc);

    // Compute the type from the given conversion type
    wctrans_t t = wctrans(desc);

    if (t == 0)
        // If the type is 0, it's an unknown conversion type
        wprintf(L"Unknown conversion: \"%s\"\n", desc);
    else {
        // Otherwise, let's do the conversion
        wint_t result = towctrans(c, t);
        wprintf(L"'%lc' -> %s -> '%lc'\n", c, desc, result);
    }
}
```

Output trên máy tôi:

``` {.default}
Enter a character and conversion type: b toupper
'b' -> toupper -> 'B'

Enter a character and conversion type: B toupper
'B' -> toupper -> 'B'

Enter a character and conversion type: B tolower
'B' -> tolower -> 'b'

Enter a character and conversion type: ! toupper
'!' -> toupper -> '!'
```

### See Also {.unnumbered .unlisted}

[`towctrans()`](#man-towctrans)

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
