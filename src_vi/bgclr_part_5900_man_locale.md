<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<locale.h>` Xử Lý Locale {#locale}

[i[`locale.h.` header file]i]

|Hàm|Mô tả|
|--------|----------------------|
|[`setlocale()`](#man-setlocale)|Đặt locale|
|[`localeconv()`](#man-localeconv)|Lấy thông tin về locale hiện tại|

"Locale" là các chi tiết về cách chương trình nên chạy tùy theo vị
trí địa lý của nó trên trái đất.

Ví dụ, ở locale này, một đơn vị tiền tệ có thể in ra là `$123`, còn
ở locale khác là `€123`.

Hoặc một locale dùng encoding ASCII và locale khác dùng UTF-8.

Mặc định, chương trình chạy trong locale "C". Nó có một tập ký tự
cơ bản với encoding single-byte. Nếu bạn thử in ký tự UTF-8 trong
locale C, sẽ không có gì in ra. Bạn phải chuyển sang một locale
thích hợp.

[[manbreak]]
## `setlocale()` {#man-setlocale}

[i[`setlocale()` function]i]

Đặt locale

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <locale.h>

char *setlocale(int category, const char *locale);
```

### Mô tả {.unnumbered .unlisted}

Đặt `locale` cho `category` chỉ định.

Category là một trong các giá trị sau:

