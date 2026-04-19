<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<stdlib.h>` Các Hàm Thư Viện Chuẩn {#stdlib}

[i[`stdlib.h` header file]i]

Một số hàm dưới đây có các biến thể xử lý các kiểu khác nhau: `atoi()`,
`strtod()`, `strtol()`, `abs()`, và `div()`. Ở đây tôi chỉ liệt kê một
cái cho gọn.

|Hàm|Mô tả|
|--------|----------------------|
|[`_Exit()`](#man-exit)|Thoát (exit) chương trình đang chạy và không ngoái đầu nhìn lại|
|[`abort()`](#man-abort)|Kết thúc chương trình đột ngột|
|[`abs()`](#man-abs)|Tính giá trị tuyệt đối của một số nguyên|
|[`aligned_alloc()`](#man-aligned_alloc)|Cấp phát bộ nhớ được căn chỉnh cụ thể|
|[`at_quick_exit()`](#man-atexit)|Đăng ký handler chạy khi chương trình thoát nhanh|
|[`atexit()`](#man-atexit)|Đăng ký handler chạy khi chương trình thoát|
|[`atof()`](#man-atof)|Chuyển chuỗi thành giá trị dấu phẩy động|
|[`atoi()`](#man-atoi)|Chuyển một số nguyên trong chuỗi sang kiểu số nguyên|
|[`bsearch()`](#man-bsearch)|Binary Search (có thể) trên một mảng đối tượng|
|[`calloc()`](#man-malloc)|Cấp phát và điền 0 bộ nhớ để dùng tuỳ ý|
|[`div()`](#man-div)|Tính thương và phần dư của hai số|
|[`exit()`](#man-exit)|Thoát chương trình đang chạy|
|[`free()`](#man-free)|Giải phóng một vùng bộ nhớ|
|[`getenv()`](#man-getenv)|Lấy giá trị của một biến môi trường|
|[`malloc()`](man-malloc)|Cấp phát bộ nhớ để dùng tuỳ ý|
|[`mblen()`](#man-mblen)|Trả về số byte của một ký tự multibyte|
|[`mbstowcs()`](#man-mbstowcs)|Chuyển chuỗi multibyte thành chuỗi ký tự rộng|
|[`mbtowc()`](#man-mbtowc)|Chuyển một ký tự multibyte thành ký tự rộng|
|[`qsort()`](#man-qsort)|Quicksort (có thể) dữ liệu|
|[`quick_exit()`](#man-exit)|Thoát chương trình đang chạy một cách nhanh chóng|
|[`rand()`](#man-rand)|Trả về một số giả ngẫu nhiên|
|[`realloc()`](#man-realloc)|Đổi kích thước một vùng bộ nhớ đã cấp phát trước đó|
|[`srand()`](#man-srand)|Seed bộ sinh số giả ngẫu nhiên có sẵn|
|[`strtod()`](#man-strtod)|Chuyển chuỗi thành số dấu phẩy động|
|[`strtol()`](#man-strtol)|Chuyển chuỗi thành số nguyên|
|[`system()`](#man-system)|Chạy một chương trình bên ngoài|
|[`wcstombs()`](#man-wcstombs)|Chuyển chuỗi ký tự rộng thành chuỗi multibyte|
|[`wctomb()`](#man-wctomb)|Chuyển ký tự rộng thành ký tự multibyte|

Header `<stdlib.h>` gói đủ mọi loại hàm---dám nói luôn---linh tinh nhét
hết vào đây. Bao gồm:

* Chuyển đổi từ số sang chuỗi
* Chuyển đổi từ chuỗi sang số
* Sinh số giả ngẫu nhiên
* Cấp phát bộ nhớ động
* Nhiều cách để thoát chương trình
* Khả năng chạy chương trình bên ngoài
* Binary search (hoặc vài kiểu tìm kiếm nhanh nào đó)
* Quicksort (hoặc vài kiểu sắp xếp nhanh nào đó)
* Các hàm số học với số nguyên
* Chuyển đổi ký tự và chuỗi multibyte và ký tự rộng

Vậy đó... mỗi thứ một tí.

## Kiểu và Macro của `<stdlib.h>`

Vài kiểu và macro mới được giới thiệu, dù một số có thể cũng được định
nghĩa ở chỗ khác:

[i[`size_t` type]i]
[i[`wchar_t` type]i]
[i[`div_t` type]i]
[i[`ldiv_t` type]i]
[i[`lldiv_t` type]i]

|Kiểu|Mô tả|
|-|-|
|`size_t`|Được trả về từ `sizeof` và dùng ở nhiều chỗ khác
|`wchar_t`|Cho các thao tác với ký tự rộng
|`div_t`|Cho hàm `div()`|
|`ldiv_t`|Cho hàm `ldiv()`|
|`lldiv_t`|Cho hàm `lldiv()`|

Và một vài macro:

[i[`NULL` macro]i]
[i[`EXIT_SUCCESS` macro]i]
[i[`EXIT_FAILURE` macro]i]
[i[`RAND_MAX` macro]i]
[i[`MB_CUR_MAX` macro]i]

|Kiểu|Mô tả|
|-|-|
|`NULL`|Người bạn con trỏ tốt của chúng ta|
|`EXIT_SUCCESS`|Mã thoát đẹp khi mọi thứ suôn sẻ|
|`EXIT_FAILURE`|Mã thoát đẹp khi mọi thứ tệ hại|
|`RAND_MAX`|Giá trị lớn nhất mà hàm `rand()` có thể trả về|
|`MB_CUR_MAX`|Số byte tối đa trong một ký tự multibyte tại locale hiện tại|

Vậy đó. Bao nhiêu hàm vui vẻ và hữu ích trong đây. Cùng xem thử nào!


[[manbreak]]
## `atof()` {#man-atof}

[i[`atof()` function]i]

Chuyển chuỗi thành giá trị dấu phẩy động

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdlib.h>

double atof(const char *nptr);
```

### Mô tả {.unnumbered .unlisted}

