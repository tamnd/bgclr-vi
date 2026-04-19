
<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<threads.h>` Các Hàm Multithreading {#threads}

[i[`threads.h` header file]i]

|Hàm|Mô tả|
|-|-|
|[`call_once()`](#man-call_once)|Gọi một hàm đúng một lần dù có bao nhiêu thread cùng thử|
|[`cnd_broadcast()`](#man-cnd_broadcast)|Đánh thức tất cả thread đang chờ trên một condition variable|
|[`cnd_destroy()`](#man-cnd_destroy)|Giải phóng tài nguyên của một condition variable|
|[`cnd_init()`](#man-cnd_init)|Khởi tạo một condition variable để sẵn sàng dùng|
|[`cnd_signal()`](#man-cnd_signal)|Đánh thức một thread đang chờ trên một condition variable|
|[`cnd_timedwait()`](#man-cnd_timedwait)|Chờ trên một condition variable có timeout|
|[`cnd_wait()`](#man-cnd_wait)|Chờ một signal trên một condition variable|
|[`mtx_destroy()`](#man-mtx_destroy)|Dọn dẹp một mutex khi xong việc|
|[`mtx_init()`](#man-mtx_init)|Khởi tạo một mutex để dùng|
|[`mtx_lock()`](#man-mtx_lock)|Giành lock trên một mutex|
|[`mtx_timedlock()`](#man-mtx_timedlock)|Khoá một mutex cho phép timeout|
|[`mtx_trylock()`](#man-mtx_trylock)|Thử khoá một mutex, trả về ngay nếu không được|
|[`mtx_unlock()`](#man-mtx_unlock)|Giải phóng một mutex khi xong critical section|
|[`thrd_create()`](#man-thrd_create)|Tạo một thread thực thi mới|
|[`thrd_current()`](#man-thrd_current)|Lấy ID của thread đang gọi|
|[`thrd_detach()`](#man-thrd_detach)|Tự động dọn dẹp thread khi thoát|
|[`thrd_equal()`](#man-thrd_equal)|So sánh hai thread descriptor xem có bằng nhau không|
|[`thrd_exit()`](#man-thrd_exit)|Dừng và thoát thread này|
|[`thrd_join()`](#man-thrd_join)|Chờ một thread thoát|
|[`thrd_yield()`](#man-thrd_yield)|Dừng chạy để các thread khác có thể chạy|
|[`tss_create()`](#man-tss_create)|Tạo thread-specific storage mới|
|[`tss_delete()`](#man-tss_delete)|Dọn dẹp một biến thread-specific storage|
|[`tss_get()`](#man-tss_get)|Lấy dữ liệu thread-specific|
|[`tss_set()`](#man-tss_set)|Đặt dữ liệu thread-specific|

Cái header này cho chúng ta cả đống thứ hay ho:

* Threads (thread)
* Mutex
* Condition Variable (biến điều kiện)
* Thread-Specific Storage (bộ nhớ riêng cho thread)
* Và, cuối cùng nhưng không kém phần vui vẻ, hàm `call_once()` luôn thú vị!

Tận hưởng nào!

[[manbreak]]
## `call_once()` {#man-call_once}

[i[`call_once()` function]i]

Gọi một hàm đúng một lần dù có bao nhiêu thread cùng thử

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <threads.h>

void call_once(once_flag *flag, void (*func)(void));
```

### Mô tả {.unnumbered .unlisted}

Nếu bạn có một đống thread cùng chạy trên cùng đoạn code có gọi một
hàm, nhưng bạn chỉ muốn hàm đó chạy đúng một lần, thì `call_once()` có
thể giúp bạn.

Điểm bất tiện là hàm được gọi không trả về gì và không nhận tham số nào
cả.

Nếu cần nhiều hơn thế, bạn sẽ phải tự đặt một cờ threadsafe, kiểu như
`atomic_flag`, hoặc một cờ được bảo vệ bằng mutex.

Để dùng được nó, bạn cần truyền vào một con trỏ tới hàm cần thực thi,
`func`, và cả một con trỏ tới cờ kiểu `once_flag`.

`once_flag` là kiểu opaque, nên tất cả những gì bạn cần biết là bạn
khởi tạo nó bằng giá trị `ONCE_FLAG_INIT`.

### Giá trị trả về {.unnumbered .unlisted}

Không trả về gì cả.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <threads.h>

once_flag of = ONCE_FLAG_INIT;  // Khởi tạo như thế này

void run_once_function(void)
{
    printf("I'll only run once!\n");
}

int run(void *arg)
{
    (void)arg;

    printf("Thread running!\n");

    call_once(&of, run_once_function);

    return 0;
}

#define THREAD_COUNT 5

int main(void)
{
    thrd_t t[THREAD_COUNT];

    for (int i = 0; i < THREAD_COUNT; i++)
        thrd_create(t + i, run, NULL);

    for (int i = 0; i < THREAD_COUNT; i++)
        thrd_join(t[i], NULL);
}
```

Output (có thể khác giữa các lần chạy):

``` {.default}
Thread running!
Thread running!
I'll only run once!
Thread running!
Thread running!
Thread running!
```

<!--
### See Also {.unnumbered .unlisted}

[`example()`](#man-example),
-->

[[manbreak]]
## `cnd_broadcast()` {#man-cnd_broadcast}

[i[`cnd_broadcast()` function]i]

Đánh thức tất cả thread đang chờ trên một condition variable

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <threads.h>

int cnd_broadcast(cnd_t *cond);
```

### Mô tả {.unnumbered .unlisted}

Hàm này giống hệt `cnd_signal()` ở chỗ nó đánh thức các thread đang chờ
trên một condition variable... khác biệt là thay vì chỉ khều dậy một
thread, nó đánh thức toàn bộ.

Tất nhiên, chỉ một thread sẽ lấy được mutex, và mấy thread còn lại phải
chờ đến lượt. Nhưng thay vì ngủ để chờ signal, chúng sẽ ngủ để chờ
giành lại mutex. Nói cách khác, chúng đã sẵn sàng nhảy vào cuộc.

Điều này tạo nên khác biệt trong một tình huống cụ thể mà `cnd_signal()`
có thể để bạn kẹt cứng.

Nếu bạn dựa vào các thread tiếp theo để phát `cnd_signal()` kế tiếp,
nhưng `cnd_wait()` của bạn lại nằm trong vòng `while`^[Đúng ra nên như
vậy vì có spurious wakeup.] không cho thread nào thoát ra được, bạn sẽ
kẹt luôn. Không còn thread nào được đánh thức từ việc chờ nữa.

Nhưng nếu bạn `cnd_broadcast()`, tất cả thread đều được đánh thức, và
giả định là ít nhất một trong số đó sẽ được phép thoát khỏi vòng
`while`, rồi nó lại broadcast cho lần đánh thức tiếp theo khi xong
việc.

### Giá trị trả về {.unnumbered .unlisted}

Trả về `thrd_success` hoặc `thrd_error` tuỳ theo mọi chuyện diễn ra thế
nào.

### Ví dụ {.unnumbered .unlisted}

Trong ví dụ dưới đây, chúng ta khởi động một đống thread, nhưng chúng
chỉ được phép chạy nếu ID của chúng khớp với ID hiện tại. Nếu không,
chúng quay lại chờ.

Nếu bạn dùng `cnd_signal()` để đánh thức thread tiếp theo, có thể nó
không phải là thread có ID đúng để chạy. Nếu không phải, nó quay lại
ngủ và chúng ta treo (vì không còn thread nào đang thức để gọi
`cnd_signal()` lần nữa).

Nhưng nếu bạn `cnd_broadcast()` để đánh thức tất cả, tất cả chúng sẽ
lần lượt thử thoát khỏi vòng `while`. Và một trong số đó sẽ thành công.

Thử đổi `cnd_broadcast()` sang `cnd_signal()` để thấy deadlock có khả
năng xảy ra. Không xảy ra mỗi lần, nhưng thường là có.

``` {.c .numberLines}
#include <stdio.h>
#include <threads.h>

cnd_t condvar;
mtx_t mutex;

int run(void *arg)
{
    int id = *(int*)arg;

    static int current_id = 0;

    mtx_lock(&mutex);

    while (id != current_id) {
        printf("THREAD %d: waiting\n", id);
        cnd_wait(&condvar, &mutex);

        if (id != current_id)
            printf("THREAD %d: woke up, but it's not my turn!\n", id);
        else
            printf("THREAD %d: woke up, my turn! Let's go!\n", id);
    }

    current_id++;

    printf("THREAD %d: signaling thread %d to run\n", id, current_id);

    //cnd_signal(&condvar);
    cnd_broadcast(&condvar);
    mtx_unlock(&mutex);

    return 0;
}

#define THREAD_COUNT 5

int main(void)
{
    thrd_t t[THREAD_COUNT];
    int id[] = {4, 3, 2, 1, 0};

    mtx_init(&mutex, mtx_plain);
    cnd_init(&condvar);

    for (int i = 0; i < THREAD_COUNT; i++)
        thrd_create(t + i, run, id + i);

    for (int i = 0; i < THREAD_COUNT; i++)
        thrd_join(t[i], NULL);

    mtx_destroy(&mutex);
    cnd_destroy(&condvar);
}
```

