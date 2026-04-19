<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<setjmp.h>` Goto Không Cục Bộ {#setjmp}

[i[`setjmp.h` header file]i]

Các hàm này cho phép bạn tua ngược call stack về một điểm trước đó,
với một đống cái bẫy đi kèm. Hiếm khi được dùng.

|Hàm|Mô tả|
|--------|----------------------|
|`longjmp()`|Quay về chỗ đánh dấu đã đặt trước đó|
|`setjmp()`|Đánh dấu chỗ này để quay về sau|

Còn có một kiểu mờ (opaque type) mới, `jmp_buf`, giữ toàn bộ thông
tin cần thiết để làm được trò ảo thuật này.

Nếu bạn muốn biến local tự động của mình vẫn đúng sau lời gọi
`longjmp()`, khai báo chúng là `volatile` ở chỗ bạn gọi `setjmp()`.

[[manbreak]]
## `setjmp()` {#man-setjmp}

[i[`setjmp()` function]i]

Lưu vị trí này để quay về sau

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <setjmp.h>

int setjmp(jmp_buf env);
```

### Mô tả {.unnumbered .unlisted}

Đây là cách bạn lưu vị trí để sau này có thể `longjmp()` quay về.
Coi như đang set điểm warp để dùng sau.

Về cơ bản, bạn gọi hàm này, đưa cho nó một `env` để nó điền vào mọi
thông tin cần thiết để quay lại đây sau. Cái `env` này là thứ bạn
sẽ truyền cho `longjmp()` sau này khi muốn teleport về đây.

Và phần funky thực sự là hàm này có thể trả về theo hai kiểu khác
nhau:

1. Có thể trả về `0` từ lời gọi set up điểm jump đích.

2. Có thể trả về non-zero khi bạn thực sự warp về đây từ lời gọi
   `longjmp()`.

Bạn có thể kiểm tra giá trị trả về để biết case nào đang xảy ra.

Bạn chỉ được gọi `setjmp()` trong một số trường hợp giới hạn.

1. Như một biểu thức đứng riêng:

   ``` {.c}
   setjmp(env);
   ```

   Bạn cũng có thể cast nó về `(void)` nếu vì lý do gì đó muốn làm
   vậy.

2. Như biểu thức điều khiển đầy đủ trong `if` hoặc `switch`. 

   ``` {.c}
   if (setjmp(env)) { ... }
   
   switch (setjmp(env)) { ... }
   ```

   Nhưng không được thế này, vì nó không phải biểu thức điều khiển
   đầy đủ trong trường hợp này:

   ``` {.c}
   if (x == 2 && setjmp()) { ... }   // Undefined behavior
   ```

3. Giống (2) phía trên, trừ việc có so sánh với integer constant:

   ``` {.c}
   if (setjmp(env) == 0) { ... }

   if (setjmp(env) > 2) { ... }
   ```

4. Như toán hạng cho toán tử phủ định (`!`):

   ``` {.c}
   if (!setjmp(env)) { ... }
   ```

Mọi thứ khác đều là (bạn đoán đúng rồi) undefined behavior!

Đây có thể là macro hoặc hàm, nhưng bạn xử nó cùng cách trong mọi
trường hợp.

### Giá trị trả về {.unnumbered .unlisted}

Cái này funky. Nó trả về một trong hai thứ:

Trả về `0` nếu đây là lời gọi `setjmp()` để set up.

Trả về non-zero nếu việc đang ở đây là kết quả của lời gọi
`longjmp()`. (Cụ thể, nó trả về giá trị được truyền vào hàm
`longjmp()`.)

### Ví dụ {.unnumbered .unlisted}

Đây là một hàm gọi `setjmp()` để set up (nơi nó trả về `0`), rồi
gọi xuống sâu vài level vào các hàm, và cuối cùng cắt ngang đường
return bằng `longjmp()` quay về chỗ `setjmp()` đã được gọi trước
đó. Lần này, nó truyền `3490` làm giá trị, và `setjmp()` sẽ trả về
giá trị đó.

``` {.c .numberLines}
#include <stdio.h>
#include <setjmp.h>

jmp_buf env;

void depth2(void)
{
    printf("Entering depth 2\n");
    longjmp(env, 3490);           // Nhảy về setjmp()!!
    printf("Leaving depth 2\n");  // Cái này không chạy
}

void depth1(void)
{
    printf("Entering depth 1\n");
    depth2();
    printf("Leaving depth 1\n");  // Cái này không chạy
}

int main(void)
{
    switch (setjmp(env)) {
        case 0:
            printf("Calling into functions, setjmp() returned 0\n");
            depth1();
            printf("Returned from functions\n");  // Cái này không chạy
            break;

        case 3490:
            printf("Bailed back to main, setjmp() returned 3490\n");
            break;
    }
}
```