Ngày xưa cái tên này viết tắt cho [fl["ASCII-To-Floating" hồi
đó|http://man.cat-v.org/unix-1st/3/atof]], nhưng bây giờ không ai dám
dùng kiểu ngôn ngữ thô thiển đó nữa.

Nhưng ý tưởng thì vẫn như cũ: chúng ta sẽ chuyển một chuỗi chứa chữ số
và (tuỳ chọn) một dấu thập phân thành giá trị dấu phẩy động. Khoảng
trắng đầu chuỗi bị bỏ qua, và việc chuyển đổi dừng ở ký tự không hợp lệ
đầu tiên.

Nếu kết quả không vừa trong `double`, hành vi là không xác định.

Nó thường hoạt động như thể bạn đã gọi [`strtod()`](#man-strtod):

``` {.c}
strtod(nptr, NULL)
```

Nên xem trang tham chiếu [đó](#man-strtod) để biết thêm thông tin.

Thực ra `strtod()` xịn hơn và bạn chắc nên dùng nó.

### Giá trị trả về {.unnumbered .unlisted}

Trả về chuỗi đã được chuyển thành `double`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    double x = atof("3.141593");

    printf("%f\n", x);  // 3.141593
}
```

### Xem thêm {.unnumbered .unlisted}

[`atoi()`](#man-atoi),
[`strtod()`](#man-strtod)

[[manbreak]]
## `atoi()`, `atol()`, `atoll()` {#man-atoi}

[i[`atoi()` function]i]
[i[`atol()` function]i]
[i[`atoll()` function]i]

Chuyển một số nguyên trong chuỗi sang kiểu số nguyên

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdlib.h>

int atoi(const char *nptr);

long int atol(const char *nptr);

long long int atoll(const char *nptr);
```

### Mô tả {.unnumbered .unlisted}

Ngày xưa, `atoi()` viết tắt cho
[fl["ASCII-To_Integer"|http://man.cat-v.org/unix-1st/3/atoi]] nhưng
giờ spec không nhắc đến chuyện đó nữa.

Các hàm này nhận một chuỗi có số trong đó và chuyển nó thành số nguyên
của kiểu trả về tương ứng. Khoảng trắng đầu bị bỏ qua. Việc chuyển đổi
dừng ở ký tự không hợp lệ đầu tiên.

Nếu kết quả không vừa trong kiểu trả về, hành vi là không xác định.

Nó thường hoạt động như thể bạn đã gọi họ hàm [`strtol()`](#man-strtol):

``` {.c}
atoi(nptr)                 // về cơ bản giống như...
(int)strtol(nptr, NULL, 10)

atol(nptr)                 // về cơ bản giống như...
strtol(nptr, NULL, 10)

atoll(nptr)                // về cơ bản giống như...
strtoll(nptr, NULL, 10)
```

Lần nữa, các hàm [`strtol()`](#man-strtol) nhìn chung tốt hơn, nên tôi
khuyên dùng chúng thay vì mấy hàm này.

### Giá trị trả về {.unnumbered .unlisted}

Trả về kết quả số nguyên tương ứng với kiểu trả về.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    int x = atoi("3490");

    printf("%d\n", x);  // 3490
}
```

### Xem thêm {.unnumbered .unlisted}

[`atof()`](#man-atof),
[`strtol()`](#man-strtol)

[[manbreak]]
## `strtod()`, `strtof()`, `strtold()` {#man-strtod}

[i[`strtod()` function]i]
[i[`strtof()` function]i]
[i[`strtold()` function]i]

Chuyển chuỗi thành số dấu phẩy động

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdlib.h>

double strtod(const char * restrict nptr, char ** restrict endptr);

float strtof(const char * restrict nptr, char ** restrict endptr);

long double strtold(const char * restrict nptr, char ** restrict endptr);
```

### Mô tả {.unnumbered .unlisted}

Đây là mấy hàm hay ho, chuyển chuỗi thành số dấu phẩy động (thậm chí cả
NaN hoặc Infinity) và lại còn cung cấp chút kiểm tra lỗi nữa.

Đầu tiên, khoảng trắng đầu chuỗi bị bỏ qua.

Rồi các hàm cố gắng chuyển từng ký tự thành kết quả dấu phẩy động. Cuối
cùng, khi gặp ký tự không hợp lệ (hoặc ký tự NUL), chúng đặt `endptr`
trỏ tới ký tự không hợp lệ đó.

Đặt `endptr` thành `NULL` nếu bạn không quan tâm đến vị trí ký tự không
hợp lệ đầu tiên ở đâu.

Nếu bạn không đặt `endptr` thành `NULL`, nó sẽ trỏ tới ký tự NUL nếu
quá trình chuyển đổi không gặp ký tự xấu nào. Nghĩa là:

``` {.c}
if (*endptr == '\0') {
    printf("What a perfectly-formed number!\n");
} else {
    printf("I found badness in your number: \"%s\"\n", endptr);
}
```

Nhưng đoán xem! Bạn cũng có thể chuyển chuỗi thành các giá trị đặc
biệt, như NaN và Infinity!

Nếu `nptr` trỏ tới chuỗi chứa `INF` hoặc `INFINITY` (chữ hoa hay chữ
thường cũng được), giá trị Infinity sẽ được trả về.

Nếu `nptr` trỏ tới chuỗi chứa `NAN`, thì (một NaN yên lặng, không báo
hiệu) sẽ được trả về. Bạn có thể gắn tag cho `NAN` bằng một chuỗi ký tự
từ tập `0`-`9`, `a`-`z`, `A`-`Z`, và `_` bằng cách bao chúng trong dấu
ngoặc:

``` {.c}
NAN(foobar_3490)
```

Việc compiler của bạn làm gì với cái này là do implementation quyết
định, nhưng nó có thể được dùng để chỉ định các kiểu NaN khác nhau.

Bạn cũng có thể chỉ định số ở dạng thập lục phân với số mũ luỹ thừa 2
($2^x$) nếu bắt đầu bằng `0x` (hoặc `0X`). Với phần số mũ, dùng `p`
theo sau là số mũ cơ số 10. (Bạn không thể dùng `e` vì đó là chữ số hex
hợp lệ!)

Ví dụ:

``` {.c}
0xabc.123p15
```

Có giá trị bằng $0xabc.123\times2^{15}$.

Bạn có thể đưa vào `FLT_DECIMAL_DIG`, `DBL_DECIMAL_DIG`, hoặc
`LDBL_DECIMAL_DIG` chữ số và nhận được kết quả làm tròn chính xác cho
kiểu đó.

### Giá trị trả về {.unnumbered .unlisted}

Trả về số đã chuyển đổi. Nếu không có số nào, trả về `0`. `endptr` được
đặt trỏ tới ký tự không hợp lệ đầu tiên, hoặc tới ký tự NUL kết thúc
nếu tất cả ký tự đều được xử lý.

Nếu có tràn số, `HUGE_VAL`, `HUGE_VALF`, hoặc `HUGE_VALL` sẽ được trả
về, mang dấu của input, và `errno` được đặt thành `ERANGE`.

Nếu có underflow, nó trả về số nhỏ nhất gần 0 nhất với dấu của input.
`errno` có thể được đặt thành `ERANGE`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    char *inp = "   123.4567beej";
    char *badchar;

    double val = strtod(inp, &badchar);

    printf("Converted string to %f\n", val);
    printf("Encountered bad characters: %s\n", badchar);

    val = strtod("987.654321beej", NULL);
    printf("Ignoring bad chars for result: %f\n", val);

    val = strtod("11.2233", &badchar);

    if (*badchar == '\0')
        printf("No bad chars: %f\n", val);
    else
        printf("Found bad chars: %f, %s\n", val, badchar);
}
```

Output:

``` {.default}
Converted string to 123.456700
Encountered bad characters: beej
Ignoring bad chars: 987.654321
No bad chars: 11.223300
```

### Xem thêm {.unnumbered .unlisted}

[`atof()`](#man-atof),
[`strtol()`](#man-strtol)

[[manbreak]]
## `strtol()`, `strtoll()`, `strtoul()`, `strtoull()` {#man-strtol}

[i[`strtol()` function]i]
[i[`strtoll()` function]i]
[i[`strtoul()` function]i]
[i[`strtoull()` function]i]

Chuyển chuỗi thành số nguyên

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdlib.h>

long int strtol(const char * restrict nptr,
                char ** restrict endptr, int base);

long long int strtoll(const char * restrict nptr,
                      char ** restrict endptr, int base);

unsigned long int strtoul(const char * restrict nptr,
                          char ** restrict endptr, int base);

unsigned long long int strtoull(const char * restrict nptr,
                                char ** restrict endptr, int base);

```

### Mô tả {.unnumbered .unlisted}

Mấy hàm này chuyển chuỗi thành số nguyên giống `atoi()`, nhưng chúng có
thêm vài tính năng hay ho.

Đáng chú ý nhất, chúng có thể cho bạn biết chỗ nào việc chuyển đổi bắt
đầu sai, tức là ký tự không hợp lệ, nếu có, xuất hiện ở đâu. Khoảng
trắng đầu bị bỏ qua. Dấu `+` hoặc `-` có thể đứng trước số.

Ý tưởng cơ bản là nếu mọi thứ ổn, các hàm này sẽ trả về giá trị số
nguyên chứa trong chuỗi. Và nếu bạn truyền vào `endptr` kiểu `char**`,
nó sẽ đặt biến đó trỏ vào ký tự NUL ở cuối chuỗi.

Nếu mọi thứ không ổn, chúng sẽ đặt `endptr` trỏ vào ký tự đầu tiên có
vấn đề. Nghĩa là, nếu bạn đang chuyển giá trị `103z2!` ở hệ 10, chúng
sẽ đặt `endptr` trỏ vào ký tự `z` vì đó là ký tự không phải số đầu
tiên.

Bạn có thể truyền `NULL` cho `endptr` nếu không muốn làm kiểu kiểm tra
lỗi đó.

Khoan---tôi vừa nói là chúng ta có thể chỉ định cơ số cho việc chuyển
đổi à? Đúng rồi! Đúng, tôi nói vậy. Mà [flw[cơ số|Radix]] thì nằm ngoài
phạm vi tài liệu này rồi, nhưng chắc chắn một số cơ số quen thuộc hơn
là nhị phân (cơ số 2), bát phân (cơ số 8), thập phân (cơ số 10), và
thập lục phân (cơ số 16).

Bạn có thể chỉ định cơ số để chuyển đổi làm tham số thứ ba. Các cơ số
từ 2 đến 36 được hỗ trợ, với các chữ số không phân biệt hoa thường chạy
từ `0` tới `Z`.

Nếu bạn chỉ định cơ số là `0`, hàm sẽ cố gắng tự xác định nó. Mặc định
là cơ số 10 trừ vài trường hợp:

Chuyển nhị phân là mới trong C23!

* Nếu số bắt đầu bằng `0b` hoặc `0B`, nó sẽ là nhị phân (cơ số 2)
* Nếu số bắt đầu bằng `0`, nó sẽ là bát phân (cơ số 8)
* Nếu số bắt đầu bằng `0x` hoặc `0X`, nó sẽ là hex (cơ số 16)

Locale có thể ảnh hưởng đến hành vi của các hàm này.

### Giá trị trả về {.unnumbered .unlisted}

Trả về giá trị đã chuyển đổi.

`endptr`, nếu không phải `NULL`, được đặt trỏ vào ký tự không hợp lệ
đầu tiên, hoặc vào đầu chuỗi nếu không có chuyển đổi nào được thực
hiện, hoặc vào ký tự NUL kết thúc chuỗi nếu tất cả ký tự đều hợp lệ.

Nếu có tràn số, một trong các giá trị sau sẽ được trả về: `LONG_MIN`,
`LONG_MAX`, `LLONG_MIN`, `LLONG_MAX`, `ULONG_MAX`, `ULLONG_MAX`. Và
`errno` được đặt thành `ERANGE`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    // Tất cả output ở hệ thập phân (cơ số 10)

    printf("%ld\n", strtol("123", NULL, 0));      // 123
    printf("%ld\n", strtol("123", NULL, 10));     // 123
    printf("%ld\n", strtol("101010", NULL, 2));   // nhị phân, 42
    printf("%ld\n", strtol("123", NULL, 8));      // bát phân, 83
    printf("%ld\n", strtol("123", NULL, 16));     // hex, 291

    printf("%ld\n", strtol("0123", NULL, 0));     // bát phân, 83
    printf("%ld\n", strtol("0x123", NULL, 0));    // hex, 291

    char *badchar;
    long int x = strtol("   1234beej", &badchar, 0);

    printf("Value is %ld\n", x);               // Value is 1234
    printf("Bad chars at \"%s\"\n", badchar);  // Bad chars at "beej"
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

### Xem thêm {.unnumbered .unlisted}

[`atoi()`](#man-atoi),
[`strtod()`](#man-strtod),
[`setlocale()`](#man-setlocale),
[`strtoimax()`](#man-strtoimax),
[`strtoumax()`](#man-strtoimax)

[[manbreak]]
## `rand()` {#man-rand}

[i[`rand()` function]i]

Trả về một số giả ngẫu nhiên

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdlib.h>

int rand(void);
```

### Mô tả {.unnumbered .unlisted}

Hàm này trả về một số giả ngẫu nhiên trong khoảng `0` tới `RAND_MAX`,
bao gồm cả hai đầu. (`RAND_MAX` sẽ tối thiểu là $32767$.)

Nếu muốn ép nó vào một khoảng nhất định, cách cổ điển là dùng toán tử
modulo `%`, dù [fl[việc này có gây ra
bias|https://stackoverflow.com/questions/10984974/why-do-people-say-there-is-modulo-bias-when-using-a-random-number-generator]]
nếu `RAND_MAX+1` không phải bội số của số bạn chia dư. Xử lý chuyện này
nằm ngoài phạm vi guide này.

Nếu muốn tạo một số dấu phẩy động giữa `0` và `1` bao gồm cả hai, bạn
có thể chia kết quả cho `RAND_MAX`. Hoặc `RAND_MAX+1` nếu không muốn
bao gồm `1`. Nhưng tất nhiên, cũng có [fl[những vấn đề ngoài phạm vi
nữa|https://mumble.net/~campbell/2014/04/28/uniform-random-float]].

Tóm lại, `rand()` là cách tuyệt vời để lấy các số ngẫu nhiên có thể tệ
một cách dễ dàng. Chắc cũng đủ dùng cho trò chơi bạn đang viết.

Spec nói rõ thêm:

> Không có đảm bảo nào về chất lượng của chuỗi ngẫu nhiên được sinh ra
> và một số implementation được biết là sinh ra các chuỗi với các bit
> thấp kém ngẫu nhiên đến mức đáng lo. Ứng dụng có yêu cầu riêng nên
> dùng bộ sinh được biết là đủ tốt cho nhu cầu của chúng.

Hệ thống của bạn chắc có bộ sinh số ngẫu nhiên tốt nếu bạn cần nguồn
mạnh hơn. Người dùng Linux có `getrandom()`, ví dụ vậy, và Windows có
`CryptGenRandom()`.

Với các công việc số ngẫu nhiên đòi hỏi cao hơn, bạn có thể thấy một
thư viện như [fl[GNU Scientific
Library|https://www.gnu.org/software/gsl/doc/html/rng.html]] hữu ích.

Với đa số implementation, các số do `rand()` sinh ra sẽ giống nhau qua
các lần chạy. Để khắc phục, bạn cần bắt đầu nó ở một vị trí khác bằng
cách truyền một _seed_ vào bộ sinh số ngẫu nhiên. Bạn có thể làm việc
này với [`srand()`](#man-srand).

### Giá trị trả về {.unnumbered .unlisted}

Trả về một số ngẫu nhiên trong khoảng `0` tới `RAND_MAX`, bao gồm cả
hai đầu.

### Ví dụ {.unnumbered .unlisted}

Lưu ý rằng tất cả các ví dụ này đều không sinh ra phân phối hoàn toàn
đều. Nhưng đủ tốt cho mắt người không luyện, và thực sự rất phổ biến
trong sử dụng chung khi chất lượng số ngẫu nhiên trung bình là chấp
nhận được.

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    printf("RAND_MAX = %d\n", RAND_MAX);

    printf("0 to 9: %d\n", rand() % 10);

    printf("10 to 44: %d\n", rand() % 35 + 10);
    printf("0 to 0.99999: %f\n", rand() / ((float)RAND_MAX + 1));
    printf("10.5 to 15.7: %f\n", 10.5 + 5.2 * rand() / (float)RAND_MAX);
}
```

Output trên máy tôi:

``` {.default}
RAND_MAX = 2147483647
0 to 9: 3
10 to 44: 21
0 to 0.99999: 0.783099
10.5 to 15.7: 14.651888
```

Ví dụ seed cho RNG bằng thời gian:

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(void)
{
    // time(NULL) gần như chắc chắn trả về số giây kể từ
    // ngày 1 tháng 1 năm 1970:

    srand(time(NULL));

    for (int i = 0; i < 5; i++)
        printf("%d\n", rand());
}
```

### Xem thêm {.unnumbered .unlisted}

[`srand()`](#man-srand)

[[manbreak]]
## `srand()` {#man-srand}

[i[`srand()` function]i]

Seed bộ sinh số giả ngẫu nhiên có sẵn

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdlib.h>

void srand(unsigned int seed);
```

### Mô tả {.unnumbered .unlisted}

Bí mật nho nhỏ bẩn thỉu của việc sinh số giả ngẫu nhiên là chúng hoàn
toàn xác định (deterministic). Không có gì ngẫu nhiên về chúng cả.
Chúng chỉ _trông_ ngẫu nhiên thôi.

Nếu bạn dùng `rand()` và chạy chương trình nhiều lần, bạn có thể thấy
một chuyện _đáng ngờ_: chúng sinh ra cùng các số ngẫu nhiên lặp đi lặp
lại.

Để thay đổi, chúng ta cần cho bộ sinh số giả ngẫu nhiên một "điểm bắt
đầu" mới, gọi là vậy. Chúng ta gọi đó là _seed_. Nó chỉ là một số, nhưng
nó được dùng làm nền tảng cho việc sinh số tiếp theo. Cho seed khác, bạn
sẽ có dãy số ngẫu nhiên khác. Cho seed giống nhau, bạn sẽ có cùng dãy số
ngẫu nhiên tương ứng^[Fan của Minecraft có thể nhớ rằng khi tạo thế
giới mới, họ được cho tuỳ chọn nhập vào một seed số ngẫu nhiên. Giá trị
duy nhất đó được dùng để sinh ra toàn bộ thế giới ngẫu nhiên đó. Và nếu
bạn của bạn bắt đầu thế giới với cùng seed bạn dùng, họ sẽ nhận được
cùng thế giới bạn có.].

Nên nếu bạn gọi `srand(3490)` trước khi bắt đầu sinh số với `rand()`,
bạn sẽ có cùng dãy mỗi lần. `srand(37)` cũng sẽ cho bạn cùng dãy mỗi
lần, nhưng đó sẽ là dãy khác với dãy bạn có từ `srand(3490)`.

Nhưng nếu bạn không thể hardcode seed (vì làm vậy sẽ cho bạn cùng dãy
mỗi lần), thì bạn làm thế nào?

Rất phổ biến là dùng số giây kể từ ngày 1 tháng 1 năm 1970 (ngày này
được biết đến là [flw[_Unix epoch_|Unix_time]]) để seed cho bộ sinh. Cái
này nghe có vẻ khá tuỳ tiện nhưng thực ra đó chính xác là giá trị mà đa
số implementation trả về từ lời gọi thư viện `time(NULL)`^[Spec của C
không quy định chính xác `time(NULL)` sẽ trả về gì, nhưng spec POSIX
thì có! Và gần như ai cũng trả về đúng thứ đó: số giây kể từ epoch.].

Chúng ta sẽ làm vậy trong ví dụ.

Nếu bạn không gọi `srand()`, nó như thể bạn đã gọi `srand(1)`.

### Giá trị trả về {.unnumbered .unlisted}

Không trả về gì!

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>
#include <time.h>    // cho lời gọi time()

int main(void)
{
    srand(time(NULL));

    for (int i = 0; i < 5; i++)
        printf("%d\n", rand() % 32);
}
```

Output:

``` {.default}
4
20
22
14
9
```

Output từ lần chạy tiếp theo:

``` {.default}
19
0
31
31
24
```

### Xem thêm {.unnumbered .unlisted}

[`rand()`](#man-rand),
[`time()`](#man-time)


[[manbreak]]
## `aligned_alloc()` {#man-aligned_alloc}

[i[`aligned_alloc()` function]i]

Cấp phát bộ nhớ được căn chỉnh cụ thể

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdlib.h>

void *aligned_alloc(size_t alignment, size_t size);
```

### Mô tả {.unnumbered .unlisted}

Có lẽ bạn muốn dùng [`malloc()`](#man-malloc) hoặc
[`calloc()`](#man-malloc) thay vì cái này. Nhưng nếu chắc chắn là
không, đọc tiếp!

Bình thường bạn không cần nghĩ về chuyện này, vì `malloc()` và
`realloc()` cả hai đều cung cấp vùng bộ nhớ được
[flw[căn chỉnh|Data_structure_alignment]] phù hợp để dùng với bất kỳ
kiểu dữ liệu nào.

Nhưng nếu bạn cần căn chỉnh cụ thể hơn, bạn có thể chỉ định nó với hàm
này.

Khi xong việc với vùng bộ nhớ, nhớ giải phóng nó bằng một lời gọi
[`free()`](#man-free).

Đừng truyền `0` cho size. Nó chắc không làm gì bạn muốn đâu.

Nếu bạn thắc mắc, tất cả bộ nhớ cấp phát động đều được hệ thống tự động
giải phóng khi chương trình kết thúc. Dù vậy, việc `free()` rõ ràng mọi
thứ bạn đã cấp phát được coi là _Good Form_ (phong cách tốt). Cách này
các lập trình viên khác sẽ không nghĩ bạn cẩu thả.

### Giá trị trả về {.unnumbered .unlisted}

Trả về con trỏ tới vùng bộ nhớ vừa được cấp phát, căn chỉnh như yêu
cầu. Trả về `NULL` nếu có gì đó sai.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int main(void)
{
    int *p = aligned_alloc(256, 10 * sizeof(int));

    // Cho vui, chuyển sang intptr_t và mod với 256
    // để chắc chắn chúng ta thật sự căn chỉnh trên biên 256 byte.
    //
    // Chuyện này chắc là một kiểu hành vi do implementation định nghĩa,
    // nhưng tôi cá là nó hoạt động.

    intptr_t ip = (intptr_t)p;

    printf("%ld\n", ip % 256);   // 0!

    // Giải phóng
    free(p);
}
```

### Xem thêm {.unnumbered .unlisted}

[`malloc()`](#man-malloc),
[`calloc()`](#man-malloc),
[`free()`](#man-free)

[[manbreak]]
## `calloc()`, `malloc()` {#man-malloc}

[i[`calloc()` function]i]
[i[`malloc()` function]i]

Cấp phát bộ nhớ để dùng tuỳ ý

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdlib.h>

void *calloc(size_t nmemb, size_t size);

void *malloc(size_t size);
```

### Mô tả {.unnumbered .unlisted}

Cả hai hàm này đều cấp phát bộ nhớ cho mục đích chung. Vùng nhớ sẽ được
căn chỉnh sao cho có thể dùng lưu trữ bất kỳ kiểu dữ liệu nào.

`malloc()` cấp phát chính xác số byte bộ nhớ được chỉ định trong một
khối liên tục. Vùng bộ nhớ có thể đầy dữ liệu rác. (Bạn có thể xoá nó
bằng [`memset()`](#man-memset), nếu muốn.)

`calloc()` thì khác ở chỗ nó cấp phát chỗ cho `nmemb` đối tượng, mỗi
cái `size` byte. (Bạn có thể làm điều tương tự với `malloc()`, nhưng
bạn phải tự nhân.)

`calloc()` có thêm tính năng: nó xoá toàn bộ bộ nhớ về `0`.

Nên nếu bạn định sao cũng zero out bộ nhớ, `calloc()` có lẽ là lựa chọn
đúng. Nếu không, bạn có thể tránh chi phí đó bằng cách gọi `malloc()`.

Khi xong việc với vùng bộ nhớ, giải phóng nó bằng một lời gọi `free()`.

Đừng truyền `0` cho size. Nó chắc không làm gì bạn muốn đâu.

Nếu bạn thắc mắc, tất cả bộ nhớ cấp phát động đều được hệ thống tự động
giải phóng khi chương trình kết thúc. Dù vậy, việc `free()` rõ ràng mọi
thứ bạn đã cấp phát được coi là _Good Form_ (phong cách tốt). Cách này
các lập trình viên khác sẽ không nghĩ bạn cẩu thả.

### Giá trị trả về {.unnumbered .unlisted}

Cả hai hàm trả về con trỏ tới bộ nhớ mới toanh, sáng bóng vừa được cấp
phát. Hoặc `NULL` nếu có chuyện gì đó xảy ra.

### Ví dụ {.unnumbered .unlisted}

So sánh `malloc()` và `calloc()` khi cấp phát 5 `int`:

``` {.c .numberLines}
#include <stdlib.h>

int main(void)
{
    // Cấp phát chỗ cho 5 int
    int *p = malloc(5 * sizeof(int));

    p[0] = 12;
    p[1] = 30;

    // Cấp phát chỗ cho 5 int
    // (Đồng thời xoá bộ nhớ đó về 0)
    int *q = calloc(5, sizeof(int));

    q[0] = 12;
    q[1] = 30;

    // Xong rồi
    free(p);
    free(q);
}
```

### Xem thêm {.unnumbered .unlisted}

[`aligned_alloc()`](#man-aligned_alloc),
[`free()`](#man-free)

[[manbreak]]
## `free()` {#man-free}

[i[`free()` function]i]

Giải phóng một vùng bộ nhớ

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdlib.h>

void free(void *ptr);
```

### Mô tả {.unnumbered .unlisted}

Bạn biết con trỏ bạn nhận được từ `malloc()`, `calloc()`, hoặc
`aligned_alloc()` chứ? Bạn truyền con trỏ đó cho `free()` để giải phóng
bộ nhớ gắn với nó.

Nếu bạn không làm vậy, bộ nhớ sẽ vẫn được cấp phát MÃI MÃI! (Ờ, cho
đến khi chương trình thoát, dù sao đi nữa.)

Sự thật thú vị: `free(NULL)` không làm gì cả. Bạn có thể gọi nó an
toàn. Đôi khi điều đó tiện.

Đừng `free()` một con trỏ đã được `free()` trước đó. Đừng `free()` một
con trỏ mà bạn không nhận được từ một trong các hàm cấp phát. Như vậy
sẽ là _Bad_^["Thử tưởng tượng mọi sự sống như bạn biết dừng ngay lập
tức và mọi phân tử trong cơ thể bạn nổ tung ở tốc độ ánh sáng." ---Egon
Spengler].

### Giá trị trả về {.unnumbered .unlisted}

Không trả về gì!

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdlib.h>

int main(void)
{
    // Cấp phát chỗ cho 5 int
    int *p = malloc(5 * sizeof(int));

    p[0] = 12;
    p[1] = 30;

    // Giải phóng chỗ đó
    free(p);
}
```

### Xem thêm {.unnumbered .unlisted}

[`malloc()`](#man-malloc),
[`calloc()`](#man-malloc),
[`aligned_alloc()`](#man-aligned_alloc)

[[manbreak]]
## `realloc()` {#man-realloc}

[i[`realloc()` function]i]

Đổi kích thước một vùng bộ nhớ đã cấp phát trước đó

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdlib.h>

void *realloc(void *ptr, size_t size);
```

### Mô tả {.unnumbered .unlisted}

Hàm này lấy một con trỏ tới vùng bộ nhớ đã cấp phát trước đó với
`malloc()` hoặc `calloc()` và đổi kích thước nó thành kích thước mới.

Nếu kích thước mới nhỏ hơn kích thước cũ, phần dữ liệu vượt quá kích
thước mới sẽ bị loại bỏ.

Nếu kích thước mới lớn hơn kích thước cũ, phần lớn hơn mới sẽ không
được khởi tạo. (Bạn có thể xoá nó bằng [`memset()`](#man-memset).)

Lưu ý quan trọng: bộ nhớ có thể bị di chuyển! Nếu bạn đổi kích thước,
hệ thống có thể cần chuyển bộ nhớ sang một khối liên tục lớn hơn. Nếu
chuyện này xảy ra, `realloc()` sẽ sao chép dữ liệu cũ sang vị trí mới
cho bạn.

Vì chuyện này, việc lưu giá trị trả về vào con trỏ của bạn để cập nhật
vị trí mới khi có di chuyển là quan trọng. (Cũng nhớ kiểm tra lỗi để
không ghi đè con trỏ cũ bằng `NULL`, gây rò rỉ bộ nhớ.)

Bạn cũng có thể `relloc()` bộ nhớ cấp phát bởi `aligned_alloc()`, nhưng
nó có thể mất căn chỉnh nếu khối bị di chuyển.

### Giá trị trả về {.unnumbered .unlisted}

Trả về con trỏ tới vùng bộ nhớ đã đổi kích thước. Nó có thể bằng với
`ptr` truyền vào, hoặc có thể ở vị trí khác.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    // Cấp phát chỗ cho 5 int
    int *p = malloc(5 * sizeof(int));

    p[0] = 12;
    p[1] = 30;

    // Realloc cho 10 byte
    int *new_p = realloc(p, 10 * sizeof(int));

    if (new_p == NULL) {
        printf("Error reallocing\n");
    } else {
        p = new_p;  // Ổn rồi; giữ lại thôi
        p[7] = 99;
    }

    // Xong
    free(p);
}
```

### Xem thêm {.unnumbered .unlisted}

[`malloc()`](#man-malloc),
[`calloc()`](#man-malloc)

[[manbreak]]
## `abort()` {#man-abort}

[i[`abort()` function]i]

Kết thúc chương trình đột ngột

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdlib.h>

_Noreturn void abort(void);
```

### Mô tả {.unnumbered .unlisted}

Hàm này kết thúc việc thực thi chương trình _không bình thường_ và ngay
lập tức. Dùng nó trong những tình huống hiếm và bất ngờ.

Các stream đang mở có thể không được flush. File tạm đã tạo có thể
không bị xoá. Exit handler không được gọi.

Mã thoát khác 0 được trả về môi trường.

Trên một số hệ thống, `abort()` có thể [flw[dump core|Core_dump]],
nhưng chuyện này nằm ngoài phạm vi spec.

Bạn có thể gây ra tương đương `abort()` bằng cách gọi `raise(SIGABRT)`,
nhưng tôi không biết vì sao bạn lại làm vậy.

Cách portable duy nhất để dừng một lời gọi `abort()` giữa chừng là dùng
`signal()` để bắt `SIGABRT` rồi `exit()` trong signal handler.

### Giá trị trả về {.unnumbered .unlisted}

Hàm này không bao giờ trả về.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    int bad_thing = 1;

    if (bad_thing) {
        printf("This should never have happened!\n");
        fflush(stdout);  // Đảm bảo thông điệp ra được
        abort();
    }
}
```

Trên máy tôi, output là:

``` {.default}
This should never have happened!
zsh: abort (core dumped)  ./foo
```

### Xem thêm {.unnumbered .unlisted}

[`signal()`](#man-signal)

[[manbreak]]
## `atexit()`, `at_quick_exit()` {#man-atexit}

[i[`atexit()` function]i]
[i[`at_quick_exit()` function]i]

Đăng ký handler chạy khi chương trình thoát

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdlib.h>

int atexit(void (*func)(void));

int at_quick_exit(void (*func)(void));
```

### Mô tả {.unnumbered .unlisted}

Khi chương trình thoát bình thường bằng `exit()` hoặc `return` từ
`main()`, nó sẽ tìm các handler đã đăng ký trước đó để gọi trên đường
ra. Các handler này được đăng ký bằng lời gọi `atexit()`.

Cứ nghĩ nó như là, "Này, lúc chuẩn bị thoát, làm mấy việc thêm này
nhé."

Với lời gọi `quick_exit()`, bạn có thể dùng hàm `at_quick_exit()` để
đăng ký handler cho nó^[`quick_exit()` khác `exit()` ở chỗ file đang mở
có thể không được flush và file tạm có thể không bị xoá.]. Không có sự
chồng chéo trong handler giữa `exit()` và `quick_exit()`, tức là khi
gọi một hàm, không handler nào của hàm kia được kích hoạt.

Bạn có thể đăng ký nhiều handler để chạy---ít nhất 32 handler được hỗ
trợ bởi cả `exit()` và `quick_exit()`.

Tham số `func` trong các hàm nhìn hơi lạ---nó là con trỏ tới một hàm để
gọi. Về cơ bản cứ đặt tên hàm cần gọi vào đó (không có dấu ngoặc đằng
sau). Xem ví dụ bên dưới.

Nếu bạn gọi `atexit()` từ bên trong handler `atexit()` của bạn (hoặc
tương đương trong handler `at_quick_exit()`), thì không rõ liệu nó có
được gọi hay không. Vậy nên hãy đăng ký tất cả trước khi thoát.

Khi thoát, các hàm sẽ được gọi theo thứ tự ngược với thứ tự chúng được
đăng ký.

### Giá trị trả về {.unnumbered .unlisted}

Các hàm này trả về `0` khi thành công, hoặc khác 0 khi thất bại.

### Ví dụ {.unnumbered .unlisted}

`atexit()`:

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>

void exit_handler_1(void)
{
    printf("Exit handler 1 called!\n");
}

void exit_handler_2(void)
{
    printf("Exit handler 2 called!\n");
}

int main(void)
{
    atexit(exit_handler_1);
    atexit(exit_handler_2);

    exit(0);
}
```

Output:

``` {.default}
Exit handler 2 called!
Exit handler 1 called!
```

Và một ví dụ tương tự với `quick_exit()`:

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>

void exit_handler_1(void)
{
    printf("Exit handler 1 called!\n");
}

void exit_handler_2(void)
{
    printf("Exit handler 2 called!\n");
}

int main(void)
{
    at_quick_exit(exit_handler_1);
    at_quick_exit(exit_handler_2);

    quick_exit(0);
}
```

### Xem thêm {.unnumbered .unlisted}

[`exit()`](#man-exit),
[`quick_exit()`](#man-exit)

[[manbreak]]
## `exit()`, `quick_exit()`, `_Exit()` {#man-exit}

[i[`exit()` function]i]
[i[`quick_exit()` function]i]
[i[`_Exit()` function]i]

Thoát chương trình đang chạy

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdlib.h>

_Noreturn void exit(int status);

_Noreturn void quick_exit(int status);

_Noreturn void _Exit(int status);
```

### Mô tả {.unnumbered .unlisted}

Tất cả các hàm này khiến chương trình thoát, với các mức dọn dẹp khác
nhau.

`exit()` dọn dẹp nhiều nhất và là cách thoát bình thường nhất.

`quick_exit()` là cách thứ hai về mức độ dọn dẹp.

`_Exit()` bỏ hết mọi thứ không một chút thủ tục và ragequit tại chỗ.

Gọi `exit()` hoặc `quick_exit()` khiến các handler tương ứng `atexit()`
hoặc `at_quick_exit()` được gọi theo thứ tự ngược với thứ tự chúng được
đăng ký.

`exit()` sẽ flush tất cả stream và xoá tất cả file tạm.

`quick_exit()` hoặc `_Exit()` có thể không làm các thao tác lịch sự đó.

`_Exit()` cũng không gọi các at-exit handler nào cả.

Với tất cả các hàm, mã thoát `status` được trả về môi trường.

Các mã thoát được định nghĩa:

|Status|Mô tả|
|-|-|
|`EXIT_SUCCESS`|Thường trả về khi chuyện tốt đẹp xảy ra|
|`0`|Giống `EXIT_SUCCESS`|
|`EXIT_FAILURE`|Ôi không! Chắc chắn là thất bại!|
|Giá trị dương bất kỳ|Thường chỉ một loại thất bại khác|

Lưu ý OS X: `quick_exit()` không được hỗ trợ.

### Giá trị trả về {.unnumbered .unlisted}

Không hàm nào trong số này từng trả về.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdlib.h>

int main(void)
{
    int contrived_exit_type = 1;

    switch(contrived_exit_type) {
        case 1:
            exit(EXIT_SUCCESS);

        case 2:
            // Không được hỗ trợ trong OS X
            quick_exit(EXIT_SUCCESS);

        case 3:
            _Exit(2);
    }
}
```

### Xem thêm {.unnumbered .unlisted}

[`atexit()`](#man-atexit),
[`at_quick_exit()`](#man-atexit)

[[manbreak]]
## `getenv()` {#man-getenv}

[i[`getenv()` function]i]

Lấy giá trị của một biến môi trường

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdlib.h>

char *getenv(const char *name);
```

### Mô tả {.unnumbered .unlisted}

Environment (môi trường) thường cung cấp các biến được đặt trước khi
chương trình chạy mà bạn có thể truy cập lúc runtime.

Tất nhiên chi tiết cụ thể tuỳ hệ thống, nhưng các biến này là cặp
key/value, và bạn có thể lấy value bằng cách truyền key cho `getenv()`
qua tham số `name`.

Bạn không được phép ghi đè chuỗi trả về.

Cái này khá hạn chế trong standard, nhưng OS của bạn thường cung cấp
chức năng tốt hơn.

### Giá trị trả về {.unnumbered .unlisted}

Trả về con trỏ tới giá trị của biến môi trường, hoặc `NULL` nếu biến
không tồn tại.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    printf("PATH is %s\n", getenv("PATH"));
}
```

Output (bị cắt trong trường hợp của tôi):

``` {.default}
PATH is /usr/bin:/usr/local/bin:/usr/sbin:/home/beej/.cargo/bin [...]
```

<!--
### See Also {.unnumbered .unlisted}

[`example()`](#man-example),
-->

[[manbreak]]
## `system()` {#man-system}

[i[`system()` function]i]

Chạy một chương trình bên ngoài

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdlib.h>

int system(const char *string);
```

### Mô tả {.unnumbered .unlisted}

Hàm này sẽ chạy một chương trình bên ngoài rồi trả về cho bên gọi.

Cách nó chạy chương trình là do hệ thống quy định, nhưng thường là bạn
có thể truyền cho nó cái gì đó giống như bạn gõ trên dòng lệnh, tìm
trong `PATH`, v.v.

Không phải hệ thống nào cũng có khả năng này, nhưng bạn có thể kiểm tra
bằng cách truyền `NULL` cho `system()` và xem nó trả về 0 (không có
command processor) hay khác 0 (có command processor! Yay!)

Nếu bạn đang lấy input từ người dùng và truyền nó cho `system()`, hãy
_cực kỳ_ cẩn thận escape tất cả ký tự đặc biệt của shell (tất cả ký tự
không phải chữ cái/số) bằng dấu backslash để ngăn kẻ xấu chạy cái gì
đó bạn không muốn.

### Giá trị trả về {.unnumbered .unlisted}

Nếu truyền `NULL`, trả về khác 0 nếu có command processor (tức là
`system()` sẽ hoạt động).

Ngược lại trả về giá trị do implementation định nghĩa.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    printf("Here's a directory listing:\n\n");

    system("ls -l");   // Chạy lệnh này và trả về

    printf("\nAll done!\n");
}
```

Output:

``` {.default}
Here's a directory listing:

total 92
drwxr-xr-x 3 beej beej  4096 Oct 14 21:38 bin
drwxr-xr-x 2 beej beej  4096 Dec 20 20:07 examples
-rwxr-xr-x 1 beej beej 16656 Feb 23 21:49 foo
-rw-rw-rw- 1 beej beej   155 Feb 23 21:49 foo.c
-rw-r--r-- 1 beej beej  1350 Jan 27 22:11 Makefile
-rw-r--r-- 1 beej beej  4644 Jan 18 09:12 README.md
drwxr-xr-x 3 beej beej  4096 Feb 23 20:21 src
drwxr-xr-x 6 beej beej  4096 Feb 21 20:24 stage
drwxr-xr-x 2 beej beej  4096 Sep 27 20:54 translations
drwxr-xr-x 2 beej beej  4096 Sep 27 20:54 website

All done!
```

<!--
### See Also {.unnumbered .unlisted}

[`example()`](#man-example),
-->

[[manbreak]]
## `bsearch()` {#man-bsearch}

[i[`bsearch()` function]i]

Binary Search (có thể) trên một mảng đối tượng

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdlib.h>

// Trước C23:

void *bsearch(const void *key, const void *base,
              size_t nmemb, size_t size,
              int (*compar)(const void *, const void *));
// C23:

QVoid *bsearch(const void *key, QVoid *base,
               size_t nmemb, size_t size,
               int (*compar)(const void *, const void *));
```

### Mô tả {.unnumbered .unlisted}

Hàm trông điên rồ này tìm kiếm một giá trị trong mảng.

Nó chắc là binary search hoặc một kiểu tìm kiếm nhanh, hiệu quả nào đó.
Nhưng spec không nói rõ.

Tuy nhiên, mảng phải được sắp xếp! Nên binary search có vẻ khả thi.

* `key` là con trỏ tới giá trị cần tìm.
* `base` là con trỏ tới đầu mảng---mảng phải được sắp xếp!
* `nmemb` là số phần tử trong mảng.
* `size` là `sizeof` của mỗi phần tử trong mảng.
* `compar` là con trỏ tới hàm so sánh key với các giá trị khác.

Hàm so sánh nhận key làm đối số thứ nhất và giá trị cần so sánh làm đối
số thứ hai. Nó nên trả về số âm nếu key nhỏ hơn giá trị, `0` nếu key
bằng giá trị, và số dương nếu key lớn hơn giá trị.

Kiểu này thường được tính bằng cách lấy hiệu giữa key và giá trị cần so
sánh. Nếu phép trừ được hỗ trợ.

Giá trị trả về từ hàm [`strcmp()`](#man-strcmp) có thể dùng để so sánh
chuỗi.

Lần nữa, mảng phải được sắp xếp theo thứ tự của hàm so sánh trước khi
chạy `bsearch()`. May cho bạn, bạn chỉ cần gọi [`qsort()`](#man-qsort)
với cùng hàm so sánh để lo việc này.

Nó là hàm đa dụng---nó sẽ tìm bất kỳ kiểu mảng nào cho bất cứ thứ gì.
Đánh đổi là bạn phải viết hàm so sánh.

Và chuyện đó không đáng sợ như nhìn. Nhảy xuống ví dụ.

### Giá trị trả về {.unnumbered .unlisted}

Hàm trả về con trỏ tới giá trị tìm được, hoặc `NULL` nếu không tìm
thấy.

Mới trong C23: Nếu `base` là `const`, kiểu trả về của hàm `bsearch()`
cũng sẽ là `const`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>

int compar(const void *key, const void *value)
{
    const int *k = key, *v = value;  // Cần int, không phải void

    return *k - *v;
}

int main(void)
{
    int a[9] = {2, 6, 9, 12, 13, 18, 20, 32, 47};

    int *r, key;

    key = 12;  // 12 có trong mảng
    r = bsearch(&key, a, 9, sizeof(int), compar);
    printf("Found %d\n", *r);

    key = 30;  // Không tìm thấy 30
    r = bsearch(&key, a, 9, sizeof(int), compar);
    if (r == NULL)
        printf("Didn't find 30\n");

    // Tìm với key không tên, con trỏ tới 32
    r = bsearch(&(int){32}, a, 9, sizeof(int), compar);
    printf("Found %d\n", *r);  // Tìm thấy
}
```

Output:

``` {.default}
Found 12
Didn't find 30
Found 32
```

### Xem thêm {.unnumbered .unlisted}

[`strcmp()`](#man-strcmp),
[`qsort()`](#man-qsort)


[[manbreak]]
## `qsort()` {#man-qsort}

[i[`qsort()` function]i]

Quicksort (có thể) dữ liệu

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdlib.h>

void qsort(void *base, size_t nmemb, size_t size,
           int (*compar)(const void *, const void *));
```

### Mô tả {.unnumbered .unlisted}

Hàm này sẽ quicksort (hoặc một kiểu sắp xếp khác, chắc cũng nhanh) một
mảng dữ liệu tại chỗ^["Tại chỗ" (in-place) nghĩa là mảng gốc sẽ chứa
kết quả; không có mảng mới nào được cấp phát.].

Giống `bsearch()`, nó không biết gì về dữ liệu. Bất kỳ dữ liệu nào có
thể định nghĩa thứ tự tương đối đều có thể sắp xếp, dù là `int`,
`struct`, hay bất kỳ thứ gì khác.

Cũng giống `bsearch()`, bạn phải cho một hàm so sánh để thực hiện việc
so sánh thực sự.

* `base` là con trỏ tới đầu mảng cần sắp xếp.
* `nmemb` là số phần tử trong mảng.
* `size` là `sizeof` của mỗi phần tử.
* `compar` là con trỏ tới hàm so sánh.

Hàm so sánh nhận con trỏ tới hai phần tử của mảng làm đối số và so sánh
chúng. Nó nên trả về số âm nếu đối số thứ nhất nhỏ hơn đối số thứ hai,
`0` nếu chúng bằng nhau, và số dương nếu đối số thứ nhất lớn hơn đối
số thứ hai.

Kiểu này thường được tính bằng cách lấy hiệu giữa đối số thứ nhất và
đối số thứ hai. Nếu phép trừ được hỗ trợ.

Giá trị trả về từ hàm [`strcmp()`](#man-strcmp) có thể cung cấp thứ tự
sắp xếp cho chuỗi.

Nếu bạn phải sắp xếp một `struct`, chỉ việc trừ theo trường cụ thể mà
bạn muốn sắp xếp theo.

Hàm so sánh này có thể được dùng bởi [`bsearch()`](#man-bsearch) để tìm
kiếm sau khi danh sách đã được sắp xếp.

Để đảo ngược thứ tự sắp xếp, trừ đối số thứ hai cho đối số thứ nhất,
tức là đảo dấu giá trị trả về từ `compar()`.


### Giá trị trả về {.unnumbered .unlisted}

Không trả về gì!

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>

int compar(const void *elem0, const void *elem1)
{
    const int *x = elem0, *y = elem1;  // Cần int, không phải void

    if (*x > *y) return 1;
    if (*x < *y) return -1;
    return 0;
}

int main(void)
{
    int a[9] = {14, 2, 3, 17, 10, 8, 6, 1, 13};

    // Sắp xếp danh sách

    qsort(a, 9, sizeof(int), compar);

    // In danh sách đã sắp xếp

    for (int i = 0; i < 9; i++)
        printf("%d ", a[i]);

    putchar('\n');

    // Dùng cùng hàm compar() để binary search
    // cho 17 (truyền vào như một đối tượng không tên)

    int *r = bsearch(&(int){17}, a, 9, sizeof(int), compar);
    printf("Found %d!\n", *r);
}
```

Output:

``` {.default}
1 2 3 6 8 10 13 14 17
Found 17!
```

### Xem thêm {.unnumbered .unlisted}

[`strcmp()`](#man-strcmp),
[`bsearch()`](#man-bsearch)

[[manbreak]]
## `abs()`, `labs()`, `llabs()` {#man-abs}

[i[`abs()` function]i]
[i[`labs()` function]i]
[i[`llabs()` function]i]

Tính giá trị tuyệt đối của một số nguyên

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdlib.h>

int abs(int j);

long int labs(long int j);

long long int llabs(long long int j);
```

### Mô tả {.unnumbered .unlisted}

Tính giá trị tuyệt đối của `j`. Nếu bạn không nhớ, đó là khoảng cách từ
`j` đến 0.

Nói cách khác, nếu `j` âm, trả về nó dưới dạng dương. Nếu nó dương, trả
về nó dưới dạng dương. Lúc nào cũng dương. Tận hưởng cuộc sống đi.

Nếu kết quả không thể biểu diễn được, hành vi là không xác định. Đặc
biệt để ý nửa trên của các số unsigned.

### Giá trị trả về {.unnumbered .unlisted}

Trả về giá trị tuyệt đối của `j`, $|j|$.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    printf("|-2| = %d\n", abs(-2));
    printf("|4|  = %d\n", abs(4));
}
```

Output:

``` {.default}
|-2| = 2
|4|  = 4
```

### Xem thêm {.unnumbered .unlisted}

[`fabs()`](#man-fabs)


[[manbreak]]
## `div()`, `ldiv()`, `lldiv()` {#man-div}

[i[`div()` function]i]
[i[`ldiv()` function]i]
[i[`lldiv()` function]i]

Tính thương và phần dư của hai số
 
### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdlib.h>

div_t div(int numer, int denom);

ldiv_t ldiv(long int numer, long int denom);

lldiv_t lldiv(long long int numer, long long int denom);
```

### Mô tả {.unnumbered .unlisted}

Các hàm này cho bạn thương và phần dư của một cặp số trong một lần.

Chúng trả về một cấu trúc có hai trường, `quot` và `rem`, kiểu của
chúng khớp với kiểu của `numer` và `denom`. Để ý mỗi hàm trả về một
biến thể khác của `div_t`.

Các biến thể `div_t` này tương đương với:

``` {.c}
typedef struct {
    int quot, rem;
} div_t;

typedef struct {
    long int quot, rem;
} ldiv_t;

typedef struct {
    long long int quot, rem;
} lldiv_t;
```

Tại sao lại dùng mấy cái này thay vì toán tử chia?

C99 Rationale nói:

> Vì C89 có ngữ nghĩa do implementation định nghĩa cho phép chia số
> nguyên có dấu khi có toán hạng âm, `div` và `ldiv`, và `lldiv` trong
> C99, được phát minh để cung cấp ngữ nghĩa được xác định rõ cho chia
> và phép dư số nguyên có dấu. Ngữ nghĩa được lấy giống như trong
> Fortran. Vì các hàm này trả về cả thương và phần dư, chúng cũng đóng
> vai trò là cách tiện lợi để mô hình hiệu quả phần cứng bên dưới tính
> cả hai kết quả như một phần của cùng thao tác. Bảng 7.2 tóm tắt ngữ
> nghĩa của các hàm này.

Thật vậy, K&R2 (C89) nói:

> Hướng truncation cho `/` và dấu của kết quả cho `%` phụ thuộc máy với
> toán hạng âm [...]

Rationale sau đó tiếp tục nói rõ dấu của thương và phần dư sẽ là gì
cho trước dấu của tử và mẫu khi dùng các hàm `div()`:

|`numer`|`denom`|`quot`|`rem`|
|:-:|:-:|:-:|:-:|
|$+$|$+$|$+$|$+$|
|$-$|$+$|$-$|$-$|
|$+$|$-$|$-$|$+$|
|$-$|$-$|$+$|$-$|


### Giá trị trả về {.unnumbered .unlisted}

Một cấu trúc `div_t`, `ldiv_t`, hoặc `lldiv_t` với các trường `quot` và
`rem` chứa thương và phần dư của phép toán `numer/denom`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    div_t d = div(64, -7);

    printf("64 / -7 = %d\n", d.quot);
    printf("64 %% -7 = %d\n", d.rem);
}
```

Output:

``` {.default}
64 / -7 = -9
64 % -7 = 1
```

### Xem thêm {.unnumbered .unlisted}

[`fmod()`](#man-fmod),
[`remainder()`](#man-remainder)


[[manbreak]]
## `mblen()` {#man-mblen}

[i[`mblen()` function]i]

Trả về số byte của một ký tự multibyte

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdlib.h>

int mblen(const char *s, size_t n);
```

### Mô tả {.unnumbered .unlisted}

Nếu bạn có một ký tự multibyte trong một chuỗi, hàm này sẽ cho bạn biết
nó dài bao nhiêu byte.

`n` là số byte tối đa `mblen()` sẽ quét trước khi bỏ cuộc.

Nếu `s` là con trỏ `NULL`, kiểm tra xem encoding này có phụ thuộc trạng
thái không, như đã nói ở phần giá trị trả về bên dưới. Nó cũng reset
trạng thái, nếu có.

Hành vi của hàm này chịu ảnh hưởng bởi locale.

### Giá trị trả về {.unnumbered .unlisted}

Trả về số byte được dùng để mã hoá ký tự này, hoặc `-1` nếu không có ký
tự multibyte hợp lệ trong `n` byte tiếp theo.

Hoặc, nếu `s` là NULL, trả về true nếu encoding này có phụ thuộc trạng
thái.

### Ví dụ {.unnumbered .unlisted}

Cho ví dụ, tôi dùng bộ ký tự mở rộng để đặt ký tự Unicode vào source.
Nếu cái này không hoạt động với bạn, dùng escape `\uXXXX`.

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>
#include <locale.h>

int main(void)
{
    setlocale(LC_ALL, "");

    printf("State dependency: %d\n", mblen(NULL, 0));
    printf("Bytes for €: %d\n", mblen("€", 5));
    printf("Bytes for \u00e9: %d\n", mblen("\u00e9", 5));  // \u00e9 == é
    printf("Bytes for &: %d\n", mblen("&", 5));
}
```

Output (trong trường hợp của tôi, encoding là UTF-8, nhưng của bạn có
thể khác):

``` {.default}
State dependency: 0
Bytes for €: 3
Bytes for é: 2
Bytes for &: 1
```

### Xem thêm {.unnumbered .unlisted}

[`mbtowc()`](#man-mbtowc),
[`mbstowcs())`](#man-mbstowcs),
[`setlocale()`](#man-setlocale)


[[manbreak]]
## `mbtowc()` {#man-mbtowc}

[i[`mbtowc()` function]i]

Chuyển một ký tự multibyte thành ký tự rộng

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdlib.h>

int mbtowc(wchar_t * restrict pwc, const char * restrict s, size_t n);
```

### Mô tả {.unnumbered .unlisted}

Nếu bạn có một ký tự multibyte, hàm này sẽ chuyển nó thành ký tự rộng
và lưu tại địa chỉ do `pwc` trỏ tới. Tối đa `n` byte của ký tự multibyte
sẽ được phân tích.

Nếu `pwc` là `NULL`, ký tự kết quả sẽ không được lưu. (Hữu ích khi chỉ
muốn lấy giá trị trả về.)

Nếu `s` là con trỏ `NULL`, kiểm tra xem encoding này có phụ thuộc trạng
thái không, như đã nói ở phần giá trị trả về bên dưới. Nó cũng reset
trạng thái, nếu có.

Hành vi của hàm này chịu ảnh hưởng bởi locale.

### Giá trị trả về {.unnumbered .unlisted}

Trả về số byte được dùng trong ký tự rộng đã mã hoá, hoặc `-1` nếu
không có ký tự multibyte hợp lệ trong `n` byte tiếp theo.

Trả về `0` nếu `s` trỏ tới ký tự NUL.

Hoặc, nếu `s` là NULL, trả về true nếu encoding này có phụ thuộc trạng
thái.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>
#include <locale.h>
#include <wchar.h>

int main(void)
{
    setlocale(LC_ALL, "");

    printf("State dependency: %d\n", mbtowc(NULL, NULL, 0));

    wchar_t wc;
    int bytes;

    bytes = mbtowc(&wc, "€", 5);

    printf("L'%lc' takes %d bytes as multibyte char '€'\n", wc, bytes);
}
```

Output trên máy tôi:

``` {.default}
State dependency: 0
L'€' takes 3 bytes as multibyte char '€'
```

### Xem thêm {.unnumbered .unlisted}

[`mblen()`](#man-mblen),
[`mbstowcs()`](#man-mbstowcs),
[`wcstombs()`](#man-wcstombs),
[`setlocale()`](#man-setlocale)

[[manbreak]]
## `wctomb()` {#man-wctomb}

[i[`wctomb()` function]i]

Chuyển ký tự rộng thành ký tự multibyte

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdlib.h>

int wctomb(char *s, wchar_t wc);
```

### Mô tả {.unnumbered .unlisted}

Nếu bạn đang nắm trong tay một ký tự rộng, bạn có thể dùng cái này để
biến nó thành multibyte.

Ký tự rộng `wc` được lưu dưới dạng ký tự multibyte trong chuỗi được trỏ
bởi `s`. Buffer mà `s` trỏ tới nên dài ít nhất `MB_CUR_MAX` ký tự. Lưu
ý `MB_CUR_MAX` thay đổi theo locale.

Nếu `wc` là ký tự rộng NUL, một NUL sẽ được lưu vào `s` sau các byte
cần thiết để reset shift state (nếu có).

Nếu `s` là con trỏ `NULL`, kiểm tra xem encoding này có phụ thuộc trạng
thái không, như đã nói ở phần giá trị trả về bên dưới. Nó cũng reset
trạng thái, nếu có.

Hành vi của hàm này chịu ảnh hưởng bởi locale.

### Giá trị trả về {.unnumbered .unlisted}

Trả về số byte được dùng trong ký tự multibyte đã mã hoá, hoặc `-1` nếu
`wc` không tương ứng với ký tự multibyte hợp lệ nào.

Hoặc, nếu `s` là NULL, trả về true nếu encoding này có phụ thuộc trạng
thái.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>
#include <locale.h>
#include <wchar.h>

int main(void)
{
    setlocale(LC_ALL, "");

    printf("State dependency: %d\n", mbtowc(NULL, NULL, 0));

    int bytes;
    char mb[MB_CUR_MAX + 1];

    bytes = wctomb(mb, L'€');
    mb[bytes] = '\0';

    printf("L'€' takes %d bytes as multibyte char '%s'\n", bytes, mb);
}
```

Output trên máy tôi:

``` {.default}
State dependency: 0
L'€' takes 3 bytes as multibyte char '€'
```

### Xem thêm {.unnumbered .unlisted}

[`mbtowc()`](#man-mbtowc),
[`mbstowcs()`](#man-mbstowcs),
[`wcstombs()`](#man-wcstombs),
[`setlocale()`](#man-setlocale)


[[manbreak]]
## `mbstowcs()` {#man-mbstowcs}

[i[`mbstowcs()` function]i]

Chuyển chuỗi multibyte thành chuỗi ký tự rộng

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdlib.h>

size_t mbstowcs(wchar_t * restrict pwcs, const char * restrict s, size_t n);
```

### Mô tả {.unnumbered .unlisted}

Nếu bạn có một chuỗi multibyte (hay chuỗi thường), bạn có thể chuyển
nó thành chuỗi ký tự rộng với hàm này.

Tối đa `n` ký tự rộng được ghi vào đích `pwcs` từ nguồn `s`.

Ký tự NUL được lưu dưới dạng ký tự NUL rộng.

Phần mở rộng POSIX không portable: nếu bạn đang dùng một thư viện tuân
thủ POSIX, hàm này cho phép `pwcs` là `NULL` nếu bạn chỉ quan tâm tới
giá trị trả về. Đáng chú ý nhất là, việc này sẽ cho bạn số ký tự trong
chuỗi multibyte (trái ngược với [`strlen()`](#man-strlen) đếm số byte.)

### Giá trị trả về {.unnumbered .unlisted}

Trả về số ký tự rộng được ghi vào đích `pwcs`.

Nếu tìm thấy ký tự multibyte không hợp lệ, trả về `(size_t)(-1)`.

Nếu giá trị trả về là `n`, nghĩa là kết quả _không_ được kết thúc bằng
NUL.

### Ví dụ {.unnumbered .unlisted}

Source này dùng bộ ký tự mở rộng. Nếu compiler của bạn không hỗ trợ,
bạn sẽ phải thay chúng bằng escape `\u`.

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>
#include <locale.h>
#include <string.h>

int main(void)
{
    setlocale(LC_ALL, "");

    wchar_t wcs[128];
    char *s = "€200 for this spoon?";  // 20 ký tự

    size_t char_count, byte_count;

    char_count = mbstowcs(wcs, s, 128);
    byte_count = strlen(s);

    printf("Wide string: L\"%ls\"\n", wcs);
    printf("Char count : %zu\n", char_count);    // 20
    printf("Byte count : %zu\n\n", byte_count);  // 22 trên máy tôi

    // Phần mở rộng POSIX cho phép bạn truyền NULL cho
    // đích để chỉ dùng giá trị trả về (là số ký tự của
    // chuỗi, nếu không có lỗi xảy ra)

    s = "§¶°±π€•";  // 7 ký tự

    char_count = mbstowcs(NULL, s, 0);  // Chỉ POSIX, không portable
    byte_count = strlen(s);

    printf("Multibyte str: \"%s\"\n", s);
    printf("Char count   : %zu\n", char_count);  // 7
    printf("Byte count   : %zu\n", byte_count);  // 16 trên máy tôi
}
```

Output trên máy tôi (số byte sẽ tuỳ thuộc vào encoding của bạn):

``` {.default}
Wide string: L"€200 for this spoon?"
Char count : 20
Byte count : 22

Multibyte str: "§¶°±π€•"
Char count   : 7
Byte count   : 16
```

### Xem thêm {.unnumbered .unlisted}

[`mblen()`](#man-mblen),
[`mbtowc()`](#man-mbtowc),
[`wcstombs()`](#man-wcstombs),
[`setlocale()`](#man-setlocale)


[[manbreak]]
## `wcstombs()` {#man-wcstombs}

[i[`wcstombs()` function]i]

Chuyển chuỗi ký tự rộng thành chuỗi multibyte

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdlib.h>

size_t wcstombs(char * restrict s, const wchar_t * restrict pwcs, size_t n);
```

### Mô tả {.unnumbered .unlisted}

Nếu bạn có chuỗi ký tự rộng và muốn biến nó thành chuỗi multibyte, đây
là hàm cho bạn!

Nó sẽ lấy các ký tự rộng được `pwcs` trỏ tới và chuyển chúng thành ký
tự multibyte lưu vào `s`. Không quá `n` byte sẽ được ghi vào `s`.

Phần mở rộng POSIX không portable: nếu bạn đang dùng một thư viện tuân
thủ POSIX, hàm này cho phép `s` là `NULL` nếu bạn chỉ quan tâm tới giá
trị trả về. Đáng chú ý nhất, việc này sẽ cho bạn số byte cần thiết để
mã hoá các ký tự rộng thành chuỗi multibyte.

### Giá trị trả về {.unnumbered .unlisted}

Trả về số byte được ghi vào `s`, hoặc `(size_t)(-1)` nếu một trong các
ký tự không thể mã hoá thành chuỗi multibyte.

Nếu giá trị trả về là `n`, nghĩa là kết quả _không_ được kết thúc bằng
NUL.

### Ví dụ {.unnumbered .unlisted}

Source này dùng bộ ký tự mở rộng. Nếu compiler của bạn không hỗ trợ,
bạn sẽ phải thay chúng bằng escape `\u`.

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>
#include <locale.h>
#include <string.h>

int main(void)
{
    setlocale(LC_ALL, "");

    char mbs[128];
    wchar_t *wcs = L"€200 for this spoon?";  // 20 ký tự

    size_t byte_count;

    byte_count = wcstombs(mbs, wcs, 128);

    printf("Wide string: L\"%ls\"\n", wcs);
    printf("Multibyte  : \"%s\"\n", mbs);
    printf("Byte count : %zu\n\n", byte_count);  // 22 trên máy tôi

    // Phần mở rộng POSIX cho phép bạn truyền NULL cho
    // đích để chỉ dùng giá trị trả về (là số ký tự của
    // chuỗi, nếu không có lỗi xảy ra)

    wcs = L"§¶°±π€•";  // 7 ký tự

    byte_count = wcstombs(NULL, wcs, 0);  // Chỉ POSIX, không portable

    printf("Wide string: L\"%ls\"\n", wcs);
    printf("Byte count : %zu\n", byte_count);  // 16 trên máy tôi
}
```

Output trên máy tôi (số byte sẽ tuỳ thuộc vào encoding của bạn):

``` {.default}
Wide string: L"€200 for this spoon?"
Multibyte  : "€200 for this spoon?"
Byte count : 22

Wide string: L"§¶°±π€•"
Byte count : 16
```

### Xem thêm {.unnumbered .unlisted}

[`mblen()`](#man-mblen),
[`wctomb()`](#man-wctomb),
[`mbstowcs()`](#man-mbstowcs),
[`setlocale()`](#man-setlocale)

[[manbreak]]
## `memalignment()` {#man-memalignment}

[i[`memalignment()` function]i]

### Synopsis {.unnumbered .unlisted}

Mới trong C23!

``` {.c}
#include <stdlib.h>

size_t memalignment(const void * p);
```

### Mô tả {.unnumbered .unlisted}

Hàm này sẽ cho bạn biết memory alignment (căn chỉnh bộ nhớ) (tính bằng
byte) của đối tượng được trỏ tới.

Ý tưởng là chúng ta sẽ lấy được cùng thông tin như khi dùng
[`alignof`](#man-alignof), chỉ khác là chúng ta có thể làm việc đó với
`void*` không có kiểu.

Và bạn có thể muốn làm điều này vì dữ liệu căn chỉnh sai có thể chậm
hơn hoặc không dùng được trên nhiều nền tảng.

### Giá trị trả về {.unnumbered .unlisted}

Trả về căn chỉnh dạng số nguyên của `p`, sẽ là luỹ thừa của 2. Trả về
`0` nếu truyền vào `NULL`. 

`0` nghĩa là con trỏ không thể dùng để truy cập đối tượng của bất kỳ
kiểu nào.

### Ví dụ {.unnumbered .unlisted}

(Lưu ý: chưa có compiler nào của tôi hỗ trợ hàm này, nên đoạn code phần
lớn chưa được test.)

Đề xuất cho tính năng này gợi ý rằng một macro có thể hữu ích để xác
định xem con trỏ có căn chỉnh tốt cho một kiểu cụ thể hay không, nên
chúng ta sẽ ăn cắp cái đó làm ví dụ:

``` {.c}
#include <stdio.h>
#include <stdalign.h>
#include <stdlib.h>

#define isaligned(P, T) (memalignment (P) >= alignof(T))

void check(void *p)
{
    printf("%lu %lu\n", memalignment(p), alignof(int));
    if (isaligned(p, int)) {
        puts("The pointer p is well-aligned for an int! :)");

        // Nên tôi thoải mái làm thế này:

        int *i = p;
        *i = 3490;

    } else
        puts("The pointer p is poorly-aligned for an int! :(");
}

int main(void)
{
    char *p = malloc(10);

    check(p);
    check(p + 1);
}
```

### Xem thêm {.unnumbered .unlisted}

[`alignof()`](#man-alignof),
[`alignas()`](#man-alignas),
[`max_align_t`](#man-max_align_t)

<!--
[[manbreak]]
## `example()`, `example()`, `example()` {#man-example}

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
