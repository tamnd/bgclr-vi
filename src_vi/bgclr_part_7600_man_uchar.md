<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<uchar.h>` Hàm Tiện Ích Unicode {#uchar}

|Hàm|Mô tả|
|--------|----------------------|
|[`c16rtomb()`](#man-c16rtomb)|Chuyển `char16_t` sang ký tự multibyte|
|[`c32rtomb()`](#man-c16rtomb)|Chuyển `char32_t` sang ký tự multibyte|
|[`mbrtoc16()`](#man-mbrtoc16)|Chuyển ký tự multibyte sang `char16_t`|
|[`mbrtoc32()`](#man-mbrtoc16)|Chuyển ký tự multibyte sang `char32_t`|


Các hàm này là _restartable_, tức là nhiều luồng có thể cùng gọi
chúng an toàn. Chúng xử được chuyện đó nhờ giữ biến conversion
state riêng (kiểu `mbstate_t`) cho mỗi lần gọi.

## Kiểu

Header này định nghĩa bốn kiểu.

[i[`char16_t` type]i]
[i[`char32_t` type]i]
[i[`mbstate_t` type]i]
[i[`size_t` type]i]

|Kiểu|Mô tả|
|------|----------------------|
|`char16_t`|Kiểu giữ ký tự 16-bit|
|`char32_t`|Kiểu giữ ký tự 32-bit|
|`mbstate_t`|Giữ conversion state cho các hàm restartable (cũng định nghĩa trong [`<wchar.h>`](#wchar))|
|`size_t`|Giữ các count (cũng định nghĩa trong [`<stddef.h>`](#stddef))|

String literal cho các kiểu ký tự này là `u` cho `char16_t` và `U`
cho `char32_t`.

``` {.c}
char16_t *str1 = u"Hello, world!";
char32_t *str2 = U"Hello, world!";

char16_t *chr1 = u'A';
char32_t *chr2 = U'B';
```

Lưu ý `char16_t` và `char32_t` _có thể_ chứa Unicode. Hoặc không.
Nếu `__STDC_UTF_16__` hoặc `__STDC_UTF_32__` được định nghĩa bằng
`1`, thì `char16_t` và `char32_t` tương ứng dùng Unicode. Không thì
chúng không dùng và giá trị thật lưu lại phụ thuộc locale. Và nếu
bạn không xài Unicode, tôi xin chia buồn.

## Vấn đề trên OS X

Header này không có trên OS X---buồn nhỉ. Nếu chỉ cần mấy kiểu
thôi, bạn có thể làm:

``` {.c}
#include <stdint.h>

typedef int_least16_t char16_t;
typedef int_least32_t char32_t;
```

Nhưng nếu bạn còn cần cả các hàm nữa thì tự lo.

[[manbreak]]
## `mbrtoc16()` `mbrtoc32()` {#man-mbrtoc16}

[i[`mbrtoc16()` function]i]
[i[`mbrtoc32()` function]i]

Chuyển ký tự multibyte sang `char16_t` hoặc `char32_t` kiểu
restartable

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <uchar.h>

size_t mbrtoc16(char16_t * restrict pc16, const char * restrict s, size_t n,
                mbstate_t * restrict ps);

size_t mbrtoc32(char32_t * restrict pc32, const char * restrict s, size_t n,
                mbstate_t * restrict ps);
```

### Description {.unnumbered .unlisted}

Cho một source string `s` và buffer đích `pc16` (hoặc `pc32` với
`mbrtoc32()`), chuyển ký tự đầu tiên của nguồn thành các `char16_t`
(hoặc `char32_t` với `mbrtoc32()`).

Đại loại bạn có một ký tự thường và muốn nó ở dạng `char16_t` hay
`char32_t`. Dùng mấy hàm này là xong. Lưu ý chỉ một ký tự được
chuyển thôi bất kể `s` có bao nhiêu ký tự.

