<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->
# `<string.h>` Thao Tác Chuỗi {#stringref}

[i[`string.h` header file]i]

|Hàm|Mô tả|
|-|-|
|[`memccpy()`](#man-memcpy)|Sao chép một vùng bộ nhớ sang vùng khác, dừng lại tại một ký tự được chỉ định.|
|[`memchr()`](#man-strchr)|Tìm lần xuất hiện đầu tiên của một ký tự trong bộ nhớ.|
|[`memcmp()`](#man-strcmp)|So sánh hai vùng bộ nhớ.|
|[`memcpy()`](#man-memcpy)|Sao chép một vùng bộ nhớ sang vùng khác.|
|[`memmove()`](#man-memcpy)|Di chuyển một vùng bộ nhớ (có thể chồng nhau).|
|[`memset()`](#man-memset)|Đặt một vùng bộ nhớ về một giá trị.|
|[`memset_explicit()`](#man-memset)|Đặt một vùng bộ nhớ về một giá trị theo cách không thể bị tối ưu hoá bỏ đi.|
|[`strcat()`](#man-strcat)|Concatenate (nối) hai chuỗi lại với nhau.|
|[`strchr()`](#man-strchr)|Tìm lần xuất hiện đầu tiên của một ký tự trong chuỗi.|
|[`strcmp()`](#man-strcmp)|So sánh hai chuỗi.|
|[`strcoll()`](#man-strcoll)|So sánh hai chuỗi có tính đến locale.|
|[`strcpy()`](#man-strcpy)|Sao chép một chuỗi.|
|[`strcspn()`](#man-strspn)|Tìm độ dài của một chuỗi không chứa một tập các ký tự nào đó.|
|[`strdup()`](#man-strdup)|Nhân bản một chuỗi trên heap.|
|[`strerror()`](#man-strerror)|Trả về thông báo lỗi dễ đọc ứng với một mã cho trước.|
|[`strlen()`](#man-strlen)|Trả về độ dài của một chuỗi.|
|[`strncat()`](#man-strcat)|Concatenate (nối) hai chuỗi, có giới hạn độ dài.|
|[`strncmp()`](#man-strcmp)|So sánh hai chuỗi, có giới hạn độ dài.|
|[`strncpy()`](#man-strcpy)|Sao chép hai chuỗi, có giới hạn độ dài.|
|[`strndup()`](#man-strdup)|Nhân bản một chuỗi trên heap, có giới hạn độ dài.|
|[`strpbrk()`](#man-strpbrk)|Tìm trong chuỗi một trong các ký tự của một tập hợp.|
|[`strrchr()`](#man-strchr)|Tìm lần xuất hiện cuối cùng của một ký tự trong chuỗi.|
|[`strspn()`](#man-strspn)|Tìm độ dài của một chuỗi chỉ gồm một tập các ký tự.|
|[`strstr()`](#man-strstr)|Tìm một chuỗi con trong một chuỗi.|
|[`strtok()`](#man-strtok)|Tách chuỗi thành các token.|
|[`strxfrm()`](#man-strxfrm)|Chuẩn bị một chuỗi để so sánh như thể bằng `strcoll()`.|

Như đã nhắc từ sớm trong guide, một string (chuỗi) trong C là một chuỗi
các byte trong bộ nhớ, được kết thúc bằng một ký tự NUL ('`\0`'). Cái
NUL ở cuối rất quan trọng, vì nó cho tất cả các hàm chuỗi này (và
`printf()` và `puts()` và mọi thứ khác có dính dáng đến chuỗi) biết
điểm kết thúc thực sự của chuỗi ở đâu.

May thay, khi bạn thao tác với một chuỗi bằng một trong rất nhiều hàm
có sẵn này, chúng sẽ tự thêm null terminator (kết thúc bằng NUL) giúp
bạn, nên thực ra hiếm khi bạn phải tự theo dõi nó. (Đôi lúc bạn cũng
phải làm, đặc biệt nếu bạn đang tự tay dựng một chuỗi từ đầu bằng cách
thêm từng ký tự một hoặc đại loại vậy.)

Trong mục này bạn sẽ tìm thấy các hàm để lấy chuỗi con ra khỏi chuỗi,
concatenate (nối) các chuỗi với nhau, lấy độ dài (length) của một
chuỗi, vân vân và mây mây.

[[manbreak]]
## `memcpy()`, `memccpy()`, `memmove()` {#man-memcpy}

[i[`memcpy()` function]i]
[i[`memccpy()` function]i]
[i[`memmove()` function]i]

Sao chép byte từ vị trí này sang vị trí khác trong bộ nhớ

### Synopsis {.unnumbered .unlisted}

`memccpy()` là mới trong C23!

``` {.c}
#include <string.h>

void *memcpy(void * restrict s1, const void * restrict s2, size_t n);

void *memccpy(void * restrict s1, const void * restrict s2, int c,
              size_t n);

void *memmove(void *s1, const void *s2, size_t n);
```

### Mô tả {.unnumbered .unlisted}

Mấy hàm này sao chép bộ nhớ---bao nhiêu byte bạn muốn cũng được! Từ
nguồn sang đích, với số byte mà bạn chỉ định!

`memccpy()` cho bạn thêm một tuỳ chọn: dừng lại sau khi gặp một ký tự
nhất định trong nguồn.

Khác biệt chính giữa các biến thể `memcpy()` và `memmove()` là cái
trước không thể sao chép an toàn các vùng bộ nhớ overlap (chồng) nhau,
còn cái sau thì có.

Tôi không chắc vì sao bạn lại muốn dùng `memcpy()` thay vì `memmove()`,
nhưng tôi đoán chắc nó nhanh hơn một chút.

Các tham số có thứ tự đặc biệt: đích trước, rồi đến nguồn. Tôi nhớ thứ
tự này vì nó giống như một phép gán "`=`": đích nằm ở bên trái.

### Giá trị trả về {.unnumbered .unlisted}

Cả hai hàm đều trả về đúng cái bạn truyền vào ở tham số `s1` cho tiện.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <string.h>

int main(void)
{
    char s[100] = "Goats";
    char t[100];

    memcpy(t, s, 6);       // Sao chép bộ nhớ không chồng nhau

    memmove(s + 2, s, 6);  // Sao chép bộ nhớ chồng nhau
}
```

### Xem thêm {.unnumbered .unlisted}

[`strcpy()`](#man-strcpy),
[`strncpy()`](#man-strcpy)

[[manbreak]]
## `strcpy()`, `strncpy()` {#man-strcpy}

[i[`strcpy()` function]i]
[i[`strncpy()` function]i]

Sao chép một chuỗi

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <string.h>

char *strcpy(char *dest, char *src);

char *strncpy(char *dest, char *src, size_t n);
```

### Mô tả {.unnumbered .unlisted}

Mấy hàm này sao chép một chuỗi từ một địa chỉ sang địa chỉ khác, dừng
lại tại null terminator trên chuỗi `src`.

`strncpy()` cũng giống `strcpy()`, chỉ khác là chỉ `n` ký tự đầu được
sao chép thực sự. Cẩn thận nhé: nếu bạn chạm tới giới hạn `n` trước
khi gặp null terminator trên chuỗi `src`, chuỗi `dest` của bạn sẽ
không được NUL-terminated (kết thúc bằng NUL). Cẩn thận! CẨN THẬN!

(Nếu chuỗi `src` có ít hơn `n` ký tự, nó hoạt động đúng như
`strcpy()`.)

Bạn có thể tự mình kết thúc chuỗi bằng cách nhét `'\0'` vào:

``` {.c}
char s[10];
char foo = "My hovercraft is full of eels."; // nhiều hơn 10 ký tự

strncpy(s, foo, 9); // chỉ chép 9 ký tự vào vị trí 0-8
s[9] = '\0';        // vị trí 9 nhận ký tự kết thúc
```

### Giá trị trả về {.unnumbered .unlisted}

Cả hai hàm đều trả về `dest` cho tiện, không tính thêm phí gì.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <string.h>

int main(void)
{
    char *src = "hockey hockey hockey hockey hockey hockey hockey hockey";
    char dest[20];

    int len;

    strcpy(dest, "I like "); // dest giờ là "I like "

    len = strlen(dest);

    // hơi hóc búa, nhưng ta dùng chút số học con trỏ để append
    // được càng nhiều src vào cuối dest càng tốt, -1 trong độ dài để
    // chừa chỗ cho ký tự kết thúc:
    strncpy(dest+len, src, sizeof(dest)-len-1);

    // nhớ rằng sizeof() trả về kích thước của mảng theo byte
    // và một char là một byte:
    dest[sizeof(dest)-1] = '\0'; // kết thúc chuỗi

    // dest giờ là:      v null terminator
    // I like hockey hocke 
    // 01234567890123456789012345
}
```

### Xem thêm {.unnumbered .unlisted}

[`memcpy()`](#man-memcpy),
[`strcat()`](#man-strcat),
[`strncat()`](#man-strcat)

[[manbreak]]
## `strdup()`, `strndup()` {#man-strdup}

[i[`strdup()` function]i]
[i[`strndup()` function]i]

Nhân bản (duplicate) một chuỗi trên heap

### Synopsis {.unnumbered .unlisted}

Mới trong C23!

``` {.c}
#include <string.h>

char *strdup(const char *s);

char *strndup(const char *s, size_t size);
```

### Mô tả {.unnumbered .unlisted}

Cái này giống `strcpy()`, chỉ khác là nó tự cấp phát chỗ cho chuỗi
mới, như thể được làm bằng [`malloc()`](#man-malloc).

Con trỏ tới chuỗi nhân bản mà nó trả về nên được giải phóng bằng một
lần gọi [`free()`](#man-free) khi bạn dùng xong.

`strndup()` hoạt động tương tự, chỉ khác là bạn có thể giới hạn số
byte được duplicate. `strndup()` luôn tạo ra một chuỗi
NUL-terminated.

### Giá trị trả về {.unnumbered .unlisted}

Cả hai hàm đều trả về con trỏ tới chuỗi mới được tạo, hoặc `NULL` nếu
không cấp phát được bộ nhớ cho bản nhân bản.

### Ví dụ {.unnumbered .unlisted}

Đây là ví dụ nhân bản một chuỗi rồi viết hoa chữ cái đầu của bản nhân
bản.

``` {.c}
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

char *dup_cap(const char *s)
{
    char *d = strdup(s);

    if (d != NULL)
        d[0] = toupper(d[0]);

    return d;
}

int main(void)
{
    char *s = dup_cap("hello, world!");

    if (s != NULL)
        puts(s);  // Hello, world!
    else
        puts("Error duplicating string");

    free(s);
}
```

### Xem thêm {.unnumbered .unlisted}

[`strcpy()`](#man-strcpy),
[`strncpy()`](#man-strcpy),
[`malloc()`](#man-malloc),
[`free()`](#man-free)

[[manbreak]]
## `strcat()`, `strncat()` {#man-strcat}

[i[`strcat()` function]i]
[i[`strncat()` function]i]

Concatenate (nối) hai chuỗi thành một chuỗi duy nhất

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <string.h>

int strcat(const char *dest, const char *src);

int strncat(const char *dest, const char *src, size_t n);
```

### Mô tả {.unnumbered .unlisted}

"Concatenate", cho ai chưa biết, nghĩa là "dán vào nhau". Mấy hàm
này nhận hai chuỗi, dán chúng lại, rồi lưu kết quả vào chuỗi đầu
tiên.

Các hàm này không tính đến kích thước của chuỗi thứ nhất khi nối. Dịch
ra thực tế nghĩa là bạn có thể cố nhét một chuỗi 2 megabyte vào một
chỗ chỉ có 10 byte. Điều này sẽ dẫn đến hậu quả ngoài ý muốn, trừ khi
bạn cố ý dẫn đến hậu quả ngoài ý muốn, trong trường hợp đó nó sẽ dẫn
đến hậu quả ngoài-ý-muốn-một-cách-có-chủ-ý.

Gạt chuyện đùa kỹ thuật sang một bên, sếp và/hoặc giáo sư của bạn sẽ
nổi điên.

Nếu bạn muốn chắc chắn không tràn chuỗi đầu tiên, hãy kiểm tra độ dài
của các chuỗi trước và dùng một phép trừ cực kỳ cao siêu để đảm bảo
mọi thứ vừa vặn.

Thực ra bạn có thể chỉ concatenate `n` ký tự đầu của chuỗi thứ hai
bằng cách dùng `strncat()` và chỉ định số ký tự tối đa cần sao chép.

### Giá trị trả về {.unnumbered .unlisted}

Cả hai hàm đều trả về một con trỏ tới chuỗi đích, như hầu hết các hàm
xử lý chuỗi khác.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <string.h>

int main(void)
{
    char dest[30] = "Hello";
    char *src = ", World!";
    char numbers[] = "12345678";

    printf("dest before strcat: \"%s\"\n", dest); // "Hello"

    strcat(dest, src);
    printf("dest after strcat:  \"%s\"\n", dest); // "Hello, world!"

    strncat(dest, numbers, 3); // strcat 3 ký tự đầu của numbers
    printf("dest after strncat: \"%s\"\n", dest); // "Hello, world!123"
}
```

Để ý tôi có trộn lẫn ký pháp con trỏ và mảng ở đó với `src` và
`numbers`; với các hàm chuỗi thì chuyện đó không sao cả.

### Xem thêm {.unnumbered .unlisted}

[`strlen()`](#man-strlen)

[[manbreak]]
## `strcmp()`, `strncmp()`, `memcmp()` {#man-strcmp}

[i[`strcmp()` function]i]
[i[`strncmp()` function]i]
[i[`memcmp()` function]i]

So sánh hai chuỗi hoặc hai vùng bộ nhớ và trả về phần chênh lệch

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <string.h>

int strcmp(const char *s1, const char *s2);

int strncmp(const char *s1, const char *s2, size_t n);

int memcmp(const void *s1, const void *s2, size_t n);
```

### Mô tả {.unnumbered .unlisted}

Tất cả các hàm này đều so sánh các khối byte trong bộ nhớ.

`strcmp()` và `strncmp()` làm việc với chuỗi NUL-terminated, trong
khi `memcmp()` sẽ so sánh đúng số byte bạn chỉ định, bơ đi mọi ký tự
NUL mà nó vô tình gặp trên đường.

`strcmp()` so sánh toàn bộ chuỗi đến cuối, còn `strncmp()` chỉ so
sánh `n` ký tự đầu của các chuỗi.

Giá trị chúng trả về hơi kỳ kỳ. Về cơ bản nó là phần chênh lệch của
các chuỗi, nên nếu các chuỗi giống nhau thì nó trả về 0 (vì chênh
lệch bằng 0). Nó sẽ trả về khác 0 nếu các chuỗi khác nhau; về cơ bản
nó sẽ tìm ký tự đầu tiên không khớp và trả về giá trị nhỏ hơn 0 nếu
ký tự đó trong `s1` nhỏ hơn ký tự tương ứng trong `s2`. Nó sẽ trả về
giá trị lớn hơn 0 nếu ký tự đó trong `s1` lớn hơn trong `s2`.

Vậy nếu chúng trả về `0`, phép so sánh là bằng nhau (tức là chênh
lệch bằng `0`.)

Các hàm này có thể dùng làm hàm so sánh cho
[`qsort()`](#man-qsort) nếu bạn có một mảng các `char*` cần sắp xếp.

### Giá trị trả về {.unnumbered .unlisted}

Trả về 0 nếu các chuỗi hay các vùng bộ nhớ giống nhau, nhỏ hơn 0 nếu
ký tự khác biệt đầu tiên trong `s1` nhỏ hơn ký tự tương ứng trong
`s2`, hoặc lớn hơn 0 nếu ký tự khác biệt đầu tiên trong `s1` lớn hơn
trong `s2`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <string.h>

int main(void)
{
    char *s1 = "Muffin";
    char *s2 = "Muffin Sandwich";
    char *s3 = "Muffin";

    int r1 = strcmp("Biscuits", "Kittens");
    printf("%d\n", r1); // in ra < 0 vì 'B' < 'K'

    int r2 = strcmp("Kittens", "Biscuits");
    printf("%d\n", r2); // in ra > 0 vì 'K' > 'B'

    if (strcmp(s1, s2) == 0)
        printf("This won't get printed because the strings differ\n");

    if (strcmp(s1, s3) == 0)
        printf("This will print because s1 and s3 are the same\n");

    // hơi lạ...nhưng nếu các chuỗi giống nhau, nó sẽ trả về
    // 0, mà cũng có thể hiểu là "false". Not-false
    // là "true", nên (!strcmp()) sẽ là true nếu các chuỗi giống
    // nhau. Ừ, kỳ thật, nhưng bạn sẽ thấy cái này suốt ngoài đời
    // nên cứ quen dần đi:

    if (!strcmp(s1, s3))
        printf("The strings are the same!\n");

    if (!strncmp(s1, s2, 6))
        printf("The first 6 characters of s1 and s2 are the same\n");
}
```

### Xem thêm {.unnumbered .unlisted}

[`memcmp()`](#man-strcmp),
[`qsort()`](#man-qsort)

[[manbreak]]
## `strcoll()` {#man-strcoll}

[i[`strcoll()` function]i]

So sánh hai chuỗi có tính đến locale

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <string.h>

int strcoll(const char *s1, const char *s2);
```

### Mô tả {.unnumbered .unlisted}

Đây về cơ bản là `strcmp()`, chỉ khác là nó xử lý các ký tự có dấu
tốt hơn tuỳ theo locale.

Ví dụ, `strcmp()` của tôi báo rằng ký tự "é" (có dấu) lớn hơn "f".
Nhưng chuyện đó chẳng có mấy tác dụng cho việc sắp xếp theo bảng chữ
cái.

Bằng cách set giá trị locale `LC_COLLATE` (theo tên hoặc qua
`LC_ALL`), bạn có thể khiến `strcoll()` sắp xếp theo cách có ý nghĩa
hơn với locale hiện tại. Ví dụ, có "é" xuất hiện một cách tử tế
_trước_ "f".

Nó cũng chậm hơn `strcmp()` kha khá nên chỉ dùng khi bắt buộc. Xem
[`strxfrm()`](#man-strxfrm) để có cách tăng tốc tiềm năng.

### Giá trị trả về {.unnumbered .unlisted}

Giống các hàm so sánh chuỗi khác, `strcoll()` trả về giá trị âm nếu
`s1` nhỏ hơn `s2`, hoặc giá trị dương nếu `s1` lớn hơn `s2`. Hoặc
`0` nếu chúng bằng nhau.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <string.h>
#include <locale.h>

int main(void)
{
    setlocale(LC_ALL, "");

    // Nếu bộ ký tự nguồn của bạn không hỗ trợ "é" trong chuỗi
    // bạn có thể thay bằng `\u00e9`, là code point Unicode
    // của "é".

    printf("%d\n", strcmp("é", "f"));   // Báo é > f, ẹ.
    printf("%d\n", strcoll("é", "f"));  // Báo é < f, hoan hô!
}
```

### Xem thêm {.unnumbered .unlisted}

[`strcmp()`](#man-strcmp)

[[manbreak]]
## `strxfrm()` {#man-strxfrm}

[i[`strxfrm()` function]i]

Chuyển đổi (transform) một chuỗi để so sánh dựa trên locale

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <string.h>

size_t strxfrm(char * restrict s1, const char * restrict s2, size_t n);
```

### Mô tả {.unnumbered .unlisted}

Đây là một hàm be bé kỳ lạ, nên chịu khó theo tôi nhé.

Trước tiên, nếu bạn chưa làm quen, hãy tìm hiểu
[`strcoll()`](#man-strcoll) vì cái này liên quan mật thiết tới nó.

OK! Giờ bạn đã quay lại, bạn có thể nghĩ về `strxfrm()` như phần đầu
trong ruột của `strcoll()`. Về cơ bản, `strcoll()` phải transform
(chuyển đổi) một chuỗi sang một dạng có thể đem so sánh bằng
`strcmp()`. Và nó làm việc này bằng `strxfrm()` cho cả hai chuỗi mỗi
lần bạn gọi.

`strxform()` lấy chuỗi `s2` và transform nó (chuẩn bị cho
`strcmp()`) lưu kết quả vào `s1`. Nó ghi không quá `n` byte, bảo vệ
ta khỏi những vụ tràn buffer (buffer overflow) kinh khủng.

Nhưng khoan---còn một chế độ khác nữa! Nếu bạn truyền `NULL` cho `s1`
và `0` cho `n`, nó sẽ trả về số byte mà chuỗi đã transform _đáng ra
sẽ_ cần^[Nó luôn trả về số byte mà chuỗi đã transform chiếm, nhưng
trong trường hợp này vì `s1` là `NULL`, nó không thực sự ghi ra một
chuỗi đã transform.]. Cái này hữu ích khi bạn cần cấp phát sẵn chỗ để
chứa chuỗi đã transform trước khi `strcmp()` nó với chuỗi khác.

Ý tôi là, nói thẳng ra, `strcoll()` chậm so với `strcmp()`. Nó phải
làm thêm rất nhiều việc khi chạy `strxfrm()` trên tất cả các chuỗi.

Thực tế, ta có thể thấy cách nó hoạt động bằng cách tự viết một bản
như thế này:

``` {.c .numberLines}
int my_strcoll(char *s1, char *s2)
{
    // Dùng n = 0 để chỉ lấy độ dài của các chuỗi đã transform
    int len1 = strxfrm(NULL, s1, 0) + 1;
    int len2 = strxfrm(NULL, s2, 0) + 1;

    // Cấp phát đủ chỗ cho mỗi chuỗi
    char *d1 = malloc(len1);
    char *d2 = malloc(len2);

    // Transform các chuỗi để so sánh
    strxfrm(d1, s1, len1);
    strxfrm(d2, s2, len2);

    // So sánh các chuỗi đã transform
    int result = strcmp(d1, d2);

    // Giải phóng các chuỗi đã transform
    free(d2);
    free(d1);

    return result;
}
```

Bạn thấy ở dòng 12, 13 và 16 phía trên, ta transform hai chuỗi input
rồi gọi `strcmp()` trên kết quả.

Vậy tại sao ta có hàm này? Không thể cứ gọi `strcoll()` cho xong
chuyện à?

Ý tưởng là: nếu bạn có một chuỗi sẽ được đem so sánh với rất nhiều
chuỗi khác, có lẽ bạn chỉ muốn transform chuỗi đó một lần, rồi dùng
`strcmp()` nhanh hơn để tiết kiệm cả đống công việc ta đã phải làm
trong hàm phía trên.

Ta sẽ làm điều đó trong ví dụ.

### Giá trị trả về {.unnumbered .unlisted}

Trả về số byte của chuỗi đã transform. Nếu giá trị lớn hơn `n`, kết
quả trong `s1` không có ý nghĩa.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <string.h>
#include <locale.h>
#include <stdlib.h>

// Transform một chuỗi để so sánh, trả về kết quả đã malloc
char *get_xfrm_str(char *s)
{
    int len = strxfrm(NULL, s, 0) + 1;
    char *d = malloc(len);

    strxfrm(d, s, len);

    return d;
}

// Làm một nửa công việc của strcoll() thông thường vì chuỗi thứ hai
// đã được transform sẵn khi truyền vào.
int half_strcoll(char *s1, char *s2_transformed)
{
    char *s1_transformed = get_xfrm_str(s1);

    int result = strcmp(s1_transformed, s2_transformed);

    free(s1_transformed);

    return result;
}

int main(void)
{
    setlocale(LC_ALL, "");

    // Transform trước chuỗi dùng để so sánh
    char *s = get_xfrm_str("éfg");

    // So sánh lặp đi lặp lại với "éfg" 
    printf("%d\n", half_strcoll("fgh", s));  // "fgh" > "éfg"
    printf("%d\n", half_strcoll("àbc", s));  // "àbc" < "éfg"
    printf("%d\n", half_strcoll("ĥij", s));  // "ĥij" > "éfg"
    
    free(s);
}
```

### Xem thêm {.unnumbered .unlisted}
[`strcoll()`](#man-strcoll)

[[manbreak]]
## `strchr()`, `strrchr()`, `memchr()` {#man-strchr}

[i[`strchr()` function]i]
[i[`strrchr()` function]i]
[i[`memchr()` function]i]

Tìm một ký tự trong chuỗi

### Synopsis {.unnumbered .unlisted}

``` {.c}
// Pre-C23:

#include <string.h>

char *strchr(char *str, int c);

char *strrchr(char *str, int c);

void *memchr(const void *s, int c, size_t n);


// C23:

QChar *strchr(QChar *s, int c);

QChar *strrchr(QChar *s, int c);

QVoid *memchr(QVoid *s, int c, size_t n);
```

### Mô tả {.unnumbered .unlisted}

Các hàm `strchr()` và `strrchr` lần lượt tìm lần xuất hiện đầu tiên
hoặc cuối cùng của một chữ cái trong chuỗi. (Chữ "r" thừa trong
`strrchr()` là viết tắt của "reverse" (ngược)---nó bắt đầu tìm từ
cuối chuỗi và đi ngược về.) Mỗi hàm trả về con trỏ tới char đó, hoặc
`NULL` nếu không tìm thấy chữ cái trong chuỗi.

`memchr()` tương tự, chỉ khác là thay vì dừng lại ở ký tự NUL đầu
tiên, nó tiếp tục tìm trong bao nhiêu byte bạn chỉ định.

Khá thẳng thắn.

Một việc bạn có thể làm nếu muốn tìm lần xuất hiện tiếp theo của ký
tự sau khi tìm được lần đầu, là gọi lại hàm với giá trị trả về trước
đó cộng một. (Nhớ số học con trỏ chứ?) Hoặc trừ một nếu bạn tìm
ngược. Đừng lỡ tay đi quá cuối chuỗi!

### Giá trị trả về {.unnumbered .unlisted}

Trả về con trỏ tới nơi xuất hiện của ký tự trong chuỗi, hoặc `NULL`
nếu không tìm thấy ký tự.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <string.h>

int main(void)
{
    // "Hello, world!"
    //       ^  ^   ^
    //       A  B   C

    char *str = "Hello, world!";
    char *p;

    p = strchr(str, ',');       // p giờ trỏ vào vị trí A
    p = strrchr(str, 'o');      // p giờ trỏ vào vị trí B

    p = memchr(str, '!', 13);   // p giờ trỏ vào vị trí C

    // tìm lặp lại tất cả các lần xuất hiện của chữ 'B'
    str = "A BIG BROWN BAT BIT BEEJ";

    for(p = strchr(str, 'B'); p != NULL; p = strchr(p + 1, 'B')) {
        printf("Found a 'B' here: %s\n", p);
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

<!--
### See Also {.unnumbered .unlisted}
-->

[[manbreak]]
## `strspn()`, `strcspn()` {#man-strspn}

[i[`strspn()` function]i]
[i[`strcspn()` function]i]

Trả về độ dài của một chuỗi chỉ gồm một tập các ký tự, hoặc không
thuộc một tập các ký tự

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <string.h>

size_t strspn(char *str, const char *accept);

size_t strcspn(char *str, const char *reject);
```

### Mô tả {.unnumbered .unlisted}

`strspn()` sẽ cho bạn biết độ dài của một chuỗi chỉ gồm toàn bộ các
ký tự trong tập `accept`. Tức là, nó bắt đầu đi dọc `str` cho đến
khi tìm thấy một ký tự _không_ nằm trong tập (nghĩa là một ký tự
không được chấp nhận), rồi trả về độ dài của chuỗi tính đến đó.

`strcspn()` hoạt động tương tự, chỉ khác là nó đi dọc `str` cho tới
khi tìm thấy một ký tự trong tập `reject` (tập loại trừ---nghĩa là
một ký tự cần bị loại bỏ.) Rồi nó trả về độ dài của chuỗi tính đến
đó.

### Giá trị trả về {.unnumbered .unlisted}

Độ dài của chuỗi gồm toàn bộ ký tự trong `accept` (với `strspn()`),
hoặc độ dài của chuỗi gồm toàn bộ ký tự không thuộc `reject` (với
`strcspn()`).

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <string.h>

int main(void)
{
    char str1[] = "a banana";
    char str2[] = "the bolivian navy on maenuvers in the south pacific";
    int n;

    // có bao nhiêu chữ cái trong str1 trước khi gặp thứ không phải nguyên âm?
    n = strspn(str1, "aeiou");
    printf("%d\n", n);  // n == 1, chỉ "a"

    // có bao nhiêu chữ cái trong str1 trước khi gặp thứ không phải a, b,
    // hay khoảng trắng?
    n = strspn(str1, "ab ");
    printf("%d\n", n);  // n == 4, "a ba"

    // có bao nhiêu chữ cái trong str2 trước khi gặp "y"?
    n = strcspn(str2, "y");
    printf("%d\n", n);  // n = 16, "the bolivian nav"
}
```

### Xem thêm {.unnumbered .unlisted}

[`strchr()`](#man-strchr),
[`strrchr()`](#man-strchr)

[[manbreak]]
## `strpbrk()` {#man-strpbrk}

[i[`strpbrk()` function]i]

Tìm trong chuỗi một trong các ký tự của một tập hợp

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <string.h>

// Pre-C23:

char *strpbrk(const char *s1, const char *s2);

// C23:

QChar *strpbrk(QChar *s1, const char *s2);
```

### Mô tả {.unnumbered .unlisted}

Hàm này tìm trong chuỗi `s1` bất kỳ ký tự nào có trong chuỗi `s2`.

Nó giống cách `strchr()` tìm một ký tự cụ thể trong một chuỗi, chỉ
khác là nó sẽ khớp _bất kỳ_ ký tự nào có trong `s2`.

Nghĩ về sức mạnh đó đi!

### Giá trị trả về {.unnumbered .unlisted}

Trả về con trỏ tới ký tự đầu tiên được khớp trong `s1`, hoặc NULL
nếu không tìm thấy.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <string.h>

int main(void)
{
    //  p trỏ vào đây sau strpbrk
    //              v
    char *s1 = "Hello, world!";
    char *s2 = "dow!";  // Khớp bất kỳ ký tự nào trong số này

    char *p = strpbrk(s1, s2);  // p trỏ vào chữ o

    printf("%s\n", p);  // "o, world!"
}
```

### Xem thêm {.unnumbered .unlisted}

[`strchr()`](#man-strchr),
[`memchr()`](#man-strchr)

[[manbreak]]
## `strstr()` {#man-strstr}

[i[`strstr()` function]i]

Tìm một chuỗi trong một chuỗi khác

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <string.h>

// Pre-C23:

char *strstr(const char *str, const char *substr);

// C23:

QChar *strstr(QChar *s1, const char *s2);
```

### Mô tả {.unnumbered .unlisted}

Giả sử bạn có một chuỗi dài loằng ngoằng, và bạn muốn tìm một từ,
hoặc bất kỳ chuỗi con nào khiến bạn thích thú, bên trong chuỗi đầu
tiên. Vậy thì `strstr()` là dành cho bạn! Nó sẽ trả về con trỏ tới
`substr` nằm trong `str`!

### Giá trị trả về {.unnumbered .unlisted}

Bạn nhận lại một con trỏ tới nơi xuất hiện của `substr` bên trong
`str`, hoặc `NULL` nếu không tìm thấy chuỗi con.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <string.h>

int main(void)
{
    char *str = "The quick brown fox jumped over the lazy dogs.";
    char *p;

    p = strstr(str, "lazy");
    printf("%s\n", p == NULL? "null": p); // "lazy dogs."

    // p là NULL sau dòng này, vì chuỗi "wombat" không có trong str:
    p = strstr(str, "wombat");
    printf("%s\n", p == NULL? "null": p); // "null"
}
```

### Xem thêm {.unnumbered .unlisted}

[`strchr()`](#man-strchr),
[`strrchr()`](#man-strchr),
[`strspn()`](#man-strspn),
[`strcspn()`](#man-strspn)

[[manbreak]]
## `strtok()` {#man-strtok}

[i[`strtok()` function]i]

Tách chuỗi thành các token

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <string.h>

char *strtok(char *str, const char *delim);
```

### Mô tả {.unnumbered .unlisted}

Nếu bạn có một chuỗi chứa một đống dấu phân cách, và bạn muốn chia
chuỗi đó thành từng mẩu riêng, hàm này có thể làm việc đó cho bạn.

Cách dùng hơi kỳ kỳ, nhưng ít ra mỗi khi bạn thấy hàm này ngoài đời,
nó đều kỳ một cách nhất quán.

Về cơ bản, lần đầu tiên gọi nó, bạn truyền chuỗi `str` bạn muốn chia
ra làm tham số đầu tiên. Cho mỗi lần gọi tiếp theo để lấy thêm token
từ chuỗi, bạn truyền `NULL`. Hơi kỳ, nhưng `strtok()` ghi nhớ chuỗi
ban đầu bạn đã truyền vào, và tiếp tục lột các token ra cho bạn.

Lưu ý rằng nó làm việc này bằng cách thực sự đặt một null terminator
sau token, rồi trả về con trỏ tới đầu token. Vì vậy chuỗi gốc bạn
truyền vào bị phá huỷ, có thể nói thế. Nếu bạn cần giữ chuỗi nguyên,
hãy chắc chắn truyền một bản sao của nó vào `strtok()` để chuỗi gốc
không bị phá.

### Giá trị trả về {.unnumbered .unlisted}

Con trỏ tới token tiếp theo. Nếu hết token, `NULL` sẽ được trả về.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <string.h>

int main(void)
{
    // chia chuỗi thành một loạt từ được phân tách bởi khoảng trắng
    // hoặc dấu câu
    char str[] = "Where is my bacon, dude?";
    char *token;

    // Lưu ý cái cấu trúc if-do-while sau đây rất rất rất rất rất
    // phổ biến khi dùng strtok().

    // lấy token đầu tiên (nhớ đảm bảo có một token đầu tiên!)
    if ((token = strtok(str, ".,?! ")) != NULL) {
        do {
            printf("Word: \"%s\"\n", token);

            // giờ, điều kiện tiếp tục của while lấy
            // token kế tiếp (bằng cách truyền NULL làm tham số đầu)
            // và tiếp tục nếu token không phải NULL:
        } while ((token = strtok(NULL, ".,?! ")) != NULL);
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

### Xem thêm {.unnumbered .unlisted}

[`strchr()`](#man-strchr),
[`strrchr()`](#man-strchr),
[`strspn()`](#man-strspn),
[`strcspn()`](#man-strspn)


[[manbreak]]
## `memset()`, `memset_explicit {#man-memset}

[i[`memset()` function]i]
[i[`memset_explicit()` function]i]

Đặt một vùng bộ nhớ về một giá trị nhất định

### Synopsis {.unnumbered .unlisted}

`memset_explicit()` là mới trong C23!

``` {.c}
#include <string.h>

void *memset(void *s, int c, size_t n);

void *memset_explicit(void *s, int c, size_t n);
```
### Mô tả {.unnumbered .unlisted}

Hàm này là thứ bạn dùng để đặt một vùng bộ nhớ về một giá trị cụ
thể, cụ thể là `c` được chuyển sang `unsigned char`.

Cách dùng phổ biến nhất là để zero out (đặt về 0) một mảng hoặc một
`struct`.

`memset_explicit()` chỉ khác ở chỗ nó sẽ không bao giờ bị tối ưu hoá
bỏ đi (như `memset()` có thể bị). Ý tưởng là bạn có thể dùng nó để
xoá sạch thông tin nhạy cảm (như mật khẩu) khỏi bộ nhớ trước khi
đám hacker khó ưa nào đó chạm tay vào.

### Giá trị trả về {.unnumbered .unlisted}

`memset()` và `memset_explicit()` trả về đúng cái bạn truyền vào làm
`s` cho tiện vui vẻ.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <string.h>

int main(void)
{
    struct banana {
        float ripeness;
        char *peel_color;
        int grams;
    };

    struct banana b;

    memset(&b, 0, sizeof b);

    printf("%d\n", b.ripeness == 0.0);     // True
    printf("%d\n", b.peel_color == NULL);  // True
    printf("%d\n", b.grams == 0);          // True
}
```

### Xem thêm {.unnumbered .unlisted}

[`memcpy()`](#man-memcpy),
[`memmove()`](#man-memcpy)

[[manbreak]]
## `strerror()` {#man-strerror}

[i[`strerror()` function]i]

Lấy phiên bản chuỗi của một mã lỗi

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <string.h>

char *strerror(int errnum);
```

### Mô tả {.unnumbered .unlisted}

Hàm này gắn rất chặt với `perror()` (hàm in thông báo lỗi dễ đọc
tương ứng với `errno`). Nhưng thay vì in ra, `strerror()` trả về
con trỏ tới chuỗi thông báo lỗi tuỳ theo locale.

Nên nếu bạn vì lý do nào đó cần cái chuỗi đó (ví dụ bạn định
`fprintf()` nó ra file chẳng hạn), hàm này sẽ đưa nó cho bạn. Bạn
chỉ cần truyền `errno` làm đối số. (Nhớ rằng `errno` được set làm
trạng thái lỗi bởi rất nhiều hàm khác nhau.)

Thực ra bạn có thể truyền số nguyên bất kỳ vào `errnum` tuỳ ý. Hàm
sẽ trả về _một_ thông báo nào đó, kể cả khi số đó không ứng với giá
trị `errno` đã biết nào.

Các giá trị của `errno` và các chuỗi được `strerror()` trả về phụ
thuộc vào hệ thống.

### Giá trị trả về {.unnumbered .unlisted}

Một chuỗi thông báo lỗi ứng với mã lỗi cho trước.

Bạn không được phép chỉnh sửa chuỗi được trả về.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <string.h>
#include <errno.h>

int main(void)
{
    FILE *fp = fopen("NONEXISTENT_FILE.TXT", "r");

    if (fp == NULL) {
        char *errmsg = strerror(errno);
        printf("Error %d opening file: %s\n", errno, errmsg);
    }
}
```

Output:

``` {.default}
Error 2 opening file: No such file or directory
```

### Xem thêm {.unnumbered .unlisted}

[`perror()`](#man-perror)

[[manbreak]]
## `strlen()` {#man-strlen}

[i[`strlen()` function]i]

Trả về độ dài của một chuỗi

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <string.h>

size_t strlen(const char *s);
```

### Mô tả {.unnumbered .unlisted}

Hàm này trả về độ dài của chuỗi null-terminated được truyền vào
(không tính ký tự NUL ở cuối). Nó làm điều này bằng cách đi dọc
chuỗi và đếm byte cho tới ký tự NUL, nên nó hơi tốn thời gian một
chút. Nếu bạn phải lấy độ dài của cùng một chuỗi nhiều lần, hãy lưu
nó vào một biến đâu đó.

### Giá trị trả về {.unnumbered .unlisted}

Trả về số byte trong chuỗi. Lưu ý rằng con số này có thể khác với
số ký tự trong một chuỗi multibyte.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <string.h>

int main(void)
{
    char *s = "Hello, world!"; // 13 ký tự

    // in ra "The string is 13 characters long.":

    printf("The string is %zu characters long.\n", strlen(s));
}
```

### Xem thêm {.unnumbered .unlisted}

<!--
[[manbreak]]
## `vprintf()`, `vfprintf()`, `vsprintf()`, `vsnprintf()` {#man-vprintf}

### Synopsis {.unnumbered .unlisted}
### Description {.unnumbered .unlisted}
### Return Value {.unnumbered .unlisted}
### Example {.unnumbered .unlisted}
### See Also {.unnumbered .unlisted}
[`sprintf()`](#man-printf),
-->
