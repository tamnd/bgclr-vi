<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<ctype.h>` Phân loại và Chuyển đổi Ký tự {#ctype}

[i[`ctype.h` header file]i]

|Hàm|Mô tả|
|--------|----------------------|
|[`isalnum()`](#man-isalnum)|Kiểm tra ký tự có là chữ cái hoặc chữ số|
|[`isalpha()`](#man-isalpha)|Trả về true nếu ký tự là chữ cái|
|[`isblank()`](#man-isblank)|Kiểm tra ký tự có là whitespace ngăn từ|
|[`iscntrl()`](#man-iscntrl)|Kiểm tra ký tự có là ký tự điều khiển|
|[`isdigit()`](#man-isdigit)|Kiểm tra ký tự có là chữ số|
|[`isgraph()`](#man-isgraph)|Kiểm tra ký tự có in được và không phải space|
|[`islower()`](#man-islower)|Kiểm tra ký tự có là chữ thường|
|[`isprint()`](#man-isprint)|Kiểm tra ký tự có in được|
|[`ispunct()`](#man-ispunct)|Kiểm tra ký tự có là dấu câu|
|[`isspace()`](#man-isspace)|Kiểm tra ký tự có là whitespace|
|[`isupper()`](#man-isupper)|Kiểm tra ký tự có là chữ hoa|
|[`isxdigit()`](#man-isxdigit)|Kiểm tra ký tự có là chữ số hex|
|[`tolower()`](#man-tolower)|Chuyển chữ cái sang chữ thường|
|[`toupper()`](#man-toupper)|Chuyển chữ cái sang chữ hoa|


Bộ macro này tiện để kiểm tra xem một ký tự có thuộc một nhóm nào đó
không, chẳng hạn chữ cái, chữ số, ký tự điều khiển, v.v.

Đáng ngạc nhiên là chúng nhận tham số `int` thay vì kiểu `char` nào
đó. Lý do là để bạn tiện nhét `EOF` vào nếu có biểu diễn int của nó.
Nếu không phải `EOF`, giá trị truyền vào phải biểu diễn được bằng
`unsigned char`. Ngược lại thì (tèn tèn TÈÈÈN) undefined behavior.
Cho nên quên việc nhét ký tự UTF-8 nhiều byte vào đây đi.

Bạn có thể tránh undefined behavior này kiểu portable bằng cách ép
kiểu các đối số của những hàm này thành `(unsigned char)`. Công nhận
nghe phiền và xấu. Các giá trị trong basic character set đều dùng
được an toàn vì chúng là giá trị dương vừa vặn trong `unsigned char`.

Ngoài ra, hành vi của những hàm này cũng thay đổi theo locale.

Trong nhiều trang ở section này, tôi có kèm vài ví dụ. Chúng chạy ở
locale "C", và có thể khác đi nếu bạn đã đặt locale khác.

Chú ý là ký tự rộng (wide character) có bộ hàm phân loại riêng của
nó, nên đừng có thử dùng mấy hàm này trên `wchar_t`. Nghe không thì
_biết tay_!

[[manbreak]]
## `isalnum()` {#man-isalnum}

[i[`isalnum()` function]i]

Kiểm tra ký tự có là chữ cái hoặc chữ số

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <ctype.h>

int isalnum(int c);
```

### Mô tả {.unnumbered .unlisted}

Kiểm tra xem ký tự có là chữ cái (`A`-`Z` hoặc `a`-`z`) hoặc chữ số
(`0`-`9`).

Tương đương với:

``` {.c}
isalpha(c) || isdigit(c)
```

### Giá trị trả về {.unnumbered .unlisted}

Trả về true nếu ký tự là chữ cái (`A`-`Z` hoặc `a`-`z`) hoặc chữ số
(`0`-`9`).

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <ctype.h>

int main(void)
{
    //             kiểm tra ký tự này
    //                      v
    printf("%s\n", isalnum('a')? "yes": "no");  // yes
    printf("%s\n", isalnum('B')? "yes": "no");  // yes
    printf("%s\n", isalnum('5')? "yes": "no");  // yes
    printf("%s\n", isalnum('?')? "yes": "no");  // no
}
```

### Xem thêm {.unnumbered .unlisted}

[`isalpha()`](#man-isalpha),
[`isdigit()`](#man-isdigit)


[[manbreak]]
## `isalpha()` {#man-isalpha}

[i[`isalpha()` function]i]

Trả về true nếu ký tự là chữ cái

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <ctype.h>

int isalpha(int c);
```