Khi các hàm scan `s`, bạn không muốn chúng chạy quá khỏi đầu cuối.
Nên bạn truyền `n` là số byte tối đa được kiểm. Hàm sẽ dừng sau khi
xét đủ từng ấy byte hoặc khi có đủ một ký tự multibyte hoàn chỉnh,
tùy cái nào tới trước.

Vì chúng restartable, truyền vào một biến conversion state cho hàm
làm việc.

Và kết quả sẽ được đặt vào `pc16` (hoặc `pc32` với `mbrtoc32()`).

### Return Value {.unnumbered .unlisted}

Khi thành công, hàm trả về số giữa `1` và `n` (bao gồm cả hai đầu)
biểu thị số byte tạo nên ký tự multibyte đó.

Hoặc, cũng tính là thành công, chúng có thể trả `0` nếu ký tự nguồn
là NUL (giá trị `0`).

Khi không hoàn toàn thành công, chúng có thể trả đủ loại code. Tất
cả đều kiểu `size_t`, nhưng là giá trị âm cast sang kiểu đó.

|Giá trị trả về|Mô tả|
|------|----------------------|
|`(size_t)(-1)`|Lỗi encoding---đây không phải chuỗi byte hợp lệ. `errno` được đặt thành `EILSEQ`.|
|`(size_t)(-2)`|`n` byte đã được xét và tạo thành _một phần_ ký tự hợp lệ, nhưng chưa hoàn chỉnh.|
|`(size_t)(-3)`|Một giá trị tiếp theo của ký tự không biểu diễn được bằng một giá trị đơn. Xem dưới.|

Trường hợp `(size_t)(-3)` hơi lạ. Cơ bản là có vài ký tự không biểu
diễn được bằng 16 bit nên không lưu được trong `char16_t`. Các ký
tự này được lưu trong cái (gọi trong thế giới Unicode) là _surrogate
pair_. Tức là có _hai_ giá trị 16-bit đi liền nhau biểu diễn một
giá trị Unicode lớn hơn.

Ví dụ, nếu bạn muốn đọc ký tự Unicode `\U0001fbc5` (là một
[flw[hình người que|Symbols_for_Legacy_Computing]]---tôi không để
trong text vì font của tôi không render nó được) thì nó dài hơn 16
bit. Nhưng mỗi lần gọi `mbrtoc16()` chỉ trả một `char16_t`!

Nên các lần gọi `mbrtoc16()` kế tiếp sẽ giải giá trị _tiếp theo_
trong surrogate pair và trả về `(size_t)(-3)` để báo cho bạn biết
chuyện này đã xảy ra.

Bạn cũng có thể truyền `NULL` cho `pc16` hoặc `pc32`. Làm vậy sẽ
không lưu kết quả, nhưng bạn có thể dùng nếu chỉ quan tâm đến giá
trị trả về của hàm.

Cuối cùng, nếu bạn truyền `NULL` cho `s`, lệnh gọi tương đương với:

``` {.c}
mbrtoc16(NULL, "", 1, ps)
```

Vì ký tự là NUL trong trường hợp đó, chuyện này có tác dụng đặt
state trong `ps` về conversion state ban đầu.

### Example {.unnumbered .unlisted}

Ví dụ use case thường thấy, lấy hai giá trị ký tự đầu tiên từ chuỗi
multibyte `"€Zillion"`:

``` {.c}
#include <uchar.h>
#include <stdio.h>   // cho printf()
#include <locale.h>  // cho setlocale()
#include <string.h>  // cho memset()

int main(void)
{
    char *s = "\u20acZillion";  // 20ac là "€"
    char16_t pc16;
    size_t r;
    mbstate_t mbs;

    setlocale(LC_ALL, "");
    memset(&mbs, 0, sizeof mbs);

    // Kiểm 8 byte kế xem có ký tự nào trong đó
    r = mbrtoc16(&pc16, s, 8, &mbs);

    printf("%zu\n", r);     // In một giá trị >= 1 (3 trong locale UTF-8)
    printf("%#x\n", pc16);  // In 0x20ac cho "€"

    s += r;  // Sang ký tự kế

    // Kiểm 8 byte kế xem có ký tự nào trong đó
    r = mbrtoc16(&pc16, s, 8, &mbs);

    printf("%zu\n", r);     // In 1
    printf("%#x\n", pc16);  // In 0x5a cho "Z"
}
```