Một lần chạy mẫu với `cnd_broadcast()`:

``` {.default}
THREAD 4: waiting
THREAD 1: waiting
THREAD 3: waiting
THREAD 2: waiting
THREAD 0: signaling thread 1 to run
THREAD 2: woke up, but it's not my turn!
THREAD 2: waiting
THREAD 4: woke up, but it's not my turn!
THREAD 4: waiting
THREAD 3: woke up, but it's not my turn!
THREAD 3: waiting
THREAD 1: woke up, my turn! Let's go!
THREAD 1: signaling thread 2 to run
THREAD 4: woke up, but it's not my turn!
THREAD 4: waiting
THREAD 3: woke up, but it's not my turn!
THREAD 3: waiting
THREAD 2: woke up, my turn! Let's go!
THREAD 2: signaling thread 3 to run
THREAD 4: woke up, but it's not my turn!
THREAD 4: waiting
THREAD 3: woke up, my turn! Let's go!
THREAD 3: signaling thread 4 to run
THREAD 4: woke up, my turn! Let's go!
THREAD 4: signaling thread 5 to run
```

Một lần chạy mẫu với `cnd_signal()`:

``` {.default}
THREAD 4: waiting
THREAD 1: waiting
THREAD 3: waiting
THREAD 2: waiting
THREAD 0: signaling thread 1 to run
THREAD 4: woke up, but it's not my turn!
THREAD 4: waiting

[deadlock at this point]
```

Thấy `THREAD 0` đã signal rằng tới lượt `THREAD 1` chưa? Nhưng---tin
xấu---`THREAD 4` lại là đứa được đánh thức. Thế là không còn ai tiếp
tục quá trình. `cnd_broadcast()` thì sẽ đánh thức tất cả, nên sau cùng
`THREAD 1` sẽ chạy, thoát khỏi `while`, và broadcast để thread tiếp
theo chạy.

### Xem thêm {.unnumbered .unlisted}

