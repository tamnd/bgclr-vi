<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<signal.h>` Xử Lý Signal {#signal}

[i[`signal.h` header file]i]

|Hàm|Mô tả|
|--------|----------------------|
|[`signal()`](#man-signal)|Đặt signal handler cho một signal|
|[`raise()`](#man-raise)|Làm cho một signal được raise lên|

Xử lý signal kiểu portable, đại khái!

Các signal này được raise vì đủ lý do như người dùng bấm CTRL-C, yêu
cầu terminate từ chương trình ngoài, vi phạm truy cập bộ nhớ, vân
vân.

OS của bạn nhiều khả năng còn định nghĩa thêm cả đống signal khác.

Hệ thống này khá giới hạn, như bạn sẽ thấy bên dưới. Nếu bạn trên
Unix, gần như chắc chắn OS của bạn có khả năng xử lý signal xịn hơn
hẳn so với thư viện chuẩn C. Xem
[flm[`sigaction`|sigaction.2.en]].

[[manbreak]]
## `signal()` {#man-signal}

[i[`signal()` function]i]

Đặt signal handler cho một signal

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <signal.h>

void (*signal(int sig, void (*func)(int)))(int);
```

### Mô tả {.unnumbered .unlisted}

Cái khai báo hàm _đó_ nhìn sao ta?

Thôi bỏ qua nó một chút, nói về hàm này làm gì đã.

Khi một signal được raise, _điều gì đó_ sẽ xảy ra. Hàm này cho phép
bạn chọn một trong các việc sau để làm khi signal xảy ra:

* Bỏ qua signal
* Thực hiện hành động mặc định
* Có một hàm cụ thể được gọi

Hàm `signal()` nhận hai tham số. Tham số đầu, `sig`, là tên signal
cần xử lý.

|Signal|Mô tả|
|-|-|
|`SIGABRT`|Được raise khi `abort()` được gọi|
|`SIGFPE`|Exception số học floating-point|
|`SIGILL`|CPU thử thực thi lệnh không hợp lệ|
|`SIGINT`|Signal interrupt, như khi `CTRL-C` được bấm|
|`SIGSEGV`|Segmentation Violation: thử truy cập bộ nhớ bị cấm|
|`SIGTERM`|Yêu cầu terminate[^b43b]|

[^b43b]: Như kiểu được gửi từ lệnh `kill` trên Unix.]

Vậy đó là phần đầu khi bạn gọi `signal()`---nói cho nó biết signal
cần xử:

``` {.c}
signal(SIGINT, ...
```

Nhưng tham số `func` kia là gì?

Tiết lộ luôn, đó là pointer tới một hàm nhận tham số `int` và trả
về `void`. Ta có thể dùng nó để gọi một hàm tuỳ ý khi signal xảy
ra.

Trước khi làm chuyện đó, xem mấy cái dễ trước: bảo hệ thống bỏ qua
signal hoặc thực hiện hành động mặc định (đây là cái nó làm mặc
định nếu bạn không bao giờ gọi `signal()`).

Bạn có thể đặt `func` bằng một trong hai giá trị đặc biệt để làm
chuyện này:

|`func`|Mô tả|
|-|-|
|`SIG_DFL`|Thực hiện hành động mặc định cho signal này|
|`SIG_IGN`|Bỏ qua signal này|

Ví dụ:

``` {.c}
signal(SIGTERM, SIG_DFL);  // Hành động mặc định với SIGTERM
signal(SIGINT, SIG_IGN);   // Bỏ qua SIGINT
```

Nhưng nếu bạn muốn handler của riêng mình làm gì đó thay vì default
hay ignore thì sao? Bạn có thể truyền vào một hàm của bạn để được
gọi. Đó là lý do cái function signature điên rồ kia tồn tại (một
phần). Nó nói rằng tham số có thể là con trỏ tới hàm nhận tham số
`int` và trả về `void`.

Vậy nếu bạn muốn gọi handler của mình, bạn có thể viết code thế
này:

``` {.c}
int handler(int sig)
{
    // Xử lý signal
}

int main(void)
{
    signal(SIGINT, handler);
```

Trong signal handler bạn có thể làm gì? Không nhiều.

Nếu signal là do `abort()` hoặc `raise()`, handler không được gọi
`raise()`.

Nếu signal **không** phải do `abort()` hoặc `raise()`, bạn chỉ được
gọi mấy hàm sau từ thư viện chuẩn (dù spec không cấm gọi các hàm
non-library khác):

