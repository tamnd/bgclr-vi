<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<stdio.h>` Thư Viện I/O Chuẩn {#stdio}

[i[`stdio.h` header file]i]

|Hàm|Mô tả|
|-|-|
|[`clearerr()`](#man-feof)|Xoá cờ trạng thái `feof` và `ferror`|
|[`fclose()`](#man-fclose)|Đóng một file đang mở|
|[`feof()`](#man-feof)|Trả về trạng thái end-of-file (cuối file) của file|
|[`ferror()`](#man-feof)|Trả về trạng thái lỗi của file|
|[`fflush()`](#man-fflush)|Flush (đẩy đệm) toàn bộ output có đệm ra file|
|[`fgetc()`](#man-getc)|Đọc một ký tự từ một file|
|[`fgetpos()`](#man-fgetpos)|Lấy vị trí I/O của file|
|[`fgets()`](#man-gets)|Đọc một dòng từ file|
|[`fopen()`](#man-fopen)|Mở một file|
|[`fprintf()`](#man-printf)|In output có định dạng ra file|
|[`fputc()`](#man-putc)|In một ký tự ra file|
|[`fputs()`](#man-puts)|In một chuỗi ra file|
|[`fread()`](#man-fread)|Đọc dữ liệu nhị phân từ file|
|[`freopen()`](#man-freopen)|Đổi file gắn với một stream|
|[`fscanf()`](#man-scanf)|Đọc input có định dạng từ file|
|[`fseek()`](#man-fseek)|Đặt vị trí I/O của file|
|[`fsetpos()`](#man-fgetpos)|Đặt vị trí I/O của file|
|[`ftell()`](#man-ftell)|Lấy vị trí I/O của file|
|[`fwrite()`](#man-fwrite)|Ghi dữ liệu nhị phân ra file|
|[`getc()`](#man-getc)|Lấy một ký tự từ `stdin`|
|[`getchar()`](#man-getc)|Lấy một ký tự từ `stdin`|
|[`gets()`](#man-gets)|Lấy một chuỗi từ `stdin` (đã bị gỡ bỏ trong C11)|
|[`perror()`](#man-perror)|In một thông báo lỗi dễ đọc cho người dùng|
|[`printf()`](#man-printf)|In output có định dạng ra `stdout`|
|[`putc()`](#man-putc)|In một ký tự ra `stdout`|
|[`putchar()`](#man-putc)|In một ký tự ra `stdout`|
|[`puts()`](#man-puts)|In một chuỗi ra `stdout`|
|[`remove()`](#man-remove)|Xoá một file khỏi đĩa|
|[`rename()`](#man-rename)|Đổi tên hoặc di chuyển một file trên đĩa|
|[`rewind()`](#man-fseek)|Đặt vị trí I/O về đầu file|
|[`scanf()`](#man-scanf)|Đọc input có định dạng từ `stdin`|
|[`setbuf()`](#man-setbuf)|Cấu hình đệm cho các thao tác I/O|
|[`setvbuf()`](#man-setbuf)|Cấu hình đệm cho các thao tác I/O|
|[`snprintf()`](#man-printf)|In output có định dạng ra chuỗi với giới hạn độ dài|
|[`sprintf()`](#man-printf)|In output có định dạng ra chuỗi|
|[`sscanf()`](#man-scanf)|Đọc input có định dạng từ chuỗi|
|[`tmpfile()`](#man-tmpfile)|Tạo một file tạm|
|[`tmpnam()`](#man-tmpnam)|Sinh một tên duy nhất cho file tạm|
|[`ungetc()`](#man-ungetc)|Đẩy ngược một ký tự trở lại input stream|
|[`vfprintf()`](#man-vprintf)|Phiên bản variadic của in output có định dạng ra file|
|[`vfscanf()`](#man-vscanf)|Phiên bản variadic của đọc input có định dạng từ file|
|[`vprintf()`](#man-vprintf)|Phiên bản variadic của in output có định dạng ra `stdout`|
|[`vscanf()`](#man-vscanf)|Phiên bản variadic của đọc input có định dạng từ `stdin`|
|[`vsnprintf()`](#man-vprintf)|Phiên bản variadic của in output có định dạng ra chuỗi với giới hạn độ dài|
|[`vsprintf()`](#man-vprintf)|Phiên bản variadic của in output có định dạng ra chuỗi|
|[`vsscanf()`](#man-vscanf)|Phiên bản variadic của đọc input có định dạng từ chuỗi|

Cơ bản nhất trong tất cả các thư viện của thư viện chuẩn C chính là thư
viện I/O chuẩn. Nó được dùng để đọc và ghi file. Tôi biết bạn đang rất
háo hức chuyện này.

Vậy nên tôi sẽ kể tiếp. Nó cũng được dùng để đọc và ghi ra console, như
chúng ta đã thấy nhiều lần với hàm `printf()`.

(Một bí mật nhỏ ở đây---trong nhiều hệ điều hành, rất nhiều thứ thực ra
sâu bên trong đều là file, và console cũng không phải ngoại lệ.
"_Mọi thứ trong Unix đều là file!_" `:-)`)

Chắc bạn sẽ muốn có prototype của các hàm mình có thể dùng phải không?
Để đặt đôi bàn tay nhỏ xíu bẩn thỉu của bạn lên chúng, bạn cần include
`stdio.h`.

Anyway, chúng ta có thể làm đủ trò hay ho với I/O file. PHÁT HIỆN NÓI
DỐI. Được rồi, được rồi. Chúng ta có thể làm đủ thứ với I/O file. Về
cơ bản, chiến lược như sau:

1. Dùng `fopen()` để lấy một con trỏ đến cấu trúc file kiểu [i[`FILE*`
   type]i] `FILE*`. Con trỏ này là thứ bạn sẽ truyền vào nhiều hàm I/O
   file khác.

2. Dùng một vài hàm file khác, như `fscanf()`, `fgets()`, `fprintf()`,
   v.v. bằng `FILE*` mà `fopen()` trả về.

3. Khi xong, gọi `fclose()` với `FILE*`. Điều này cho hệ điều hành biết
   rằng bạn đã thực sự xong với file, không có take-back nào nữa.

Trong `FILE*` có gì? Như bạn có thể đoán, nó trỏ tới một `struct` chứa
đủ loại thông tin về vị trí đọc ghi hiện tại trong file, file được mở
như thế nào, và những thứ tương tự. Nhưng thành thật mà nói, ai quan
tâm. Không ai cả. Cấu trúc `FILE` là _opaque_ đối với bạn là một lập
trình viên; nghĩa là bạn không cần biết bên trong có gì, và bạn cũng
không _muốn_ biết bên trong có gì. Bạn chỉ cần truyền nó vào các hàm
I/O chuẩn khác và chúng biết phải làm gì.

Thực ra điều này khá quan trọng: cố gắng đừng nghịch ngợm bên trong
cấu trúc `FILE`. Nó thậm chí còn khác nhau giữa các hệ thống, và bạn
sẽ kết cục viết code rất không portable (không di động).

Một điều nữa cần nhắc về thư viện I/O chuẩn: rất nhiều hàm thao tác
trên file dùng tiền tố "f" trong tên hàm. Hàm tương đương thao tác
trên console sẽ bỏ "f" đi. Ví dụ, nếu muốn in ra console bạn dùng
`printf()`, còn nếu muốn in ra file thì dùng `fprintf()`, thấy chưa?

Khoan! Nếu ghi ra console, về cơ bản, giống như ghi ra file vì mọi
thứ trong Unix đều là file, thì tại sao lại có hai hàm? Câu trả lời:
tiện hơn. Nhưng quan trọng hơn, có tồn tại `FILE*` nào gắn với console
mà bạn có thể dùng không? Câu trả lời: CÓ!

Thực tế, có _ba_ (đếm đi!) `FILE*` đặc biệt mà bạn có sẵn chỉ bằng
việc include `stdio.h`. Một cho input, và hai cho output.

Nghe có vẻ không công bằng lắm---sao output lại được hai file, còn
input chỉ có một?

Đừng vội---cứ xem chúng trước đã:

[i[`stdin` standard input]i]
[i[`stdout` standard output]i]
[i[`stderr` standard error]i]

|Stream|Mô tả|
|-|-|
|`stdin`|Input từ console.|
|`stdout`|Output ra console.|
|`stderr`|Output ra console trên file stream lỗi.|

Standard input (`stdin`) mặc định là những gì bạn gõ từ bàn phím. Bạn
có thể dùng nó với `fscanf()` nếu muốn, như thế này:

``` {.c}
/* dòng này: */
scanf("%d", &x);

/* tương đương dòng này: */
fscanf(stdin, "%d", &x);
```

Và `stdout` cũng hoạt động tương tự:

``` {.c}
printf("Hello, world!\n");
fprintf(stdout, "Hello, world!\n"); /* giống dòng trên! */
```

Vậy `stderr` là cái gì? Chuyện gì xảy ra khi bạn output ra đó? Thông
thường nó cũng ra console giống `stdout`, nhưng người ta dùng nó cho
các thông báo lỗi nói riêng. Tại sao? Trên nhiều hệ thống, bạn có thể
redirect output của chương trình vào một file từ dòng lệnh...và đôi
khi bạn chỉ quan tâm tới phần output lỗi thôi. Vậy nên nếu chương
trình ngoan và ghi hết lỗi ra `stderr`, người dùng có thể redirect
chỉ `stderr` vào một file và chỉ xem phần đó. Đó là một điều hay mà
bạn, với tư cách lập trình viên, có thể làm.

Cuối cùng, khá nhiều hàm ở đây trả về `int` trong khi bạn có thể mong
đợi `char`. Đó là vì hàm có thể trả về một ký tự _hoặc_ end-of-file
(`EOF`), và `EOF` có khả năng là một số nguyên. Nếu không nhận được
`EOF` làm giá trị trả về, bạn có thể an toàn lưu kết quả vào một
`char`.

[[manbreak]]

## `remove()` {#man-remove}

[i[`remove()` function]i]

Xoá một file

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>

int remove(const char *filename); 
```

### Mô tả {.unnumbered .unlisted}

Xoá file đã chỉ định khỏi hệ thống tập tin. Đơn giản là xoá. Không có
gì phép thuật. Chỉ cần gọi hàm này và hiến tế một con gà nhỏ, file bạn
yêu cầu sẽ bị xoá.

### Giá trị trả về {.unnumbered .unlisted}

Trả về 0 khi thành công, và `-1` khi lỗi, đồng thời set `errno`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>

int main(void)
{
    char *filename = "evidence.txt";

    remove(filename);
}
```

### Xem thêm {.unnumbered .unlisted}

[`rename()`](#man-rename)

[[manbreak]]
## `rename()` {#man-rename}

[i[`rename()` function]i]

Đổi tên file và tuỳ chọn di chuyển nó sang vị trí mới

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>

int rename(const char *old, const char *new);
```

### Mô tả {.unnumbered .unlisted}

Đổi tên file `old` thành `new`. Dùng hàm này nếu bạn đã chán cái tên
cũ của file và sẵn sàng đổi mới. Đôi khi đổi tên file đơn giản lại
khiến nó cảm giác như mới, và có thể tiết kiệm tiền so với việc mua
toàn bộ file mới!

Một điều hay nữa bạn có thể làm với hàm này là thực sự di chuyển một
file từ thư mục này sang thư mục khác bằng cách chỉ định đường dẫn
khác cho tên mới.

### Giá trị trả về {.unnumbered .unlisted}

Trả về 0 khi thành công, và `-1` khi lỗi, đồng thời set `errno`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>

int main(void)
{
    // Đổi tên một file
    rename("foo", "bar");

    // Đổi tên và chuyển sang thư mục khác:
    rename("/home/beej/evidence.txt", "/tmp/nothing.txt");
}
```

### Xem thêm {.unnumbered .unlisted}

[`remove()`](#man-remove)

[[manbreak]]

## `tmpfile()` {#man-tmpfile}

[i[`tmpfile()` function]i]

Tạo một file tạm

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>

FILE *tmpfile(void);
```

### Mô tả {.unnumbered .unlisted}

Đây là một hàm nho nhỏ tiện lợi, nó sẽ tạo và mở cho bạn một file tạm,
và trả về một `FILE*` để bạn dùng. File được mở ở chế độ "`r+b`", nên
phù hợp để đọc, ghi và dữ liệu nhị phân.

