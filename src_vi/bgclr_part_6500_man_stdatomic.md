<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<stdatomic.h>` Các Hàm Liên Quan Đến Atomic {#stdatomic}

[i[`stdatomic.h` header file]i]

|Hàm|Mô tả|
|-|-|
|[`atomic_compare_exchange_strong_explicit()`](#man-atomic_compare_exchange)|Compare-and-exchange nguyên tử, strong, explicit|
|[`atomic_compare_exchange_strong()`](#man-atomic_compare_exchange)|Compare-and-exchange nguyên tử, strong|
|[`atomic_compare_exchange_weak_explicit()`](#man-atomic_compare_exchange)|Compare-and-exchange nguyên tử, weak, explicit|
|[`atomic_compare_exchange_weak()`](#man-atomic_compare_exchange)|Compare-and-exchange nguyên tử, weak|
|[`atomic_exchange_explicit()`](#man-atomic_exchange)|Thay giá trị trong một object nguyên tử, explicit|
|[`atomic_exchange()`](#man-atomic_exchange)|Thay giá trị trong một object nguyên tử|
|[`atomic_fetch_add_explicit()`](#man-atomic_fetch)|Cộng nguyên tử vào một số nguyên atomic, explicit|
|[`atomic_fetch_add()`](#man-atomic_fetch)|Cộng nguyên tử vào một số nguyên atomic|
|[`atomic_fetch_and_explicit()`](#man-atomic_fetch)|AND bit nguyên tử một số nguyên atomic, explicit|
|[`atomic_fetch_and()`](#man-atomic_fetch)|AND bit nguyên tử một số nguyên atomic|
|[`atomic_fetch_or_explicit()`](#man-atomic_fetch)|OR bit nguyên tử một số nguyên atomic, explicit|
|[`atomic_fetch_or()`](#man-atomic_fetch)|OR bit nguyên tử một số nguyên atomic|
|[`atomic_fetch_sub_explicit()`](#man-atomic_fetch)|Trừ nguyên tử khỏi một số nguyên atomic, explicit|
|[`atomic_fetch_sub()`](#man-atomic_fetch)|Trừ nguyên tử khỏi một số nguyên atomic|
|[`atomic_fetch_xor_explicit()`](#man-atomic_fetch)|XOR bit nguyên tử một số nguyên atomic, explicit|
|[`atomic_fetch_xor()`](#man-atomic_fetch)|XOR bit nguyên tử một số nguyên atomic|
|[`atomic_flag_clear_explicit()`](#man-atomic_flag_clear)|Xoá một atomic flag, explicit|
|[`atomic_flag_clear()`](#man-atomic_flag_clear)|Xoá một atomic flag|
|[`atomic_flag_test_and_set_explicit()`](#man-atomic_flag_test_and_set)|Test-and-set một atomic flag, explicit|
|[`atomic_flag_test_and_set()`](#man-atomic_flag_test_and_set)|Test-and-set một atomic flag|
|[`atomic_init()`](#man-atomic_init)|Khởi tạo một biến atomic|
|[`atomic_is_lock_free()`](#man-atomic_is_lock_free)|Xác định xem một kiểu atomic có lock-free không|
|[`atomic_load_explicit()`](#man-atomic_load)|Trả về giá trị từ một biến atomic, explicit|
|[`atomic_load()`](#man-atomic_load)|Trả về giá trị từ một biến atomic|
|[`atomic_signal_fence()`](#man-atomic_signal_fence)|Fence cho signal handler trong cùng thread|
|[`atomic_store_explicit()`](#man-atomic_store)|Lưu một giá trị vào biến atomic, explicit|
|[`atomic_store()`](#man-atomic_store)|Lưu một giá trị vào biến atomic|
|[`atomic_thread_fence()`](#man-atomic_thread_fence)|Dựng một fence|
|[`ATOMIC_VAR_INIT()`](#man-ATOMIC_VAR_INIT)|Tạo initializer cho một biến atomic|
|[`kill_dependency()`](#man-kill_dependency)|Kết thúc một chuỗi dependency|

Trên các hệ điều hành kiểu Unix, bạn có thể cần thêm `-latomic` vào
dòng lệnh biên dịch.

## Các Kiểu Atomic

Header này định nghĩa sẵn một đống kiểu:

[i[`atomic_bool` type]i]
[i[`atomic_char` type]i]
[i[`atomic_schar` type]i]
[i[`atomic_uchar` type]i]
[i[`atomic_short` type]i]
[i[`atomic_ushort` type]i]
[i[`atomic_int` type]i]
[i[`atomic_uint` type]i]
[i[`atomic_long` type]i]
[i[`atomic_ulong` type]i]
[i[`atomic_llong` type]i]
[i[`atomic_ullong` type]i]
[i[`atomic_char16_t` type]i]
[i[`atomic_char32_t` type]i]
[i[`atomic_wchar_t` type]i]
[i[`atomic_int_least8_t` type]i]
[i[`atomic_uint_least8_t` type]i]
[i[`atomic_int_least16_t` type]i]
[i[`atomic_uint_least16_t` type]i]
[i[`atomic_int_least32_t` type]i]
[i[`atomic_uint_least32_t` type]i]
[i[`atomic_int_least64_t` type]i]
[i[`atomic_uint_least64_t` type]i]
[i[`atomic_int_fast8_t` type]i]
[i[`atomic_uint_fast8_t` type]i]
[i[`atomic_int_fast16_t` type]i]
[i[`atomic_uint_fast16_t` type]i]
[i[`atomic_int_fast32_t` type]i]
[i[`atomic_uint_fast32_t` type]i]
[i[`atomic_int_fast64_t` type]i]
[i[`atomic_uint_fast64_t` type]i]
[i[`atomic_intptr_t` type]i]
[i[`atomic_uintptr_t` type]i]
[i[`atomic_size_t` type]i]
[i[`atomic_ptrdiff_t` type]i]
[i[`atomic_intmax_t` type]i]
[i[`atomic_uintmax_t` type]i]

|Kiểu atomic|Dạng đầy đủ tương đương|
|-|-|
|`atomic_bool`|`_Atomic _Bool`|
|`atomic_char`|`_Atomic char`|
|`atomic_schar`|`_Atomic signed char`|
|`atomic_uchar`|`_Atomic unsigned char`|
|`atomic_short`|`_Atomic short`|
|`atomic_ushort`|`_Atomic unsigned short`|
|`atomic_int`|`_Atomic int`|
|`atomic_uint`|`_Atomic unsigned int`|
|`atomic_long`|`_Atomic long`|
|`atomic_ulong`|`_Atomic unsigned long`|
|`atomic_llong`|`_Atomic long long`|
|`atomic_ullong`|`_Atomic unsigned long long`|
|`atomic_char16_t`|`_Atomic char16_t`|
|`atomic_char32_t`|`_Atomic char32_t`|
|`atomic_wchar_t`|`_Atomic wchar_t`|
|`atomic_int_least8_t`|`_Atomic int_least8_t`|
|`atomic_uint_least8_t`|`_Atomic uint_least8_t`|
|`atomic_int_least16_t`|`_Atomic int_least16_t`|
|`atomic_uint_least16_t`|`_Atomic uint_least16_t`|
|`atomic_int_least32_t`|`_Atomic int_least32_t`|
|`atomic_uint_least32_t`|`_Atomic uint_least32_t`|
|`atomic_int_least64_t`|`_Atomic int_least64_t`|
|`atomic_uint_least64_t`|`_Atomic uint_least64_t`|
|`atomic_int_fast8_t`|`_Atomic int_fast8_t`|
|`atomic_uint_fast8_t`|`_Atomic uint_fast8_t`|
|`atomic_int_fast16_t`|`_Atomic int_fast16_t`|
|`atomic_uint_fast16_t`|`_Atomic uint_fast16_t`|
|`atomic_int_fast32_t`|`_Atomic int_fast32_t`|
|`atomic_uint_fast32_t`|`_Atomic uint_fast32_t`|
|`atomic_int_fast64_t`|`_Atomic int_fast64_t`|
|`atomic_uint_fast64_t`|`_Atomic uint_fast64_t`|
|`atomic_intptr_t`|`_Atomic intptr_t`|
|`atomic_uintptr_t`|`_Atomic uintptr_t`|
|`atomic_size_t`|`_Atomic size_t`|
|`atomic_ptrdiff_t`|`_Atomic ptrdiff_t`|
|`atomic_intmax_t`|`_Atomic intmax_t`|
|`atomic_uintmax_t`|`_Atomic uintmax_t`|

Bạn có thể tự làm thêm kiểu của mình bằng [i[`_Atomic` type
qualifier]i] type qualifier `_Atomic`:

``` {.c}
_Atomic double x;
```

hoặc [i[`_Atomic()` type specifier]i] type specifier `_Atomic()`:

``` {.c}
_Atomic(double) x;
```

## Các Macro Lock-free {#lock-free-macros}

Các macro này cho bạn biết một kiểu có lock-free hay không. Có thể.

Chúng có thể dùng ở compile time với `#if`. Chúng áp dụng cho cả kiểu
signed và unsigned.