[`cnd_signal()`](#man-signal),
[`mtx_lock()`](#man-mtx_lock),
[`mtx_unlock()`](#man-mtx_unlock)

[[manbreak]]
## `cnd_destroy()` {#man-cnd_destroy}

[i[`cnd_destroy()` function]i]

Giải phóng tài nguyên của một condition variable

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <threads.h>

void cnd_destroy(cnd_t *cond);
```

### Mô tả {.unnumbered .unlisted}

Đây là cặp đối nghịch của `cnd_init()` và nên được gọi khi tất cả
thread đã dùng xong một condition variable.

### Giá trị trả về {.unnumbered .unlisted}

Không trả về gì cả!

### Ví dụ {.unnumbered .unlisted}

Ví dụ condition variable tổng quát ở đây, nhưng bạn có thể thấy
`cnd_destroy()` ở gần cuối.

``` {.c .numberLines}
#include <stdio.h>
#include <threads.h>

cnd_t condvar;
mtx_t mutex;

int run(void *arg)
{
    (void)arg;

    mtx_lock(&mutex);

    printf("Thread: waiting...\n");
    cnd_wait(&condvar, &mutex);
    printf("Thread: running again!\n");

    mtx_unlock(&mutex);

    return 0;
}

int main(void)
{
    thrd_t t;

    mtx_init(&mutex, mtx_plain);
    cnd_init(&condvar);

    printf("Main creating thread\n");
    thrd_create(&t, run, NULL);

    // Ngủ 0.1s để thread kia có thời gian vào trạng thái chờ
    thrd_sleep(&(struct timespec){.tv_nsec=100000000L}, NULL);

    mtx_lock(&mutex);
    printf("Main: signaling thread\n");
    cnd_signal(&condvar);
    mtx_unlock(&mutex);

    thrd_join(t, NULL);

    mtx_destroy(&mutex);
    cnd_destroy(&condvar);  // <-- HUỶ CONDITION VARIABLE
}
```

Output:

``` {.default}
Main creating thread
Thread: waiting...
Main: signaling thread
Thread: running again!
```

### Xem thêm {.unnumbered .unlisted}

[`cnd_init()`](#man-cnd_init)

[[manbreak]]
## `cnd_init()` {#man-cnd_init}

[i[`cnd_init()` function]i]

Khởi tạo một condition variable để sẵn sàng dùng

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <threads.h>

int cnd_init(cnd_t *cond);
```

### Mô tả {.unnumbered .unlisted}

Đây là cặp đối nghịch của `cnd_destroy()`. Hàm này chuẩn bị một
condition variable để dùng, làm đủ thứ việc hậu trường trên nó.

Đừng dùng một condition variable mà chưa gọi hàm này trước!

### Giá trị trả về {.unnumbered .unlisted}

Nếu mọi chuyện suôn sẻ, trả về `thrd_success`. Nếu không suôn sẻ, nó
có thể trả về `thrd_nomem` khi hệ thống hết bộ nhớ, hoặc `thread_error`
trong trường hợp lỗi khác.

### Ví dụ {.unnumbered .unlisted}

Ví dụ condition variable tổng quát ở đây, nhưng bạn có thể thấy
`cnd_init()` ở đầu `main()`.

``` {.c .numberLines}
#include <stdio.h>
#include <threads.h>

cnd_t condvar;
mtx_t mutex;

int run(void *arg)
{
    (void)arg;

    mtx_lock(&mutex);

    printf("Thread: waiting...\n");
    cnd_wait(&condvar, &mutex);
    printf("Thread: running again!\n");

    mtx_unlock(&mutex);

    return 0;
}

int main(void)
{
    thrd_t t;

    mtx_init(&mutex, mtx_plain);
    cnd_init(&condvar);      // <-- KHỞI TẠO CONDITION VARIABLE

    printf("Main creating thread\n");
    thrd_create(&t, run, NULL);

    // Ngủ 0.1s để thread kia có thời gian vào trạng thái chờ
    thrd_sleep(&(struct timespec){.tv_nsec=100000000L}, NULL);

    mtx_lock(&mutex);
    printf("Main: signaling thread\n");
    cnd_signal(&condvar);
    mtx_unlock(&mutex);

    thrd_join(t, NULL);

    mtx_destroy(&mutex);
    cnd_destroy(&condvar);
}
```

Output:

``` {.default}
Main creating thread
Thread: waiting...
Main: signaling thread
Thread: running again!
```

### Xem thêm {.unnumbered .unlisted}

[`cnd_destroy()`](#man-cnd_destroy)

[[manbreak]]
## `cnd_signal()` {#man-cnd_signal}

[i[`cnd_signal()` function]i]

Đánh thức một thread đang chờ trên một condition variable

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <threads.h>

int cnd_signal(cnd_t *cond);
```

### Mô tả {.unnumbered .unlisted}

Nếu bạn có một thread (hoặc một đống thread) đang chờ trên một
condition variable, hàm này sẽ đánh thức một trong số đó để chạy.

So với `cnd_broadcast()` vốn đánh thức tất cả thread. Xem trang
[`cnd_broadcast()`](#man-cnd_broadcast) để biết thêm thông tin về lúc
nào nên dùng cái kia và lúc nào nên dùng cái này.

### Giá trị trả về {.unnumbered .unlisted}

Trả về `thrd_success` hoặc `thrd_error` tuỳ xem chương trình của bạn
đang vui hay buồn.

### Ví dụ {.unnumbered .unlisted}

Ví dụ condition variable tổng quát ở đây, nhưng bạn có thể thấy
`cnd_signal()` ở giữa `main()`.

``` {.c .numberLines}
#include <stdio.h>
#include <threads.h>

cnd_t condvar;
mtx_t mutex;

int run(void *arg)
{
    (void)arg;

    mtx_lock(&mutex);

    printf("Thread: waiting...\n");
    cnd_wait(&condvar, &mutex);
    printf("Thread: running again!\n");

    mtx_unlock(&mutex);

    return 0;
}

int main(void)
{
    thrd_t t;

    mtx_init(&mutex, mtx_plain);
    cnd_init(&condvar);

    printf("Main creating thread\n");
    thrd_create(&t, run, NULL);

    // Ngủ 0.1s để thread kia có thời gian vào trạng thái chờ
    thrd_sleep(&(struct timespec){.tv_nsec=100000000L}, NULL);

    mtx_lock(&mutex);
    printf("Main: signaling thread\n");
    cnd_signal(&condvar);    // <-- SIGNAL THREAD CON TẠI ĐÂY!
    mtx_unlock(&mutex);

    thrd_join(t, NULL);

    mtx_destroy(&mutex);
    cnd_destroy(&condvar);
}
```

Output:

``` {.default}
Main creating thread
Thread: waiting...
Main: signaling thread
Thread: running again!
```

### Xem thêm {.unnumbered .unlisted}

[`cnd_init()`](#man-cnd_init),
[`cnd_destroy()`](#man-cnd_destroy)

[[manbreak]]
## `cnd_timedwait()` {#man-cnd_timedwait}

[i[`cnd_timedwait()` function]i]

Chờ trên một condition variable có timeout

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <threads.h>

int cnd_timedwait(cnd_t *restrict cond, mtx_t *restrict mtx,
                  const struct timespec *restrict ts);
```

### Mô tả {.unnumbered .unlisted}

Hàm này giống [`cnd_wait()`](#man-cnd_wait) chỉ khác là chúng ta được
phép chỉ định thêm một timeout.

Lưu ý là thread vẫn phải giành lại mutex để làm thêm việc kể cả sau
khi timeout. Khác biệt chính là `cnd_wait()` thông thường chỉ thử
giành mutex sau khi có `cnd_signal()` hoặc `cnd_broadcast()`, trong khi
`cnd_timedwait()` cũng làm vậy, **và** còn thử giành mutex sau khi
timeout.

Timeout được chỉ định dưới dạng thời gian tuyệt đối (thời gian tuyệt
đối) theo UTC tính từ Epoch. Bạn có thể lấy giá trị này qua hàm
[`timespec_get()`](#man-timespec_get) rồi cộng thêm vào kết quả để
timeout muộn hơn thời điểm hiện tại, như trong ví dụ.

Coi chừng chuyện bạn không được có nhiều hơn 999999999 nano giây
(nanosecond) trong trường `tv_nsec` của `struct timespec`. Dùng phép
mod để chúng nằm trong khoảng cho phép.

### Giá trị trả về {.unnumbered .unlisted}

Nếu thread thức dậy vì lý do không phải timeout (ví dụ signal hay
broadcast), trả về `thrd_success`. Nếu thức dậy do timeout, trả về
`thrd_timedout`. Ngược lại trả về `thrd_error`.

### Ví dụ {.unnumbered .unlisted}

Ví dụ này cho một thread chờ trên một condition variable tối đa 1.75
giây. Và nó luôn timeout vì chả có ai gửi signal cả. Bi kịch.

``` {.c .numberLines}
#include <stdio.h>
#include <time.h>
#include <threads.h>

cnd_t condvar;
mtx_t mutex;

int run(void *arg)
{
    (void)arg;

    mtx_lock(&mutex);

    struct timespec ts;

    // Lấy thời gian hiện tại
    timespec_get(&ts, TIME_UTC);

    // Cộng thêm 1.75 giây kể từ bây giờ
    ts.tv_sec += 1;
    ts.tv_nsec += 750000000L;

    // Xử lý tràn nsec
    ts.tv_sec += ts.tv_nsec / 1000000000L;
    ts.tv_nsec = ts.tv_nsec % 1000000000L;

    printf("Thread: waiting...\n");
    int r = cnd_timedwait(&condvar, &mutex, &ts);

    switch (r) {
        case thrd_success:
            printf("Thread: signaled!\n");
            break;

        case thrd_timedout:
            printf("Thread: timed out!\n");
            return 1;

        case thrd_error:
            printf("Thread: Some kind of error\n");
            return 2;
    }

    mtx_unlock(&mutex);

    return 0;
}

int main(void)
{
    thrd_t t;

    mtx_init(&mutex, mtx_plain);
    cnd_init(&condvar);

    printf("Main creating thread\n");
    thrd_create(&t, run, NULL);

    // Ngủ 3s để thread kia có thời gian timeout
    thrd_sleep(&(struct timespec){.tv_sec=3}, NULL);

    thrd_join(t, NULL);

    mtx_destroy(&mutex);
    cnd_destroy(&condvar);
}
```

Output:

``` {.default}
Main creating thread
Thread: waiting...
Thread: timed out!
```

### Xem thêm {.unnumbered .unlisted}

[`cnd_wait()`](#man-cnd_wait),
[`timespec_get()`](#man-timespec_get)

[[manbreak]]
## `cnd_wait()` {#man-cnd_wait}

[i[`cnd_wait()` function]i]

Chờ một signal trên một condition variable

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <threads.h>

int cnd_wait(cnd_t *cond, mtx_t *mtx);
```

### Mô tả {.unnumbered .unlisted}

Hàm này đưa thread đang gọi vào giấc ngủ cho tới khi nó được đánh thức
bởi một lời gọi `cnd_signal()` hoặc `cnd_broadcast()`.

### Giá trị trả về {.unnumbered .unlisted}

Nếu mọi thứ tuyệt vời, trả về `thrd_success`. Ngược lại, nó trả về
`thrd_error` để báo rằng có gì đó đã sai nghiêm trọng đến mức kinh
hoàng.

### Ví dụ {.unnumbered .unlisted}

Ví dụ condition variable tổng quát ở đây, nhưng bạn có thể thấy
`cnd_wait()` trong hàm `run()`.

``` {.c .numberLines}
#include <stdio.h>
#include <threads.h>

cnd_t condvar;
mtx_t mutex;

int run(void *arg)
{
    (void)arg;

    mtx_lock(&mutex);

    printf("Thread: waiting...\n");
    cnd_wait(&condvar, &mutex);       // <-- CHỜ TẠI ĐÂY!
    printf("Thread: running again!\n");

    mtx_unlock(&mutex);

    return 0;
}

int main(void)
{
    thrd_t t;

    mtx_init(&mutex, mtx_plain);
    cnd_init(&condvar);

    printf("Main creating thread\n");
    thrd_create(&t, run, NULL);

    // Ngủ 0.1s để thread kia có thời gian vào trạng thái chờ
    thrd_sleep(&(struct timespec){.tv_nsec=100000000L}, NULL);

    mtx_lock(&mutex);
    printf("Main: signaling thread\n");
    cnd_signal(&condvar);    // <-- SIGNAL THREAD CON TẠI ĐÂY!
    mtx_unlock(&mutex);

    thrd_join(t, NULL);

    mtx_destroy(&mutex);
    cnd_destroy(&condvar);
}
```

Output:

``` {.default}
Main creating thread
Thread: waiting...
Main: signaling thread
Thread: running again!
```

### Xem thêm {.unnumbered .unlisted}

[`cnd_timedwait()`](#man-cnd_timedwait)

[[manbreak]]
## `mtx_destroy()` {#man-mtx_destroy}

[i[`mtx_destroy()` function]i]

Dọn dẹp một mutex khi xong việc

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <threads.h>

void mtx_destroy(mtx_t *mtx);
```

### Mô tả {.unnumbered .unlisted}

Ngược lại của [`mtx_init()`](#man-mtx_init), hàm này giải phóng mọi
tài nguyên liên quan đến mutex được truyền vào.

Bạn nên gọi hàm này khi tất cả thread đã xong việc với mutex đó.

### Giá trị trả về {.unnumbered .unlisted}

Không trả về gì cả, cái đồ vô ơn ích kỷ!

### Ví dụ {.unnumbered .unlisted}

Ví dụ mutex tổng quát ở đây, nhưng bạn có thể thấy `mtx_destroy()` ở
gần cuối.

``` {.c .numberLines}
#include <stdio.h>
#include <threads.h>

cnd_t condvar;
mtx_t mutex;

int run(void *arg)
{
    (void)arg;

    static int count = 0;

    mtx_lock(&mutex);

    printf("Thread: I got %d!\n", count);
    count++;

    mtx_unlock(&mutex);

    return 0;
}

#define THREAD_COUNT 5

int main(void)
{
    thrd_t t[THREAD_COUNT];

    mtx_init(&mutex, mtx_plain);

    for (int i = 0; i < THREAD_COUNT; i++)
        thrd_create(t + i, run, NULL);

    for (int i = 0; i < THREAD_COUNT; i++)
        thrd_join(t[i], NULL);

    mtx_destroy(&mutex);   // <-- HUỶ MUTEX TẠI ĐÂY
}
```

Output:

``` {.default}
Thread: I got 0!
Thread: I got 1!
Thread: I got 2!
Thread: I got 3!
Thread: I got 4!
```

### Xem thêm {.unnumbered .unlisted}

[`mtx_init()`](#man-mtx_init)

[[manbreak]]
## `mtx_init()` {#man-mtx_init}

[i[`mtx_init()` function]i]

Khởi tạo một mutex để dùng

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <threads.h>

int mtx_init(mtx_t *mtx, int type);
```

### Mô tả {.unnumbered .unlisted}

Trước khi bạn có thể dùng một biến mutex, bạn phải khởi tạo nó bằng
lời gọi này để chuẩn bị mọi thứ sẵn sàng.

Nhưng khoan! Không đơn giản thế đâu. Bạn phải nói cho nó biết bạn muốn
tạo `type` mutex loại gì.

|Loại|Mô tả|
|-|-|
|`mtx_plain`|Mutex xưa nay thường thấy|
|`mtx_timed`|Mutex hỗ trợ timeout|
|`mtx_plain|mtx_recursive`|Mutex recursive (đệ quy)|
|`mtx_timed|mtx_recursive`|Mutex recursive hỗ trợ timeout|

Như bạn thấy, bạn có thể biến mutex plain hoặc timed thành _recursive_
bằng cách OR bit với `mtx_recursive`.

"Recursive" nghĩa là kẻ đang giữ lock có thể gọi `mtx_lock()` nhiều
lần trên cùng một lock. (Nó phải unlock cũng bằng số lần tương đương
thì người khác mới lấy được mutex.) Điều này có thể giúp code dễ chịu
hơn trong một số trường hợp, đặc biệt nếu bạn gọi một hàm cần khoá
mutex mà bạn đã đang giữ mutex đó rồi.

Và timeout cho thread một cơ hội _thử_ giành lock trong một khoảng
thời gian, rồi bỏ cuộc nếu không giành được trong khung thời gian đó.
Bạn dùng hàm [`mtx_timedlock()`](#man-mtx_timedlock) với mutex kiểu
`mtx_timed`.

### Giá trị trả về {.unnumbered .unlisted}

Trả về `thrd_success` trong một thế giới hoàn hảo, và có thể là
`thrd_error` trong một thế giới không hoàn hảo.

### Ví dụ {.unnumbered .unlisted}

Ví dụ mutex tổng quát ở đây, nhưng bạn có thể thấy `mtx_init()` ở đầu
`main()`:

``` {.c .numberLines}
#include <stdio.h>
#include <threads.h>

cnd_t condvar;
mtx_t mutex;

int run(void *arg)
{
    (void)arg;

    static int count = 0;

    mtx_lock(&mutex);

    printf("Thread: I got %d!\n", count);
    count++;

    mtx_unlock(&mutex);

    return 0;
}

#define THREAD_COUNT 5

int main(void)
{
    thrd_t t[THREAD_COUNT];

    mtx_init(&mutex, mtx_plain);  // <-- TẠO MUTEX TẠI ĐÂY

    for (int i = 0; i < THREAD_COUNT; i++)
        thrd_create(t + i, run, NULL);

    for (int i = 0; i < THREAD_COUNT; i++)
        thrd_join(t[i], NULL);

    mtx_destroy(&mutex);   // <-- HUỶ MUTEX TẠI ĐÂY
}
```

Output:

``` {.default}
Thread: I got 0!
Thread: I got 1!
Thread: I got 2!
Thread: I got 3!
Thread: I got 4!
```

### Xem thêm {.unnumbered .unlisted}

[`mtx_destroy()`](#man-mtx_destroy)

[[manbreak]]
## `mtx_lock()` {#man-mtx_lock}

[i[`mtx_lock()` function]i]

Giành lock trên một mutex

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <threads.h>

int mtx_lock(mtx_t *mtx);
```

### Mô tả {.unnumbered .unlisted}

Nếu bạn là một thread và muốn bước vào critical section (đoạn tới hạn),
tôi có một hàm hợp ý bạn đây!

Một thread gọi hàm này sẽ chờ cho tới khi giành được mutex, rồi nó sẽ
tóm lấy, tỉnh dậy và chạy!

Nếu mutex là recursive và đã bị khoá bởi chính thread này rồi, nó sẽ
được khoá lần nữa và số đếm lock sẽ tăng lên. Nếu mutex không phải
recursive và thread đã giữ nó rồi, lời gọi này sẽ báo lỗi.

### Giá trị trả về {.unnumbered .unlisted}

Trả về `thrd_success` khi mọi thứ tốt đẹp và `thrd_error` khi trục
trặc.

### Ví dụ {.unnumbered .unlisted}

Ví dụ mutex tổng quát ở đây, nhưng bạn có thể thấy `mtx_lock()` trong
hàm `run()`:

``` {.c .numberLines}
#include <stdio.h>
#include <threads.h>

cnd_t condvar;
mtx_t mutex;

int run(void *arg)
{
    (void)arg;

    static int count = 0;

    mtx_lock(&mutex);  // <-- KHOÁ TẠI ĐÂY

    printf("Thread: I got %d!\n", count);
    count++;

    mtx_unlock(&mutex);

    return 0;
}

#define THREAD_COUNT 5

int main(void)
{
    thrd_t t[THREAD_COUNT];

    mtx_init(&mutex, mtx_plain);  // <-- TẠO MUTEX TẠI ĐÂY

    for (int i = 0; i < THREAD_COUNT; i++)
        thrd_create(t + i, run, NULL);

    for (int i = 0; i < THREAD_COUNT; i++)
        thrd_join(t[i], NULL);

    mtx_destroy(&mutex);   // <-- HUỶ MUTEX TẠI ĐÂY
}
```

Output:

``` {.default}
Thread: I got 0!
Thread: I got 1!
Thread: I got 2!
Thread: I got 3!
Thread: I got 4!
```

### Xem thêm {.unnumbered .unlisted}

[`mtx_unlock()`](#man-mtx_unlock),
[`mtx_trylock()`](#man-mtx_trylock),
[`mtx_timedlock()`](#man-mtx_timedlock)

[[manbreak]]
## `mtx_timedlock()` {#man-mtx_timedlock}

[i[`mtx_timedlock()` function]i]

Khoá một mutex cho phép timeout

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <threads.h>

int mtx_timedlock(mtx_t *restrict mtx, const struct timespec *restrict ts);
```

### Mô tả {.unnumbered .unlisted}

Giống hệt [`mtx_lock()`](#man-mtx_lock) chỉ khác là bạn có thể thêm
timeout nếu không muốn chờ mãi mãi.

Timeout được chỉ định dưới dạng thời gian tuyệt đối theo UTC tính từ
Epoch. Bạn có thể lấy giá trị này qua hàm
[`timespec_get()`](#man-timespec_get) rồi cộng thêm vào kết quả để
timeout muộn hơn thời điểm hiện tại, như trong ví dụ.

Coi chừng chuyện bạn không được có nhiều hơn 999999999 nano giây trong
trường `tv_nsec` của `struct timespec`. Dùng phép mod để chúng nằm
trong khoảng cho phép.

### Giá trị trả về {.unnumbered .unlisted}

Nếu mọi chuyện ổn và mutex được giành, trả về `thrd_success`. Nếu
timeout xảy ra trước, trả về `thrd_timedout`.

Ngoài ra trả về `thrd_error`. Vì nếu chả có gì đúng thì mọi thứ đều
sai.

### Ví dụ {.unnumbered .unlisted}

Ví dụ này cho một thread chờ trên mutex tối đa 1.75 giây. Và nó luôn
timeout vì chả có ai gửi signal cả.

``` {.c .numberLines}
#include <stdio.h>
#include <time.h>
#include <threads.h>

mtx_t mutex;

int run(void *arg)
{
    (void)arg;

    struct timespec ts;

    // Lấy thời gian hiện tại
    timespec_get(&ts, TIME_UTC);

    // Cộng thêm 1.75 giây kể từ bây giờ
    ts.tv_sec += 1;
    ts.tv_nsec += 750000000L;

    // Xử lý tràn nsec
    ts.tv_sec += ts.tv_nsec / 1000000000L;
    ts.tv_nsec = ts.tv_nsec % 1000000000L;

    printf("Thread: waiting for lock...\n");
    int r = mtx_timedlock(&mutex, &ts);

    switch (r) {
        case thrd_success:
            printf("Thread: grabbed lock!\n");
            break;

        case thrd_timedout:
            printf("Thread: timed out!\n");
            break;

        case thrd_error:
            printf("Thread: Some kind of error\n");
            break;
    }

    mtx_unlock(&mutex);

    return 0;
}

int main(void)
{
    thrd_t t;

    mtx_init(&mutex, mtx_plain);

    mtx_lock(&mutex);

    printf("Main creating thread\n");
    thrd_create(&t, run, NULL);

    // Ngủ 3s để thread kia có thời gian timeout
    thrd_sleep(&(struct timespec){.tv_sec=3}, NULL);

    mtx_unlock(&mutex);

    thrd_join(t, NULL);

    mtx_destroy(&mutex);
}
```

Output:

``` {.default}
Main creating thread
Thread: waiting for lock...
Thread: timed out!
```

### Xem thêm {.unnumbered .unlisted}

[`mtx_lock()`](#man-mtx_lock),
[`mtx_trylock()`](#man-mtx_trylock),
[`timespec_get()`](#man-timespec_get)

[[manbreak]]
## `mtx_trylock()` {#man-mtx_trylock}

[i[`mtx_trylock()` function]i]

Thử khoá một mutex, trả về ngay nếu không được

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <threads.h>

int mtx_trylock(mtx_t *mtx);
```

### Mô tả {.unnumbered .unlisted}

Hàm này hoạt động giống hệt [`mtx_lock`](#man-mtx_lock) chỉ khác là nó
trả về ngay lập tức nếu không thể giành được lock.

Spec có ghi rằng có khả năng `mtx_trylock()` có thể thất bại kiểu
spurious với `thrd_busy` ngay cả khi không có thread nào khác đang giữ
lock. Tôi không chắc tại sao lại vậy, nhưng bạn nên viết code phòng thủ
chống lại điều này.

### Giá trị trả về {.unnumbered .unlisted}

Trả về `thrd_success` nếu mọi chuyện ổn. Hoặc `thrd_busy` nếu có thread
khác đang giữ lock. Hoặc `thrd_error`, nghĩa là có gì đó đã đi đúng. À
ý tôi là "sai".

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <time.h>
#include <threads.h>

mtx_t mutex;

int run(void *arg)
{
    int id = *(int*)arg;

    int r = mtx_trylock(&mutex);   // <-- THỬ GIÀNH LOCK

    switch (r) {
        case thrd_success:
            printf("Thread %d: grabbed lock!\n", id);
            break;

        case thrd_busy:
            printf("Thread %d: lock already taken :(\n", id);
            return 1;

        case thrd_error:
            printf("Thread %d: Some kind of error\n", id);
            return 2;
    }

    mtx_unlock(&mutex);

    return 0;
}

#define THREAD_COUNT 5

int main(void)
{
    thrd_t t[THREAD_COUNT];
    int id[THREAD_COUNT];

    mtx_init(&mutex, mtx_plain);

    for (int i = 0; i < THREAD_COUNT; i++) {
        id[i] = i;
        thrd_create(t + i, run, id + i);
    }

    for (int i = 0; i < THREAD_COUNT; i++)
        thrd_join(t[i], NULL);

    mtx_destroy(&mutex);
}
```

Output (khác nhau giữa các lần chạy):

``` {.default}
Thread 0: grabbed lock!
Thread 1: lock already taken :(
Thread 4: lock already taken :(
Thread 3: grabbed lock!
Thread 2: lock already taken :(
```

### Xem thêm {.unnumbered .unlisted}

[`mtx_lock()`](#man-mtx_lock),
[`mtx_timedlock()`](#man-mtx_timedlock),
[`mtx_unlock()`](#man-mtx_unlock)

[[manbreak]]
## `mtx_unlock()` {#man-mtx_unlock}

[i[`mtx_unlock()` function]i]

Giải phóng một mutex khi xong critical section

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <threads.h>

int mtx_unlock(mtx_t *mtx);
```

### Mô tả {.unnumbered .unlisted}

Sau khi bạn đã làm xong hết mấy thứ nguy hiểm, nơi mà các thread liên
quan không được giẫm chân lên nhau... bạn có thể buông tay siết chặt
của mình khỏi mutex bằng cách gọi `mtx_unlock()`.

### Giá trị trả về {.unnumbered .unlisted}

Trả về `thrd_success` khi thành công. Hoặc `thrd_error` khi lỗi. Không
gì sáng tạo lắm trong khoản này.

### Ví dụ {.unnumbered .unlisted}

Ví dụ mutex tổng quát ở đây, nhưng bạn có thể thấy `mtx_unlock()`
trong hàm `run()`:

``` {.c .numberLines}
#include <stdio.h>
#include <threads.h>

cnd_t condvar;
mtx_t mutex;

int run(void *arg)
{
    (void)arg;

    static int count = 0;

    mtx_lock(&mutex);

    printf("Thread: I got %d!\n", count);
    count++;

    mtx_unlock(&mutex);  // <-- UNLOCK TẠI ĐÂY

    return 0;
}

#define THREAD_COUNT 5

int main(void)
{
    thrd_t t[THREAD_COUNT];

    mtx_init(&mutex, mtx_plain);

    for (int i = 0; i < THREAD_COUNT; i++)
        thrd_create(t + i, run, NULL);

    for (int i = 0; i < THREAD_COUNT; i++)
        thrd_join(t[i], NULL);

    mtx_destroy(&mutex);
}
```

Output:

``` {.default}
Thread: I got 0!
Thread: I got 1!
Thread: I got 2!
Thread: I got 3!
Thread: I got 4!
```

### Xem thêm {.unnumbered .unlisted}

[`mtx_lock()`](#man-mtx_lock),
[`mtx_timedlock()`](#man-mtx_timedlock),
[`mtx_trylock()`](#man-mtx_trylock)

[[manbreak]]
## `thrd_create()` {#man-thrd_create}

[i[`thrd_create()` function]i]

Tạo một thread thực thi mới

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <threads.h>

int thrd_create(thrd_t *thr, thrd_start_t func, void *arg);
```

### Mô tả {.unnumbered .unlisted}

Giờ thì _bạn_ có QUYỀN NĂNG!

Phải không nào?

Đây là cách bạn khởi động thread mới để chương trình làm nhiều việc
cùng lúc^[Ừm, ít nhất là chừng nào bạn có đủ core rảnh. OS sẽ lên lịch
cho chúng tuỳ khả năng.]!

Để làm được chuyện này, bạn cần truyền vào một con trỏ tới `thrd_t` sẽ
được dùng để đại diện cho thread mà bạn đang spawn (tạo).

Thread đó sẽ bắt đầu chạy hàm mà bạn truyền con trỏ vào qua tham số
`func`. Đây là một giá trị kiểu `thrd_start_t`, tức là con trỏ tới một
hàm trả về `int` và nhận một tham số `void*` duy nhất, ví dụ:

``` {.c}
int thread_run_func(void *arg)
```

Và, như bạn có thể đoán, con trỏ bạn truyền vào `thrd_create()` cho
tham số `arg` sẽ được chuyển tiếp đến hàm `func`. Đây là cách bạn cung
cấp thêm thông tin cho thread khi nó khởi động.

Tất nhiên, với `arg`, bạn phải chắc chắn truyền con trỏ tới một object
thread-safe hoặc mỗi thread một cái riêng.

Nếu thread trả về từ hàm đó, nó thoát y như thể đã gọi `thrd_exit()`.

Cuối cùng, giá trị mà hàm `func` trả về có thể được thread cha nhặt
bằng `thrd_join()`.

### Giá trị trả về {.unnumbered .unlisted}

Trong trường hợp tốt đẹp, trả về `thrd_success`. Nếu bạn hết bộ nhớ,
sẽ trả về `thrd_nomem`. Ngược lại, `thrd_error`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <threads.h>

int run(void *arg)
{
    int id = *(int*)arg;

    printf("Thread %d: I'm alive!!\n", id);

    return id;
}

#define THREAD_COUNT 5

int main(void)
{
    thrd_t t[THREAD_COUNT];
    int id[THREAD_COUNT];  // Mỗi thread một cái

    for (int i = 0; i < THREAD_COUNT; i++) {
        id[i] = i; // Truyền số thứ tự thread làm ID
        thrd_create(t + i, run, id + i);
    }

    for (int i = 0; i < THREAD_COUNT; i++) {
        int res;

        thrd_join(t[i], &res);

        printf("Main: thread %d exited with code %d\n", i, res);
    }
}
```

Output (có thể khác nhau giữa các lần chạy):

``` {.default}
Thread 1: I'm alive!!
Thread 0: I'm alive!!
Thread 3: I'm alive!!
Thread 2: I'm alive!!
Main: thread 0 exited with code 0
Main: thread 1 exited with code 1
Main: thread 2 exited with code 2
Main: thread 3 exited with code 3
Thread 4: I'm alive!!
Main: thread 4 exited with code 4
```

### Xem thêm {.unnumbered .unlisted}

[`thrd_exit()`](#man-thrd_exit),
[`thrd_join()`](#man-thrd_join)

[[manbreak]]
## `thrd_current()` {#man-thrd_current}

[i[`thrd_current()` function]i]

Lấy ID của thread đang gọi

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <threads.h>

thrd_t thrd_current(void);
```

### Mô tả {.unnumbered .unlisted}

Mỗi thread có một ID opaque kiểu `thrd_t`. Đây là giá trị mà ta thấy
được khởi tạo khi gọi [`thrd_create()`](#man-thrd_create).

Nhưng nếu bạn muốn lấy ID của thread đang chạy thì sao?

Không vấn đề gì! Gọi hàm này thôi là nó trả về cho bạn.

Để làm gì ư? Ai mà biết!

Thực ra, thành thật mà nói, tôi có thể thấy nó được dùng ở vài chỗ.

1. Bạn có thể dùng để một thread tự detach (detach) chính mình bằng
   `thrd_detach()`. Tôi không rõ tại sao bạn lại muốn làm điều này.
2. Bạn có thể dùng để so sánh ID của thread hiện tại với một ID khác
   mà bạn lưu trong biến nào đó bằng hàm `thrd_equal()`. Cái này nghe
   hợp lý nhất.
3. ...
4. Kiếm lời!

Nếu ai có cách dùng khác, cho tôi biết nhé.

### Giá trị trả về {.unnumbered .unlisted}

Trả về ID của thread đang gọi.

### Ví dụ {.unnumbered .unlisted}

Đây là ví dụ chung chung cho thấy cách lấy ID thread hiện tại và so
sánh với một ID thread đã ghi trước đó rồi đưa ra hành động kịch tính
dựa trên kết quả! Với sự tham gia của Arnold Schwarzenegger!

``` {.c .numberLines}
#include <stdio.h>
#include <threads.h>

thrd_t first_thread_id;

int run(void *arg)
{
    (void)arg;

    thrd_t my_id = thrd_current();   // <-- LẤY ID THREAD CỦA TÔI

    if (thrd_equal(my_id, first_thread_id))
        printf("I'm the first thread!\n");
    else
        printf("I'm not the first!\n");

    return 0;
}

int main(void)
{
    thrd_t t;

    thrd_create(&first_thread_id, run, NULL);
    thrd_create(&t, run, NULL);

    thrd_join(first_thread_id, NULL);
    thrd_join(t, NULL);
}
```

Output:

``` {.default}
Come on, you got what you want, Cohaagen! Give deez people ay-ah!
```

À không, đợi đã, đó là câu thoại của Arnold Schwarzenegger trong
_Total Recall_, một trong những phim khoa học viễn tưởng hay nhất mọi
thời đại. Xem nó ngay rồi quay lại đọc tiếp trang tham khảo này.

Trời---kết phim mới đỉnh làm sao! Còn Johnny Cab? Xuất sắc. Thôi tiếp
nào!

Output:

``` {.default}
I'm the first thread!
I'm not the first!
```

### Xem thêm {.unnumbered .unlisted}

[`thrd_equal()`](#man-thrd_equal),
[`thrd_detach()`](#man-thrd_detach)

[[manbreak]]
## `thrd_detach()` {#man-thrd_detach}

[i[`thrd_detach()` function]i]

Tự động dọn dẹp thread khi thoát

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <threads.h>

int thrd_detach(thrd_t thr);
```

### Mô tả {.unnumbered .unlisted}

Bình thường bạn phải `thrd_join()` để mấy tài nguyên liên quan đến
thread đã chết được dọn dẹp. (Đáng chú ý nhất là exit status của nó
vẫn còn lởn vởn chờ được nhặt.)

Nhưng nếu bạn gọi `thrd_detach()` trên thread trước, thì không cần dọn
thủ công nữa. Chúng cứ thế thoát và được OS dọn dẹp.

(Lưu ý rằng khi main thread chết thì tất cả thread đều chết, dù trong
trường hợp nào.)

### Giá trị trả về {.unnumbered .unlisted}

`thrd_success` nếu thread được detach thành công, ngược lại là
`thrd_error`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <threads.h>

thrd_t first_thread_id;

int run(void *arg)
{
    (void)arg;

    printf("Thread running!\n");

    return 0;
}

#define THREAD_COUNT 5

int main(void)
{
    thrd_t t;

    for (int i = 0; i < THREAD_COUNT; i++) {
        thrd_create(&t, run, NULL);
        thrd_detach(t);
    }

    // Không cần thrd_join()!

    // Ngủ 1/4 giây để chúng kịp chạy xong hết
    thrd_sleep(&(struct timespec){.tv_nsec=250000000}, NULL);
}
```

### Xem thêm {.unnumbered .unlisted}

[`thrd_join()`](#man-thrd_join),
[`thrd_exit()`](#man-thrd_exit)

[[manbreak]]
## `thrd_equal()` {#man-thrd_equal}

[i[`thrd_equal()` function]i]

So sánh hai thread descriptor xem có bằng nhau không

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <threads.h>

int thrd_equal(thrd_t thr0, thrd_t thr1);
```

### Mô tả {.unnumbered .unlisted}

Nếu bạn có hai thread descriptor trong các biến `thrd_t`, bạn có thể
kiểm tra chúng có bằng nhau không bằng hàm này.

Ví dụ, có thể một trong các thread có "siêu năng lực" đặc biệt mà các
thread khác không có, và hàm run cần phân biệt được chúng, như trong
ví dụ.

### Giá trị trả về {.unnumbered .unlisted}

Trả về khác 0 nếu hai thread bằng nhau. Trả về `0` nếu không.

### Ví dụ {.unnumbered .unlisted}

Đây là ví dụ chung chung cho thấy cách lấy ID thread hiện tại và so
sánh với một ID thread đã ghi trước đó rồi đưa ra hành động nhàm chán
dựa trên kết quả.

``` {.c .numberLines}
#include <stdio.h>
#include <threads.h>

thrd_t first_thread_id;

int run(void *arg)
{
    (void)arg;

    thrd_t my_id = thrd_current();

    if (thrd_equal(my_id, first_thread_id))  // <-- SO SÁNH!
        printf("I'm the first thread!\n");
    else
        printf("I'm not the first!\n");

    return 0;
}

int main(void)
{
    thrd_t t;

    thrd_create(&first_thread_id, run, NULL);
    thrd_create(&t, run, NULL);

    thrd_join(first_thread_id, NULL);
    thrd_join(t, NULL);
}
```

Output:

``` {.default}
I'm the first thread!
I'm not the first!
```

### Xem thêm {.unnumbered .unlisted}

[`thrd_current()`](#man-thrd_current)

[[manbreak]]
## `thrd_exit()` {#man-thrd_exit}

[i[`thrd_exit()` function]i]

Dừng và thoát thread này

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <threads.h>

_Noreturn void thrd_exit(int res);
```

### Mô tả {.unnumbered .unlisted}

Thread thường thoát bằng cách return từ hàm run của nó. Nhưng nếu nó
muốn thoát sớm (có thể từ sâu trong call stack), hàm này sẽ làm việc
đó.

Mã `res` có thể được một thread khác nhặt lấy qua `thrd_join()`, và nó
tương đương với việc trả về một giá trị từ hàm run.

Như khi return từ hàm run, hàm này cũng sẽ dọn dẹp đúng cách toàn bộ
thread-specific storage liên quan đến thread này---tất cả destructor
cho các biến TSS của thread sẽ được gọi. Nếu vẫn còn biến TSS với
destructor sau đợt dọn dẹp đầu tiên^[Ví dụ, nếu một destructor làm cho
nhiều biến khác được đặt lại.], các destructor còn lại sẽ được gọi.
Việc này lặp lại cho tới khi không còn gì nữa, hoặc số vòng tàn sát
đạt `TSS_DTOR_ITERATIONS`.

Nếu main thread gọi hàm này, nó như thể bạn đã gọi
`exit(EXIT_SUCCESS)`.

### Giá trị trả về {.unnumbered .unlisted}

Hàm này không bao giờ trả về vì thread gọi nó bị giết trong quá trình
này. Ảo diệu thiệt!

### Ví dụ {.unnumbered .unlisted}

Các thread trong ví dụ này thoát sớm với kết quả `22` nếu chúng nhận
được giá trị `NULL` cho `arg`.

``` {.c .numberLines}
#include <stdio.h>
#include <threads.h>

thrd_t first_thread_id;

int run(void *arg)
{
    (void)arg;

    if (arg == NULL)
        thrd_exit(22);

    return 0;
}

#define THREAD_COUNT 5

int main(void)
{
    thrd_t t[THREAD_COUNT];

    for (int i = 0; i < THREAD_COUNT; i++)
        thrd_create(t + i, run, i == 2? NULL: "spatula");


    for (int i = 0; i < THREAD_COUNT; i++) {
        int res;
        thrd_join(t[i], &res);

        printf("Thread %d exited with code %d\n", i, res);
    }
}
```

Output:

``` {.default}
Thread 0 exited with code 0
Thread 1 exited with code 0
Thread 2 exited with code 22
Thread 3 exited with code 0
Thread 4 exited with code 0
```

### Xem thêm {.unnumbered .unlisted}

[`thrd_join()`](#man-thrd_join)

[[manbreak]]
## `thrd_join()` {#man-thrd_join}

[i[`thrd_join()` function]i]

Chờ một thread thoát

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <threads.h>

int thrd_join(thrd_t thr, int *res);
```

### Mô tả {.unnumbered .unlisted}

Khi thread cha bắn ra một đống thread con, nó có thể chờ chúng chạy
xong bằng lời gọi này

### Giá trị trả về {.unnumbered .unlisted}

### Ví dụ {.unnumbered .unlisted}

Các thread trong ví dụ này thoát sớm với kết quả `22` nếu chúng nhận
được giá trị `NULL` cho `arg`. Thread cha nhặt mã kết quả này bằng
`thrd_join()`.

``` {.c .numberLines}
#include <stdio.h>
#include <threads.h>

thrd_t first_thread_id;

int run(void *arg)
{
    (void)arg;

    if (arg == NULL)
        thrd_exit(22);

    return 0;
}

#define THREAD_COUNT 5

int main(void)
{
    thrd_t t[THREAD_COUNT];

    for (int i = 0; i < THREAD_COUNT; i++)
        thrd_create(t + i, run, i == 2? NULL: "spatula");


    for (int i = 0; i < THREAD_COUNT; i++) {
        int res;
        thrd_join(t[i], &res);

        printf("Thread %d exited with code %d\n", i, res);
    }
}
```

Output:

``` {.default}
Thread 0 exited with code 0
Thread 1 exited with code 0
Thread 2 exited with code 22
Thread 3 exited with code 0
Thread 4 exited with code 0
```

### Xem thêm {.unnumbered .unlisted}

[`thrd_exit()`](#man-thrd_exit)

## `thrd_sleep()` {#man-thrd_sleep}

Ngủ trong một số giây và nano giây nhất định

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <threads.h>

int thrd_sleep(const struct timespec *duration, struct timespec *remaining);
```

### Mô tả {.unnumbered .unlisted}

Hàm này đưa thread hiện tại vào giấc ngủ (ngủ) một lúc^[Các hệ kiểu
Unix có syscall `sleep()` ngủ theo số giây nguyên. Nhưng `thrd_sleep()`
có lẽ portable hơn và thêm nữa còn cho độ phân giải dưới-giây!] cho
phép các thread khác chạy.

Thread đang gọi sẽ thức dậy sau khi hết thời gian, hoặc nếu nó bị
signal ngắt hoặc gì đó.

Nếu không bị ngắt, nó sẽ ngủ ít nhất là bằng chừng bạn yêu cầu. Có khi
lâu hơn chút. Bạn biết đấy, rời khỏi giường khó cỡ nào.

Cấu trúc nhìn như thế này:

``` {.c}
struct timespec {
    time_t tv_sec;   // Giây
    long   tv_nsec;  // Nano giây (phần tỷ của một giây)
};
```

Đừng đặt `tv_nsec` lớn hơn 999,999,999. Tôi không rõ chuyện gì sẽ
chính thức xảy ra nếu bạn làm vậy, nhưng trên máy tôi thì
`thrd_sleep()` trả về `-2` và thất bại.

### Giá trị trả về {.unnumbered .unlisted}

Trả về `0` khi hết thời gian, hoặc `-1` nếu bị signal ngắt. Hoặc bất
kỳ giá trị âm nào khác khi có lỗi khác. Kỳ lạ là spec cho phép "giá trị
âm khác cho lỗi khác" cũng là `-1`, nên chúc may mắn với chuyện đó.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <threads.h>

int main(void)
{
    // Ngủ 3.25 giây
    thrd_sleep(&(struct timespec){.tv_sec=3, .tv_nsec=250000000}, NULL);

    return 0;
}
```

### Xem thêm {.unnumbered .unlisted}

[`thrd_yield()`](#man-thrd_yield)

[[manbreak]]
## `thrd_yield()` {#man-thrd_yield}

[i[`thrd_yield()` function]i]

Dừng chạy để các thread khác có thể chạy

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <threads.h>

void thrd_yield(void);
```

### Mô tả {.unnumbered .unlisted}

Nếu bạn có một thread đang hốc hết CPU và bạn muốn cho các thread khác
thời gian chạy, bạn có thể gọi `thrd_yield()`. Nếu hệ thống thấy hợp
lý, nó sẽ đưa thread đang gọi vào giấc ngủ và một trong các thread
khác sẽ chạy thay.

Đây là cách hay để "lịch sự" với các thread khác trong chương trình
nếu bạn muốn khuyến khích chúng chạy thay.

### Giá trị trả về {.unnumbered .unlisted}

Không trả về gì cả!

### Ví dụ {.unnumbered .unlisted}

Ví dụ này hơi tệ vì OS dù sao cũng sẽ tự lên lịch lại các thread trên
output, nhưng nó thể hiện được ý chính.

Main thread cho các thread khác một cơ hội chạy sau mỗi khối công việc
ngu ngốc mà nó làm.

``` {.c .numberLines}
#include <stdio.h>
#include <threads.h>

int run(void *arg)
{
    int main_thread = arg != NULL;

    if (main_thread) {
        long int total = 0;

        for (int i = 0; i < 10; i++) {
            for (long int j = 0; j < 1000L; j++)
                total++;

            printf("Main thread yielding\n");
            thrd_yield();                       // <-- YIELD TẠI ĐÂY
        }
    } else
        printf("Other thread running!\n");

    return 0;
}

#define THREAD_COUNT 10

int main(void)
{
    thrd_t t[THREAD_COUNT];

    for (int i = 0; i < THREAD_COUNT; i++)
        thrd_create(t + i, run, i == 0? "main": NULL);

    for (int i = 0; i < THREAD_COUNT; i++)
        thrd_join(t[i], NULL);

    return 0;
}
```

Output sẽ khác giữa các lần chạy. Để ý rằng kể cả sau `thrd_yield()`,
các thread khác có thể vẫn chưa sẵn sàng chạy và main thread sẽ tiếp
tục.

``` {.default}
Main thread yielding
Main thread yielding
Main thread yielding
Other thread running!
Other thread running!
Other thread running!
Other thread running!
Main thread yielding
Other thread running!
Other thread running!
Main thread yielding
Main thread yielding
Main thread yielding
Other thread running!
Main thread yielding
Main thread yielding
Main thread yielding
Other thread running!
Other thread running!
```

### Xem thêm {.unnumbered .unlisted}

[`thrd_sleep()`](#man-thrd_sleep)

[[manbreak]]
## `tss_create()` {#man-tss_create}

[i[`tss_create()` function]i]

Tạo thread-specific storage mới

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <threads.h>

int tss_create(tss_t *key, tss_dtor_t dtor);
```

### Mô tả {.unnumbered .unlisted}

Hàm này giúp bạn khi cần lưu các giá trị khác nhau theo từng thread.

Một chỗ hay gặp là khi bạn có một biến ở phạm vi file được chia sẻ
giữa cả đống hàm và thường xuyên bị trả về. Cái đó không threadsafe.
Một cách refactor là thay nó bằng thread-specific storage để mỗi
thread có code riêng của mình và không giẫm chân lên nhau.

Để làm việc này, bạn truyền vào con trỏ tới một khoá `tss_t`---đây là
biến bạn sẽ dùng trong các lời gọi `tss_set()` và `tss_get()` sau đó
để đặt và lấy giá trị gắn với khoá này.

Phần thú vị là con trỏ destructor `dtor` kiểu `tss_dtor_t`. Nó thực ra
là con trỏ tới một hàm nhận tham số `void*` và trả về `void`, tức là

``` {.c}
void dtor(void *p) { ... }
```

Hàm này sẽ được gọi cho mỗi thread khi thread thoát bằng `thrd_exit()`
(hoặc return từ hàm run).

Gọi hàm này khi các destructor của thread khác đang chạy là hành vi
không xác định (unspecified behavior).

### Giá trị trả về {.unnumbered .unlisted}

Không trả về gì cả!

### Ví dụ {.unnumbered .unlisted}

Đây là ví dụ TSS chung chung. Để ý biến TSS được tạo ở gần đầu
`main()`.

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>
#include <threads.h>

tss_t str;

void some_function(void)
{
    // Lấy giá trị per-thread của chuỗi này
    char *tss_string = tss_get(str);

    // Và in nó ra
    printf("TSS string: %s\n", tss_string);
}

int run(void *arg)
{
    int serial = *(int*)arg;  // Lấy số thứ tự của thread này
    free(arg);

    // malloc() chỗ chứa dữ liệu cho thread này
    char *s = malloc(64);
    sprintf(s, "thread %d! :)", serial);  // Một chuỗi nho nhỏ vui tươi

    // Đặt biến TSS này trỏ tới chuỗi
    tss_set(str, s);

    // Gọi một hàm sẽ lấy biến
    some_function();

    return 0; // Tương đương thrd_exit(0); kích hoạt destructor
}

#define THREAD_COUNT 15

int main(void)
{
    thrd_t t[THREAD_COUNT];

    // Tạo biến TSS mới, hàm free() là destructor
    tss_create(&str, free);                  // <-- TẠO BIẾN TSS!

    for (int i = 0; i < THREAD_COUNT; i++) {
        int *n = malloc(sizeof *n);  // Chứa số thứ tự thread
        *n = i;
        thrd_create(t + i, run, n);
    }

    for (int i = 0; i < THREAD_COUNT; i++) {
        thrd_join(t[i], NULL);
    }

    // Và tất cả thread đã xong, nên giải phóng cái này
    tss_delete(str);
}
```

Output:

``` {.default}
TSS string: thread 0! :)
TSS string: thread 2! :)
TSS string: thread 1! :)
TSS string: thread 5! :)
TSS string: thread 3! :)
TSS string: thread 6! :)
TSS string: thread 4! :)
TSS string: thread 7! :)
TSS string: thread 8! :)
TSS string: thread 9! :)
TSS string: thread 10! :)
TSS string: thread 13! :)
TSS string: thread 12! :)
TSS string: thread 11! :)
TSS string: thread 14! :)
```

### Xem thêm {.unnumbered .unlisted}

[`tss_delete()`](#man-tss_delete),
[`tss_set()`](#man-tss_set),
[`tss_get()`](#man-tss_get),
[`thrd_exit()`](#man-thrd_exit)

[[manbreak]]
## `tss_delete()` {#man-tss_delete}

[i[`tss_delete()` function]i]

Dọn dẹp một biến thread-specific storage

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <threads.h>

void tss_delete(tss_t key);
```

### Mô tả {.unnumbered .unlisted}

Đây là cặp đối nghịch của `tss_create()`. Bạn tạo (khởi tạo) biến TSS
trước khi dùng, rồi khi tất cả thread cần dùng đã xong, bạn xoá
(huỷ/giải phóng) nó bằng hàm này.

Hàm này không gọi destructor nào cả! Mấy cái đó đều do `thrd_exit()`
gọi!

### Giá trị trả về {.unnumbered .unlisted}

Không trả về gì cả!

### Ví dụ {.unnumbered .unlisted}

Đây là ví dụ TSS chung chung. Để ý biến TSS được xoá ở gần cuối
`main()`.

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>
#include <threads.h>

tss_t str;

void some_function(void)
{
    // Lấy giá trị per-thread của chuỗi này
    char *tss_string = tss_get(str);

    // Và in nó ra
    printf("TSS string: %s\n", tss_string);
}

int run(void *arg)
{
    int serial = *(int*)arg;  // Lấy số thứ tự của thread này
    free(arg);

    // malloc() chỗ chứa dữ liệu cho thread này
    char *s = malloc(64);
    sprintf(s, "thread %d! :)", serial);  // Một chuỗi nho nhỏ vui tươi

    // Đặt biến TSS này trỏ tới chuỗi
    tss_set(str, s);

    // Gọi một hàm sẽ lấy biến
    some_function();

    return 0; // Tương đương thrd_exit(0); kích hoạt destructor
}

#define THREAD_COUNT 15

int main(void)
{
    thrd_t t[THREAD_COUNT];

    // Tạo biến TSS mới, hàm free() là destructor
    tss_create(&str, free);

    for (int i = 0; i < THREAD_COUNT; i++) {
        int *n = malloc(sizeof *n);  // Chứa số thứ tự thread
        *n = i;
        thrd_create(t + i, run, n);
    }

    for (int i = 0; i < THREAD_COUNT; i++) {
        thrd_join(t[i], NULL);
    }

    // Và tất cả thread đã xong, nên giải phóng cái này
    tss_delete(str);    // <-- XOÁ BIẾN TSS!
}
```

Output:

``` {.default}
TSS string: thread 0! :)
TSS string: thread 2! :)
TSS string: thread 1! :)
TSS string: thread 5! :)
TSS string: thread 3! :)
TSS string: thread 6! :)
TSS string: thread 4! :)
TSS string: thread 7! :)
TSS string: thread 8! :)
TSS string: thread 9! :)
TSS string: thread 10! :)
TSS string: thread 13! :)
TSS string: thread 12! :)
TSS string: thread 11! :)
TSS string: thread 14! :)
```

### Xem thêm {.unnumbered .unlisted}

[`tss_create()`](#man-tss_create),
[`tss_set()`](#man-tss_set),
[`tss_get()`](#man-tss_get),
[`thrd_exit()`](#man-thrd_exit)

[[manbreak]]
## `tss_get()` {#man-tss_get}

[i[`tss_get()` function]i]

Lấy dữ liệu thread-specific

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <threads.h>

void *tss_get(tss_t key);
```

