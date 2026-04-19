<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<stdarg.h>` Tham Số Biến Đổi {#stdarg}

[i[`stdarg.h` header file]i]

|Macro|Mô tả|
|--------|----------------------|
|[`va_arg()`](#man-va_arg)|Lấy tham số biến đổi kế tiếp|
|[`va_copy()`](#man-va_copy)|Copy một `va_list` và công việc đã làm tới thời điểm đó|
|[`va_end()`](#man-va_end)|Báo hiệu ta đã xử lý xong tham số biến đổi|
|[`va_start()`](#man-va_start)|Khởi tạo một `va_list` để bắt đầu xử lý tham số biến đổi|

Header file này là cái cho phép bạn viết hàm nhận số lượng tham số
biến đổi.

Ngoài các macro, bạn còn có một kiểu mới giúp C theo dõi vị trí
đang xử lý đến đâu trong quá trình xử lý tham số biến đổi:
[i[`va_list` type]i] `va_list`. Kiểu này là opaque, và bạn sẽ
truyền nó quanh các macro khác nhau để giúp lấy tham số.

Chú ý mỗi hàm variadic cần ít nhất một tham số non-variable. Bạn
cần cái này để khởi động xử lý với `va_start()`.

[[manbreak]]
## `va_arg()` {#man-va_arg}

[i[`va_arg()` macro]i]

Lấy tham số biến đổi kế tiếp

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdarg.h>

type va_arg(va_list ap, type);
```

### Mô tả {.unnumbered .unlisted}

Nếu bạn có variable argument list đã được khởi tạo bằng
`va_start()`, truyền nó vào đây cùng với kiểu của tham số bạn đang
muốn lấy, ví dụ:

``` {.c}
int   x = va_arg(args, int);
float y = va_arg(args, float);
```

### Giá trị trả về {.unnumbered .unlisted}

Eval thành giá trị và kiểu của tham số biến đổi kế tiếp.

### Ví dụ {.unnumbered .unlisted}

Đây là demo cộng số lượng integer tuỳ ý lại với nhau. Tham số đầu
tiên là số lượng integer cần cộng. Ta sẽ dùng cái đó để biết phải
gọi `va_arg()` bao nhiêu lần.

``` {.c .numberLines}
#include <stdio.h>
#include <stdarg.h>

int add(int count, ...)
{
    int total = 0;
    va_list va;

    va_start(va, count);   // Bắt đầu với tham số sau "count"

    for (int i = 0; i < count; i++) {
        int n = va_arg(va, int);   // Lấy int kế tiếp

        total += n;
    }

    va_end(va);  // Xong hết

    return total;
}

int main(void)
{
    printf("%d\n", add(4, 6, 2, -4, 17));  // 6 + 2 - 4 + 17 = 21
    printf("%d\n", add(2, 22, 44));        // 22 + 44 = 66
}
```

### Xem thêm {.unnumbered .unlisted}