[i[`ATOMIC_BOOL_LOCK_FREE` macro]i]
[i[`ATOMIC_CHAR_LOCK_FREE` macro]i]
[i[`ATOMIC_CHAR16_T_LOCK_FREE` macro]i]
[i[`ATOMIC_CHAR32_T_LOCK_FREE` macro]i]
[i[`ATOMIC_WCHAR_T_LOCK_FREE` macro]i]
[i[`ATOMIC_SHORT_LOCK_FREE` macro]i]
[i[`ATOMIC_INT_LOCK_FREE` macro]i]
[i[`ATOMIC_LONG_LOCK_FREE` macro]i]
[i[`ATOMIC_LLONG_LOCK_FREE` macro]i]
[i[`ATOMIC_POINTER_LOCK_FREE` macro]i]

|Kiểu Atomic|Macro Lock-Free|
|-|-|
|`atomic_bool`|`ATOMIC_BOOL_LOCK_FREE`|
|`atomic_char`|`ATOMIC_CHAR_LOCK_FREE`|
|`atomic_char16_t`|`ATOMIC_CHAR16_T_LOCK_FREE`|
|`atomic_char32_t`|`ATOMIC_CHAR32_T_LOCK_FREE`|
|`atomic_wchar_t`|`ATOMIC_WCHAR_T_LOCK_FREE`|
|`atomic_short`|`ATOMIC_SHORT_LOCK_FREE`|
|`atomic_int`|`ATOMIC_INT_LOCK_FREE`|
|`atomic_long`|`ATOMIC_LONG_LOCK_FREE`|
|`atomic_llong`|`ATOMIC_LLONG_LOCK_FREE`|
|`atomic_intptr_t`|`ATOMIC_POINTER_LOCK_FREE`|