### Mô tả {.unnumbered .unlisted}

Một khi bạn đã đặt một biến bằng `tss_set()`, bạn có thể lấy giá trị
qua `tss_get()`---chỉ cần truyền vào khoá là bạn nhận lại được con trỏ
tới giá trị.

Đừng gọi hàm này từ trong destructor.

### Giá trị trả về {.unnumbered .unlisted}

Trả về giá trị đã lưu cho `key` được cho, hoặc `NULL` nếu có trục
trặc.

### Ví dụ {.unnumbered .unlisted}

Đây là ví dụ TSS chung chung. Để ý biến TSS được lấy trong
`some_function()`, bên dưới.

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>
#include <threads.h>

tss_t str;

void some_function(void)
{
    // Lấy giá trị per-thread của chuỗi này
    char *tss_string = tss_get(str);    // <-- LẤY GIÁ TRỊ

    // Và in nó ra
    printf("TSS string: %s\n", tss_string);
}

int run(void *arg)
{
    int serial = *(int*)arg;  // Lấy số thứ tự của thread này
    free(arg);

    // malloc() chỗ chứa dữ liệu cho thread này
    char *s = malloc(64);
    sprintf(s, "thread %d! :)", serial);  // Một chuỗi nho nhỏ vui tươi

    // Đặt biến TSS này trỏ tới chuỗi
    tss_set(str, s);

    // Gọi một hàm sẽ lấy biến
    some_function();

    return 0; // Tương đương thrd_exit(0); kích hoạt destructor
}