|Category|Mô tả|
|-|-|
|`LC_ALL`|Tất cả các category dưới đây|
|`LC_COLLATE`|Ảnh hưởng tới hàm [`strcoll()`](#man-strcoll) và [`strxfrm()`](#man-strxfrm)|
|`LC_CTYPE`|Ảnh hưởng tới các hàm trong [`<ctype.h>`](#ctype)|
|`LC_MONETARY`|Ảnh hưởng tới thông tin tiền tệ mà [`localeconv()`](#man-localeconv) trả về|
|`LC_NUMERIC`|Ảnh hưởng tới dấu thập phân cho I/O định dạng và hàm xử lý chuỗi định dạng, cùng thông tin tiền tệ mà [`localeconv()`](#man-localeconv) trả về|
|`LC_TIME`|Ảnh hưởng tới hàm [`strftime()`](#man-strftime) và [`wcsftime()`](#man-wcsftime)|

Và có ba giá trị portable bạn có thể truyền cho `locale`; mọi chuỗi
khác đều là implementation-defined và không portable.

|Locale|Mô tả|
|-|-|
|`"C"`|Đặt chương trình về locale C|
|`""`|(Chuỗi rỗng) Đặt chương trình về locale native của hệ|
|`NULL`|Không thay đổi gì; chỉ trả về locale hiện tại|
|Khác|Đặt chương trình về một locale implementation-defined|

Lời gọi phổ biến nhất, tôi dám cá, là:

``` {.c}
// Đặt mọi cài đặt locale về locale native của hệ

setlocale(LC_ALL, "");
```

Tiện là `setlocale()` trả về locale vừa được đặt, nên bạn có thể
thấy locale thực tế trên hệ của mình là gì.

### Giá trị trả về {.unnumbered .unlisted}

Nếu thành công, trả về con trỏ tới chuỗi biểu diễn locale hiện tại.
Bạn không được modify chuỗi này, và nó có thể bị thay đổi bởi các
lời gọi `setlocale()` kế tiếp.

Nếu thất bại, trả về `NULL`.

### Ví dụ {.unnumbered .unlisted}

Ở đây ta lấy locale hiện tại. Rồi đặt nó về locale native, và in ra.

``` {.c .numberLines}
#include <stdio.h>
#include <locale.h>

int main(void)
{
    char *loc;

    // Lấy locale hiện tại
    loc = setlocale(LC_ALL, NULL);

    printf("Starting locale: %s\n", loc);

    // Đặt (và lấy) locale về locale native
    loc = setlocale(LC_ALL, "");
    
    printf("Native locale: %s\n", loc);
}
```

Output trên hệ của tôi:

``` {.default}
Starting locale: C
Native locale: en_US.UTF-8
```

Lưu ý locale native của tôi (trên máy Linux) có thể khác với những
gì bạn thấy.

Dù vậy, tôi vẫn có thể đặt nó thẳng tay trên hệ của mình, hoặc đặt
về bất kỳ locale nào đã cài:

``` {.c .numberLines startFrom="13"}
    loc = setlocale(LC_ALL, "en_US.UTF-8");   // Không portable
```

Nhưng lần nữa, hệ của bạn có thể có các locale khác được định nghĩa.

### Xem thêm {.unnumbered .unlisted}

[`localeconv()`](#man-localeconv),
[`strcoll()`](#man-strcoll),
[`strxfrm()`](#man-strxfrm),
[`strftime()`](#man-strftime),
[`wcsftime()`](#man-wcsftime),
[`printf()`](#man-printf),
[`scanf()`](#man-scanf),
[`<ctype.h>`](#ctype)

[[manbreak]]
## `localeconv()` {#man-localeconv}

[i[`localeconv()` function]i]

Lấy thông tin về locale hiện tại

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <locale.h>

struct lconv *localeconv(void);
```

### Mô tả {.unnumbered .unlisted}

Hàm này chỉ trả về một con trỏ tới `struct lconv`, nhưng vẫn là một
tay có sức mạnh đáng kể.

Struct trả về chứa _cả tấn_ thông tin về locale. Dưới đây là các
trường của `struct lconv` và ý nghĩa của chúng.

Trước hết, vài quy ước. Trong tên trường bên dưới, `_p_` nghĩa là
"positive" (dương), `_n_` nghĩa là "negative" (âm), và `int_` nghĩa
là "international" (quốc tế). Dù khá nhiều trong số này có kiểu
`char` hoặc `char*`, hầu hết (hoặc chuỗi mà chúng trỏ tới) thực ra
được đối xử như integer^[Nhớ là `char` chỉ là integer cỡ một byte.].

Trước khi đi tiếp, bạn cần biết `CHAR_MAX` (từ `<limits.h>`) là giá
trị lớn nhất mà một `char` có thể giữ. Và khá nhiều giá trị `char`
bên dưới dùng nó để báo hiệu rằng giá trị không có sẵn trong locale
đó.

|Trường|Mô tả|
|-----|-----------|
|`char *mon_decimal_point`|Ký tự dấu thập phân cho tiền, ví dụ `"."`.|
|`char *mon_thousands_sep`|Ký tự phân cách hàng nghìn cho tiền, ví dụ `","`.|
|`char *mon_grouping`|Mô tả cách nhóm cho tiền (xem bên dưới).|
|`char *positive_sign`|Dấu dương cho tiền, ví dụ `"+"` hoặc `""`.|
|`char *negative_sign`|Dấu âm cho tiền, ví dụ `"-"`.|
|`char *currency_symbol`|Ký hiệu tiền tệ, ví dụ `"$"`.|
|`char frac_digits`|Khi in số tiền, in bao nhiêu chữ số sau dấu thập phân, ví dụ `2`.|
|`char p_cs_precedes`|`1` nếu `currency_symbol` đi trước giá trị cho số tiền không âm, `0` nếu đi sau.|
|`char n_cs_precedes`|`1` nếu `currency_symbol` đi trước giá trị cho số tiền âm, `0` nếu đi sau.|
|`char p_sep_by_space`|Xác định cách phân cách `currency symbol` khỏi giá trị cho số không âm (xem bên dưới).|
|`char n_sep_by_space`|Xác định cách phân cách `currency symbol` khỏi giá trị cho số âm (xem bên dưới).|
|`char p_sign_posn`|Xác định vị trí `positive_sign` cho số không âm.|
|`char p_sign_posn`|Xác định vị trí `positive_sign` cho số âm.|
|`char *int_curr_symbol`|Ký hiệu tiền tệ quốc tế, ví dụ `"USD "`.|
|`char int_frac_digits`|Giá trị quốc tế cho `frac_digits`.|
|`char int_p_cs_precedes`|Giá trị quốc tế cho `p_cs_precedes`.|
|`char int_n_cs_precedes`|Giá trị quốc tế cho `n_cs_precedes`.|
|`char int_p_sep_by_space`|Giá trị quốc tế cho `p_sep_by_space`.|
|`char int_n_sep_by_space`|Giá trị quốc tế cho `n_sep_by_space`.|
|`char int_p_sign_posn`|Giá trị quốc tế cho `p_sign_posn`.|
|`char int_n_sign_posn`|Giá trị quốc tế cho `n_sign_posn`.|

Mặc dù khá nhiều trong số này có kiểu `char`, giá trị chứa trong đó
được truy cập như integer.

Tất cả biến thể `sep_by_space` xử lý khoảng cách quanh ký hiệu tiền
tệ. Giá trị hợp lệ:

|Giá trị|Mô tả|
|:--:|------------|
|`0`|Không có khoảng trắng giữa ký hiệu tiền tệ và giá trị.|
|`1`|Phân cách ký hiệu tiền tệ (và dấu, nếu có) khỏi giá trị bằng khoảng trắng.|
|`2`|Phân cách dấu khỏi ký hiệu tiền tệ (nếu kề nhau) bằng khoảng trắng, ngược lại phân cách dấu khỏi giá trị bằng khoảng trắng.|

Các biến thể `sign_posn` được xác định bởi giá trị sau:

|Giá trị|Mô tả|
|:--:|------------|
|`0`|Đặt ngoặc đơn quanh giá trị và ký hiệu tiền tệ.|
|`1`|Đặt chuỗi dấu ở trước ký hiệu tiền tệ và giá trị.|
|`2`|Đặt chuỗi dấu sau ký hiệu tiền tệ và giá trị.|
|`3`|Đặt chuỗi dấu ngay trước ký hiệu tiền tệ.|
|`4`|Đặt chuỗi dấu ngay sau ký hiệu tiền tệ.|

### Giá trị trả về {.unnumbered .unlisted}

Trả về con trỏ tới struct chứa thông tin locale.

Chương trình không được modify struct này.

Các lời gọi `localeconv()` kế tiếp có thể ghi đè struct này, cũng
như các lời gọi `setlocale()` với `LC_ALL`, `LC_MONETARY`, hoặc
`LC_NUMERIC`.

### Ví dụ {.unnumbered .unlisted}

Đây là chương trình in thông tin locale cho locale native.

``` {.c .numberLines}
#include <stdio.h>
#include <locale.h>
#include <limits.h>  // for CHAR_MAX

void print_grouping(char *mg)
{
    int done = 0;

    while (!done) {
        if (*mg == CHAR_MAX)
            printf("CHAR_MAX ");
        else
            printf("%c ", *mg + '0');
        done = *mg == CHAR_MAX || *mg == 0;
        mg++;
    }
}

int main(void)
{
    setlocale(LC_ALL, "");

    struct lconv *lc = localeconv();

    printf("mon_decimal_point : %s\n", lc->mon_decimal_point);
    printf("mon_thousands_sep : %s\n", lc->mon_thousands_sep);
    printf("mon_grouping      : ");
    print_grouping(lc->mon_grouping);
    printf("\n");
    printf("positive_sign     : %s\n", lc->positive_sign);
    printf("negative_sign     : %s\n", lc->negative_sign);
    printf("currency_symbol   : %s\n", lc->currency_symbol);
    printf("frac_digits       : %c\n", lc->frac_digits);
    printf("p_cs_precedes     : %c\n", lc->p_cs_precedes);
    printf("n_cs_precedes     : %c\n", lc->n_cs_precedes);
    printf("p_sep_by_space    : %c\n", lc->p_sep_by_space);
    printf("n_sep_by_space    : %c\n", lc->n_sep_by_space);
    printf("p_sign_posn       : %c\n", lc->p_sign_posn);
    printf("p_sign_posn       : %c\n", lc->p_sign_posn);
    printf("int_curr_symbol   : %s\n", lc->int_curr_symbol);
    printf("int_frac_digits   : %c\n", lc->int_frac_digits);
    printf("int_p_cs_precedes : %c\n", lc->int_p_cs_precedes);
    printf("int_n_cs_precedes : %c\n", lc->int_n_cs_precedes);
    printf("int_p_sep_by_space: %c\n", lc->int_p_sep_by_space);
    printf("int_n_sep_by_space: %c\n", lc->int_n_sep_by_space);
    printf("int_p_sign_posn   : %c\n", lc->int_p_sign_posn);
    printf("int_n_sign_posn   : %c\n", lc->int_n_sign_posn);
}
```

Output trên hệ của tôi:

``` {.default}
mon_decimal_point : .
mon_thousands_sep : ,
mon_grouping      : 3 3 0 
positive_sign     : 
negative_sign     : -
currency_symbol   : $
frac_digits       : 2
p_cs_precedes     : 1
n_cs_precedes     : 1
p_sep_by_space    : 0
n_sep_by_space    : 0
p_sign_posn       : 1
p_sign_posn       : 1
int_curr_symbol   : USD 
int_frac_digits   : 2
int_p_cs_precedes : 1
int_n_cs_precedes : 1
int_p_sep_by_space: 1
int_n_sep_by_space: 1
int_p_sign_posn   : 1
int_n_sign_posn   : 1
```

### Xem thêm {.unnumbered .unlisted}

[`setlocale()`](#man-setlocale)

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