### Mô tả {.unnumbered .unlisted}

Trả về true cho các ký tự chữ cái (`A`-`Z` hoặc `a`-`z`).

Về mặt kỹ thuật (và ở locale "C") tương đương với:

``` {.c}
isupper(c) || islower(c)
```

Cực kỳ siêu kỹ thuật, vì tôi biết bạn đang khát khao đoạn này phức
tạp một cách không cần thiết, nó còn có thể bao gồm một số ký tự đặc
thù locale mà cái này đúng:

``` {.c}
!iscntrl(c) && !isdigit(c) && !ispunct(c) && !isspace(c)
```

và cái này đúng:

``` {.c}
isupper(c) || islower(c)
```

### Giá trị trả về {.unnumbered .unlisted}

Trả về true cho các ký tự chữ cái (`A`-`Z` hoặc `a`-`z`).

Hoặc bất kỳ thứ điên rồ nào khác trong phần mô tả ở trên.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <ctype.h>

int main(void)
{
    //             kiểm tra ký tự này
    //                      v
    printf("%s\n", isalpha('a')? "yes": "no");  // yes
    printf("%s\n", isalpha('B')? "yes": "no");  // yes
    printf("%s\n", isalpha('5')? "yes": "no");  // no
    printf("%s\n", isalpha('?')? "yes": "no");  // no
}
```

### Xem thêm {.unnumbered .unlisted}

[`isalnum()`](#man-isalnum)

[[manbreak]]
## `isblank()` {#man-isblank}

[i[`isblank()` function]i]

Kiểm tra ký tự có là whitespace ngăn từ

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <ctype.h>

int isblank(int c);
```

### Mô tả {.unnumbered .unlisted}

True nếu ký tự là whitespace dùng để ngăn các từ trên cùng một dòng.

Ví dụ, space (`' '`) hoặc tab ngang (`'\t'`). Locale khác có thể định
nghĩa các ký tự blank khác.

### Giá trị trả về {.unnumbered .unlisted}

Trả về true nếu ký tự là whitespace dùng để ngăn các từ trên cùng một
dòng.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <ctype.h>

int main(void)
{
    //             kiểm tra ký tự này
    //                      v
    printf("%s\n", isblank(' ')? "yes": "no");   // yes
    printf("%s\n", isblank('\t')? "yes": "no");  // yes
    printf("%s\n", isblank('\n')? "yes": "no");  // no
    printf("%s\n", isblank('a')? "yes": "no");   // no
    printf("%s\n", isblank('?')? "yes": "no");   // no
}
```

### Xem thêm {.unnumbered .unlisted}

[`isspace()`](#man-isspace)

[[manbreak]]
## `iscntrl()` {#man-iscntrl}

[i[`iscntrl()` function]i]

Kiểm tra ký tự có là ký tự điều khiển

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <ctype.h>

int iscntrl(int c);
```

### Mô tả {.unnumbered .unlisted}

_Ký tự điều khiển_ (control character) là ký tự không in được, tuỳ
theo locale.

Với locale "C", nghĩa là các ký tự điều khiển nằm trong khoảng 0x00
đến 0x1F (ký tự ngay trước SPACE) và 0x7F (ký tự DEL).

Nói chung nếu nó không phải ký tự ASCII (hoặc Unicode nhỏ hơn 128) in
được, thì nó là ký tự điều khiển ở locale "C".
 
### Giá trị trả về {.unnumbered .unlisted}

Trả về true nếu `c` là ký tự điều khiển.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <ctype.h>