#define THREAD_COUNT 15

int main(void)
{
    thrd_t t[THREAD_COUNT];

    // Tạo biến TSS mới, hàm free() là destructor
    tss_create(&str, free);

    for (int i = 0; i < THREAD_COUNT; i++) {
        int *n = malloc(sizeof *n);  // Chứa số thứ tự thread
        *n = i;
        thrd_create(t + i, run, n);
    }

    for (int i = 0; i < THREAD_COUNT; i++) {
        thrd_join(t[i], NULL);
    }

    // Và tất cả thread đã xong, nên giải phóng cái này
    tss_delete(str);
}
```

Output:

``` {.default}
TSS string: thread 0! :)
TSS string: thread 2! :)
TSS string: thread 1! :)
TSS string: thread 5! :)
TSS string: thread 3! :)
TSS string: thread 6! :)
TSS string: thread 4! :)
TSS string: thread 7! :)
TSS string: thread 8! :)
TSS string: thread 9! :)
TSS string: thread 10! :)
TSS string: thread 13! :)
TSS string: thread 12! :)
TSS string: thread 11! :)
TSS string: thread 14! :)
```

### Xem thêm {.unnumbered .unlisted}

[`tss_set()`](#man-tss_set)

[[manbreak]]
## `tss_set()` {#man-tss_set}

[i[`tss_set()` function]i]

Đặt dữ liệu thread-specific

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <threads.h>

int tss_set(tss_t key, void *val);
```