Ví dụ với surrogate pair. Trong trường hợp này ta đọc đủ để có toàn
bộ ký tự, nhưng kết quả phải được lưu trong hai `char16_t`, cần hai
lần gọi để lấy cả hai.

``` {.c .numberLines}
#include <uchar.h>
#include <stdio.h>   // cho printf()
#include <string.h>  // cho memset()
#include <locale.h>  // cho setlocale()

int main(void)
{
    char *s = "\U0001fbc5*";   // Glyph hình người que, hơn 16 bit
    char16_t pc16;
    mbstate_t mbs;
    size_t r;

    setlocale(LC_ALL, "");
    memset(&mbs, 0, sizeof mbs);

    r = mbrtoc16(&pc16, s, 8, &mbs);

    printf("%zd\n", r);     // r là 4 byte trong locale UTF-8
    printf("%#x\n", pc16);  // Giá trị đầu của surrogate pair

    s += r;  // Sang ký tự kế

    r = mbrtoc16(&pc16, s, 8, &mbs);

    printf("%zd\n", r);     // r là (size_t)(-3) ở đây để báo...
    printf("%#x\n", pc16);  // ...Giá trị thứ hai của surrogate pair

    // Vì r là -3, nghĩa là ta vẫn đang xử cùng một ký tự,
    // nên ĐỪNG sang ký tự kế lần này
    //s += r;  // Comment đi

    r = mbrtoc16(&pc16, s, 8, &mbs);

    printf("%zd\n", r);     // 1 byte cho "*"
    printf("%#x\n", pc16);  // 0x2a cho "*"
}
```

Output trên hệ của tôi, cho thấy ký tự đầu được biểu diễn bởi cặp
`(0xd83e, 0xdfc5)` và ký tự thứ hai được biểu diễn bởi `0x2a`:

``` {.default}
4
0xd83e
-3
0xdfc5
1
0x2a
```

### See Also {.unnumbered .unlisted}