int main(void)
{
    //             kiểm tra ký tự này
    //                      v
    printf("%s\n", iscntrl('\t')? "yes": "no");  // yes (tab)
    printf("%s\n", iscntrl('\n')? "yes": "no");  // yes (newline)
    printf("%s\n", iscntrl('\r')? "yes": "no");  // yes (return)
    printf("%s\n", iscntrl('\a')? "yes": "no");  // yes (bell)
    printf("%s\n", iscntrl(' ')? "yes": "no");   // no
    printf("%s\n", iscntrl('a')? "yes": "no");   // no
    printf("%s\n", iscntrl('?')? "yes": "no");   // no
}
```

### Xem thêm {.unnumbered .unlisted}

[`isgraph()`](#man-isgraph),
[`isprint()`](#man-isprint)


[[manbreak]]
## `isdigit()` {#man-isdigit}

[i[`isdigit()` function]i]

Kiểm tra ký tự có là chữ số

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <ctype.h>

int isdigit(int c);
```

### Mô tả {.unnumbered .unlisted}

Kiểm tra xem `c` có là chữ số trong khoảng `0`-`9` không.

### Giá trị trả về {.unnumbered .unlisted}

Trả về true nếu ký tự là chữ số, không có gì bất ngờ.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <ctype.h>

int main(void)
{
    //             kiểm tra ký tự này
    //                      v
    printf("%s\n", isdigit('0')? "yes": "no");   // yes
    printf("%s\n", isdigit('5')? "yes": "no");   // yes
    printf("%s\n", isdigit('a')? "yes": "no");   // no
    printf("%s\n", isdigit('B')? "yes": "no");   // no
    printf("%s\n", isdigit('?')? "yes": "no");   // no
}
```

### Xem thêm {.unnumbered .unlisted}

[`isalnum()`](#man-isalnum),
[`isxdigit()`](#man-isxdigit)

[[manbreak]]
## `isgraph()` {#man-isgraph}

[i[`isgraph()` function]i]

Kiểm tra ký tự có in được và không phải space

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <ctype.h>

int isgraph(int c);
```

### Mô tả {.unnumbered .unlisted}

Kiểm tra xem `c` có là ký tự in được nào mà không phải space (`' '`)
không.

### Giá trị trả về {.unnumbered .unlisted}

Trả về true nếu `c` là ký tự in được nào mà không phải space (`' '`).

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <ctype.h>

int main(void)
{
    //             kiểm tra ký tự này
    //                      v
    printf("%s\n", isgraph('0')? "yes": "no");   // yes
    printf("%s\n", isgraph('a')? "yes": "no");   // yes
    printf("%s\n", isgraph('B')? "yes": "no");   // yes
    printf("%s\n", isgraph('?')? "yes": "no");   // yes
    printf("%s\n", isgraph(' ')? "yes": "no");   // no
    printf("%s\n", isgraph('\n')? "yes": "no");  // no
}
```

### Xem thêm {.unnumbered .unlisted}

[`iscntrl()`](#man-iscntrl),
[`isprint()`](#man-isprint)

[[manbreak]]
## `islower()` {#man-islower}

[i[`islower()` function]i]

Kiểm tra ký tự có là chữ thường

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <ctype.h>

int islower(int c);
```

### Mô tả {.unnumbered .unlisted}

Kiểm tra xem ký tự có là chữ thường trong khoảng `a`-`z` không.

Ở các locale khác, có thể có những ký tự chữ thường khác. Trong mọi
trường hợp, để là chữ thường, điều sau đây phải đúng:

``` {.c}
!iscntrl(c) && !isdigit(c) && !ispunct(c) && !isspace(c)
```

### Giá trị trả về {.unnumbered .unlisted}

Trả về true nếu ký tự là chữ thường.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <ctype.h>

int main(void)
{
    //             kiểm tra ký tự này
    //                      v
    printf("%s\n", islower('c')? "yes": "no");   // yes
    printf("%s\n", islower('0')? "yes": "no");   // no
    printf("%s\n", islower('B')? "yes": "no");   // no
    printf("%s\n", islower('?')? "yes": "no");   // no
    printf("%s\n", islower(' ')? "yes": "no");   // no
}
```

### Xem thêm {.unnumbered .unlisted}

[`isupper()`](#man-isupper),
[`isalpha()`](#man-isalpha),
[`toupper()`](#man-toupper),
[`tolower()`](#man-tolower)

[[manbreak]]
## `isprint()` {#man-isprint}

[i[`isprint()` function]i]

Kiểm tra ký tự có in được

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <ctype.h>

int isprint(int c);
```