[`va_start()`](#man-va_start),
[`va_end()`](#man-va_end)

[[manbreak]]
## `va_copy()` {#man-va_copy}

[i[`va_copy()` macro]i]

Copy một `va_list` và công việc đã làm tới thời điểm đó

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdarg.h>

void va_copy(va_list dest, va_list src);
```

### Mô tả {.unnumbered .unlisted}

Mục đích chính của hàm này là lưu trạng thái giữa chừng trong quá
trình xử lý tham số biến đổi để bạn có thể scan tới rồi rewind lại
chỗ đã lưu.

Bạn truyền vào `src` `va_list` và nó copy sang `dest`.

Nếu đã gọi hàm này một lần cho một `dest` cụ thể, bạn không được
gọi lại (hay gọi `va_start()`) với cùng `dest` đó trừ khi bạn gọi
`va_end()` cho cái `dest` đó trước.

``` {.c}
va_copy(dest, src);
va_copy(dest, src2);  // SAI!

va_copy(dest, src);
va_start(dest, var);  // SAI!

va_copy(dest, src);
va_end(dest);
va_copy(dest, src2);  // OK!

va_copy(dest, src);
va_end(dest);
va_start(dest, var);  // OK!
```

### Giá trị trả về {.unnumbered .unlisted}

Không trả về gì.

### Ví dụ {.unnumbered .unlisted}

Đây là ví dụ cộng tất cả tham số biến đổi lại, rồi quay lại cộng
thêm tất cả các số từ thứ ba trở đi nữa, ví dụ nếu tham số là:

``` {.default}
10 20 30 40
```

Đầu tiên ta cộng tất cả được `100`, rồi cộng thêm mọi thứ từ số
thứ ba, tức cộng `30+40`, tổng ra `170`.

Ta sẽ làm vậy bằng cách lưu vị trí trong quá trình xử lý tham số
biến đổi với `va_copy`, rồi dùng nó sau để xử lý lại phần tham số
đuôi.

(Và đúng rồi, tôi biết có cách toán học làm chuyện này mà không cần
rewind, nhưng tôi đang khó lòng nghĩ ra ví dụ hay!)

``` {.c .numberLines}
#include <stdio.h>
#include <stdarg.h>

// Cộng tất cả các số lại, rồi cộng lại lần nữa tất cả các số
// từ sau số thứ hai.
int contrived_adder(int count, ...)
{
    if (count < 3) return 0; // OK, tôi đang lười. Bắt được rồi đó.

    int total = 0;

    va_list args, mid_args;

    va_start(args, count);

    for (int i = 0; i < count; i++) {

        // Nếu ta đang ở số thứ hai, lưu chỗ vào
        // mid_args:

        if (i == 2)
            va_copy(mid_args, args);

        total += va_arg(args, int);
    }

    va_end(args); // Xong cái này

    // Nhưng giờ bắt đầu với mid_args và cộng hết những cái đó:
    for (int i = 0; i < count - 2; i++)
        total += va_arg(mid_args, int);

    va_end(mid_args); // Xong cái này luôn

    return total;
}

int main(void)
{
    // 10+20+30 + 30 == 90
    printf("%d\n", contrived_adder(3, 10, 20, 30));

    // 10+20+30+40+50 + 30+40+50 == 270
    printf("%d\n", contrived_adder(5, 10, 20, 30, 40, 50));
}
```

### Xem thêm {.unnumbered .unlisted}

[`va_start()`](#man-va_start),
[`va_arg()`](#man-va_arg),
[`va_end()`](#man-va_end)

[[manbreak]]
## `va_end()` {#man-va_end}

[i[`va_end()` macro]i]

Báo hiệu ta đã xử lý xong tham số biến đổi

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdarg.h>

void va_end(va_list ap);
```

### Mô tả {.unnumbered .unlisted}

Sau khi bạn đã `va_start()` hoặc `va_copy` một `va_list` mới, bạn
**phải** gọi `va_end()` với nó trước khi nó ra khỏi scope. 

Bạn cũng phải làm vậy nếu định gọi `va_start()` hoặc `va_copy()`
_lại_ trên biến mà bạn đã làm vậy rồi.

Đó là luật nếu bạn muốn tránh undefined behavior.

Nhưng cứ nghĩ nó như cleanup thôi. Bạn gọi `va_start()`, nên bạn sẽ
gọi `va_end()` khi xong.

### Giá trị trả về {.unnumbered .unlisted}

Không trả về gì.

### Ví dụ {.unnumbered .unlisted}

Đây là demo cộng số lượng integer tuỳ ý lại với nhau. Tham số đầu
tiên là số lượng integer cần cộng. Ta sẽ dùng cái đó để biết phải
gọi `va_arg()` bao nhiêu lần.

``` {.c .numberLines}
#include <stdio.h>
#include <stdarg.h>

int add(int count, ...)
{
    int total = 0;
    va_list va;

    va_start(va, count);   // Bắt đầu với tham số sau "count"

    for (int i = 0; i < count; i++) {
        int n = va_arg(va, int);   // Lấy int kế tiếp

        total += n;
    }

    va_end(va);  // Xong hết

    return total;
}

int main(void)
{
    printf("%d\n", add(4, 6, 2, -4, 17));  // 6 + 2 - 4 + 17 = 21
    printf("%d\n", add(2, 22, 44));        // 22 + 44 = 66
}
```

### Xem thêm {.unnumbered .unlisted}

[`va_start()`](#man-va_start),
[`va_copy()`](#man-va_copy)

[[manbreak]]
## `va_start()` {#man-va_start}

[i[`va_start()` macro]i]

Khởi tạo một `va_list` để bắt đầu xử lý tham số biến đổi

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdarg.h>

void va_start(va_list ap, parmN);
```

### Mô tả {.unnumbered .unlisted}

Bạn đã khai báo một biến kiểu `va_list` để theo dõi quá trình xử
lý tham số biến đổi... giờ làm sao khởi tạo nó để có thể bắt đầu
gọi `va_arg()` lấy các tham số đó?

`va_start()` ra tay cứu nguy!

Việc bạn làm là truyền `va_list` của bạn vào, ở đây thể hiện qua
tham số `ap`. Chỉ truyền list, không truyền pointer tới nó.

Rồi cho tham số thứ hai của `va_start()`, bạn đưa tên tham số mà
bạn muốn bắt đầu xử lý tham số _sau_ nó. Cái này phải là tham số
ngay trước `...` trong danh sách tham số.

Nếu bạn đã gọi `va_start()` trên một `va_list` cụ thể và muốn gọi
`va_start()` lại trên nó, bạn **phải** gọi `va_end()` trước!

### Giá trị trả về {.unnumbered .unlisted}

Không trả về gì!

### Ví dụ {.unnumbered .unlisted}

Đây là demo cộng số lượng integer tuỳ ý lại với nhau. Tham số đầu
tiên là số lượng integer cần cộng. Ta sẽ dùng cái đó để biết phải
gọi `va_arg()` bao nhiêu lần.

``` {.c .numberLines}
#include <stdio.h>
#include <stdarg.h>

int add(int count, ...)
{
    int total = 0;
    va_list va;

    va_start(va, count);   // Bắt đầu với tham số sau "count"

    for (int i = 0; i < count; i++) {
        int n = va_arg(va, int);   // Lấy int kế tiếp

        total += n;
    }

    va_end(va);  // Xong hết

    return total;
}

int main(void)
{
    printf("%d\n", add(4, 6, 2, -4, 17));  // 6 + 2 - 4 + 17 = 21
    printf("%d\n", add(2, 22, 44));        // 22 + 44 = 66
}
```

### Xem thêm {.unnumbered .unlisted}

[`va_arg()`](#man-va_arg),
[`va_end()`](#man-va_end)

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