### Mô tả {.unnumbered .unlisted}

Một khi bạn đã thiết lập biến TSS bằng `tss_create()`, bạn có thể đặt
nó theo từng thread qua `tss_set()`.

`key` là định danh của dữ liệu này, còn `val` là con trỏ tới dữ liệu.

Destructor được chỉ định trong `tss_create()` sẽ được gọi cho giá trị
được đặt khi thread thoát.

Ngoài ra, nếu có destructor _và_ đã có giá trị sẵn cho khoá này rồi,
destructor sẽ không được gọi cho giá trị đã có. Thực tế, hàm này không
bao giờ khiến destructor được gọi. Nên bạn phải tự lo lấy---tốt nhất là
dọn dẹp giá trị cũ trước khi ghi đè bằng giá trị mới.

### Giá trị trả về {.unnumbered .unlisted}

Trả về `thrd_success` khi vui, và `thrd_error` khi không.

### Ví dụ {.unnumbered .unlisted}

Đây là ví dụ TSS chung chung. Để ý biến TSS được đặt trong `run()`,
bên dưới.

``` {.c .numberLines}
#include <stdio.h>
#include <stdlib.h>
#include <threads.h>

tss_t str;

void some_function(void)
{
    // Lấy giá trị per-thread của chuỗi này
    char *tss_string = tss_get(str);

    // Và in nó ra
    printf("TSS string: %s\n", tss_string);
}

int run(void *arg)
{
    int serial = *(int*)arg;  // Lấy số thứ tự của thread này
    free(arg);

    // malloc() chỗ chứa dữ liệu cho thread này
    char *s = malloc(64);
    sprintf(s, "thread %d! :)", serial);  // Một chuỗi nho nhỏ vui tươi

    // Đặt biến TSS này trỏ tới chuỗi
    tss_set(str, s);    // <-- ĐẶT BIẾN TSS

    // Gọi một hàm sẽ lấy biến
    some_function();

    return 0; // Tương đương thrd_exit(0); kích hoạt destructor
}

#define THREAD_COUNT 15

int main(void)
{
    thrd_t t[THREAD_COUNT];

    // Tạo biến TSS mới, hàm free() là destructor
    tss_create(&str, free);

    for (int i = 0; i < THREAD_COUNT; i++) {
        int *n = malloc(sizeof *n);  // Chứa số thứ tự thread
        *n = i;
        thrd_create(t + i, run, n);
    }

    for (int i = 0; i < THREAD_COUNT; i++) {
        thrd_join(t[i], NULL);
    }

    // Và tất cả thread đã xong, nên giải phóng cái này
    tss_delete(str);
}
```

Output:

``` {.default}
TSS string: thread 0! :)
TSS string: thread 2! :)
TSS string: thread 1! :)
TSS string: thread 5! :)
TSS string: thread 3! :)
TSS string: thread 6! :)
TSS string: thread 4! :)
TSS string: thread 7! :)
TSS string: thread 8! :)
TSS string: thread 9! :)
TSS string: thread 10! :)
TSS string: thread 13! :)
TSS string: thread 12! :)
TSS string: thread 11! :)
TSS string: thread 14! :)
```

### Xem thêm {.unnumbered .unlisted}

[`tss_get()`](#man-tss_get)

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