### Mô tả {.unnumbered .unlisted}

Kiểm tra xem ký tự có in được không, kể cả space (`' '`). Nên là
giống `isgraph()`, nhưng lần này space không bị bỏ rơi ngoài trời
lạnh.

### Giá trị trả về {.unnumbered .unlisted}

Trả về true nếu ký tự in được, kể cả space (`' '`).

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <ctype.h>

int main(void)
{
    //             kiểm tra ký tự này
    //                      v
    printf("%s\n", isprint('c')? "yes": "no");   // yes
    printf("%s\n", isprint('0')? "yes": "no");   // yes
    printf("%s\n", isprint(' ')? "yes": "no");   // yes
    printf("%s\n", isprint('\r')? "yes": "no");  // no
}
```

### Xem thêm {.unnumbered .unlisted}

[`isgraph()`](#man-isgraph),
[`iscntrl()`](#man-iscntrl)

[[manbreak]]
## `ispunct()` {#man-ispunct}

[i[`ispunct()` function]i]

Kiểm tra ký tự có là dấu câu

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <ctype.h>

int ispunct(int c);
```

### Mô tả {.unnumbered .unlisted}

Kiểm tra xem ký tự có là dấu câu.

Ở locale "C", điều đó có nghĩa là:

``` {.c}
!isspace(c) && !isalnum(c)
```

Ở các locale khác, có thể có các ký tự dấu câu khác (nhưng cũng không
thể là space hoặc chữ-số).

### Giá trị trả về {.unnumbered .unlisted}

True nếu ký tự là dấu câu.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <ctype.h>

int main(void)
{
    //             kiểm tra ký tự này
    //                      v
    printf("%s\n", ispunct(',')? "yes": "no");   // yes
    printf("%s\n", ispunct('!')? "yes": "no");   // yes
    printf("%s\n", ispunct('c')? "yes": "no");   // no
    printf("%s\n", ispunct('0')? "yes": "no");   // no
    printf("%s\n", ispunct(' ')? "yes": "no");   // no
    printf("%s\n", ispunct('\n')? "yes": "no");  // no
}
```

### Xem thêm {.unnumbered .unlisted}

[`isspace()`](#man-isspace),
[`isalnum()`](#man-isalnum)

[[manbreak]]
## `isspace()` {#man-isspace}

[i[`isspace()` function]i]

Kiểm tra ký tự có là whitespace

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <ctype.h>

int isspace(int c);
```

### Mô tả {.unnumbered .unlisted}

Kiểm tra xem `c` có là ký tự whitespace không. Bao gồm:

* Space (`' '`)
* Formfeed (`'\f'`)
* Newline (`'\n'`)
* Carriage Return (`'\r'`)
* Horizontal Tab (`'\t'`)
* Vertical Tab (`'\v'`)

Các locale khác có thể xác định các ký tự whitespace khác. `isalnum()`
là false với mọi ký tự whitespace.

### Giá trị trả về {.unnumbered .unlisted}

True nếu ký tự là whitespace.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <ctype.h>

int main(void)
{
    //             kiểm tra ký tự này
    //                      v
    printf("%s\n", isspace(' ')? "yes": "no");   // yes
    printf("%s\n", isspace('\n')? "yes": "no");  // yes
    printf("%s\n", isspace('\t')? "yes": "no");  // yes
    printf("%s\n", isspace(',')? "yes": "no");   // no
    printf("%s\n", isspace('!')? "yes": "no");   // no
    printf("%s\n", isspace('c')? "yes": "no");   // no
}
```

### Xem thêm {.unnumbered .unlisted}

[`isblank()`](#man-isblank)

[[manbreak]]
## `isupper()` {#man-isupper}

[i[`isupper()` function]i]

Kiểm tra ký tự có là chữ hoa

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <ctype.h>

int isupper(int c);
```

### Mô tả {.unnumbered .unlisted}

Kiểm tra xem ký tự có là chữ hoa trong khoảng `A`-`Z` không.

Ở các locale khác, có thể có những ký tự chữ hoa khác. Trong mọi
trường hợp, để là chữ hoa, điều sau đây phải đúng:

``` {.c}
!iscntrl(c) && !isdigit(c) && !ispunct(c) && !isspace(c)
```

### Giá trị trả về {.unnumbered .unlisted}

Trả về true nếu ký tự là chữ hoa.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <ctype.h>

int main(void)
{
    //             kiểm tra ký tự này
    //                      v
    printf("%s\n", isupper('B')? "yes": "no");   // yes
    printf("%s\n", isupper('c')? "yes": "no");   // no
    printf("%s\n", isupper('0')? "yes": "no");   // no
    printf("%s\n", isupper('?')? "yes": "no");   // no
    printf("%s\n", isupper(' ')? "yes": "no");   // no
}
```

### Xem thêm {.unnumbered .unlisted}

[`islower()`](#man-islower),
[`isalpha()`](#man-isalpha),
[`toupper()`](#man-toupper),
[`tolower()`](#man-tolower)

[[manbreak]]
## `isxdigit()` {#man-isxdigit}

[i[`isxdigit()` function]i]

Kiểm tra ký tự có là chữ số hex

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <ctype.h>

int isxdigit(int c);
```

### Mô tả {.unnumbered .unlisted}

Trả về true nếu ký tự là chữ số hex. Cụ thể là `0`-`9`, `a`-`f`, hoặc
`A`-`F`.

### Giá trị trả về {.unnumbered .unlisted}

True nếu ký tự là chữ số hex.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <ctype.h>

int main(void)
{
    //             kiểm tra ký tự này
    //                      v
    printf("%s\n", isxdigit('B')? "yes": "no");   // yes
    printf("%s\n", isxdigit('c')? "yes": "no");   // yes
    printf("%s\n", isxdigit('2')? "yes": "no");   // yes
    printf("%s\n", isxdigit('G')? "yes": "no");   // no
    printf("%s\n", isxdigit('?')? "yes": "no");   // no
}
```

### Xem thêm {.unnumbered .unlisted}

[`isdigit()`](#man-isdigit)

[[manbreak]]
## `tolower()` {#man-tolower}

[i[`tolower()` function]i]

Chuyển chữ cái sang chữ thường

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <ctype.h>

int tolower(int c);
```

### Mô tả {.unnumbered .unlisted}

Nếu ký tự là chữ hoa (tức `isupper(c)` là true), hàm này trả về chữ
thường tương ứng.

Các locale khác nhau có thể có tập chữ hoa và chữ thường khác nhau.

### Giá trị trả về {.unnumbered .unlisted}

Trả về giá trị chữ thường của một chữ hoa. Nếu ký tự không phải chữ
hoa, trả về không đổi.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <ctype.h>

int main(void)
{
    //             đổi ký tự này
    //                      v
    printf("%c\n", tolower('B'));  // b (đã chuyển thường!)
    printf("%c\n", tolower('e'));  // e (không đổi)
    printf("%c\n", tolower('!'));  // ! (không đổi)
}
```

### Xem thêm {.unnumbered .unlisted}

[`toupper()`](#man-toupper),
[`islower()`](#man-islower),
[`isupper()`](#man-isupper)

[[manbreak]]
## `toupper()` {#man-toupper}

[i[`toupper()` function]i]

Chuyển chữ cái sang chữ hoa

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <ctype.h>

int toupper(int c);
```

### Mô tả {.unnumbered .unlisted}

Nếu ký tự là chữ thường (tức `islower(c)` là true), hàm này trả về
chữ hoa tương ứng.

Các locale khác nhau có thể có tập chữ hoa và chữ thường khác nhau.

### Giá trị trả về {.unnumbered .unlisted}

Trả về giá trị chữ hoa của một chữ thường. Nếu ký tự không phải chữ
thường, trả về không đổi.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <ctype.h>

int main(void)
{
    //             đổi ký tự này
    //                      v
    printf("%c\n", toupper('B'));  // B (không đổi)
    printf("%c\n", toupper('e'));  // E (đã chuyển hoa!)
    printf("%c\n", toupper('!'));  // ! (không đổi)
}
```

### Xem thêm {.unnumbered .unlisted}

[`tolower()`](#man-tolower),
[`islower()`](#man-islower),
[`isupper()`](#man-isupper)

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