Bằng một chút phép thuật, file tạm sẽ tự động bị xoá khi nó được
`close()` hoặc khi chương trình của bạn kết thúc. (Cụ thể, theo cách
Unix, `tmpfile()`
[fl[_unlinks_|https://man.archlinux.org/man/unlinkat.2.en#DESCRIPTION]]
file ngay sau khi mở. Nghĩa là nó đã được đặt trong trạng thái sẵn
sàng bị xoá khỏi đĩa, nhưng vẫn tồn tại vì tiến trình của bạn vẫn đang
mở nó. Ngay khi tiến trình của bạn kết thúc, mọi file mở đều được đóng
lại, và file tạm biến vào hư không.)

### Giá trị trả về {.unnumbered .unlisted}

Hàm này trả về một `FILE*` đã mở khi thành công, hoặc `NULL` khi thất
bại.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>

int main(void)
{
    FILE *temp;
    char s[128];

    temp = tmpfile();

    fprintf(temp, "What is the frequency, Alexander?\n");

    rewind(temp); // quay về đầu

    fscanf(temp, "%s", s); // đọc lại ra

    fclose(temp); // đóng (và xoá một cách thần kỳ)
}
```

### Xem thêm {.unnumbered .unlisted}

[`fopen()`](#man-fopen),
[`fclose()`](#man-fclose),
[`tmpnam()`](#man-tmpnam)

[[manbreak]]

## `tmpnam()` {#man-tmpnam}

[i[`tmpnam()` function]i]

Sinh một tên duy nhất cho file tạm

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>

char *tmpnam(char *s);
```

### Mô tả {.unnumbered .unlisted}

Hàm này nhìn kỹ các file đang tồn tại trên hệ thống của bạn, rồi nghĩ
ra một cái tên duy nhất cho file mới phù hợp để dùng làm file tạm.

Giả sử bạn có một chương trình cần lưu dữ liệu trong thời gian ngắn,
nên bạn tạo một file tạm cho dữ liệu đó, sẽ bị xoá khi chương trình
kết thúc. Giờ tưởng tượng bạn đặt tên file này là `foo.txt`. Tất cả
đều ổn, cho đến khi người dùng đã có một file tên `foo.txt` ở thư mục
bạn đang chạy chương trình. Bạn sẽ ghi đè file của họ, họ sẽ không vui
và stalk bạn mãi mãi. Và bạn chắc không muốn thế đúng không?

Ok, nên bạn khôn ra và quyết định đặt file vào `/tmp` để không ghi đè
nội dung quan trọng nào. Nhưng khoan! Lỡ có người khác đang chạy
chương trình cùng lúc và cả hai muốn dùng cùng một tên file thì sao?
Hoặc lỡ có chương trình khác đã tạo sẵn file đó?

Thấy chưa, tất cả những vấn đề đáng sợ này có thể tránh hoàn toàn nếu
bạn dùng `tmpnam()` để lấy một tên file an toàn sẵn dùng.

Vậy dùng nó thế nào? Có hai cách tuyệt vời. Một, bạn khai báo một
mảng (hoặc `malloc()` nó---sao cũng được) đủ lớn để chứa tên file tạm.
Lớn bao nhiêu? May thay, đã có một macro sẵn dành cho bạn, `L_tmpnam`,
cho biết mảng phải lớn bao nhiêu.

Và cách thứ hai: chỉ cần truyền `NULL` cho tên file. `tmpnam()` sẽ lưu
tên tạm trong một mảng tĩnh và trả về con trỏ đến đó. Những lần gọi
sau với tham số `NULL` sẽ ghi đè mảng tĩnh, nên hãy chắc là bạn đã
dùng xong trước khi gọi `tmpnam()` lần nữa.

Một lần nữa, hàm này chỉ tạo tên file cho bạn. Việc tự `fopen()` file
và dùng nó là tuỳ bạn.

Một lưu ý nữa: một số compiler cảnh báo không nên dùng `tmpnam()` vì
có hệ thống có hàm tốt hơn (như hàm `mkstemp()` trên Unix). Bạn có
thể xem tài liệu local để tìm tuỳ chọn tốt hơn. Tài liệu Linux thậm
chí còn nói, "Đừng bao giờ dùng hàm này. Dùng `mkstemp()` thay thế."

Tuy nhiên, tôi sẽ làm kẻ khó chịu và không nói về
[flm[`mkstemp()`|mkstemp.3.en]] vì nó không nằm trong chuẩn mà tôi
đang viết. Nyaah.

Macro `TMP_MAX` chứa số lượng tên file duy nhất có thể được `tmpnam()`
sinh ra. Trớ trêu thay, đó là số _tối thiểu_ các tên đó.

### Giá trị trả về {.unnumbered .unlisted}

Trả về con trỏ đến tên file tạm. Đây có thể là con trỏ đến chuỗi bạn
truyền vào, hoặc con trỏ đến vùng nhớ tĩnh nội bộ nếu bạn truyền
`NULL`. Khi lỗi (ví dụ không tìm được tên tạm duy nhất nào), `tmpnam()`
trả về `NULL`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>

int main(void)
{
    char filename[L_tmpnam];
    char *another_filename;

    if (tmpnam(filename) != NULL)
        printf("We got a temp file name: \"%s\"\n", filename);
    else
        printf("Something went wrong, and we got nothing!\n");

    another_filename = tmpnam(NULL);

    printf("We got another temp file name: \"%s\"\n", another_filename);
    printf("And we didn't error check it because we're too lazy!\n");
}

```

Trên hệ Linux của tôi, chương trình này cho ra output sau:

```
We got a temp file name: "/tmp/filew9PMuZ"
We got another temp file name: "/tmp/fileOwrgPO"
And we didn't error check it because we're too lazy!
```
    

### Xem thêm {.unnumbered .unlisted}

[`fopen()`](#man-fopen),
[`tmpfile()`](#man-tmpfile)

[[manbreak]]

## `fclose()` {#man-fclose}

[i[`fclose()` function]i]

Ngược với `fopen()`---đóng một file khi bạn xong với nó để giải phóng
tài nguyên hệ thống

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>

int fclose(FILE *stream);
```

### Mô tả {.unnumbered .unlisted}

Khi bạn mở một file, hệ thống dành ra một ít tài nguyên để duy trì
thông tin về file đang mở đó. Thường chỉ có thể mở đến một giới hạn
số file cùng lúc. Dù sao, Việc Đúng Đắn là đóng file khi bạn xong dùng
để tài nguyên hệ thống được giải phóng.

Ngoài ra, có thể bạn sẽ thấy rằng không phải mọi thông tin bạn đã ghi
vào file đã thực sự được ghi xuống đĩa cho đến khi file được đóng.
(Bạn có thể ép chuyện này bằng cách gọi `fflush()`.)

Khi chương trình của bạn thoát bình thường, nó sẽ đóng tất cả file
đang mở hộ bạn. Nhiều khi, bạn có chương trình chạy dài, và tốt hơn
là đóng file trước đó. Dù sao, không đóng file bạn đã mở khiến bạn
trông tệ hại. Vậy nên nhớ `fclose()` file khi bạn xong dùng nó!

### Giá trị trả về {.unnumbered .unlisted}

Khi thành công, trả về `0`. Thường không ai kiểm tra cái này. Khi lỗi
trả về `EOF`. Thường cũng không ai kiểm tra.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>

int main(void)
{
    FILE *fp;

    fp = fopen("spoon.txt", "r");

    if (fp == NULL) {
        printf("Error opening file\n");
    } else {
        printf("Opened file just fine!\n");
        fclose(fp);  // Xong hết!
    }
}
```

### Xem thêm {.unnumbered .unlisted}

[`fopen()`](#man-fopen)

[[manbreak]]

## `fflush()` {#man-fflush}

[i[`fflush()` function]i]

Xử lý toàn bộ I/O có đệm của một stream ngay bây giờ

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>

int fflush(FILE *stream);
```

### Mô tả {.unnumbered .unlisted}

Khi bạn làm I/O chuẩn, như đã nhắc trong phần về hàm
[`setvbuf()`](#man-setbuf), dữ liệu thường được lưu trong buffer cho
đến khi nhập xong một dòng, hoặc buffer đầy, hoặc file được đóng. Đôi
khi, bạn thực sự muốn output xảy ra _ngay giây này_, không chờ trong
buffer. Bạn có thể ép điều đó bằng cách gọi `fflush()`.

Lợi ích của việc buffered (có đệm) là OS không cần chạm đĩa mỗi lần
bạn gọi `fprintf()`. Nhược điểm là nếu bạn nhìn vào file trên đĩa sau
khi gọi `fprintf()`, có thể nó vẫn chưa được ghi ra thực sự. ("Tôi gọi
`fputs()`, nhưng file vẫn dài 0 byte! Sao thế?!") Trong hầu hết mọi
tình huống, lợi ích của đệm lớn hơn nhược điểm; với những tình huống
còn lại, dùng `fflush()`.

Lưu ý rằng theo spec, `fflush()` chỉ được thiết kế để dùng trên
output stream. Chuyện gì xảy ra nếu bạn thử nó trên input stream?
Dùng giọng rùng rợn nào: _có trờiiiii mà biếếếếết!_

### Giá trị trả về {.unnumbered .unlisted}

Khi thành công, `fflush()` trả về 0. Nếu có lỗi, nó trả về `EOF` và
đặt điều kiện lỗi cho stream (xem [`ferror()`](#man-feof)).

### Ví dụ {.unnumbered .unlisted}

Trong ví dụ này, chúng ta sẽ dùng carriage return, `'\r'`. Nó giống
newline (xuống dòng) (`'\n'`), chỉ khác là không chuyển sang dòng kế.
Nó chỉ quay về đầu dòng hiện tại.

Điều chúng ta định làm là một thanh trạng thái văn bản nho nhỏ như
nhiều chương trình dòng lệnh vẫn dùng. Nó sẽ đếm ngược từ 10 xuống 0,
in đè lên cùng một dòng.

Điểm mấu chốt là gì, và nó liên quan tới `fflush()` ra sao? Mấu chốt
là terminal rất có khả năng đang "line buffered" (đệm theo dòng) (xem
mục [`setvbuf()`](#man-setbuf) để biết thêm), nghĩa là nó sẽ không
hiển thị gì cho đến khi in ra newline. Nhưng chúng ta không in newline;
chỉ in carriage return, nên cần một cách để ép output xảy ra dù vẫn
đang ở cùng một dòng. Đúng vậy, `fflush()!`

``` {.c .numberLines}
#include <stdio.h>
#include <threads.h>

void sleep_seconds(int s)
{
    thrd_sleep(&(struct timespec){.tv_sec=s}, NULL);
}

int main(void)
{
    int count;

    for(count = 10; count >= 0; count--) {
        printf("\rSeconds until launch: ");  // mở đầu bằng CR
        if (count > 0)
            printf("%2d", count);
        else
            printf("blastoff!\n");

        // ép output ngay!!
        fflush(stdout);

        sleep_seconds(1);
    }
}
```

### Xem thêm {.unnumbered .unlisted}

[`setbuf()`](#man-setbuf),
[`setvbuf()`](#man-setbuf)

[[manbreak]]

## `fopen()` {#man-fopen}

[i[`fopen()` function]i]

Mở một file để đọc hoặc ghi

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>

FILE *fopen(const char *path, const char *mode);
```

### Mô tả {.unnumbered .unlisted}

`fopen()` mở một file để đọc hoặc ghi.

Tham số `path` có thể là đường dẫn tương đối hoặc đường dẫn đầy đủ
kèm tên file.

Tham số `mode` báo cho `fopen()` cách mở file (đọc, ghi, hay cả hai)
và có phải file nhị phân không. Các mode khả dụng:

|Mode|Mô tả|
|-|-|
|`r`|Mở file để đọc (chỉ đọc).|
|`w`|Mở file để ghi (chỉ ghi). File sẽ được tạo nếu chưa tồn tại.|
|`r+`|Mở file để đọc và ghi. File phải đã tồn tại.|
|`w+`|Mở file để ghi và đọc. File sẽ được tạo nếu chưa tồn tại.|
|`a`|Mở file để append (ghi thêm vào cuối). Giống mở để ghi, nhưng đặt file pointer ở cuối file, nên lần ghi kế sẽ nối vào cuối. File sẽ được tạo nếu chưa tồn tại.|
|`a+`|Mở file để đọc và append. File sẽ được tạo nếu chưa tồn tại.|

Bất kỳ mode nào cũng có thể thêm chữ "`b`" ở cuối, như "`wb`" ("write
binary"), để báo rằng file đó là file _binary_ (chế độ nhị phân).
("Binary" ở đây thường nghĩa là file chứa các ký tự phi chữ số trông
giống rác đối với mắt người). Nhiều hệ thống (như Unix) không phân
biệt giữa file nhị phân và không nhị phân, nên "`b`" là thừa. Nhưng
nếu dữ liệu là binary, thêm "`b`" cũng không hại, và có thể giúp người
khác khi port code của bạn sang hệ thống khác.

Macro `FOPEN_MAX` cho biết (ít nhất) có thể mở bao nhiêu stream cùng
lúc.

Macro `FILENAME_MAX` cho biết tên file hợp lệ có thể dài nhất bao
nhiêu. Đừng làm quá nhé.

### Giá trị trả về {.unnumbered .unlisted}

`fopen()` trả về một `FILE*` có thể dùng trong các lời gọi liên quan
tới file sau đó.

Nếu có chuyện gì không ổn (ví dụ bạn thử mở để đọc một file không tồn
tại), `fopen()` sẽ trả về `NULL`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>

int main(void)
{
    FILE *fp;

    fp = fopen("spoon.txt", "r");

    if (fp == NULL) {
        printf("Error opening file\n");
    } else {
        printf("Opened file just fine!\n");
        fclose(fp);  // Xong hết!
    }
}
```

### Xem thêm {.unnumbered .unlisted}

[`fclose()`](#man-fclose),
[`freopen()`](#man-freopen)

[[manbreak]]

## `freopen()` {#man-freopen}

[i[`freopen()` function]i]

Mở lại một `FILE*` đã có, gắn nó với một đường dẫn mới

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>

FILE *freopen(const char *filename, const char *mode, FILE *stream);
```

### Mô tả {.unnumbered .unlisted}

Giả sử bạn có một `FILE*` stream đã mở, nhưng đột nhiên muốn nó dùng
một file khác thay vì file đang dùng. Bạn có thể dùng `freopen()` để
"re-open" stream với một file mới.

Vì sao trên đời bạn lại muốn làm thế? Lý do phổ biến nhất là nếu bạn
có chương trình thường đọc từ `stdin`, nhưng bạn muốn nó đọc từ một
file. Thay vì đổi mọi `scanf()` sang `fscanf()`, bạn có thể đơn giản
reopen `stdin` trên file mà bạn muốn đọc.

Một cách dùng khác được một số hệ thống cho phép là truyền `NULL` cho
`filename` và chỉ định `mode` mới cho `stream`. Vậy bạn có thể đổi
file từ "`r+`" (đọc và ghi) thành chỉ "`r`" (đọc), chẳng hạn. Việc
mode nào có thể đổi là tuỳ cài đặt.

Khi bạn gọi `freopen()`, `stream` cũ sẽ bị đóng. Ngoài ra, hàm hoạt
động y hệt `fopen()` chuẩn.

### Giá trị trả về {.unnumbered .unlisted}

`freopen()` trả về `stream` nếu mọi thứ ổn.

Nếu có chuyện gì không ổn (ví dụ bạn thử mở để đọc một file không tồn
tại), `freopen()` sẽ trả về `NULL`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>

int main(void)
{
    int i, i2;

    scanf("%d", &i); // đọc i từ stdin

    // giờ đổi stdin để trỏ đến file thay vì bàn phím
    freopen("someints.txt", "r", stdin);

    scanf("%d", &i2); // lần này đọc từ file "someints.txt"

    printf("Hello, world!\n"); // in ra màn hình

    // đổi stdout để đi ra file thay vì terminal:
    freopen("output.txt", "w", stdout);

    printf("This goes to the file \"output.txt\"\n");

    // được phép trên một số hệ thống--có thể đổi mode của file:
    freopen(NULL, "wb", stdout); // đổi sang "wb" thay vì "w"
}
```

### Xem thêm {.unnumbered .unlisted}

[`fclose()`](#man-fclose),
[`fopen()`](#man-fopen)

[[manbreak]]

## `setbuf()`, `setvbuf()` {#man-setbuf}

[i[`setbuf()` function]i]

Cấu hình đệm cho các thao tác I/O chuẩn

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>

void setbuf(FILE *stream, char *buf);

int setvbuf(FILE *stream, char *buf, int mode, size_t size);
```

### Mô tả {.unnumbered .unlisted}

Bình tĩnh đi vì điều sắp nói có thể hơi bất ngờ: khi bạn `printf()`
hoặc `fprintf()` hoặc dùng bất kỳ hàm I/O kiểu như thế, _thường nó
không chạy ngay lập tức_. Vì hiệu năng, và để làm bạn bực mình, I/O
trên một `FILE*` stream được buffered (có đệm) cất an toàn cho đến
khi thoả mãn điều kiện nhất định, và chỉ lúc đó I/O thực sự mới được
thực hiện. Các hàm `setbuf()` và `setvbuf()` cho phép bạn đổi những
điều kiện đó và hành vi đệm.

Vậy có những kiểu hành vi đệm nào? Lớn nhất là "full buffering" (đệm
đầy đủ), khi đó toàn bộ I/O được lưu trong buffer lớn đến khi đầy,
rồi mới đổ ra đĩa (hoặc bất kỳ file nào). Kế tiếp là "line buffering"
(đệm theo dòng); với line buffering, I/O được gom từng dòng một (đến
khi gặp ký tự newline (`'\n'`)) rồi dòng đó mới được xử lý. Cuối cùng
là "unbuffered" (không đệm), nghĩa là I/O được xử lý ngay lập tức với
mỗi lời gọi I/O chuẩn.

Có thể bạn từng thấy và thắc mắc vì sao gọi `putchar()` hết lần này
đến lần khác mà không thấy output nào cho đến khi gọi `putchar('\n')`;
đúng rồi---`stdout` là line-buffered!

Vì `setbuf()` chỉ là phiên bản đơn giản hoá của `setvbuf()`, chúng ta
sẽ nói về `setvbuf()` trước.

`stream` là `FILE*` bạn muốn chỉnh. Chuẩn nói rằng bạn _phải_ gọi
`setvbuf()` _trước_ khi bất kỳ thao tác I/O nào được thực hiện trên
stream, không thì đến lúc đó đã quá muộn.

Tham số tiếp theo, `buf`, cho phép bạn tự làm vùng buffer (dùng
[`malloc()`](#man-malloc) hoặc chỉ một mảng `char`) để dùng cho đệm.
Nếu không quan tâm, cứ đặt `buf` là `NULL`.

Giờ đến phần quan trọng của hàm: `mode` cho phép bạn chọn loại đệm
muốn dùng trên `stream` này. Đặt là một trong các giá trị sau:

|Mode|Mô tả|
|-|-|
|`_IOFBF`|`stream` sẽ được đệm đầy đủ (full buffered).|
|`_IOLBF`|`stream` sẽ được đệm theo dòng (line buffered).|
|`_IONBF`|`stream` sẽ không có đệm (unbuffered).|

Cuối cùng, tham số `size` là kích thước mảng bạn truyền vào cho
`buf`...trừ khi bạn truyền `NULL` cho `buf`, trong trường hợp đó nó
sẽ resize buffer hiện có thành kích thước bạn chỉ định.

Còn hàm "hạng nhỏ" `setbuf()` thì sao? Nó chỉ như gọi `setvbuf()` với
các tham số nhất định, chỉ khác là `setbuf()` không trả về giá trị.
Ví dụ sau cho thấy tính tương đương:

``` {.c}
// hai dòng này tương đương:
setbuf(stream, buf);
setvbuf(stream, buf, _IOFBF, BUFSIZ); // đệm đầy đủ

// và hai dòng này tương đương:
setbuf(stream, NULL);
setvbuf(stream, NULL, _IONBF, BUFSIZ); // không đệm
```

### Giá trị trả về {.unnumbered .unlisted}

`setvbuf()` trả về 0 khi thành công, và khác 0 khi thất bại.
`setbuf()` không có giá trị trả về.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>

int main(void)
{
    FILE *fp;
    char lineBuf[1024];

    fp = fopen("somefile.txt", "w");
    setvbuf(fp, lineBuf, _IOLBF, 1024);  // đặt đệm theo dòng
    fprintf(fp, "You won't see this in the file yet. ");
    fprintf(fp, "But now you will because of this newline.\n");
    fclose(fp);

    fp = fopen("anotherfile.txt", "w");
    setbuf(fp, NULL); // đặt không đệm
    fprintf(fp, "You will see this in the file now.");
    fclose(fp);
}
```

### Xem thêm {.unnumbered .unlisted}

[`fflush()`](#man-fflush)

[[manbreak]]

## `printf()`, `fprintf()`, `sprintf()`, `snprintf()` {#man-printf}

[i[`printf()` function]i]
[i[`fprintf()` function]i]
[i[`sprintf()` function]i]
[i[`snprintf()` function]i]

In một chuỗi có định dạng ra console hoặc ra file

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>

int printf(const char *format, ...);

int fprintf(FILE *stream, const char *format, ...);

int sprintf(char * restrict s, const char * restrict format, ...);

int snprintf(char * restrict s, size_t n, const char * restrict format, ...);
```

### Mô tả {.unnumbered .unlisted}

Các hàm này in output có định dạng ra nhiều đích khác nhau.

|Hàm|Đích output|
|-|-|
|`printf()`|In ra console (mặc định thường là màn hình).|
|`fprintf()`|In ra một file.|
|`sprintf()`|In ra một chuỗi.|
|`snprintf()`|In ra một chuỗi (an toàn).|

Khác biệt duy nhất giữa chúng là các tham số đứng trước chuỗi `format`
mà bạn truyền vào.

|Hàm|Thứ bạn truyền trước `format`|
|-|-|
|`printf()`|Không có gì đứng trước `format`.|
|`fprintf()`|Truyền vào `FILE*`.|
|`sprintf()`|Truyền vào `char*` đến buffer để in vào.|
|`snprintf()`|Truyền vào `char*` đến buffer và độ dài buffer tối đa.|

Hàm `printf()` là huyền thoại về sự linh hoạt, một trong những hệ
thống xuất có khả năng tùy biến nhất từng được nghĩ ra. Nó cũng có
thể hơi ma quái đôi chỗ, rõ nhất là ở chuỗi `format`. Ta sẽ đi từng
bước.

Cách dễ nhất nhìn vào chuỗi format là: nó sẽ in mọi thứ trong chuỗi
như nguyên bản, _trừ khi_ một ký tự có dấu phần trăm (`%`) đứng
trước. Đó là lúc phép thuật xảy ra: tham số kế tiếp trong danh sách
tham số của `printf()` sẽ được in theo cách mô tả bởi mã phần trăm.
Những mã phần trăm này gọi là _format specifiers_ (bộ chỉ định định
dạng).

Đây là những format specifier phổ biến nhất.

|Specifier|Mô tả|
|:--:|--------------------------|
|`%d`|In tham số kế tiếp dưới dạng số thập phân có dấu, như `3490`. Tham số in theo cách này phải là `int`, hoặc thứ được promote lên `int`.|
|`%f`|In tham số kế tiếp dưới dạng số thực có dấu, như `3.14159`. Tham số in theo cách này phải là `double`, hoặc thứ được promote lên `double`.|
|`%c`|In tham số kế tiếp như một ký tự, như `'B'`. Tham số in theo cách này phải là biến thể của `char`.|
|`%s`|In tham số kế tiếp như một chuỗi, như `"Did you remember your mittens?"`. Tham số in theo cách này phải là `char*` hoặc `char[]`.|
|`%%`|Không có tham số nào được chuyển đổi, in một dấu phần trăm bình thường. Đây là cách in ký tự '%' bằng `printf()`.|

Đó là phần cơ bản. Tôi sẽ cho bạn thêm format specifier lát nữa,
nhưng trước hết hãy lấy thêm bề rộng. Thực ra còn rất nhiều thứ bạn
có thể chỉ định sau dấu phần trăm.

Một điều, bạn có thể đặt field width (độ rộng trường) trong đó---đây
là con số cho `printf()` biết để bao nhiêu khoảng trắng vào một bên
hoặc bên kia của giá trị bạn đang in. Giúp bạn xếp thành cột đẹp đẽ.
Nếu số này âm, kết quả được canh trái thay vì canh phải. Ví dụ:

``` {.c}
printf("%10d", x);  /* in X ở phía phải của trường 10 khoảng trắng */
printf("%-10d", x); /* in X ở phía trái của trường 10 khoảng trắng */
```

Nếu bạn không biết trước field width, bạn có thể dùng kung-foo nhỏ để
lấy nó từ danh sách tham số ngay trước tham số cần in. Làm bằng cách
đặt ghế và bàn ăn ở vị trí thẳng đứng. Dây an toàn được cài bằng
cách---_*ho khụ*_. Có vẻ tôi đã bay quá nhiều gần đây. Bỏ qua sự thật
vô dụng đó hoàn toàn, bạn có thể chỉ định field width động bằng cách
đặt `*` thay cho width. Nếu bạn không sẵn sàng hoặc không thể thực
hiện tác vụ này, vui lòng báo tiếp viên và chúng tôi sẽ xếp lại chỗ
cho bạn.

``` {.c}
int width = 12;
int value = 3490;

printf("%*d\n", width, value);
```

Bạn cũng có thể đặt "0" trước con số nếu muốn nó được pad bằng số 0:

``` {.c}
int x = 17;
printf("%05d", x);  /* "00017" */
```

Với số thực, bạn cũng có thể chỉ định muốn in bao nhiêu chữ số thập
phân bằng một field width dạng "`x.y`" trong đó `x` là field width
(bạn có thể bỏ qua nếu muốn nó chỉ đủ rộng) và `y` là số chữ số sau
dấu thập phân cần in:

``` {.c}
float f = 3.1415926535;

printf("%.2f", f);  /* "3.14" */
printf("%7.3f", f); /* "  3.141" <-- 7 khoảng trắng ngang qua */
```

Ok, các phần trên chắc chắn là cách dùng `printf()` phổ biến nhất,
nhưng hãy lấy _full coverage_ nào.

#### Bố cục Format Specifier

Về mặt kỹ thuật, bố cục của format specifier gồm các phần sau theo
thứ tự này:

1. `%`, theo sau bởi...
2. Tuỳ chọn: không hoặc nhiều flag, canh trái, pad bằng số 0, v.v.
3. Tuỳ chọn: Field width, độ rộng của trường output.
4. Tuỳ chọn: Precision (độ chính xác), hay bao nhiêu chữ số thập
   phân cần in.
5. Tuỳ chọn: Length modifier, cho việc in những thứ lớn hơn `int`
   hoặc `double`.
6. Conversion specifier (chỉ định chuyển đổi), như `d`, `f`, v.v.

Tóm lại, toàn bộ format specifier được xếp như thế này:

```
%[flags][fieldwidth][.precision][lengthmodifier]conversionspecifier
```

Còn gì dễ hơn?

#### Conversion Specifier

Hãy nói về conversion specifier trước. Mỗi cái sau đây chỉ định kiểu
có thể in, nhưng cũng có thể in bất cứ thứ gì được promote lên kiểu
đó. Ví dụ, `%d` có thể in `int`, `short`, và `char`.

Specifier nhị phân là mới trong C23!

|Conversion Specifier|Mô tả|
|:--:|--------------------------|
|`d`|In tham số `int` dưới dạng số thập phân.|
|`i`|Giống hệt `d`.|
|`b`|In `unsigned int` dưới dạng nhị phân (cơ số 2).|
|`B`|Giống hệt `b`, trừ dạng thay thế (alternate form), xem dưới.|
|`o`|In `unsigned int` dưới dạng bát phân (cơ số 8).|
|`u`|In `unsigned int` dưới dạng thập phân.|
|`x`|In `unsigned int` dưới dạng hex với chữ cái thường.|
|`X`|In `unsigned int` dưới dạng hex với chữ cái hoa; cũng chú ý dạng thay thế, xem dưới.|
|`f`|In `double` dưới dạng thập phân. Vô cực được in là `infinity` hoặc `inf`, và NaN được in là `nan`, bất kỳ cái nào cũng có thể có dấu trừ đứng đầu.|
|`F`|Giống `f`, nhưng in `INFINITY`, `INF`, hoặc `NAN` toàn chữ hoa.|
|`e`|In số theo ký hiệu khoa học, ví dụ `1.234e56`. Xử lý vô cực và NaN như `f`.|
|`E`|Giống `e`, nhưng in số mũ `E` (và vô cực và NaN) bằng chữ hoa.|
|`g`|In số nhỏ như `f` và số lớn như `e`. Xem lưu ý dưới.|
|`G`|In số nhỏ như `F` và số lớn như `E`. Xem lưu ý dưới.|
|`a`|In `double` dưới dạng hex `0xh.hhhhpd` trong đó `h` là chữ số hex thường và `d` là số mũ thập phân của 2. Vô cực và NaN dạng như `f`. Xem thêm bên dưới.|
|`A`|Giống `a` nhưng mọi thứ viết hoa.|
|`c`|Chuyển tham số `int` sang `unsigned char` và in dưới dạng ký tự.|
|`s`|In chuỗi bắt đầu từ `char*` đã cho.|
|`p`|In một `void*` dưới dạng số, chắc là địa chỉ số, có thể ở dạng hex.|
|`n`|Lưu số ký tự đã ghi tính đến giờ vào `int*` đã cho. Không in gì. Xem dưới.|
|`%`|In dấu phần trăm literal.|

##### Lưu ý về `%a` và `%A`

Khi in số thực dạng hex, có một chữ số trước dấu thập phân, và phần
còn lại tính đến precision.

``` {.c}
double pi = 3.14159265358979;

printf("%.3a\n", pi);  // 0x1.922p+1
```

C có thể chọn chữ số đầu sao cho các chữ số tiếp theo canh theo ranh
giới 4-bit.

Nếu precision bị bỏ qua và macro `FLT_RADIX` là luỹ thừa của 2, đủ
precision sẽ được dùng để biểu diễn số chính xác. Nếu `FLT_RADIX`
không phải luỹ thừa của 2, đủ precision được dùng để có thể phân
biệt bất kỳ hai giá trị floating nào.

Nếu precision là `0` và flag `#` không được chỉ định, dấu thập phân
được bỏ đi.

##### Lưu ý về `%g` và `%G`

Ý nghĩa chung là dùng ký hiệu khoa học khi số trở nên quá "extreme",
và dùng ký hiệu thập phân thường trong các trường hợp khác.

Hành vi chính xác về việc in như `%f` hay `%e` phụ thuộc vào vài yếu
tố:

Nếu số mũ lớn hơn hoặc bằng -4 **và** precision lớn hơn số mũ, chúng
ta dùng `%f`. Trong trường hợp này, precision được chuyển theo $p=p-(x+1)$,
trong đó $p$ là precision đã chỉ định và $x$ là số mũ.

Ngược lại chúng ta dùng `%e`, và precision trở thành $p-1$.

Các số 0 ở cuối phần thập phân bị xoá. Và nếu không còn cái nào, dấu
thập phân cũng bị xoá luôn. Tất cả những điều này trừ khi flag `#`
được chỉ định.

##### Lưu ý về `%n`

Specifier này ngầu và khác biệt, và hiếm khi cần. Nó thực ra không
in gì, nhưng lưu số ký tự đã in tính đến lúc đó vào tham số pointer
(con trỏ) kế tiếp trong danh sách.

``` {.c}
int numChars;
float a = 3.14159;
int b = 3490;

printf("%f %d%n\n", a, b, &numChars);
printf("The above line contains %d characters.\n", numChars);
```

Ví dụ trên sẽ in các giá trị `a` và `b`, rồi lưu số ký tự đã in đến
lúc đó vào biến `numChars`. Lời gọi `printf()` kế in kết quả đó.

``` {.default}
3.141590 3490
The above line contains 13 characters
```

#### Length Modifier

Bạn có thể dán _length_ modifier trước mỗi conversion specifier, nếu
muốn. Phần lớn các format specifier hoạt động với kiểu `int` hoặc
`double`, nhưng nếu bạn muốn kiểu lớn hơn hay nhỏ hơn thì sao? Đó là
lúc mấy cái này có ích.

Ví dụ, bạn có thể in `long long int` với modifier `ll`:

``` {.c}
long long int x = 3490;

printf("%lld\n", x);  // 3490
```

|Length Modifier|Conversion Specifier|Mô tả|
|:--:|:-----:|------------------|
|`hh`|`b`, `d`, `i`, `o`, `u`, `x`, `X`|Chuyển tham số sang `char` (signed hoặc unsigned tuỳ ngữ cảnh) trước khi in.|
|`h`|`b`, `d`, `i`, `o`, `u`, `x`, `X`|Chuyển tham số sang `short int` (signed hoặc unsigned tuỳ ngữ cảnh) trước khi in.|
|`l`|`b`, `d`, `i`, `o`, `u`, `x`, `X`|Tham số là `long int` (signed hoặc unsigned tuỳ ngữ cảnh).|
|`ll`|`b`, `d`, `i`, `o`, `u`, `x`, `X`|Tham số là `long long int` (signed hoặc unsigned tuỳ ngữ cảnh).|
|`j`|`b`, `d`, `i`, `o`, `u`, `x`, `X`|Tham số là `intmax_t` hoặc `uintmax_t` (tuỳ ngữ cảnh).|
|`z`|`b`, `d`, `i`, `o`, `u`, `x`, `X`|Tham số là `size_t`.|
|`t`|`b`, `d`, `i`, `o`, `u`, `x`, `X`|Tham số là `ptrdiff_t`.|
|`L`|`a`, `A`, `e`, `E`, `f`, `F`, `g`, `G`|Tham số là `long double`.|
|`l`|`c`|Tham số nằm trong `wint_t`, một wide character (ký tự rộng).|
|`l`|`s`|Tham số nằm trong `wchar_t*`, một chuỗi wide character.|
|`hh`|`n`|Lưu kết quả vào tham số `signed char*`.|
|`h`|`n`|Lưu kết quả vào tham số `short int*`.|
|`l`|`n`|Lưu kết quả vào tham số `long int*`.|
|`ll`|`n`|Lưu kết quả vào tham số `long long int*`.|
|`j`|`n`|Lưu kết quả vào tham số `intmax_t*`.|
|`z`|`n`|Lưu kết quả vào tham số `size_t*`.|
|`t`|`n`|Lưu kết quả vào tham số `ptrdiff_t*`.|

#### Precision

Trước length modifier, bạn có thể đặt precision (độ chính xác), mà
thường có nghĩa là bạn muốn bao nhiêu chữ số thập phân cho số thực.

Để làm điều này, bạn đặt dấu chấm (`.`) và số chữ số thập phân sau đó.

Ví dụ, chúng ta có thể in π làm tròn hai chữ số thập phân như sau:

``` {.c}
double pi = 3.14159265358979;

printf("%.2f\n", pi);  // 3.14
```

|Conversion Specifier|Ý nghĩa giá trị Precision|
|:-------:|---------------------|
|`b`, `d`, `i`, `o`, `u`, `x`, `X`|Với kiểu số nguyên, số chữ số tối thiểu (sẽ pad bằng số 0 đầu)|
|`a`, `e`, `f`, `A`, `E`, `F`|Với kiểu số thực, precision là số chữ số sau dấu thập phân.|
|`g`, `G`|Với kiểu số thực, precision là số chữ số có nghĩa được in.|
|`s`|Số byte tối đa (không phải ký tự multibyte (đa byte)!) được ghi.|

Nếu không có số nào sau dấu thập phân trong precision, precision là 0.

Nếu `*` được chỉ định sau dấu thập phân, điều kỳ diệu xảy ra! Nó có
nghĩa là tham số `int` truyền vào `printf()` ngay trước số cần in
chứa precision. Bạn có thể dùng cái này nếu không biết precision lúc
compile.

``` {.c}
int precision;
double pi = 3.14159265358979;

printf("Enter precision: "); fflush(stdout);
scanf("%d", &precision);

printf("%.*f\n", precision, pi);
```

Kết quả:

``` {.default}
Enter precision: 4
3.1416
```

#### Field Width

Trước precision tuỳ chọn, bạn có thể chỉ định field width (độ rộng
trường). Đây là số thập phân chỉ ra vùng in tham số nên rộng bao
nhiêu. Vùng đó sẽ được pad bằng khoảng trắng đầu (hoặc cuối) để đảm
bảo đủ rộng.

Nếu field width chỉ định quá nhỏ để chứa output, nó bị bỏ qua.

Xem trước, bạn có thể cho field width âm để canh hướng khác.

Hãy in một số trong trường rộng 10. Chúng ta sẽ đặt vài dấu ngoặc nhọn
quanh nó để nhìn rõ khoảng trắng pad trong output.

``` {.c}
printf("<<%10d>>\n", 3490);   // canh phải
printf("<<%-10d>>\n", 3490);  // canh trái
```

``` {.default}
<<      3490>>
<<3490      >>
```

Giống precision, bạn có thể dùng dấu sao (`*`) cho field width

``` {.c}
int field_width;
int val = 3490;

printf("Enter field_width: "); fflush(stdout);
scanf("%d", &field_width);

printf("<<%*d>>\n", field_width, val);
```

#### Flags

Trước field width, bạn có thể đặt vài flag tuỳ chọn để kiểm soát
thêm output của các trường sau. Ta vừa thấy flag `-` có thể dùng để
canh trái hoặc phải. Nhưng còn nhiều nữa!

|Flag|Mô tả|
|:--:|--------------------------|
|`-`|Với field width, canh trái trong trường (mặc định là phải).|
|`+`|Nếu số có dấu, luôn đặt `+` hoặc `-` ở đầu.|
|[SPACE]|Nếu số có dấu, đặt khoảng trắng cho số dương, hoặc `-` cho số âm.|
|`0`|Pad trường canh phải bằng số 0 đầu thay vì khoảng trắng đầu.
|`#`|In theo dạng thay thế (alternate form). Xem bên dưới.|

Ví dụ, chúng ta có thể pad một số hex với số 0 đầu đến field width 8
bằng:

``` {.c}
printf("%08x\n", 0x1234);  // 00001234
```

Kết quả của "alternate form" `#` phụ thuộc vào conversion specifier.

|Conversion Specifier|Ý nghĩa dạng thay thế (`#`)|
|:---------:|---------------------------------------|
|`o`|Tăng precision của số khác không vừa đủ để có một số `0` đứng đầu số bát phân.|
|`b`|Thêm tiền tố `0b` cho số khác không.|
|`B`|Giống `b`, nhưng viết hoa `0B`.|
|`x`|Thêm tiền tố `0x` cho số khác không.|
|`X`|Giống `x`, nhưng viết hoa `0X`.|
|`a`, `e`, `f`|Luôn in dấu thập phân, ngay cả khi không có gì theo sau.|
|`A`, `E`, `F`|Giống hệt `a`, `e`, `f`.|
|`g`, `G`|Luôn in dấu thập phân, ngay cả khi không có gì theo sau, và giữ các số 0 cuối.|


#### Chi tiết `sprintf()` và `snprintf()`

Cả `sprintf()` và `snprintf()` đều có tính chất là nếu bạn truyền
`NULL` làm buffer, không gì được ghi---nhưng bạn vẫn có thể kiểm tra
giá trị trả về để xem sẽ ghi được bao nhiêu ký tự _nếu được ghi_.

`snprintf()` **luôn** kết thúc chuỗi bằng ký tự `NUL`. Nên nếu bạn thử
ghi nhiều hơn số ký tự tối đa chỉ định, vũ trụ sẽ kết thúc.

Đùa thôi. Nếu bạn làm thế, `snprintf()` sẽ ghi $n-1$ ký tự để nó còn
đủ chỗ ghi ký tự kết thúc ở cuối.

### Giá trị trả về {.unnumbered .unlisted}

Trả về số ký tự đã output, hoặc một số âm khi lỗi.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>

int main(void)
{
    int a = 100;
    float b = 2.717;
    char *c = "beej!";
    char d = 'X';
    int e = 5;

    printf("%d\n", a); /* "100"      */
    printf("%f\n", b); /* "2.717000" */
    printf("%s\n", c); /* "beej!"    */
    printf("%c\n", d); /* "X"        */
    printf("110%%\n"); /* "110%"     */

    printf("%10d\n", a);   /* "       100" */
    printf("%-10d\n", a);  /* "100       " */
    printf("%*d\n", e, a); /* "  100"      */
    printf("%.2f\n", b);   /* "2.72"       */

    printf("%hhd\n", d); /* "88" <-- mã ASCII của 'X' */

    printf("%5d %5.2f %c\n", a, b, d); /* "  100  2.72 X" */
}
```

### Xem thêm {.unnumbered .unlisted}

[`sprintf()`](#man-printf),
[`vprintf()`](#man-vprintf)

[[manbreak]]

## `scanf()`, `fscanf()`, `sscanf()` {#man-scanf}

[i[`scanf()` function]i]
[i[`fscanf()` function]i]
[i[`sscanf()` function]i]

Đọc chuỗi, ký tự, hoặc dữ liệu số có định dạng từ console hoặc từ file

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>

int scanf(const char *format, ...);

int fscanf(FILE *stream, const char *format, ...);

int sscanf(const char * restrict s, const char * restrict format, ...);
```

### Mô tả {.unnumbered .unlisted}

Các hàm này đọc output có định dạng từ nhiều nguồn khác nhau.

|Hàm|Nguồn input|
|-|-|
|`scanf()`|Đọc từ console (mặc định thường là bàn phím).|
|`fscanf()`|Đọc từ file.|
|`sscanf()`|Đọc từ một chuỗi.|

Khác biệt duy nhất giữa chúng là các tham số đứng trước chuỗi `format`
mà bạn truyền vào.

|Hàm|Thứ bạn truyền trước `format`|
|-|-|
|`scanf()`|Không có gì đứng trước `format`.|
|`fscanf()`|Truyền vào `FILE*`.|
|`sscanf()`|Truyền vào `char*` đến buffer để đọc từ đó.|

Họ hàm `scanf()` đọc dữ liệu từ console hoặc từ `FILE` stream, phân
tích và lưu kết quả vào các biến bạn đưa vào trong danh sách tham số.

Chuỗi format rất giống của `printf()` ở chỗ bạn có thể bảo nó đọc
một `"%d"`, chẳng hạn cho `int`. Nhưng nó cũng có thêm khả năng, nổi
bật là nó có thể nuốt những ký tự khác trong input mà bạn chỉ định
trong chuỗi format.

Nhưng hãy bắt đầu đơn giản, xem cách dùng cơ bản nhất trước khi đắm
vào chiều sâu của hàm. Ta sẽ bắt đầu bằng cách đọc một `int` từ bàn
phím:

``` {.c}
int a;

scanf("%d", &a);
```

`scanf()` hiển nhiên cần một pointer đến biến nếu nó định thay đổi
biến đó, nên ta dùng toán tử address-of để lấy pointer.

Trong trường hợp này, `scanf()` đi theo chuỗi format, tìm thấy "`%d`",
rồi biết nó cần đọc một số nguyên và lưu vào biến kế tiếp trong danh
sách tham số, `a`.

Đây là vài format specifier khác bạn có thể đặt trong chuỗi format:

|Format Specifier|Mô tả|
|-|-|
|`%d`|Đọc một số nguyên để lưu vào `int`. Số này có thể có dấu.|
|`%u`|Đọc một số nguyên để lưu vào `unsigned int`.|
|`%f`|Đọc một số thực, để lưu vào `float`.|
|`%s`|Đọc một chuỗi cho đến ký tự whitespace (khoảng trắng) đầu tiên.|
|`%c`|Đọc một `char`.|

Và đó là hết chuyện!

Haha! Đùa thôi. Nếu bạn vừa từ trang `printf()` qua, bạn biết còn gần
như vô tận nội dung thêm.

#### Tiêu thụ ký tự khác

`scanf()` sẽ đi dọc chuỗi format khớp với bất kỳ ký tự nào bạn bỏ
vào.

Ví dụ, bạn có thể đọc một ngày có gạch nối như thế này:

``` {.c}
scanf("%u-%u-%u", &yyyy, &mm, &dd);
```

Trong trường hợp đó, `scanf()` sẽ cố tiêu thụ một số thập phân unsigned,
rồi một dấu gạch, rồi một số unsigned nữa, rồi một dấu gạch nữa, rồi
một số unsigned nữa.

Nếu tại bất kỳ điểm nào không khớp (ví dụ người dùng nhập "foo"),
`scanf()` sẽ bỏ đi mà không tiêu thụ những ký tự lạ.

Và nó sẽ trả về số biến được chuyển đổi thành công. Trong ví dụ trên,
nếu người dùng nhập chuỗi hợp lệ, `scanf()` sẽ trả về `3`, một cho
mỗi biến được đọc thành công.

#### Vấn đề với `scanf()`

Tôi (và C FAQ, và nhiều người) khuyên _không_ nên dùng `scanf()` để
đọc trực tiếp từ bàn phím. Quá dễ để nó ngừng tiêu thụ ký tự khi
người dùng nhập dữ liệu xấu.

Nếu bạn có dữ liệu trong file và tự tin nó ở tình trạng tốt, `fscanf()`
có thể thực sự hữu dụng.

Nhưng trong trường hợp bàn phím hoặc file, bạn luôn có thể dùng
`fgets()` để đọc một dòng đầy đủ vào buffer, rồi dùng `sscanf()` để
tách mọi thứ ra khỏi buffer. Cách này cho bạn điểm tốt của cả hai bên.

#### Vấn đề với `sscanf()`

Cách đây không lâu, một lập trình viên bên thứ ba nổi tiếng vì nghĩ
ra [fl[cách cắt thời gian load của _GTA Online_ đi
70%|https://nee.lv/2021/02/28/How-I-cut-GTA-Online-loading-times-by-70/]].

Điều họ phát hiện là cài đặt của `sscanf()` đầu tiên sẽ gọi ngầm
`strlen()`... nên ngay cả khi bạn chỉ dùng `sscanf()` để tách vài ký
tự đầu khỏi chuỗi, nó vẫn chạy tới tận cuối chuỗi trước.

Trên chuỗi ngắn, không vấn đề, nhưng trên chuỗi dài với lời gọi lặp
lại (đúng cái xảy ra trong _GTA_) nó trở nên _chậmmmmmmm_...

Vậy nên nếu bạn chỉ chuyển chuỗi thành số, hãy cân nhắc
[`atoi()`](#man-atoi), [`atof()`](#man-atof), hoặc họ hàm
[`strtol()`](#man-strtol) và [`strtod()`](#man-strtod).

(Lập trình viên đó [nhận được bug bounty
$10.000](https://www.polygon.com/2021/3/16/22334214/gta-online-loading-times-t0st-update-bug-bounty)
cho công sức đó.)

#### Chi tiết sâu

Hãy xem một `scanf()`

Và đây là vài mã nữa, nhưng những cái này không hay dùng thường xuyên.
Đương nhiên bạn có thể dùng chúng nhiều như bạn muốn!

Đầu tiên, chuỗi format. Như đã nhắc, nó có thể chứa ký tự bình thường
và các format specifier `%`. Và ký tự whitespace.

Ký tự whitespace có vai trò đặc biệt: một ký tự whitespace sẽ khiến
`scanf()` tiêu thụ càng nhiều ký tự whitespace càng tốt cho đến ký
tự non-whitespace tiếp theo. Bạn có thể dùng cái này để bỏ qua mọi
whitespace đầu hoặc cuối.

Ngoài ra, tất cả format specifier trừ `s`, `c`, và `[` tự động tiêu
thụ whitespace đầu.

Nhưng tôi biết bạn đang nghĩ gì: phần thịt của hàm này nằm trong các
format specifier. Chúng trông thế nào?

Chúng gồm các phần sau, theo thứ tự:

1. Dấu `%`
2. Tuỳ chọn: một `*` để chặn việc gán---sẽ nói sau
3. Tuỳ chọn: field width---số ký tự tối đa để đọc
4. Tuỳ chọn: length modifier, để chỉ định kiểu dài hơn hoặc ngắn hơn
5. Conversion specifier, như `d` hay `f` chỉ ra kiểu cần đọc

#### Conversion Specifier

Hãy bắt đầu với cái hay nhất và cuối cùng: _conversion specifier_.

Đây là phần của format specifier cho ta biết `scanf()` nên đọc vào
kiểu biến nào, như `%d` hay `%f`.

Chuyển đổi nhị phân là mới trong C23!

|Conversion Specifier|Mô tả|
|:--:|--------------------------|
|`d`|Khớp `int` thập phân. Có thể có dấu đầu.|
|`b`|Khớp `unsigned int` nhị phân (cơ số 2). Có thể có dấu đầu.|
|`i`|Giống `d`, chỉ khác là xử lý được nếu bạn đặt `0x` (hex) hay `0` (bát phân) hay `0b` (nhị phân) đứng đầu số.|
|`o`|Khớp `unsigned int` bát phân (cơ số 8). Bỏ qua số 0 đầu.|
|`u`|Khớp `unsigned int` thập phân.|
|`x`|Khớp `unsigned int` hex (cơ số 16).|
|`f`|Khớp số thực (hoặc ký hiệu khoa học, hoặc bất cứ thứ gì `strtod()` xử lý được).|
|`c`|Khớp một `char`, hoặc nhiều `char` nếu có field width.|
|`s`|Khớp một chuỗi `char` non-whitespace.|
|`[`|Khớp một chuỗi ký tự từ một tập. Tập kết thúc bằng `]`. Xem thêm bên dưới.|
|`p`|Khớp một pointer, ngược lại với `%p` của `printf()`.|
|`n`|Lưu số ký tự đã ghi tính đến lúc đó vào `int*` đã cho. Không tiêu thụ gì.|
|`%`|Khớp dấu phần trăm literal.|

Tất cả những cái sau đều tương đương với specifier `f`: `a`, `e`, `g`,
`A`, `E`, `F`, `G`.

Và `X` hoa tương đương với `x` thường.

##### Conversion Specifier Scanset `%[]`

Đây chắc là format specifier kỳ quặc nhất. Nó cho phép bạn chỉ định
một tập ký tự (_scanset_) để được lưu (khả năng cao vào mảng `char`).
Việc chuyển đổi dừng khi gặp ký tự không thuộc tập.

Ví dụ, `%[0-9]` nghĩa là "khớp mọi số từ 0 đến 9". Và `%[AD-G34]`
nghĩa là "khớp A, D đến G, 3, hoặc 4".

Giờ, để rối rắm thêm, bạn có thể bảo `scanf()` khớp các ký tự _không_
nằm trong tập bằng cách đặt dấu caret (`^`) ngay sau `%[` và theo sau
là tập, như: `%[^A-C]`, nghĩa là "khớp mọi ký tự _không_ từ A đến C."

Để khớp dấu ngoặc vuông đóng, đặt nó làm ký tự đầu tiên trong tập,
như: `%[]A-C]` hoặc `%[^]A-C]`. (Tôi thêm "`A-C`" để rõ rằng "`]`"
đầu tiên trong tập.)

Để khớp dấu gạch nối, đặt nó làm ký tự cuối cùng trong tập, ví dụ để
khớp A-đến-C hoặc gạch nối: `%[A-C-]`.

Vậy nếu chúng ta muốn khớp mọi chữ cái _trừ_ "%", "^", "]", "B", "C",
"D", "E", và "-", ta có thể dùng chuỗi format này: `%[^]%^B-E-]`.

Hiểu chưa? Giờ ta có thể qua hàm tiế---khoan! Còn nữa! Vâng, vẫn còn
nữa để biết về `scanf()`. Không bao giờ kết thúc à? Hãy thử tưởng
tượng tôi cảm thấy thế nào khi viết về nó!

#### Length Modifier

Vậy bạn biết "`%d`" lưu vào `int`. Nhưng làm sao lưu vào `long`,
`short`, hoặc `double`?

Chà, giống như trong `printf()`, bạn có thể thêm modifier trước type
specifier để báo `scanf()` rằng bạn có kiểu dài hơn hoặc ngắn hơn.
Sau đây là bảng các modifier khả dụng:

|Length Modifier|Conversion Specifier|Mô tả|
|:--:|:-----:|------------------|
|`hh`|`b`, `d`, `i`, `o`, `u`, `x`, `X`|Chuyển input sang `char` (signed hoặc unsigned tuỳ ngữ cảnh) trước khi in.|
|`h`|`b`, `d`, `i`, `o`, `u`, `x`, `X`|Chuyển input sang `short int` (signed hoặc unsigned tuỳ ngữ cảnh) trước khi in.|
|`l`|`b`, `d`, `i`, `o`, `u`, `x`, `X`|Chuyển input sang `long int` (signed hoặc unsigned tuỳ ngữ cảnh).|
|`ll`|`b`, `d`, `i`, `o`, `u`, `x`, `X`|Chuyển input sang `long long int` (signed hoặc unsigned tuỳ ngữ cảnh).|
|`j`|`b`, `d`, `i`, `o`, `u`, `x`, `X`|Chuyển input sang `intmax_t` hoặc `uintmax_t` (tuỳ ngữ cảnh).|
|`z`|`b`, `d`, `i`, `o`, `u`, `x`, `X`|Chuyển input sang `size_t`.|
|`t`|`b`, `d`, `i`, `o`, `u`, `x`, `X`|Chuyển input sang `ptrdiff_t`.|
|`L`|`a`, `A`, `e`, `E`, `f`, `F`, `g`, `G`|Chuyển input sang `long double`.|
|`l`|`c`,`s`,`[`|Chuyển input sang `wchar_t`, một wide character.|
|`l`|`s`|Tham số nằm trong `wchar_t*`, một chuỗi wide character.|
|`hh`|`n`|Lưu kết quả vào tham số `signed char*`.|
|`h`|`n`|Lưu kết quả vào tham số `short int*`.|
|`l`|`n`|Lưu kết quả vào tham số `long int*`.|
|`ll`|`n`|Lưu kết quả vào tham số `long long int*`.|
|`j`|`n`|Lưu kết quả vào tham số `intmax_t*`.|
|`z`|`n`|Lưu kết quả vào tham số `size_t*`.|
|`t`|`n`|Lưu kết quả vào tham số `ptrdiff_t*`.|

#### Field Widths

Field width nói chung cho phép bạn chỉ định số ký tự tối đa được
tiêu thụ. Nếu thứ bạn cố khớp ngắn hơn field width, input đó sẽ ngừng
được xử lý trước khi đạt field width.

Vậy một chuỗi sẽ ngừng tiêu thụ khi tìm thấy whitespace, ngay cả khi
khớp ít hơn field width ký tự.

Và một số float sẽ ngừng tiêu thụ ở cuối số, ngay cả khi ít ký tự hơn
field width được khớp.

Nhưng `%c` thì thú vị---nó không ngừng tiêu thụ ký tự với bất cứ điều
gì. Nên nó sẽ đi đúng đến field width. (Hoặc 1 ký tự nếu không có
field width.)

#### Bỏ qua Input với `*`

Nếu bạn đặt `*` trong format specifier, nó báo `scanf()` thực hiện
chuyển đổi đã chỉ định, nhưng không lưu vào đâu cả. Nó chỉ đơn giản
vứt dữ liệu đi khi đọc. Đây là thứ bạn dùng nếu muốn `scanf()` ăn
chút dữ liệu nhưng không muốn lưu vào đâu; bạn không truyền tham số
cho `scanf()` cho chuyển đổi này.

``` {.c}
// Đọc 3 int, nhưng bỏ cái ở giữa
scanf("%d %*d %d", &int1, &int3);
```

### Giá trị trả về {.unnumbered .unlisted}

`scanf()` trả về số item được gán vào biến. Vì việc gán vào biến
dừng khi gặp input không hợp lệ cho một format specifier nào đó, nó
có thể cho bạn biết đã nhập đủ dữ liệu đúng chưa.

Ngoài ra, `scanf()` trả về `EOF` khi gặp end-of-file.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>

int main(void)
{
    int a;
    long int b;
    unsigned int c;
    float d;
    double e;
    long double f;
    char s[100];

    scanf("%d", &a);  // lưu một int
    scanf(" %d", &a); // ăn whitespace, rồi lưu một int
    scanf("%s", s); // lưu một chuỗi
    scanf("%Lf", &f); // lưu một long double

    // lưu một unsigned, đọc whitespace, rồi lưu một long int:
    scanf("%u %ld", &c, &b);

    // lưu một int, đọc whitespace, đọc "blendo", đọc whitespace,
    // rồi lưu một float:
    scanf("%d blendo %f", &a, &d);

    // đọc whitespace, rồi lưu mọi ký tự cho đến newline
    scanf(" %[^\n]", s);

    // lưu một float, đọc (và bỏ) một int, rồi lưu một double:
    scanf("%f %*d %lf", &d, &e);

    // lưu 10 ký tự:
    scanf("%10c", s);
}
```

### Xem thêm {.unnumbered .unlisted}

[`sscanf()`](#man-scanf),
[`vscanf()`](#man-vscanf),
[`vsscanf()`](#man-vscanf),
[`vfscanf()`](#man-vscanf)

[[manbreak]]
## `vprintf()`, `vfprintf()`, `vsprintf()`, `vsnprintf()` {#man-vprintf}

[i[`vprintf()` function]i]
[i[`vfprintf()` function]i]
[i[`vsprintf()` function]i]
[i[`vsnprintf()` function]i]

Biến thể `printf()` dùng danh sách tham số biến đổi (`va_list`)

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>
#include <stdarg.h>

int vprintf(const char * restrict format, va_list arg);

int vfprintf(FILE * restrict stream, const char * restrict format,
             va_list arg);

int vsprintf(char * restrict s, const char * restrict format, va_list arg);

int vsnprintf(char * restrict s, size_t n, const char * restrict format,
              va_list arg);
```

### Mô tả {.unnumbered .unlisted}

Các hàm này giống biến thể `printf()` chỉ khác là thay vì nhận số
tham số biến đổi thực, chúng nhận một số cố định---cuối cùng là một
`va_list` tham chiếu đến các tham số biến đổi.

Giống với `printf()`, các biến thể khác nhau gửi output đến những nơi
khác nhau.

|Hàm|Đích output|
|-|-|
|`vprintf()`|In ra console (mặc định thường là màn hình).|
|`vfprintf()`|In ra file.|
|`vsprintf()`|In ra chuỗi.|
|`vsnprintf()`|In ra chuỗi (an toàn).|

Cả `vsprintf()` và `vsnprintf()` đều có tính chất là nếu bạn truyền
`NULL` làm buffer, không gì được ghi---nhưng bạn vẫn có thể kiểm tra
giá trị trả về để xem đã ghi được bao nhiêu ký tự _nếu được ghi_.

Nếu bạn thử ghi nhiều hơn số ký tự tối đa, `vsnprintf()` sẽ lịch sự
chỉ ghi $n-1$ ký tự để còn đủ chỗ cho ký tự kết thúc ở cuối.

Còn vì sao đời bạn lại muốn làm thế, lý do phổ biến nhất là để tạo
phiên bản chuyên biệt riêng của các hàm kiểu `printf()`, ăn bám lên
mọi điều tốt đẹp của `printf()`.

Xem ví dụ để có ví dụ, dự đoán được thôi.

### Giá trị trả về {.unnumbered .unlisted}

`vprintf()` và `vfprintf()` trả về số ký tự đã in, hoặc giá trị âm
khi lỗi.

`vsprintf()` trả về số ký tự đã in vào buffer, không tính ký tự kết
thúc NUL, hoặc giá trị âm nếu có lỗi.

`vnsprintf()` trả về số ký tự đã in vào buffer. Hoặc số _sẽ_ được in
nếu buffer đủ lớn.

### Ví dụ {.unnumbered .unlisted}

Trong ví dụ này, ta tạo phiên bản riêng của `printf()` gọi là
`logger()`, có timestamp output. Chú ý các lời gọi `logger()` có đủ
đồ chơi của `printf()`.

``` {.c .numberLines}
#include <stdio.h>
#include <stdarg.h>
#include <time.h>

int logger(char *format, ...)
{
    va_list va;
    time_t now_secs = time(NULL);
    struct tm *now = gmtime(&now_secs);

    // Output timestamp dạng "YYYY-MM-DD hh:mm:ss : "
    printf("%04d-%02d-%02d %02d:%02d:%02d : ",
        now->tm_year + 1900, now->tm_mon + 1, now->tm_mday,
        now->tm_hour, now->tm_min, now->tm_sec);

    va_start(va, format);
    int result = vprintf(format, va);
    va_end(va);

    printf("\n");

    return result;
}

int main(void)
{
    int x = 12;
    float y = 3.2;

    logger("Hello!");
    logger("x = %d and y = %.2f", x, y);
}
```

Output:

``` {.default}
2021-03-30 04:25:49 : Hello!
2021-03-30 04:25:49 : x = 12 and y = 3.20
```

### Xem thêm {.unnumbered .unlisted}
[`printf()`](#man-printf)

[[manbreak]]
## `vscanf()`, `vfscanf()`, `vsscanf()` {#man-vscanf}

[i[`vscanf()` function]i]
[i[`vfscanf()` function]i]
[i[`vsscanf()` function]i]

Biến thể `scanf()` dùng danh sách tham số biến đổi (`va_list`)

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>
#include <stdarg.h>

int vscanf(const char * restrict format, va_list arg);

int vfscanf(FILE * restrict stream, const char * restrict format,
            va_list arg);

int vsscanf(const char * restrict s, const char * restrict format,
            va_list arg);
```

### Mô tả {.unnumbered .unlisted}

Các hàm này giống biến thể `scanf()` chỉ khác là thay vì nhận số tham
số biến đổi thực, chúng nhận một số cố định---cuối cùng là một
`va_list` tham chiếu đến các tham số biến đổi.

|Hàm|Nguồn input|
|-|-|
|`vscanf()`|Đọc từ console (mặc định thường là bàn phím).|
|`vfscanf()`|Đọc từ file.|
|`vsscanf()`|Đọc từ chuỗi.|

Giống với họ hàm `vprintf()`, đây là cách tốt để thêm chức năng phụ
tận dụng sức mạnh mà `scanf()` mang lại.

### Giá trị trả về {.unnumbered .unlisted}

Trả về số item scan thành công, hoặc `EOF` khi gặp end-of-file hoặc
lỗi.

### Ví dụ {.unnumbered .unlisted}

Tôi phải thú nhận đã vắt óc để nghĩ khi nào bạn muốn dùng cái này.
Ví dụ tốt nhất tôi tìm được là [fl[một cái trên Stack
Overflow|https://stackoverflow.com/questions/17017331/c99-vscanf-for-dummies/17018046#17018046]]
kiểm tra lỗi giá trị trả về từ `scanf()` so với mong đợi. Một biến
thể của nó được trình bày bên dưới.

``` {.c .numberLines}
#include <stdio.h>
#include <stdarg.h>
#include <assert.h>

int error_check_scanf(int expected_count, char *format, ...)
{
    va_list va;

    va_start(va, format);
    int count = vscanf(format, va);
    va_end(va);

    // Dòng này sẽ crash chương trình nếu điều kiện sai:
    assert(count == expected_count);

    return count;
}

int main(void)
{
    int a, b;
    float c;

    error_check_scanf(3, "%d, %d/%f", &a, &b, &c);
    error_check_scanf(2, "%d", &a);
}
```

### Xem thêm {.unnumbered .unlisted}
[`scanf()`](#man-scanf)

[[manbreak]]
## `getc()`, `fgetc()`, `getchar()` {#man-getc}

[i[`getc()` function]i]
[i[`fgetc()` function]i]
[i[`getchar()` function]i]

Lấy một ký tự đơn từ console hoặc từ file

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>

int getc(FILE *stream);

int fgetc(FILE *stream);

int getchar(void);
```

### Mô tả {.unnumbered .unlisted}

Tất cả các hàm này, theo cách này hay cách khác, đọc một ký tự đơn từ
console hoặc từ một `FILE`. Khác biệt khá nhỏ, và đây là mô tả:

`getc()` trả về một ký tự từ `FILE` đã chỉ định. Về mặt sử dụng, nó
tương đương với lời gọi `fgetc()` tương tự, và `fgetc()` thường gặp
hơn. Chỉ khác ở cách cài đặt của hai hàm.

`fgetc()` trả về một ký tự từ `FILE` đã chỉ định. Về mặt sử dụng, nó
tương đương với lời gọi `getc()` tương tự, chỉ khác là `fgetc()`
thường gặp hơn. Chỉ khác ở cách cài đặt của hai hàm.

Đúng vậy, tôi đã gian lận và copy-paste đoạn trên.

`getchar()` trả về một ký tự từ `stdin`. Thực ra, nó giống gọi
`getc(stdin)`.

### Giá trị trả về {.unnumbered .unlisted}

Cả ba hàm trả về `unsigned char` mà chúng đọc được, trừ việc nó được
cast sang `int`.

Nếu gặp end-of-file hoặc lỗi, cả ba hàm đều trả về `EOF`.

### Ví dụ {.unnumbered .unlisted}

Ví dụ này đọc tất cả ký tự từ một file, chỉ output những chữ 'b' nó
tìm thấy..

``` {.c .numberLines}
#include <stdio.h>

int main(void)
{
    FILE *fp;
    int c;

    fp = fopen("spoon.txt", "r"); // nhớ kiểm tra lỗi cái này!

    // câu while dưới gán vào c, rồi so với EOF:

    while((c = fgetc(fp)) != EOF) {
        if (c == 'b') {
            putchar(c);
        }
    }

    putchar('\n');

    fclose(fp);
}
```

### Xem thêm {.unnumbered .unlisted}

[[manbreak]]
## `gets()`, `fgets()` {#man-gets}

[i[`gets()` function]i]
[i[`fgets()` function]i]

Đọc một chuỗi từ console hoặc file

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>

char *fgets(char *s, int size, FILE *stream);
char *gets(char *s);
```

### Mô tả {.unnumbered .unlisted}

Đây là những hàm lấy một chuỗi kết thúc bằng newline từ console hoặc
một file. Nói cách khác bình thường, chúng đọc một dòng văn bản. Hành
vi hơi khác, và vì thế, cách dùng cũng khác. Ví dụ, đây là cách dùng
`gets()`:

Đừng dùng `gets()`. Thực tế, từ C11 nó đã bị loại bỏ! Đây là một
trong những trường hợp hiếm hoi một hàm bị _gỡ_ khỏi chuẩn.

Phải thừa nhận là có giải thích lý do sẽ hữu ích, đúng không? Thứ
nhất, `gets()` không cho phép bạn chỉ định độ dài của buffer để lưu
chuỗi. Điều này cho phép người dùng tiếp tục nhập dữ liệu qua khỏi
đuôi buffer của bạn, và tin tôi đi, đó sẽ là Tin Xấu.

Và đó là công dụng của tham số `size` trong `fgets()`. `fgets()` sẽ
đọc tối đa `size-1` ký tự rồi đặt một terminator `NUL` sau đó.

Tôi định thêm lý do khác, nhưng về cơ bản đó là lý do chính và duy
nhất không dùng `gets()`. Như bạn có thể đoán, `fgets()` cho phép
bạn chỉ định độ dài chuỗi tối đa.

Một khác biệt giữa hai hàm: `gets()` sẽ nuốt và vứt đi ký tự newline
cuối dòng, còn `fgets()` sẽ lưu nó vào cuối chuỗi của bạn (nếu còn
chỗ).

Đây là ví dụ dùng `fgets()` từ console, làm cho nó cư xử giống `gets()`
hơn (ngoại trừ việc chứa newline):

``` {.c}
char s[100];
gets(s);  // đừng dùng cái này--đọc một dòng (từ stdin)
fgets(s, sizeof(s), stdin); // đọc một dòng từ stdin
```

Trong trường hợp này, toán tử `sizeof()` cho ta tổng kích thước mảng
theo byte, và vì `char` là một byte, nó tiện lợi cho ta tổng kích
thước của mảng.

Dĩ nhiên, như tôi đã nói, chuỗi trả về từ `fgets()` rất có khả năng
có newline ở cuối mà bạn có thể không muốn. Bạn có thể viết một hàm
ngắn cắt newline đi---thực tế, hãy gộp luôn nó vào phiên bản `gets()`
của riêng ta

``` {.c}
#include <stdio.h>
#include <string.h>

char *ngets(char *s, int size)
{
    char *rv = fgets(s, size, stdin);

    if (rv == NULL)
        return NULL;

    char *p = strchr(s, '\n');  // Tìm một newline

    if (p != NULL)  // nếu có newline
        *p = '\0';  // cắt chuỗi ở đó

    return s;
}
```

Vậy, tóm lại, dùng `fgets()` để đọc một dòng văn bản từ bàn phím hoặc
file, và đừng dùng `gets()`.

### Giá trị trả về {.unnumbered .unlisted}

Cả `gets()` và `fgets()` đều trả về con trỏ đến chuỗi đã truyền vào.

Khi lỗi hoặc end-of-file, các hàm trả về `NULL`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>

int main(void)
{
    FILE *fp;
    char s[100];

    gets(s); // đọc từ standard input (đừng dùng--dùng fgets()!)

    fgets(s, sizeof s, stdin); // đọc 100 byte từ standard input

    fp = fopen("spoon.txt", "r"); // (bạn nên kiểm tra lỗi cái này)
    fgets(s, 100, fp); // đọc 100 byte từ file datafile.dat
    fclose(fp);

    fgets(s, 20, stdin); // đọc tối đa 20 byte từ stdin
}
```

### Xem thêm {.unnumbered .unlisted}

[`getc()`](#man-getc),
[`fgetc()`](#man-getc),
[`getchar()`](#man-getc),
[`puts()`](#man-puts),
[`fputs()`](#man-puts),
[`ungetc()`](#man-ungetc)

[[manbreak]]
## `putc()`, `fputc()`, `putchar()` {#man-putc}

[i[`putc()` function]i]
[i[`fputc()` function]i]
[i[`putchar()` function]i]

Ghi một ký tự đơn ra console hoặc ra file

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>

int putc(int c, FILE *stream);

int fputc(int c, FILE *stream);

int putchar(int c);
```

### Mô tả {.unnumbered .unlisted}

Cả ba hàm output một ký tự đơn, hoặc ra console hoặc ra một `FILE`.

`putc()` nhận một tham số ký tự, và output ra `FILE` đã chỉ định.
`fputc()` làm y hệt, chỉ khác `putc()` ở cách cài đặt. Hầu hết mọi
người dùng `fputc()`.

`putchar()` ghi ký tự ra console, và giống gọi `putc(c, stdout)`.

### Giá trị trả về {.unnumbered .unlisted}

Cả ba hàm trả về ký tự đã ghi khi thành công, hoặc `EOF` khi lỗi.

### Ví dụ {.unnumbered .unlisted}

In bảng chữ cái:

``` {.c .numberLines}
#include <stdio.h>

int main(void)
{
    char i;

    for(i = 'A'; i <= 'Z'; i++)
        putchar(i);

    putchar('\n'); // đặt một newline ở cuối cho đẹp
}
```

### Xem thêm {.unnumbered .unlisted}

[[manbreak]]
## `puts()`, `fputs()` {#man-puts}

[i[`puts()` function]i]

Ghi một chuỗi ra console hoặc ra file

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>

int puts(const char *s);

int fputs(const char *s, FILE *stream);
```

### Mô tả {.unnumbered .unlisted}

Cả hai hàm này output một chuỗi kết thúc bằng NUL. `puts()` output ra
console, còn `fputs()` cho phép bạn chỉ định file để output.

### Giá trị trả về {.unnumbered .unlisted}

Cả hai hàm trả về không âm khi thành công, hoặc `EOF` khi lỗi.

### Ví dụ {.unnumbered .unlisted}

Đọc chuỗi từ console và lưu chúng vào file:

``` {.c .numberLines}
#include <stdio.h>

int main(void)
{
    FILE *fp;
    char s[100];

    fp = fopen("somefile.txt", "w"); // nhớ kiểm tra lỗi cái này!

    while(fgets(s, sizeof(s), stdin) != NULL) { // đọc một chuỗi
        fputs(s, fp);  // ghi vào file đã mở
    }

    fclose(fp);
}
```

### Xem thêm {.unnumbered .unlisted}

[[manbreak]]
## `ungetc()` {#man-ungetc}

[i[`ungetc()` function]i]

Đẩy một ký tự trở lại input stream

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>

int ungetc(int c, FILE *stream);
```

### Mô tả {.unnumbered .unlisted}

Bạn biết `getc()` đọc ký tự kế tiếp từ một file stream chứ? Đây là
ngược lại---nó đẩy một ký tự trở lại file stream để nó sẽ xuất hiện
lại ở lần đọc kế tiếp từ stream, như thể bạn chưa từng lấy nó bằng
`getc()` ngay từ đầu.

Vì sao, nhân danh tất cả những gì linh thiêng, bạn lại muốn làm thế?
Có lẽ bạn có một stream dữ liệu mà bạn đang đọc từng ký tự một, và
bạn sẽ không biết khi nào dừng cho đến khi lấy được một ký tự nhất
định, nhưng bạn muốn có thể đọc ký tự đó lại sau. Bạn có thể đọc ký
tự, thấy rằng nó là cái cần dừng, rồi `ungetc()` nó để nó xuất hiện
ở lần đọc kế.

Đúng rồi, chuyện này không xảy ra thường xuyên, nhưng thì đó.

Đây là điểm cần chú ý: chuẩn chỉ đảm bảo bạn có thể đẩy lại _một ký
tự_. Một số cài đặt có thể cho phép đẩy nhiều hơn, nhưng không có
cách nào biết chắc mà vẫn portable.

### Giá trị trả về {.unnumbered .unlisted}

Khi thành công, `ungetc()` trả về ký tự bạn truyền vào. Khi thất bại,
nó trả về `EOF`.

### Ví dụ {.unnumbered .unlisted}

Ví dụ này đọc một dấu câu, rồi mọi thứ sau nó cho đến dấu câu kế.
Nó trả về dấu câu đầu, và lưu phần còn lại vào một chuỗi.

``` {.c .numberLines}
#include <stdio.h>
#include <ctype.h>

int read_punctstring(FILE *fp, char *s)
{
    int origpunct, c;
    
    origpunct = fgetc(fp);

    if (origpunct == EOF)  // trả về EOF khi end-of-file
        return EOF;

    while (c = fgetc(fp), !ispunct(c) && c != EOF)
        *s++ = c;  // lưu vào chuỗi

    *s = '\0'; // kết thúc chuỗi bằng NUL

    // nếu vừa đọc là dấu câu, ungetc nó để lần sau fgetc lấy lại:
    if (ispunct(c))
        ungetc(c, fp);

    return origpunct;
}

int main(void)
{
    char s[128];
    char c;

    while((c = read_punctstring(stdin, s)) != EOF) {
        printf("%c: %s\n", c, s);
    }
}
```

Input mẫu:

``` {.default}
!foo#bar*baz
```

Output mẫu:

``` {.default}
!: foo
#: bar
*: baz
```

### Xem thêm {.unnumbered .unlisted}

[`fgetc()`](#man-getc)

[[manbreak]]
## `fread()` {#man-fread}

[i[`fread()` function]i]

Đọc dữ liệu nhị phân từ file

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>

size_t fread(void *p, size_t size, size_t nmemb, FILE *stream);
```

### Mô tả {.unnumbered .unlisted}

Có thể bạn còn nhớ rằng bạn có thể gọi [`fopen()`](#man-fopen) với
flag "`b`" trong chuỗi mode để mở file ở chế độ "binary" (chế độ nhị
phân). File mở ở chế độ không nhị phân (ASCII hay text mode (chế độ
văn bản)) có thể được đọc bằng các lời gọi hướng ký tự chuẩn như
[`fgetc()`](#man-getc) hay [`fgets()`](#man-gets). File mở ở binary
mode thường được đọc bằng hàm `fread()`.

Cái hàm này làm là nói, "Ê, đọc bằng này thứ, mỗi thứ là một số byte
nhất định, rồi lưu cả đống vào bộ nhớ bắt đầu từ con trỏ này."

Cái này có thể rất có ích, tin tôi đi, khi bạn muốn làm thứ như lưu
20 `int` vào file.

Nhưng khoan---không phải bạn có thể dùng [`fprintf()`](#man-printf)
với format specifier "`%d`" để lưu `int` vào file text và lưu chúng
kiểu đó sao? Ừ, chắc chắn. Cái đó có lợi thế là con người có thể mở
file và đọc số. Nhược điểm là chuyển số từ `int` sang text chậm hơn,
và số có khả năng chiếm nhiều chỗ hơn trong file. (Nhớ rằng một `int`
khả năng là 4 byte, nhưng chuỗi "12345678" là 8 byte.)

Vậy nên lưu dữ liệu nhị phân chắc chắn có thể gọn hơn và đọc nhanh
hơn.

### Giá trị trả về {.unnumbered .unlisted}

Hàm này trả về số item đọc thành công. Nếu mọi item yêu cầu đều đọc
được, giá trị trả về sẽ bằng tham số `nmemb`. Nếu gặp EOF, giá trị
trả về sẽ là 0.

Để làm bạn bối rối, nó cũng sẽ trả về 0 nếu có lỗi. Bạn có thể dùng
[`feof()`](#man-feof) hoặc [`ferror()`](#man-feof) để biết cái nào
thực sự xảy ra.

### Ví dụ {.unnumbered .unlisted}

Đọc 10 số từ file và lưu chúng vào mảng:

``` {.c .numberLines}
#include <stdio.h>

int main(void)
{
    int i;
    int n[10]
    FILE *fp;

    fp = fopen("numbers.dat", "rb");
    fread(n, sizeof(int), 10, fp);  // đọc 10 int
    fclose(fp);

    // in chúng ra:
    for(i = 0; i < 10; i++)
        printf("n[%d] == %d\n", i, n[i]);
}
```

### Xem thêm {.unnumbered .unlisted}

[`fopen()`](#man-fopen),
[`fwrite()`](#man-fwrite),
[`feof()`](#man-feof),
[`ferror()`](#man-feof)

[[manbreak]]
## `fwrite()` {#man-fwrite}

[i[`fwrite()` function]i]

Ghi dữ liệu nhị phân ra file

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>

size_t fwrite(const void *p, size_t size, size_t nmemb, FILE *stream);
```

### Mô tả {.unnumbered .unlisted}

Đây là đối tác của hàm [`fread()`](#man-fread). Nó ghi khối dữ liệu
nhị phân ra đĩa. Để hiểu điều đó nghĩa là gì, xem mục
[`fread()`](#man-fread).

### Giá trị trả về {.unnumbered .unlisted}

`fwrite()` trả về số item ghi thành công, hy vọng sẽ là `nmemb` mà
bạn truyền vào. Nó sẽ trả về 0 khi lỗi.

### Ví dụ {.unnumbered .unlisted}

Lưu 10 số ngẫu nhiên vào file:

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    int i;
    int n[10];
    FILE *fp;

    // điền mảng bằng số ngẫu nhiên:
    for(i = 0; i < 10; i++) {
        n[i] = rand();
        printf("n[%d] = %d\n", i, n[i]);
    }

    // lưu số ngẫu nhiên (10 int) vào file
    fp = fopen("numbers.dat", "wb");
    fwrite(n, sizeof(int), 10, fp); // ghi 10 int
    fclose(fp);
}
```

### Xem thêm {.unnumbered .unlisted}

[`fopen()`](#man-fopen),
[`fread()`](#man-fread)

[[manbreak]]
## `fgetpos()`, `fsetpos()` {#man-fgetpos}

[i[`fgetpos()` function]i]
[i[`fsetpos()` function]i]

Lấy vị trí hiện tại trong file, hoặc đặt vị trí hiện tại trong file.
Trên hầu hết hệ thống thì giống `ftell()` và `fseek()`

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>

int fgetpos(FILE *stream, fpos_t *pos);

int fsetpos(FILE *stream, fpos_t *pos);
```

### Mô tả {.unnumbered .unlisted}

Các hàm này giống `ftell()` và `fseek()`, chỉ khác là thay vì đếm
theo byte, chúng dùng một cấu trúc dữ liệu _opaque_ để giữ thông tin
vị trí về file. (Opaque, ở đây, nghĩa là bạn không được phép biết
kiểu dữ liệu được tạo từ cái gì.)

Trên gần như mọi hệ thống (và chắc chắn trên mọi hệ thống tôi biết),
người ta không dùng những hàm này, mà dùng `ftell()` và `fseek()`
thay thế. Các hàm này tồn tại đề phòng hệ thống của bạn không nhớ
được vị trí file dưới dạng offset byte đơn giản.

Vì biến `pos` là opaque, bạn phải gán vào nó bằng chính lời gọi
`fgetpos()`. Rồi bạn lưu giá trị cho sau này và dùng nó để reset vị
trí bằng `fsetpos()`.

### Giá trị trả về {.unnumbered .unlisted}

Cả hai hàm trả về 0 khi thành công, và `-1` khi lỗi.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>

int main(void)
{
    char s[100];
    fpos_t pos;
    FILE *fp;

    fp = fopen("spoon.txt", "r");

    fgets(s, sizeof(s), fp); // đọc một dòng từ file
    printf("%s", s);

    fgetpos(fp, &pos);   // lưu vị trí sau khi đọc

    fgets(s, sizeof(s), fp); // đọc một dòng khác từ file
    printf("%s", s);

    fsetpos(fp, &pos);   // giờ khôi phục vị trí đã lưu

    fgets(s, sizeof(s), fp); // đọc lại dòng trước đó
    printf("%s", s);

    fclose(fp);
}
```

### Xem thêm {.unnumbered .unlisted}

[`fseek()`](#man-fseek),
[`ftell()`](#man-ftell),
[`rewind()`](#man-fseek)

[[manbreak]]
## `fseek()`, `rewind()` {#man-fseek}

[i[`fseek()` function]i]
[i[`rewind()` function]i]

Định vị file pointer để chuẩn bị cho lần đọc hoặc ghi kế tiếp

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>

int fseek(FILE *stream, long offset, int whence);

void rewind(FILE *stream);
```

### Mô tả {.unnumbered .unlisted}

Khi đọc ghi một file, OS theo dõi bạn đang ở đâu trong file bằng một
bộ đếm gọi chung là file pointer. Bạn có thể đặt lại file pointer
đến một điểm khác trong file bằng lời gọi `fseek()`. Coi nó như cách
truy cập ngẫu nhiên file.

Tham số đầu là file đang nói đến, hiển nhiên rồi. Tham số `offset`
là vị trí bạn muốn seek (seek / di chuyển) đến, và `whence` là cái
offset đó so với cái gì.

Dĩ nhiên, chắc bạn muốn nghĩ offset là tính từ đầu file. Ý tôi là,
"Seek đến vị trí 3490, cái đó nên là 3490 byte tính từ đầu file." Ồ,
nó _có thể_ thế, nhưng không bắt buộc. Hãy tưởng tượng sức mạnh bạn
đang nắm giữ. Cố kiềm chế sự hứng thú của bạn.

Bạn có thể đặt giá trị `whence` thành một trong ba thứ:

|`whence`|Mô tả|
|--------|---------------------------------------------|
|`SEEK_SET`|`offset` là tương đối so với đầu file. Đây chắc là cái bạn đang nghĩ, và là giá trị dùng phổ biến nhất cho `whence`.|
|`SEEK_CUR`|`offset` là tương đối so với vị trí file pointer hiện tại. Nên, thực tế, bạn có thể nói, "Di chuyển đến vị trí hiện tại cộng 30 byte," hoặc, "di chuyển đến vị trí hiện tại trừ 20 byte."|
|`SEEK_END`|`offset` là tương đối so với cuối file. Giống `SEEK_SET` nhưng tính từ đầu kia của file. Nhớ dùng giá trị âm cho `offset` nếu muốn lùi từ cuối file, thay vì đi quá đuôi vào hư vô.|

Nhắc đến seek ra khỏi cuối file, làm được không? Được luôn. Thực tế,
bạn có thể seek xa tít khỏi cuối rồi ghi một ký tự; file sẽ được mở
rộng ra đủ lớn để chứa cả đống số 0 ra đến ký tự đó.

Giờ hàm phức tạp đã xong, `rewind()` mà tôi vừa đề cập là gì? Nó đặt
lại file pointer về đầu file:

``` {.c}
fseek(fp, 0, SEEK_SET); // giống rewind()
rewind(fp);             // giống fseek(fp, 0, SEEK_SET)
```

### Giá trị trả về {.unnumbered .unlisted}

Với `fseek()`, khi thành công trả về 0; `-1` khi thất bại.

Lời gọi `rewind()` không bao giờ thất bại.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>

int main(void)
{
    FILE *fp;

    fp = fopen("spoon.txt", "r");

    fseek(fp, 100, SEEK_SET); // seek đến byte thứ 100 của file
    printf("100: %c\n", fgetc(fp));

    fseek(fp, -31, SEEK_CUR); // seek lùi 30 byte từ vị trí hiện tại
    printf("31 back: %c\n", fgetc(fp));

    fseek(fp, -12, SEEK_END); // seek đến byte thứ 10 trước cuối file
    printf("12 from end: %c\n", fgetc(fp));

    fseek(fp, 0, SEEK_SET);   // seek về đầu file
    rewind(fp);               // cũng seek về đầu file
    printf("Beginning: %c\n", fgetc(fp));

    fclose(fp);
}
```

### Xem thêm {.unnumbered .unlisted}

[`ftell()`](#man-ftell),
[`fgetpos()`](#man-fgetpos),
[`fsetpos()`](#man-fgetpos)

[[manbreak]]
## `ftell()` {#man-ftell}

[i[`ftell()` function]i]

Cho bạn biết một file sắp đọc từ hay ghi vào chỗ nào

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>

long ftell(FILE *stream);
```

### Mô tả {.unnumbered .unlisted}

Hàm này là ngược của [`fseek()`](#man-fseek). Nó cho bạn biết vị trí
trong file mà thao tác file kế tiếp sẽ xảy ra, tính từ đầu file.

Hữu ích nếu bạn muốn nhớ vị trí hiện tại trong file, `fseek()` đi
chỗ khác, rồi quay lại sau. Bạn có thể lấy giá trị trả về từ `ftell()`
và đưa lại vào `fseek()` (với tham số `whence` đặt là `SEEK_SET`) khi
muốn quay về vị trí trước đó.

### Giá trị trả về {.unnumbered .unlisted}

Trả về offset hiện tại trong file, hoặc `-1` khi lỗi.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>

int main(void)
{
    char c[6];
    FILE *fp;

    fp = fopen("spoon.txt", "r");

    long pos;

    // seek tới 10 byte:
    fseek(fp, 10, SEEK_SET);

    // lưu vị trí hiện tại vào biến "pos":
    pos = ftell(fp);

    // Đọc vài byte
    fread(c, sizeof c  - 1, 1, fp);
    c[5] = '\0';
    printf("Read: \"%s\"\n", c);

    // và quay về vị trí bắt đầu, đã lưu trong "pos":
    fseek(fp, pos, SEEK_SET);

    // Đọc lại đúng những byte đó
    fread(c, sizeof c  - 1, 1, fp);
    c[5] = '\0';
    printf("Read: \"%s\"\n", c);

    fclose(fp);
}
```

### Xem thêm {.unnumbered .unlisted}

[`fseek()`](#man-fseek),
[`rewind()`](#man-fseek),
[`fgetpos()`](#man-fgetpos),
[`fsetpos()`](#man-fgetpos)

[[manbreak]]
## `feof()`, `ferror()`, `clearerr()` {#man-feof}

[i[`feof()` function]i]
[i[`ferror()` function]i]
[i[`clearerr()` function]i]

Xác định xem file đã đến end-of-file chưa hoặc có lỗi không

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>

int feof(FILE *stream);

int ferror(FILE *stream);

void clearerr(FILE *stream);
```

### Mô tả {.unnumbered .unlisted}

Mỗi `FILE*` bạn dùng để đọc ghi dữ liệu với file đều chứa các flag
mà hệ thống set khi xảy ra sự kiện nhất định. Nếu bị lỗi, nó set cờ
lỗi; nếu đạt cuối file trong lúc đọc, nó set cờ EOF. Khá đơn giản.

Các hàm `feof()` và `ferror()` cho bạn cách đơn giản để test các flag
này: chúng sẽ trả về khác 0 (true) nếu được set.

Khi các flag đã được set cho một stream nào đó, chúng giữ nguyên đến
khi bạn gọi `clearerr()` để xoá.

### Giá trị trả về {.unnumbered .unlisted}

`feof()` và `ferror()` trả về khác 0 (true) nếu file đã đạt EOF hoặc
có lỗi, tương ứng.

### Ví dụ {.unnumbered .unlisted}

Đọc dữ liệu nhị phân, kiểm tra EOF hoặc lỗi:

``` {.c .numberLines}
#include <stdio.h>

int main(void)
{
    int a;
    FILE *fp;

    fp = fopen("numbers.dat", "r");

    // đọc từng int một, dừng khi EOF hoặc lỗi:

    while(fread(&a, sizeof(int), 1, fp), !feof(fp) && !ferror(fp)) {
        printf("Read %d\n", a);
    }

    if (feof(fp))
        printf("End of file was reached.\n");

    if (ferror(fp))
        printf("An error occurred.\n");

    fclose(fp);
}
```

### Xem thêm {.unnumbered .unlisted}

[`fopen()`](#man-fopen),
[`fread()`](#man-fread)

[[manbreak]]
## `perror()` {#man-perror}

[i[`perror()` function]i]

In thông báo lỗi gần nhất ra `stderr`

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdio.h>
#include <errno.h>  // chỉ cần nếu bạn muốn dùng trực tiếp biến "errno"

void perror(const char *s);
```

### Mô tả {.unnumbered .unlisted}

Nhiều hàm, khi gặp điều kiện lỗi vì bất cứ lý do gì, sẽ set cho bạn
một biến toàn cục tên `errno` (trong `<errno.h>`). `errno` chỉ là
một số nguyên đại diện cho một lỗi duy nhất.

Nhưng với bạn, người dùng, một con số thường không hữu ích lắm. Vì
lý do đó, bạn có thể gọi `perror()` sau khi xảy ra lỗi để in ra lỗi
thực sự đã xảy ra dưới dạng chuỗi dễ đọc cho con người.

Và để giúp bạn, bạn có thể truyền tham số `s` sẽ được đặt trước chuỗi
lỗi.

Một mẹo khéo khác là kiểm tra giá trị của `errno` (phải include
`errno.h` mới thấy nó) đối với các lỗi cụ thể và cho code của bạn
làm những việc khác nhau. Có lẽ bạn muốn bỏ qua một số lỗi nhưng
không phải lỗi khác, chẳng hạn.

Chuẩn chỉ định nghĩa ba giá trị cho `errno`, nhưng hệ thống của bạn
chắc chắn định nghĩa nhiều hơn. Ba giá trị được định nghĩa là:

|`errno`|Mô tả|
|-|-|
|`EDOM`|Phép toán ngoài miền.|
|`EILSEQ`|Sequence (chuỗi) không hợp lệ trong encoding multibyte (đa byte) sang wide character.|
|`ERANGE`|Kết quả phép toán không vừa kiểu đã chỉ định.|

Điểm cần chú ý là các hệ thống khác nhau định nghĩa giá trị `errno`
khác nhau, nên không portable lắm ngoài 3 cái trên. Tin tốt là ít
nhất các giá trị _phần lớn_ portable giữa các hệ thống giống Unix.

### Giá trị trả về {.unnumbered .unlisted}

Không trả về gì hết! Xin lỗi!

### Ví dụ {.unnumbered .unlisted}

[`fseek()`](#man-fseek) trả về `-1` khi lỗi, và set `errno`, vậy nên
dùng nó. Seek trên `stdin` vô nghĩa, nên sẽ sinh lỗi:

``` {.c .numberLines}
#include <stdio.h>
#include <errno.h> // phải include cái này để thấy "errno" trong ví dụ này

int main(void)
{
    if (fseek(stdin, 10L, SEEK_SET) < 0)
        perror("fseek");

    fclose(stdin); // ngừng dùng stream này

    if (fseek(stdin, 20L, SEEK_CUR) < 0) {

        // kiểm tra cụ thể errno để xem loại lỗi
        // nào đã xảy ra...cái này hoạt động trên Linux,
        // nhưng trên hệ khác có thể khác!

        if (errno == EBADF) {
            perror("fseek again, EBADF");
        } else {
            perror("fseek again");
        }
    }
}
```

Và output là:

``` {.default}
fseek: Illegal seek
fseek again, EBADF: Bad file descriptor
```

### Xem thêm {.unnumbered .unlisted}

[`feof()`](#man-feof),
[`ferror()`](#man-feof),
[`strerror()`](#man-strerror)


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