Thú vị là các macro này có thể có tới _ba_ giá trị khác nhau:

|Giá trị|Ý nghĩa|
|-|-|
|`0`|Không bao giờ lock-free.|
|`1`|_Đôi khi_ lock-free[^916a].|
|`2`|Luôn lock-free.|

[^916a]: Có thể nó phụ thuộc vào môi trường run-time và không thể biết
ở compile-time.

## Atomic Flag

Kiểu mờ (opaque type) [i[`atomic_flag` type]i] `atomic_flag` là thứ
duy nhất được đảm bảo là lock-free. Dù implementation trên PC của bạn
chắc sẽ làm được nhiều hơn thế.

Nó được truy cập qua các hàm
[`atomic_flag_test_and_set()`](#man-atomic_flag_test_and_set) và
[`atomic_flag_clear()`](#man-atomic_flag_clear).

Trước khi dùng, có thể khởi tạo nó về trạng thái clear bằng:

``` {.c}
atomic_flag f = ATOMIC_FLAG_INIT;
```

## Memory Order (Thứ tự bộ nhớ)

Header này giới thiệu một kiểu `enum` mới tên là `memory_order`. Nó
được dùng bởi một đống hàm để chỉ định các memory order (thứ tự bộ
nhớ) khác với sequential consistency (tính nhất quán tuần tự).

[i[`memory_order_seq_cst` enumerated type]i]
[i[`memory_order_acq_rel` enumerated type]i]
[i[`memory_order_release` enumerated type]i]
[i[`memory_order_acquire` enumerated type]i]
[i[`memory_order_consume` enumerated type]i]
[i[`memory_order_relaxed` enumerated type]i]

|`memory_order`|Mô tả|
|-|-|
|`memory_order_seq_cst`|Sequential Consistency|
|`memory_order_acq_rel`|Acquire/Release|
|`memory_order_release`|Release|
|`memory_order_acquire`|Acquire|
|`memory_order_consume`|Consume|
|`memory_order_relaxed`|Relaxed|

Bạn có thể truyền mấy thứ này vào các hàm atomic có hậu tố `_explicit`.

Các phiên bản không có `_explicit` hoạt động y như khi bạn gọi phiên
bản `_explicit` tương ứng với `memory_order_seq_cst`.

[[manbreak]]
## `ATOMIC_VAR_INIT()` {#man-ATOMIC_VAR_INIT}

[i[`ATOMIC_VAR_INIT()` macro]i]

Tạo một initializer cho biến atomic

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdatomic.h>

#define ATOMIC_VAR_INIT(C value)   // Deprecated
```

### Mô tả {.unnumbered .unlisted}

Macro này mở rộng thành một initializer, nên bạn có thể dùng nó khi
định nghĩa biến.

Kiểu của `value` phải là kiểu cơ sở của biến atomic.

Buồn cười là, bản thân việc khởi tạo _không_ phải thao tác nguyên tử
(atomic).

[fl[CPPReference nói rằng cái này đã bị
deprecated|https://en.cppreference.com/w/cpp/atomic/ATOMIC_VAR_INIT]]
và nhiều khả năng sẽ bị bỏ. Tài liệu tiêu chuẩn
[fl[p1138r0|http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p1138r0.pdf]]
giải thích thêm rằng macro này bị hạn chế ở chỗ không thể khởi tạo
đúng các atomic `struct`, và lý do tồn tại ban đầu của nó hoá ra chẳng
hữu dụng.

Cứ khởi tạo biến trực tiếp đi là xong.

### Giá trị trả về {.unnumbered .unlisted}

Mở rộng thành initializer phù hợp cho biến atomic này.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdatomic.h>

int main(void)
{
    atomic_int x = ATOMIC_VAR_INIT(3490);  // Deprecated
    printf("%d\n", x);
}
```

### Xem thêm {.unnumbered .unlisted}

[`atomic_init()`](#man-atomic_init)

[[manbreak]]
## `atomic_init()` {#man-atomic_init}

[i[`atomic_init()` function]i]

Khởi tạo một biến atomic

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdatomic.h>

void atomic_init(volatile A *obj, C value);
```

### Mô tả {.unnumbered .unlisted}

Bạn có thể dùng nó để khởi tạo một biến atomic.

Kiểu của `value` phải là kiểu cơ sở của biến atomic.

Buồn cười là, bản thân việc khởi tạo _không_ phải thao tác nguyên tử.

Theo như tôi thấy, chẳng có gì khác biệt giữa cái này và việc gán trực
tiếp cho biến atomic. Spec nói nó có mặt để cho phép compiler chèn
thêm bất kỳ việc khởi tạo bổ sung nào cần làm, nhưng mọi thứ vẫn ổn
nếu không có nó. Nếu ai đó có thêm thông tin, gửi cho tôi nhé.

### Giá trị trả về {.unnumbered .unlisted}

Không trả về gì cả!

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdatomic.h>

int main(void)
{
    atomic_int x;
    
    atomic_init(&x, 3490);

    printf("%d\n", x);
}
```

### Xem thêm {.unnumbered .unlisted}

[`ATOMIC_VAR_INIT()`](#man-ATOMIC_VAR_INIT),
[`atomic_store()`](#man-atomic_store),
[`atomic_store_explicit()`](#man-atomic_store)

[[manbreak]]
## `kill_dependency()` {#man-kill_dependency}

[i[`kill_dependency()` function]i]

Kết thúc một chuỗi dependency

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdatomic.h>

type kill_dependency(type y);
```

### Mô tả {.unnumbered .unlisted}

Cái này có khả năng hữu ích để tối ưu nếu bạn đang dùng
`memory_order_consume` ở đâu đó.

Và nếu bạn biết mình đang làm gì. Nếu không chắc, tìm hiểu thêm trước
khi thử dùng.

### Giá trị trả về {.unnumbered .unlisted}

Trả về giá trị được truyền vào.

### Ví dụ {.unnumbered .unlisted}

Trong ví dụ này, `i` mang theo một dependency vào `x`. Và cũng sẽ mang
vào `y`, nhưng vì có lời gọi `kill_dependency()` nên không.

``` {.c .numberLines}
#include <stdio.h>
#include <stdatomic.h>

int main(void)
{
    atomic_int a;
    int i = 10, x, y;

    atomic_store_explicit(&a, 3490, memory_order_release);

    i = atomic_load_explicit(&a, memory_order_consume);
    x = i;
    y = kill_dependency(i);

    printf("%d %d\n", x, y);  // 3490 and either 3490 or 10
}
```

<!--
### See Also {.unnumbered .unlisted}

[`example()`](#man-example),
-->

[[manbreak]]
## `atomic_thread_fence()` {#man-atomic_thread_fence}

[i[`atomic_thread_fence()` function]i]

Dựng một fence (hàng rào)

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdatomic.h>

void atomic_thread_fence(memory_order order);
```

### Mô tả {.unnumbered .unlisted}

Hàm này dựng một memory fence (rào cản bộ nhớ) với `order` chỉ định.

|`order`|Mô tả|
|-|-|
|`memory_order_seq_cst`|Fence acquire/release theo sequential consistency|
|`memory_order_acq_rel`|Fence acquire/release|
|`memory_order_release`|Fence release|
|`memory_order_acquire`|Fence acquire|
|`memory_order_consume`|Fence acquire (again)|
|`memory_order_relaxed`|Không có fence gì cả---gọi với cái này chẳng có ý nghĩa gì|

Bạn có thể cố tránh dùng mấy cái này và cứ bám vào các chế độ khác
nhau với [`atomic_store_explicit()`](#man-atomic_store) và
[`atomic_load_explicit()`](#man-atomic_load). Hoặc không.

### Giá trị trả về {.unnumbered .unlisted}

Không trả về gì cả!

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <threads.h>
#include <stdatomic.h>

atomic_int shared_1 = 1;
atomic_int shared_2 = 2;

int thread_1(void *arg)
{
    (void)arg;

    atomic_store_explicit(&shared_1, 10, memory_order_relaxed);

    atomic_thread_fence(memory_order_release);

    atomic_store_explicit(&shared_2, 20, memory_order_relaxed);

    return 0;
}

int thread_2(void *arg)
{
    (void)arg;

    // If this fence runs after the release fence, we're
    // guaranteed to see thread_1's changes to the shared
    // varaibles.

    atomic_thread_fence(memory_order_acquire);

    if (shared_2 == 20) {
        printf("Shared_1 better be 10 and it's %d\n", shared_1);
    } else {
        printf("Anything's possible: %d %d\n", shared_1, shared_2);
    }

    return 0;
}

int main(void)
{
    thrd_t t1, t2;

    thrd_create(&t2, thread_2, NULL);
    thrd_create(&t1, thread_1, NULL);

    thrd_join(t1, NULL);
    thrd_join(t2, NULL);
}
```

### Xem thêm {.unnumbered .unlisted}

[`atomic_store_explicit()`](#man-atomic_store),
[`atomic_load_explicit()`](#man-atomic_load),
[`atomic_signal_fence()`](#man-atomic_signal_fence)

[[manbreak]]
## `atomic_signal_fence()` {#man-atomic_signal_fence}

[i[`atomic_signal_fence()` function]i]

Fence cho signal handler trong cùng thread

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdatomic.h>

void atomic_signal_fence(memory_order order);
```

### Mô tả {.unnumbered .unlisted}

Hàm này hoạt động giống `atomic_thread_fence()` nhưng mục đích là
trong phạm vi một thread duy nhất; đáng chú ý là để dùng trong signal
handler của thread đó.

Vì signal có thể xảy ra bất cứ lúc nào, ta có thể cần một cách để chắc
chắn rằng mọi write của thread xảy ra trước signal handler sẽ nhìn
thấy được bên trong signal handler đó.

### Giá trị trả về {.unnumbered .unlisted}

Không trả về gì cả!

### Ví dụ {.unnumbered .unlisted}

Demo một phần. (Lưu ý rằng về mặt kỹ thuật thì việc gọi `printf()`
trong signal handler là undefined behavior.)

``` {.c .numberLines}
#include <stdio.h>
#include <signal.h>
#include <stdatomic.h>

int global;

void handler(int sig)
{
    (void)sig;

    // If this runs before the release, the handler will
    // potentially see global == 0.
    //
    // Otherwise, it will definitely see global == 10.

    atomic_signal_fence(memory_order_acquire);

    printf("%d\n", global);
}

int main(void)
{
    signal(SIGINT, handler);

    global = 10;

    atomic_signal_fence(memory_order_release);

    // If the signal handler runs after the release
    // it will definitely see the value 10 in global.
}
```

### Xem thêm {.unnumbered .unlisted}

[`atomic_thread_fence()`](#man-atomic_thread_fence),
[`signal()`](#man-signal)

[[manbreak]]
## `atomic_is_lock_free()` {#man-atomic_is_lock_free}

[i[`atomic_is_lock_free()` function]i]

Xác định xem một kiểu atomic có lock-free không

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdatomic.h>

_Bool atomic_is_lock_free(const volatile A *obj);
```

### Mô tả {.unnumbered .unlisted}

Xác định xem biến `obj` kiểu `A` có lock-free không. Dùng được với bất
kỳ kiểu nào.

Khác với các [macro lock-free](#lock-free-macros) có thể dùng ở
compile-time, đây thuần tuý là hàm run-time. Vì vậy ở những chỗ mà
macro trả lời "có thể", hàm này sẽ chắc chắn cho bạn biết biến atomic
có lock-free hay không.

Cái này hữu ích khi bạn tự định nghĩa biến atomic của mình và muốn
biết trạng thái lock-free của chúng.

### Giá trị trả về {.unnumbered .unlisted}

True nếu biến lock-free, false nếu không.

### Ví dụ {.unnumbered .unlisted}

Kiểm tra xem một cặp `struct` và một `double` atomic có lock-free
không. Trên hệ thống của tôi, `struct` lớn hơn thì to quá không
lock-free được, nhưng hai cái còn lại thì OK.

``` {.c .numberLines}
#include <stdio.h>
#include <stdatomic.h>

int main(void)
{
	struct foo {
		int x, y;
	};

	struct bar {
		int x, y, z;
	};

	_Atomic(double) a;
	struct foo b;
	struct bar c;

	printf("a is lock-free: %d\n", atomic_is_lock_free(&a));
	printf("b is lock-free: %d\n", atomic_is_lock_free(&b));
	printf("c is lock-free: %d\n", atomic_is_lock_free(&c));
}
```

Output trên hệ thống của tôi (YMMV):

``` {.default}
a is lock-free: 1
b is lock-free: 1
c is lock-free: 0
```

### Xem thêm {.unnumbered .unlisted}

[Các Macro Lock-free](#lock-free-macros)

[[manbreak]]
## `atomic_store()` {#man-atomic_store}

[i[`atomic_store()` function]i]

Lưu một giá trị vào biến atomic

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdatomic.h>

void atomic_store(volatile A *object, C desired);

void atomic_store_explicit(volatile A *object,
                           C desired, memory_order order);
```

### Mô tả {.unnumbered .unlisted}

Lưu một giá trị vào biến atomic, có thể được đồng bộ.

Cái này giống như một phép gán thông thường, nhưng linh hoạt hơn.

Mấy cái sau có cùng hiệu ứng lưu trữ với một `atomic_int x`:

``` {.c}
x = 10;
atomic_store(&x, 10);
atomic_store_explicit(&x, 10, memory_order_seq_cst);
```

Nhưng hàm cuối, `atomic_store_explicit()`, cho bạn chỉ định memory
order.

Vì đây là thao tác kiểu "release-y", không có memory order kiểu
"acquire-y" nào hợp lệ. `order` chỉ có thể là `memory_order_seq_cst`,
`memory_order_release`, hoặc `memory_order_relaxed`.

`order` không thể là `memory_order_acq_rel`, `memory_order_acquire`,
hoặc `memory_order_consume`.

### Giá trị trả về {.unnumbered .unlisted}

Không trả về gì cả!

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdatomic.h>

int main(void)
{
    atomic_int x = 0;
    atomic_int y = 0;

    atomic_store(&x, 10);

    atomic_store_explicit(&y, 20, memory_order_relaxed);

    // Will print either "10 20" or "10 0":
    printf("%d %d\n", x, y);
}
```

### Xem thêm {.unnumbered .unlisted}

[`atomic_init()`](#man-atomic_init),
[`atomic_load()`](#man-atomic_load),
[`atomic_load_explicit()`](#man-atomic_load),
[`atomic_exchange()`](#man-atomic_exchange), \
[`atomic_exchange_explicit()`](#man-atomic_exchange),
[`atomic_compare_exchange_strong()`](#man-atomic_compare_exchange), \
[`atomic_compare_exchange_strong_explicit()`](#man-atomic_compare_exchange),
[`atomic_compare_exchange_weak()`](#man-atomic_compare_exchange), \
[`atomic_compare_exchange_weak_explicit()`](#man-atomic_compare_exchange),
[`atomic_fetch_*()`](#man-atomic_fetch)

[[manbreak]]
## `atomic_load()` {#man-atomic_load}

[i[`atomic_load()` function]i]

Trả về giá trị từ một biến atomic

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdatomic.h>

C atomic_load(const volatile A *object);

C atomic_load_explicit(const volatile A *object, memory_order order);
```

### Mô tả {.unnumbered .unlisted}

Với một con trỏ tới `object` kiểu `A`, nguyên tử trả về giá trị `C`
của nó. Đây là hàm generic có thể dùng với bất kỳ kiểu nào.

Hàm `atomic_load_explicit()` cho bạn chỉ định memory order.

Vì đây là thao tác kiểu "acquire-y", không có memory order kiểu
"release-y" nào hợp lệ. `order` chỉ có thể là `memory_order_seq_cst`,
`memory_order_acquire`, `memory_order_consume`, hoặc
`memory_order_relaxed`.

`order` không thể là `memory_order_acq_rel` hoặc
`memory_order_release`.

### Giá trị trả về {.unnumbered .unlisted}

Trả về giá trị được lưu trong `object`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdatomic.h>

int main(void)
{
    atomic_int x = 10;

    int v = atomic_load(&x);

    printf("%d\n", v);  // 10
}
```

### Xem thêm {.unnumbered .unlisted}

[`atomic_store()`](#man-atomic_store),
[`atomic_store_explicit()`](#man-atomic_store)

[[manbreak]]
## `atomic_exchange()` {#man-atomic_exchange}

[i[`atomic_exchange()` function]i]

Thay giá trị trong một object nguyên tử

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdatomic.h>

C atomic_exchange(volatile A *object, C desired);

C atomic_exchange_explicit(volatile A *object, C desired,
                           memory_order order);
```

### Mô tả {.unnumbered .unlisted}

Đặt giá trị trong `object` thành `desired`.

`object` có kiểu `A`, một kiểu atomic nào đó.

`desired` có kiểu `C`, kiểu non-atomic tương ứng với `A`.

Cái này rất giống `atomic_store()`, trừ việc giá trị trước đó được trả
về một cách nguyên tử.

### Giá trị trả về {.unnumbered .unlisted}

Trả về giá trị trước đó của `object`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdatomic.h>

int main(void)
{
    atomic_int x = 10;

    int previous = atomic_exchange(&x, 20);

    printf("x is  %d\n", x);
    printf("x was %d\n", previous);
}
```

Output:

``` {.default}
x is  20
x was 10
```

### Xem thêm {.unnumbered .unlisted}

[`atomic_init()`](#man-atomic_init),
[`atomic_load()`](#man-atomic_load),
[`atomic_load_explicit()`](#man-atomic_load),
[`atomic_store()`](#man-atomic_store), \
[`atomic_store_explicit()`](#man-atomic_store)
[`atomic_compare_exchange_strong()`](#man-atomic_compare_exchange), \
[`atomic_compare_exchange_strong_explicit()`](#man-atomic_compare_exchange),
[`atomic_compare_exchange_weak()`](#man-atomic_compare_exchange), \
[`atomic_compare_exchange_weak_explicit()`](#man-atomic_compare_exchange)

[[manbreak]]
## `atomic_compare_exchange_*()` {#man-atomic_compare_exchange}

[i[`atomic_compare_exchange_*()` function]i]

Compare-and-exchange nguyên tử

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdatomic.h>

_Bool atomic_compare_exchange_strong(volatile A *object,
                                     C *expected, C desired);

_Bool atomic_compare_exchange_strong_explicit(volatile A *object,
                                              C *expected, C desired,
                                              memory_order success,
                                              memory_order failure);

_Bool atomic_compare_exchange_weak(volatile A *object,
                                   C *expected, C desired);

_Bool atomic_compare_exchange_weak_explicit(volatile A *object,
                                            C *expected, C desired,
                                            memory_order success,
                                            memory_order failure);
```

### Mô tả {.unnumbered .unlisted}

Nền tảng lâu đời cho vô số thứ lock-free: compare-and-exchange (CAS).

Trong các prototype ở trên, `A` là kiểu của object atomic, và `C` là
kiểu cơ sở tương đương.

Bỏ qua các phiên bản `_explicit` một lúc, các hàm này làm:

* Nếu giá trị được trỏ tới bởi `object` bằng giá trị được trỏ tới bởi
  `expected`, thì giá trị được trỏ tới bởi `object` được đặt thành
  `desired`. Và hàm trả về `true` cho biết trao đổi đã diễn ra.

* Ngược lại, giá trị được trỏ tới bởi `expected` (vâng, `expected`)
  được đặt thành `desired` và hàm trả về `false` cho biết trao đổi
  không diễn ra.

Pseudocode cho trao đổi sẽ trông như thế này^[Hiệu quả thì cái này làm
cùng việc, nhưng rõ ràng nó không nguyên tử.]:

``` {.c}
bool compare_exchange(atomic_A *object, C *expected, C desired)
{
    if (*object is the same as *expected) {
        *object = desired
        return true
    }

    *expected = desired
    return false
}
```

Các biến thể `_weak` có thể thất bại một cách tự phát, nên ngay cả khi
`*object == *desired`, nó có thể không đổi giá trị và sẽ trả về
`false`. Vì thế bạn sẽ muốn đặt nó trong vòng lặp nếu dùng^[Spec nói:
"Cái thất bại tự phát này cho phép cài đặt compare-and-exchange trên
một lớp máy rộng hơn, ví dụ như các máy load-locked store-conditional."
Và thêm: "Khi compare-and-exchange nằm trong vòng lặp, phiên bản weak
sẽ cho hiệu năng tốt hơn trên một số nền tảng. Khi một
compare-and-exchange weak sẽ cần vòng lặp còn strong thì không, thì
strong được ưu tiên hơn."].

Các biến thể `_explicit` có hai memory order: `success` nếu `*object`
được đặt thành `desired`, và `failure` nếu không.

Đây là các hàm test-and-set, nên bạn có thể dùng
`memory_order_acq_rel` với các biến thể `_explicit`.

### Giá trị trả về {.unnumbered .unlisted}

Trả về `true` nếu `*object` là `*expected`. Ngược lại, `false`.

### Ví dụ {.unnumbered .unlisted}

Một ví dụ gượng ép, nơi nhiều thread cộng `2` vào một giá trị chia sẻ
theo cách lock-free.

(Ngoài đời thực thì tốt hơn là dùng `+= 2` để làm việc này, trừ khi
bạn đang dùng phép thuật `_explicit` nào đó.)

``` {.c .numberLines}
#include <stdio.h>
#include <threads.h>
#include <stdatomic.h>

#define LOOP_COUNT 10000

atomic_int value;

int run(void *arg)
{
    (void)arg;

    for(int i = 0; i < LOOP_COUNT; i++) {

        int cur = value;
        int next;

        do {
            next = cur + 2;
        } while (!atomic_compare_exchange_strong(&value, &cur, next));
    }

    return 0;
}

int main(void)
{
    thrd_t t1, t2;

    thrd_create(&t1, run, NULL);
    thrd_create(&t2, run, NULL);

    thrd_join(t1, NULL);
    thrd_join(t2, NULL);
    
    printf("%d should equal %d\n", value, LOOP_COUNT * 4);
}
```

Chỉ cần thay cái này bằng `value = value + 2` thôi là gây ra chuyện
đạp dữ liệu.

### Xem thêm {.unnumbered .unlisted}

[`atomic_load()`](#man-atomic_load),
[`atomic_load_explicit()`](#man-atomic_load),
[`atomic_store()`](#man-atomic_store),
[`atomic_store_explicit()`](#man-atomic_store),
[`atomic_exchange()`](#man-atomic_exchange),
[`atomic_exchange_explicit()`](#man-atomic_exchange),
[`atomic_fetch_*()`](#man-atomic_fetch)

[[manbreak]]
## `atomic_fetch_*()` {#man-atomic_fetch}

[i[`atomic_fetch_*()` function]i]

Sửa đổi biến atomic một cách nguyên tử

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdatomic.h>

C atomic_fetch_KEY(volatile A *object, M operand);

C atomic_fetch_KEY_explicit(volatile A *object, M operand,
                            memory_order order);
```

### Mô tả {.unnumbered .unlisted}

Thật ra đây là một nhóm gồm 10 hàm. Bạn thay `KEY` bằng một trong các
từ dưới để thực hiện thao tác đó:

* `add`
* `sub`
* `or`
* `xor`
* `and`

Vậy các hàm này có thể cộng hoặc trừ giá trị vào/khỏi một biến atomic,
hoặc có thể thực hiện OR, XOR, hoặc AND bit trên chúng.

Dùng với các kiểu integer hoặc pointer. Dù spec có hơi mơ hồ về vấn đề
này, các kiểu khác sẽ làm C không vui. Nó còn cố tránh undefined
behavior với signed integer:

C18 §7.17.7.5 ¶3:

> Đối với các kiểu signed integer, số học được định nghĩa dùng biểu
> diễn bù hai với quấn vòng im lặng khi tràn; không có kết quả
> undefined nào.

Trong synopsis ở trên, `A` là kiểu atomic, và `M` là kiểu non-atomic
tương ứng với `A` (hoặc `ptrdiff_t` cho pointer atomic), và `C` là
kiểu non-atomic tương ứng với `A`.

Ví dụ, đây là một số thao tác trên một `atomic_int`.

``` {.c}
atomic_fetch_add(&x, 20);
atomic_fetch_sub(&x, 37);
atomic_fetch_xor(&x, 3490);
```

Chúng tương đương `+=`, `-=`, `|=`, `^=` và `&=`, trừ việc giá trị trả
về là giá trị _trước đó_ của object atomic. (Với các toán tử gán, giá
trị của biểu thức là giá trị _sau_ khi đánh giá.)

``` {.c}
atomic_int x = 10;
int prev = atomic_fetch_add(&x, 20);
printf("%d %d\n", prev, x);  // 10 30
```

so với:

``` {.c}
atomic_int x = 10;
int prev = (x += 20);
printf("%d %d\n", prev, x);  // 30 30
```

Và, tất nhiên, phiên bản `_explicit` cho phép bạn chỉ định memory
order còn tất cả các toán tử gán đều là `memory_order_seq_cst`.

### Giá trị trả về {.unnumbered .unlisted}

Trả về giá trị trước đó của object atomic trước khi sửa đổi.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <stdatomic.h>

int main(void)
{
    atomic_int x = 0;
    int prev;

    atomic_fetch_add(&x, 3490);
    atomic_fetch_sub(&x, 12);
    atomic_fetch_xor(&x, 444);
    atomic_fetch_or(&x, 12);
    prev = atomic_fetch_and(&x, 42);

    printf("%d %d\n", prev, x);   // 3118 42
}
```

### Xem thêm {.unnumbered .unlisted}

[`atomic_exchange()`](#man-atomic_exchange),
[`atomic_exchange_explicit()`](#man-atomic_exchange),
[`atomic_compare_exchange_strong()`](#man-atomic_compare_exchange), \
[`atomic_compare_exchange_strong_explicit()`](#man-atomic_compare_exchange),
[`atomic_compare_exchange_weak()`](#man-atomic_compare_exchange), \
[`atomic_compare_exchange_weak_explicit()`](#man-atomic_compare_exchange)


[[manbreak]]
## `atomic_flag_test_and_set()` {#man-atomic_flag_test_and_set}

[i[`atomic_flag_test_and_set()` function]i]

Test-and-set một atomic flag

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdatomic.h>

_Bool atomic_flag_test_and_set(volatile atomic_flag *object);

_Bool atomic_flag_test_and_set_explicit(volatile atomic_flag *object,
                                        memory_order order);
```

### Mô tả {.unnumbered .unlisted}

Một trong các hàm lâu đời đáng kính của lập trình lock-free, hàm này
set atomic flag được chỉ định trong `object`, và trả về giá trị trước
đó của flag.

Như thường lệ, `_explicit` cho phép bạn chỉ định memory order khác.

### Giá trị trả về {.unnumbered .unlisted}

Trả về `true` nếu flag đã được set trước đó, và `false` nếu chưa.

### Ví dụ {.unnumbered .unlisted}

Dùng test-and-set để cài đặt một spin lock^[Đừng dùng cái này trừ khi
bạn biết mình đang làm gì---dùng chức năng mutex của thread thay vào
đó. Nó sẽ cho phép thread bị chặn ngủ và ngừng gặm CPU.]:

``` {.c .numberLines}
#include <stdio.h>
#include <threads.h>
#include <stdatomic.h>

// Shared non-atomic struct
struct {
    int x, y, z;
} s = {1, 2, 3};

atomic_flag f = ATOMIC_FLAG_INIT;

int run(void *arg)
{
    int tid = *(int*)arg;

    printf("Thread %d: waiting for lock...\n", tid);

    while (atomic_flag_test_and_set(&f));

    printf("Thread %d: got lock, s is {%d, %d, %d}\n", tid,
                                                       s.x, s.y, s.z);
    s.x = (tid + 1) * 5 + 0;
    s.y = (tid + 1) * 5 + 1;
    s.z = (tid + 1) * 5 + 2;
    printf("Thread %d: set s to {%d, %d, %d}\n", tid, s.x, s.y, s.z);

    printf("Thread %d: releasing lock...\n", tid);
    atomic_flag_clear(&f);

    return 0;
}

int main(void)
{
    thrd_t t1, t2;
    int tid[] = {0, 1};

    thrd_create(&t1, run, tid+0);
    thrd_create(&t2, run, tid+1);

    thrd_join(t1, NULL);
    thrd_join(t2, NULL);
}
```

Output ví dụ (thay đổi giữa các lần chạy):

``` {.default}
Thread 0: waiting for lock...
Thread 0: got lock, s is {1, 2, 3}
Thread 1: waiting for lock...
Thread 0: set s to {5, 6, 7}
Thread 0: releasing lock...
Thread 1: got lock, s is {5, 6, 7}
Thread 1: set s to {10, 11, 12}
Thread 1: releasing lock...
```

### Xem thêm {.unnumbered .unlisted}

[`atomic_flag_clear()`](#man-atomic_flag_clear)

[[manbreak]]
## `atomic_flag_clear()` {#man-atomic_flag_clear}

[i[`atomic_flag_clear()` function]i]

Xoá một atomic flag

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <stdatomic.h>

void atomic_flag_clear(volatile atomic_flag *object);

void atomic_flag_clear_explicit(volatile atomic_flag *object,
                                memory_order order);
```

### Mô tả {.unnumbered .unlisted}

Xoá một atomic flag.

Như thường lệ, `_explicit` cho phép bạn chỉ định memory order khác.

### Giá trị trả về {.unnumbered .unlisted}

Không trả về gì cả!

### Ví dụ {.unnumbered .unlisted}

Dùng test-and-set để cài đặt một spin lock^[Đừng dùng cái này trừ khi
bạn biết mình đang làm gì---dùng chức năng mutex của thread thay vào
đó. Nó sẽ cho phép thread bị chặn ngủ và ngừng gặm CPU.]:

``` {.c .numberLines}
#include <stdio.h>
#include <threads.h>
#include <stdatomic.h>

// Shared non-atomic struct
struct {
    int x, y, z;
} s = {1, 2, 3};

atomic_flag f = ATOMIC_FLAG_INIT;

int run(void *arg)
{
    int tid = *(int*)arg;

    printf("Thread %d: waiting for lock...\n", tid);

    while (atomic_flag_test_and_set(&f));

    printf("Thread %d: got lock, s is {%d, %d, %d}\n", tid,
                                                       s.x, s.y, s.z);
    s.x = (tid + 1) * 5 + 0;
    s.y = (tid + 1) * 5 + 1;
    s.z = (tid + 1) * 5 + 2;
    printf("Thread %d: set s to {%d, %d, %d}\n", tid, s.x, s.y, s.z);

    printf("Thread %d: releasing lock...\n", tid);
    atomic_flag_clear(&f);

    return 0;
}

int main(void)
{
    thrd_t t1, t2;
    int tid[] = {0, 1};

    thrd_create(&t1, run, tid+0);
    thrd_create(&t2, run, tid+1);

    thrd_join(t1, NULL);
    thrd_join(t2, NULL);
}
```

Output ví dụ (thay đổi giữa các lần chạy):

``` {.default}
Thread 0: waiting for lock...
Thread 0: got lock, s is {1, 2, 3}
Thread 1: waiting for lock...
Thread 0: set s to {5, 6, 7}
Thread 0: releasing lock...
Thread 1: got lock, s is {5, 6, 7}
Thread 1: set s to {10, 11, 12}
Thread 1: releasing lock...
```

### Xem thêm {.unnumbered .unlisted}

[`atomic_flag_test_and_set()`](#man-atomic_flag_test_and_set)

<!--
[[manbreak]]
## `example()` {#man-example}

[i[`example()` function]i]

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