Chạy thì output:

``` {.default}
Calling into functions, setjmp() returned 0
Entering depth 1
Entering depth 2
Bailed back to main, setjmp() returned 3490
```

Chú ý `printf()` thứ hai trong `case 0` không chạy; nó bị
`longjmp()` nhảy qua!

### Xem thêm {.unnumbered .unlisted}

[`longjmp()`](#man-longjmp)

[[manbreak]]
## `longjmp()` {#man-longjmp}

[i[`longjmp()` function]i]

Quay về vị trí `setjmp()` trước đó

### Synopsis {.unnumbered .unlisted}

``` {.c}
 #include <setjmp.h>

_Noreturn void longjmp(jmp_buf env, int val);
```

### Mô tả {.unnumbered .unlisted}

Hàm này trả về một lời gọi `setjmp()` trước đó trong call history.
`setjmp()` sẽ trả về giá trị `val` được truyền vào `longjmp()`.

`env` truyền cho `setjmp()` nên là chính cái bạn truyền cho
`longjmp()`.

Có cả đống vấn đề tiềm tàng khi làm chuyện này, nên bạn phải cẩn
thận tránh undefined behavior bằng cách không làm mấy điều sau:

1. Đừng gọi `longjmp()` nếu lời gọi `setjmp()` tương ứng nằm trong
   thread khác.

2. Đừng gọi `longjmp()` nếu bạn chưa gọi `setjmp()` trước đó.

3. Đừng gọi `longjmp()` nếu hàm đã gọi `setjmp()` đã hoàn thành.

4. Đừng gọi `longjmp()` nếu lời gọi `setjmp()` có một variable
   length array (VLA) trong scope và scope đó đã kết thúc.

5. Đừng gọi `longjmp()` nếu có bất kỳ VLA nào trong các scope đang
   active giữa `setjmp()` và `longjmp()`. Nguyên tắc nằm lòng ở đây
   là đừng mix VLA với `longjmp()`.

Dù `longjmp()` cố gắng khôi phục máy về trạng thái lúc `setjmp()`,
gồm cả biến local, vẫn có vài thứ không được hồi sinh lại:

* Biến local không phải volatile mà có thể đã thay đổi
* Floating point status flags
* File đang mở
* Bất kỳ thành phần nào khác của abstract machine

### Giá trị trả về {.unnumbered .unlisted}

Cái này cũng funky ở chỗ nó là một trong số ít hàm của C không bao
giờ trả về!

### Ví dụ {.unnumbered .unlisted}

Đây là một hàm gọi `setjmp()` để set up (nơi nó trả về `0`), rồi
gọi xuống sâu vài level vào các hàm, và cuối cùng cắt ngang đường
return bằng `longjmp()` quay về chỗ `setjmp()` đã được gọi trước
đó. Lần này, nó truyền `3490` làm giá trị, và `setjmp()` sẽ trả về
giá trị đó.

``` {.c .numberLines}
#include <stdio.h>
#include <setjmp.h>

jmp_buf env;

void depth2(void)
{
    printf("Entering depth 2\n");
    longjmp(env, 3490);           // Nhảy về setjmp()!!
    printf("Leaving depth 2\n");  // Cái này không chạy
}

void depth1(void)
{
    printf("Entering depth 1\n");
    depth2();
    printf("Leaving depth 1\n");  // Cái này không chạy
}

int main(void)
{
    switch (setjmp(env)) {
        case 0:
            printf("Calling into functions, setjmp() returned 0\n");
            depth1();
            printf("Returned from functions\n");  // Cái này không chạy
            break;

        case 3490:
            printf("Bailed back to main, setjmp() returned 3490\n");
            break;
    }
}
```

Chạy thì output:

``` {.default}
Calling into functions, setjmp() returned 0
Entering depth 1
Entering depth 2
Bailed back to main, setjmp() returned 3490
```

Chú ý `printf()` thứ hai trong `case 0` không chạy; nó bị
`longjmp()` nhảy qua!

### Xem thêm {.unnumbered .unlisted}

[`setjmp()`](#man-setjmp)

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
