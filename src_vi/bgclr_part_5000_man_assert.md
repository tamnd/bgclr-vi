<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<assert.h>` Runtime and Compile-time Diagnostics {#assert}

[i[`assert.h` header file]i]

|Macro|Mô tả|
|--------|----------------------|
|`assert()`|Assertion lúc chạy|
|`static_assert()`|Assertion lúc compile|

Chức năng này liên quan tới những thứ Không-Bao-Giờ-Nên-Xảy-Ra™. Nếu
có điều gì đó lẽ ra không bao giờ đúng và bạn muốn chương trình nổ
tung khi nó xảy ra, đây là header dành cho bạn.

Có hai loại assertion: assertion lúc compile (gọi là "static
assertion") và assertion lúc chạy (runtime). Nếu assertion _thất
bại_ (nghĩa là thứ bạn cần đúng thì hoá ra không đúng), chương trình
sẽ nổ tung ở compile-time hoặc runtime.

## Macro

[i[`NDEBUG` macro]i<]

Nếu bạn define macro `NDEBUG` **trước khi** include `<assert.h>`,
macro `assert()` sẽ không còn tác dụng. Bạn có thể define `NDEBUG`
thành bất cứ thứ gì, nhưng `1` có vẻ là giá trị hợp lý.

Vì `assert()` làm chương trình nổ tung lúc chạy, chắc là bạn không
muốn hành vi đó khi lên production. Define `NDEBUG` sẽ khiến
`assert()` bị bỏ qua.

`NDEBUG` không ảnh hưởng tới `static_assert()`.

[i[`NDEBUG` macro]i>]

[[manbreak]]
## `assert()` {#man-assert}

[i[`assert()` macro]i]

Nổ tung lúc chạy nếu một điều kiện thất bại

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <assert.h>

void assert(scalar expression);
```

### Mô tả {.unnumbered .unlisted}

Bạn truyền một biểu thức vào macro này. Nếu nó đánh giá ra false,
chương trình sẽ crash với assertion failure (bằng cách gọi hàm
`abort()`).

Về cơ bản, bạn đang nói, "Này, tôi đang giả định điều kiện này là
true, và nếu không phải vậy, tôi không muốn chạy tiếp nữa."

Cái này được dùng khi debug để đảm bảo không có điều kiện bất ngờ
nào phát sinh. Và nếu trong quá trình phát triển bạn thấy điều kiện
đó có phát sinh thật, có thể bạn nên sửa code để xử lý nó trước khi
lên production.

Nếu bạn đã define macro `NDEBUG` thành bất kỳ giá trị nào trước khi
`<assert.h>` được include, macro `assert()` sẽ bị bỏ qua. Đây là ý
hay trước khi ra production.

Khác với `static_assert()`, macro này không cho bạn in một thông báo
tuỳ ý. Nếu bạn muốn làm vậy, có thể tự viết một assert riêng dạng
preprocessor macro:

``` {.c}
#define ASSERT(c, m) \
do { \
    if (!(c)) { \
        fprintf(stderr, __FILE__ ":%d: assertion %s failed: %s\n", \
                        __LINE__, #c, m); \
        exit(1); \
    } \
} while(0)
```

### Giá trị trả về {.unnumbered .unlisted}

Macro này không return (vì nó gọi `abort()`, không bao giờ return).

Nếu `NDEBUG` được set, macro đánh giá ra `((void)0)`, không làm gì
cả.

### Ví dụ {.unnumbered .unlisted}

Đây là hàm chia kích thước đàn dê của ta. Nhưng ta giả định sẽ
không bao giờ bị truyền `0` vào.

Nên ta assert `amount != 0`... và nếu có, chương trình abort.

``` {.c .numberLines}
//#define NDEBUG 1   // bỏ comment để tắt assert

#include <stdio.h>
#include <assert.h>

int goat_count = 10;

void divide_goat_herd_by(int amount)
{
    assert(amount != 0);

    goat_count /= amount;
}  

int main(void)
{
    divide_goat_herd_by(2);  // OK

    divide_goat_herd_by(0);  // Kích hoạt assert
}
```

Khi tôi chạy và truyền `0` cho hàm, tôi nhận được output sau trên hệ
của tôi (output cụ thể có thể khác):

``` {.default}
assert: assert.c:10: divide_goat_herd_by: Assertion `amount != 0' failed.
```

### Xem thêm {.unnumbered .unlisted}

[`static_assert()`](#man-static_assert),
[`abort()`](#man-abort)

[[manbreak]]
## `static_assert()` {#man-static_assert}

[i[`static_assert()` macro]i]

Nổ tung lúc compile nếu một điều kiện thất bại

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <assert.h>

static_assert(constant-expression, string-literal);
```

### Mô tả {.unnumbered .unlisted}

Macro này ngăn chương trình của bạn được compile luôn nếu một điều
kiện không đúng.

Và nó in ra string literal bạn đưa cho nó.

Cơ bản là nếu `constant-expression` là false, việc compile sẽ
dừng và `string-literal` sẽ được in ra.

Constant expression phải thực sự là hằng, chỉ giá trị, không biến.
String literal cũng vậy: không biến, chỉ là literal string đặt
trong dấu ngoặc kép. (Phải như vậy vì chương trình chưa chạy ở thời
điểm này.)

### Giá trị trả về {.unnumbered .unlisted}

Không áp dụng, vì đây là chức năng compile-time.

### Ví dụ {.unnumbered .unlisted}

Đây là một ví dụ phần, với một thuật toán mà hiệu năng hay bộ nhớ
chắc là tệ nếu kích thước mảng local quá lớn. Ta phòng trường hợp
đó ngay lúc compile bằng cách bắt nó với `static_assert()`.

``` {.c .numberLines}
#include <stdio.h>
#include <assert.h>

#define ARRAY_SIZE 16

int main(void)
{
    static_assert(ARRAY_SIZE > 32, "ARRAY_SIZE too small");

    int a[ARRAY_SIZE];

    a[32] = 10;

    printf("%d\n", a[32]);
}
```

Trên hệ của tôi, khi tôi cố compile, nó in ra (output có thể khác
trên hệ khác):

``` {.default}
In file included from static_assert.c:2:
static_assert.c: In function ‘main’:
static_assert.c:8:5: error: static assertion failed: "ARRAY_SIZE too small"
    8 |     static_assert(ARRAY_SIZE > 32, "ARRAY_SIZE too small");
      |     ^~~~~~~~~~~~~
```

### Xem thêm {.unnumbered .unlisted}

[`assert()`](#man-assert)

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