* [`abort()`](#man-abort)
* [`_Exit()`](#man-exit)
* [`quick_exit()`](#man-exit)
* Hàm trong [`<stdatomic.h>`](#stdatomic) khi tham số atomic là
  lock-free
* `signal()` với tham số đầu bằng tham số được truyền vào handler

Thêm nữa, nếu signal **không** phải do `abort()` hoặc `raise()`,
handler không được truy cập bất kỳ object nào có static hoặc
thread-storage duration trừ khi nó là lock-free.

Ngoại lệ là bạn có thể gán cho biến kiểu `volatile sig_atomic_t`.
Spec không rõ liệu bạn có đọc được biến kiểu đó không. Tôi nghĩ bạn
làm vậy an toàn, nhưng lúc bạn quyết định vừa đọc vừa ghi biến đó
trong handler, bạn đã mở cửa cho khả năng race condition. Chắc tốt
nhất là chỉ set nó như một flag báo signal đã xảy ra và để thế giới
bên ngoài xử lý.

Tuỳ implementation, nhưng signal handler có thể bị reset về
`SIG_DFL` ngay trước khi handler được gọi.

Gọi `signal()` trong chương trình multithread là undefined
behavior.

Return từ handler cho `SIGFPE`, `SIGILL`, `SIGSEGV`, hoặc bất kỳ
giá trị implementation-defined nào là undefined behavior. Bạn phải
exit.

Implementation có thể ngăn hoặc không ngăn các signal khác phát
sinh khi đang ở trong signal handler.

### Giá trị trả về {.unnumbered .unlisted}

Khi thành công, `signal()` trả về con trỏ tới signal handler trước
đó đã được đặt qua lời gọi `signal()` cho signal number đó. Nếu bạn
chưa từng gọi `signal()` để đặt, trả về `SIG_DFL`.

Khi thất bại, `SIG_ERR` được trả về và `errno` được set thành một
giá trị dương.

### Ví dụ {.unnumbered .unlisted}

Đây là chương trình khiến `SIGINT` bị bỏ qua. Thông thường bạn
trigger signal này bằng cách bấm `CTRL-C`.

``` {.c .numberLines}
#include <stdio.h>
#include <signal.h>

int main(void)
{
    signal(SIGINT, SIG_IGN);

    printf("You can't hit CTRL-C to exit this program. Try it!\n\n");
    printf("Press return to exit, instead.");
    fflush(stdout);
    getchar();
}
``` 

Output:

``` {.default}
You can't hit CTRL-C to exit this program. Try it!

Press return to exit, instead.^C^C^C^C^C^C^C^C^C^C^C
```

Chương trình này đặt signal handler, rồi raise signal. Signal
handler được kích hoạt.

``` {.c .numberLines}
#include <stdio.h>
#include <signal.h>

void handler(int sig)
{
    // Undefined behavior khi gọi printf() nếu handler này không
    // phải do raise(), tức là nếu bạn bấm CTRL-C.

    printf("Got signal %d!\n", sig);

    // Thường reset handler phòng khi implementation set nó về
    // SIG_DFL khi signal xảy ra.

    signal(sig, handler);
}

int main(void)
{
    signal(SIGINT, handler);

    raise(SIGINT);
    raise(SIGINT);
    raise(SIGINT);
}
```

Output:

``` {.default}
Got signal 2!
Got signal 2!
Got signal 2!
```

Ví dụ này bắt `SIGINT` rồi set một flag thành `1`. Rồi main loop
thấy flag và exit.

``` {.c .numberLines}
#include <stdio.h>
#include <signal.h>

volatile sig_atomic_t x;

void handler(int sig)
{
    x = 1;
}

int main(void)
{
    signal(SIGINT, handler);

    printf("Hit CTRL-C to exit\n");
    while (x != 1);
}
```

### Xem thêm {.unnumbered .unlisted}

[`raise()`](#man-raise),
[`abort()`](#man-abort)

[[manbreak]]
## `raise()` {#man-raise}

[i[`raise()` function]i]

Làm cho một signal được raise lên

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <signal.h>

int raise(int sig);
```

### Mô tả {.unnumbered .unlisted}

Làm cho signal handler cho signal `sig` được gọi. Nếu handler là
`SIG_DFL` hoặc `SIG_IGN`, thì hành động mặc định hoặc không gì cả
sẽ xảy ra.

`raise()` trả về sau khi signal handler đã chạy xong.

Thú vị là, nếu bạn gây ra signal bằng `raise()`, bạn có thể gọi các
hàm thư viện từ trong signal handler mà không gây undefined
behavior. Tuy nhiên tôi không chắc sự thật đó hữu dụng thực tế ở
chỗ nào.

### Giá trị trả về {.unnumbered .unlisted}

Trả về `0` khi thành công. Khác `0` nếu không.

### Ví dụ {.unnumbered .unlisted}

Chương trình này đặt signal handler, rồi raise signal. Signal
handler được kích hoạt.

``` {.c .numberLines}
#include <stdio.h>
#include <signal.h>

void handler(int sig)
{
    // Undefined behavior khi gọi printf() nếu handler này không
    // phải do raise(), tức là nếu bạn bấm CTRL-C.

    printf("Got signal %d!\n", sig);

    // Thường reset handler phòng khi implementation set nó về
    // SIG_DFL khi signal xảy ra.

    signal(sig, handler);
}

int main(void)
{
    signal(SIGINT, handler);

    raise(SIGINT);
    raise(SIGINT);
    raise(SIGINT);
}
```

Output:

``` {.default}
Got signal 2!
Got signal 2!
Got signal 2!
```

### Xem thêm {.unnumbered .unlisted}

[`signal()`](#man-signal)

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