[`c16rtomb()`](#man-c16rtomb),
[`c32rtomb()`](#man-c16rtomb)

[[manbreak]]
## `c16rtomb()` `c32rtomb()` {#man-c16rtomb}

[i[`c16rtomb()` function]i]
[i[`c32rtomb()` function]i]

Chuyển `char16_t` hoặc `char32_t` sang ký tự multibyte kiểu
restartable

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <uchar.h>

size_t c16rtomb(char * restrict s, char16_t c16, mbstate_t * restrict ps);

size_t c32rtomb(char * restrict s, char32_t c32, mbstate_t * restrict ps);
```

### Description {.unnumbered .unlisted}

Nếu bạn có một ký tự trong `char16_t` hoặc `char32_t`, dùng các hàm
này để chuyển sang ký tự multibyte.

Các hàm này tính ra cần bao nhiêu byte cho ký tự multibyte trong
locale hiện tại và lưu vào buffer được trỏ bởi `s`.

Nhưng buffer đó phải bự cỡ nào? May là có một macro giúp: nó không
cần lớn hơn `MB_CUR_MAX`.

Trường hợp đặc biệt, nếu `s` là `NULL`, nó giống như gọi

``` {.c}
c16rtomb(buf, L'\0', ps);  // hoặc...
c32rtomb(buf, L'\0', ps);
```

trong đó `buf` là buffer do hệ thống quản mà bạn không truy cập
được.

Chuyện này có tác dụng đặt state `ps` về trạng thái ban đầu.

Cuối cùng với surrogate pair (khi ký tự bị chia thành hai
`char16_t`), bạn gọi lần đầu với phần tử đầu của cặp---lúc này hàm
sẽ trả `0`. Rồi gọi lại với phần tử thứ hai của cặp, hàm sẽ trả số
byte và lưu kết quả trong mảng `s`.

### Return Value {.unnumbered .unlisted}

Trả về số byte đã lưu vào mảng được trỏ bởi `s`.

Trả về 0 nếu việc xử lý ký tự hiện tại chưa xong, như trong trường
hợp surrogate pair.

Nếu có lỗi encoding, hàm trả `(size_t)(-1)` và `errno` được đặt
thành `EILSEQ`.

### Example {.unnumbered .unlisted}

``` {.c .numberLines}
#include <uchar.h>
#include <stdlib.h>  // cho MB_CUR_MAX
#include <stdio.h>   // cho printf()
#include <string.h>  // cho memset()
#include <locale.h>  // cho setlocale()

int main(void)
{
    char16_t c16 = 0x20ac;  // Unicode cho ký hiệu Euro
    char dest[MB_CUR_MAX];
    size_t r;
    mbstate_t mbs;

    setlocale(LC_ALL, "");
    memset(&mbs, 0, sizeof mbs);  // Reset conversion state

    // Convert
    r = c16rtomb(dest, c16, &mbs);

    printf("r == %zd\n", r);  // r == 3 trên hệ của tôi

    // Và cái này sẽ in ký hiệu Euro
    printf("dest == \"%s\"\n", dest);
}
```

Output trên hệ của tôi:

``` {.default}
r == 3
dest == "€"
```

Đây là ví dụ phức tạp hơn, chuyển một ký tự giá trị lớn trong chuỗi
multibyte thành surrogate pair (như ví dụ `mbrtoc16()` ở trên) rồi
chuyển ngược lại thành chuỗi multibyte để in.

``` {.c .numberLines}
#include <uchar.h>
#include <stdlib.h>  // cho MB_CUR_MAX
#include <stdio.h>   // cho printf()
#include <string.h>  // cho memset()
#include <locale.h>  // cho setlocale()

int main(void)
{
    char *src = "\U0001fbc5*";   // Glyph hình người que, hơn 16 bit
    char dest[MB_CUR_MAX];
    char16_t surrogate0, surrogate1;
    mbstate_t mbs;
    size_t r;

    setlocale(LC_ALL, "");
    memset(&mbs, 0, sizeof mbs);  // Reset conversion state

    // Lấy ký tự surrogate đầu
    r = mbrtoc16(&surrogate0, src, 8, &mbs);

    // Lấy ký tự surrogate kế
    src += r;  // Sang ký tự kế
    r = mbrtoc16(&surrogate1, src, 8, &mbs);

    printf("Surrogate pair: %#x, %#x\n", surrogate0, surrogate1);

    // Giờ đảo ngược lại
    memset(&mbs, 0, sizeof mbs);  // Reset conversion state

    // Xử ký tự surrogate đầu
    r = c16rtomb(dest, surrogate0, &mbs);

    // r nên là 0 lúc này, vì ký tự chưa được xử xong.
    // Và dest sẽ chưa có gì xài được... chưa đâu!
    printf("r == %zd\n", r);   // r == 0

    // Xử ký tự surrogate thứ hai
    r = c16rtomb(dest, surrogate1, &mbs);

    // Giờ thì ổn rồi. r có số byte, và dest giữ ký tự.
    printf("r == %zd\n", r);  // r == 4 trên hệ của tôi

    // Và cái này sẽ in hình người que, nếu font của bạn hỗ trợ
    printf("dest == \"%s\"\n", dest);
}
```

### See Also {.unnumbered .unlisted}

[`mbrtoc16()`](#man-mbrtoc16),
[`mbrtoc32()`](#man-mbrtoc16)

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
