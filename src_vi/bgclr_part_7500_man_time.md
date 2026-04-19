<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<time.h>` Các hàm về ngày và giờ {#time}

[i[`time.h` header file]i]

|Hàm|Mô tả|
|--------|----------------------|
|[`clock()`](#man-clock)|Xem tiến trình này đã dùng bao nhiêu thời gian CPU|
|[`difftime()`](#man-difftime)|Tính chênh lệch giữa hai mốc thời gian|
|[`mktime()`](man-mktime)|Chuyển `struct tm` thành `time_t`|
|[`time()`](#man-time)|Lấy calendar time (thời gian lịch) hiện tại|
|[`timespec_get()`](#man-timespec_get)|Lấy thời gian có độ phân giải cao hơn, thường là ngay bây giờ|
|[`asctime()`](#man-asctime)|Trả về phiên bản dễ đọc cho người của `struct tm`|
|[`ctime()`](#man-ctime)|Trả về phiên bản dễ đọc cho người của `time_t`|
|[`gmtime()`](#man-gmtime)|Chuyển calendar time thành broken-down time (thời gian đã tách thành trường) theo UTC|
|[`localtime()`](#man-localtime)|Chuyển calendar time thành broken-down time theo giờ địa phương|
|[`strftime()`](#man-strftime)|In output ngày giờ có định dạng|


Khi nói đến thời gian trong C, có hai kiểu chính cần để ý:

* [i[`time_t` type]i] **`time_t`** chứa một _calendar time_ (thời gian
  lịch). Đây là một kiểu số có tiềm năng là opaque (không lộ bên
  trong), đại diện cho một thời điểm tuyệt đối và có thể chuyển đổi
  sang UTC^[Khi bạn nói GMT, trừ khi bạn đang nói cụ thể về múi giờ
  chứ không phải về thời điểm, có lẽ thứ bạn muốn nói là "UTC".] hoặc
  giờ địa phương.

* [i[`struct tm` type]i] **`struct tm`** chứa một _broken-down time_
  (thời gian đã tách thành trường). Nó có các thứ như ngày trong
  tuần, ngày trong tháng, giờ, phút, giây, v.v.

Trên các hệ thống POSIX và Windows, `time_t` là một số nguyên và đại
diện cho số giây đã trôi qua kể từ 1 tháng 1 năm 1970 lúc 00:00 UTC.

Một `struct tm` chứa các trường sau:

``` {.c}
struct tm {
    int tm_sec;    // số giây sau phút -- [0, 60]
    int tm_min;    // số phút sau giờ -- [0, 59]
    int tm_hour;   // số giờ kể từ nửa đêm -- [0, 23]
    int tm_mday;   // ngày trong tháng -- [1, 31]
    int tm_mon;    // số tháng kể từ tháng Một -- [0, 11]
    int tm_year;   // số năm kể từ 1900
    int tm_wday;   // số ngày kể từ Chủ Nhật -- [0, 6]
    int tm_yday;   // số ngày kể từ 1 tháng 1 -- [0, 365]
    int tm_isdst;  // cờ Daylight Saving Time
};
```

Bạn có thể chuyển qua lại giữa hai kiểu này bằng `mktime()`,
`gmtime()`, và `localtime()`.

Bạn có thể in thông tin thời gian ra chuỗi bằng `ctime()`, `asctime()`,
và `strftime()`.

## Cảnh báo về Thread Safety

`asctime()`, `ctime()`: Hai hàm này trả về con trỏ tới một vùng nhớ
`static`. Cả hai có thể trả về cùng một con trỏ. Nếu bạn cần
thread-safe (an toàn với thread), bạn sẽ cần một mutex bao quanh
chúng. Nếu bạn cần cả hai kết quả cùng lúc, `strcpy()` một trong hai
ra chỗ khác.

Mọi vấn đề với `asctime()` và `ctime()` có thể né được bằng cách dùng
hàm `strftime()` thay thế---nó linh hoạt và thread-safe hơn.

`localtime()`, `gmtime()`: Hai hàm này cũng trả về con trỏ tới một
vùng nhớ `static`. Cả hai có thể trả về cùng một con trỏ. Nếu bạn cần
thread-safe, bạn sẽ cần một mutex bao quanh chúng. Nếu bạn cần cả hai
kết quả cùng lúc, hãy sao chép `struct` sang một chỗ khác.

[[manbreak]]
## `clock()` {#man-clock}

[i[`clock()` function]i]

Xem tiến trình này đã dùng bao nhiêu thời gian CPU

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <time.h>

clock_t clock(void);
```

### Mô tả {.unnumbered .unlisted}

Bộ xử lý của bạn lúc này đang tung hứng rất nhiều thứ. Chỉ vì một
tiến trình đã sống được 20 phút không có nghĩa là nó đã dùng 20 phút
"thời gian CPU".

Phần lớn thời gian, tiến trình trung bình của bạn ngồi không (đang
ngủ), và cái đó không tính vào thời gian CPU đã dùng.

Hàm này trả về một kiểu opaque đại diện cho số "clock tick" (tick
đồng hồ)^[Spec thực ra không nói "clock tick", nhưng tôi... thì nói.]
mà tiến trình đã tiêu tốn để chạy.

Bạn có thể lấy ra số giây từ đó bằng cách chia cho macro
`CLOCKS_PER_SEC`. Đây là số nguyên, nên bạn sẽ phải ép một phần của
biểu thức sang kiểu số thực để có thời gian có phần lẻ.

Chú ý rằng đây không phải "wall clock time" (thời gian đồng hồ treo
tường) của chương trình. Nếu bạn muốn lấy cái đó thì dùng một cách
đại khái `time()` và `difftime()` (có thể chỉ cho độ phân giải 1
giây) hoặc `timespec_get()` (cũng có thể chỉ cho độ phân giải thấp,
nhưng ít ra nó _có thể_ xuống tới mức nano giây).

### Giá trị trả về {.unnumbered .unlisted}

Trả về lượng thời gian CPU mà tiến trình này đã dùng. Giá trị này trả
về dưới dạng có thể chia cho `CLOCKS_PER_SEC` để ra được thời gian
tính bằng giây.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <time.h>

// Fibonacci cố tình ngây thơ
long long int fib(long long int n) {
    if (n <= 1) return n;

    return fib(n-1) + fib(n-2);
}

int main(void)
{
    printf("The 42nd Fibonacci Number is %lld\n", fib(42));

    printf("CPU time: %f\n", clock() / (double)CLOCKS_PER_SEC);
}
```

Output trên máy của tôi:

``` {.default}
The 42nd Fibonacci Number is 267914296
CPU time: 1.863078
```

### Xem thêm {.unnumbered .unlisted}

[`time()`](#man-time),
[`difftime()`](#man-difftime),
[`timespec_get()`](#man-timespec_get)


[[manbreak]]
## `difftime()` {#man-difftime}

[i[`difftime()` function]i]

Tính chênh lệch giữa hai mốc thời gian

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <time.h>

double difftime(time_t time1, time_t time0);
```

### Mô tả {.unnumbered .unlisted}

Vì kiểu `time_t` về mặt kỹ thuật là opaque, bạn không thể cứ thế lấy
thẳng ra rồi trừ đi để có chênh lệch giữa hai cái^[Trừ khi bạn đang ở
trên một hệ thống POSIX nơi `time_t` chắc chắn là số nguyên, lúc đó
bạn có thể trừ. Nhưng bạn vẫn nên dùng `difftime()` để portable
(khả chuyển) tối đa.]. Hãy dùng hàm này để làm việc đó.

Không có gì đảm bảo về độ phân giải của chênh lệch này, nhưng chắc
tới mức giây.

### Giá trị trả về {.unnumbered .unlisted}

Trả về chênh lệch giữa hai `time_t` tính bằng giây.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <time.h>

int main(void)
{
    // 12 tháng 4, 1982 và lẻ
    struct tm time_a = { .tm_year=82, .tm_mon=3, .tm_mday=12,
        .tm_hour=4, .tm_min=00, .tm_sec=04, .tm_isdst=-1,
    };

    // 15 tháng 11, 2020 và lẻ
    struct tm time_b = { .tm_year=120, .tm_mon=10, .tm_mday=15,
        .tm_hour=16, .tm_min=27, .tm_sec=00, .tm_isdst=-1,
    };

    time_t cal_a = mktime(&time_a);
    time_t cal_b = mktime(&time_b);

    double diff = difftime(cal_b, cal_a);

    double years = diff / 60 / 60 / 24 / 365.2425;  // gần đủ rồi

    printf("%f seconds (%f years) between events\n", diff, years);
}
```

Output:

``` {.default}
1217996816.000000 seconds (38.596783 years) between events
```

### Xem thêm {.unnumbered .unlisted}

[`time()`](#man-time),
[`mktime()`](#man-mktime)


[[manbreak]]
## `mktime()` {#man-mktime}

[i[`mktime()` function]i]

Chuyển `struct tm` với giờ địa phương thành `time_t`

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <time.h>

time_t mktime(struct tm *timeptr);
```

### Mô tả {.unnumbered .unlisted}

Nếu bạn có ngày và giờ ở local (giờ địa phương) và muốn chuyển nó
sang `time_t` (để rồi `difftime()` nó hay làm gì đó), bạn có thể
chuyển đổi bằng hàm này.

Về cơ bản bạn điền vào các trường trong `struct tm` của mình theo
giờ địa phương, và `mktime()` sẽ chuyển chúng sang `time_t` UTC
tương ứng.

Vài lưu ý:

* Đừng bận tâm điền `tm_wday` hay `tm_yday`. `mktime()` sẽ điền
  chúng giúp bạn.

* Bạn có thể đặt `tm_isdst` thành `0` để báo rằng giờ của bạn không
  phải Daylight Saving Time (DST / giờ tiết kiệm ánh sáng), `1` để
  báo là có, và `-1` để `mktime()` tự điền theo sở thích của locale.

Nếu bạn không có compiler C23 và cần nhập input theo UTC, xem các
hàm không chuẩn
[fl[`timegm()`|https://man.archlinux.org/man/timegm.3.en]] cho các
hệ Unix-like và
[fl[`_mkgmtime()`|https://docs.microsoft.com/en-us/cpp/c-runtime-library/reference/mkgmtime-mkgmtime32-mkgmtime64?view=msvc-160]]
cho Windows.

### Giá trị trả về {.unnumbered .unlisted}

Trả về giờ địa phương trong `struct tm` dưới dạng `time_t` calendar
time.

Trả về `(time_t)(-1)` nếu có lỗi.

### Ví dụ {.unnumbered .unlisted}

Trong ví dụ sau, chúng ta để `mktime()` cho biết thời điểm đó có
phải DST hay không.

``` {.c .numberLines}
#include <stdio.h>
#include <time.h>

int main(void)
{
    struct tm broken_down_time = {
        .tm_year=82,   // số năm kể từ 1900
        .tm_mon=3,     // số tháng kể từ tháng Một -- [0, 11]
        .tm_mday=12,   // ngày trong tháng -- [1, 31]
        .tm_hour=4,    // số giờ kể từ nửa đêm -- [0, 23]
        .tm_min=00,    // số phút sau giờ -- [0, 59]
        .tm_sec=04,    // số giây sau phút -- [0, 60]
        .tm_isdst=-1,  // cờ Daylight Saving Time
    };

    time_t calendar_time = mktime(&broken_down_time);

    char *days[] = {"Sunday", "Monday", "Tuesday",
        "Wednesday", "Furzeday", "Friday", "Saturday"};

    // Cái này sẽ in ra những gì có trong broken_down_time
    printf("Local time : %s", asctime(localtime(&calendar_time)));
    printf("Is DST     : %d\n", broken_down_time.tm_isdst);
    printf("Day of week: %s\n\n", days[broken_down_time.tm_wday]);

    // Cái này sẽ in UTC cho giờ địa phương ở trên
    printf("UTC        : %s", asctime(gmtime(&calendar_time)));
}
```

Output (đối với tôi ở Pacific Time---UTC đi trước 8 tiếng):

``` {.default}
Local time : Mon Apr 12 04:00:04 1982
Is DST     : 0
Day of week: Monday

UTC        : Mon Apr 12 12:00:04 1982
```

### Xem thêm {.unnumbered .unlisted}

[`timegm()`](#man-timegm),
[`localtime()`](#man-localtime),
[`gmtime()`](#man-gmtime)


[[manbreak]]
## `timegm()` {#man-timegm}

[i[`timegm()` function]i]

Chuyển `struct tm` với giờ UTC thành `time_t`

### Synopsis {.unnumbered .unlisted}

Mới trong C23!

``` {.c}
#include <time.h>

time_t timegm(struct tm *timeptr);
```

### Mô tả {.unnumbered .unlisted}

Nếu bạn có ngày và giờ ở UTC và muốn chuyển nó sang `time_t` (để
rồi `difftime()` nó hay làm gì đó), bạn có thể chuyển đổi bằng hàm
này.

Về cơ bản bạn điền các trường trong `struct tm` của mình theo giờ
địa phương, và `mktime()` sẽ chuyển chúng sang `time_t` UTC tương
ứng.

Vài lưu ý:

* Đừng bận tâm điền `tm_wday` hay `tm_yday`. `mktime()` sẽ điền
  chúng giúp bạn.

* Spec không nói gì về cờ Daylight Saving `tm_isdst`, nhưng vì UTC
  miễn nhiễm với DST, tôi đoán là nó bị bỏ qua hoặc được đặt thành
  `0` giùm ta.

Nếu bạn không có compiler C23 và cần nhập input theo UTC, xem các
hàm không chuẩn
[fl[`timegm()`|https://man.archlinux.org/man/timegm.3.en]] cho các
hệ Unix-like và
[fl[`_mkgmtime()`|https://docs.microsoft.com/en-us/cpp/c-runtime-library/reference/mkgmtime-mkgmtime32-mkgmtime64?view=msvc-160]]
cho Windows.

### Giá trị trả về {.unnumbered .unlisted}

Trả về giờ UTC trong `struct tm` dưới dạng `time_t` calendar time.

Trả về `(time_t)(-1)` nếu có lỗi.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <time.h>

int main(void)
{
    struct tm broken_down_time = {
        .tm_year=82,   // số năm kể từ 1900
        .tm_mon=3,     // số tháng kể từ tháng Một -- [0, 11]
        .tm_mday=12,   // ngày trong tháng -- [1, 31]
        .tm_hour=4,    // số giờ kể từ nửa đêm -- [0, 23]
        .tm_min=00,    // số phút sau giờ -- [0, 59]
        .tm_sec=04,    // số giây sau phút -- [0, 60]
        .tm_isdst=-1,  // cờ Daylight Saving Time
    };

    time_t calendar_time = timegm(&broken_down_time);

    char *days[] = {"Sunday", "Monday", "Tuesday",
        "Wednesday", "Furzeday", "Friday", "Saturday"};

    // Cái này sẽ in ra những gì có trong broken_down_time
    printf("UTC        : %s", asctime(gmtime(&calendar_time)));
    printf("Day of week: %s\n\n", days[broken_down_time.tm_wday]);

    // Cái này sẽ in UTC cho giờ địa phương ở trên
    printf("Local time : %s", asctime(localtime(&calendar_time)));
}
```

### Xem thêm {.unnumbered .unlisted}

[`mktime()`](#man-mktime),
[`timegm()`](#man-timegm),
[`localtime()`](#man-localtime),
[`gmtime()`](#man-gmtime)


[[manbreak]]
## `time()` {#man-time}

[i[`time()` function]i]

Lấy calendar time hiện tại

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <time.h>

time_t time(time_t *timer);
```

### Mô tả {.unnumbered .unlisted}

Trả về calendar time ngay lúc này. Ý tôi là, bây giờ. Không, bây giờ!

Nếu `timer` không phải `NULL`, nó cũng sẽ được nạp thời gian hiện tại.

Giá trị này có thể chuyển thành `struct tm` bằng `localtime()` hoặc
`gmtime()`, hoặc in trực tiếp bằng `ctime()`.

### Giá trị trả về {.unnumbered .unlisted}

Trả về calendar time hiện tại. Cũng nạp `timer` với thời gian hiện
tại nếu nó không phải `NULL`.

Hoặc trả về `(time_t)(-1)` nếu không lấy được thời gian vì bạn đã
rơi khỏi dòng không-thời gian và/hoặc hệ thống không hỗ trợ thời
gian.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <time.h>

int main(void)
{
    time_t now = time(NULL);

    printf("The local time is %s", ctime(&now));
}
```

Ví dụ output:

``` {.default}
The local time is Mon Mar  1 18:45:14 2021
```

### Xem thêm {.unnumbered .unlisted}

[`localtime()`](#man-localtime),
[`gmtime()`](#man-gmtime),
[`ctime()`](#man-ctime)

[[manbreak]]
## `timespec_get()` {#man-timespec_get}

[i[`timespec_get()` function]i]

Lấy thời gian có độ phân giải cao hơn, thường là ngay bây giờ

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <time.h>

int timespec_get(struct timespec *ts, int base);
```

### Mô tả {.unnumbered .unlisted}

Hàm này nạp thời gian UTC hiện tại (trừ khi được chỉ định khác) vào
`struct timespec`, `ts`, bạn đưa vào.

Struct đó có hai trường:

``` {.c}
struct timespec {
    time_t tv_sec;   // Số nguyên giây
    long   tv_nsec;  // Nano giây, 0-999999999
}
```

Nano giây là một phần tỷ của giây. Bạn có thể chia cho 1000000000.0
để chuyển sang giây.

Tham số `base` theo spec chỉ có một giá trị được định nghĩa:
`TIME_UTC`. Vậy nên để đảm bảo tính khả chuyển thì đặt nó là cái
đó. Việc này sẽ nạp vào `ts` thời gian hiện tại tính bằng số giây kể
từ một [flw[Epoch|Unix_time]] (mốc thời gian) do hệ thống định
nghĩa, thường là 1 tháng 1 năm 1970 lúc 00:00 UTC.

Implementation (bản cài đặt) của bạn có thể định nghĩa các giá trị
khác cho `base`.

### Giá trị trả về {.unnumbered .unlisted}

Khi `base` là `TIME_UTC`, hàm nạp vào `ts` thời gian UTC hiện tại.

Khi thành công, trả về `base`, các giá trị hợp lệ của nó sẽ luôn
khác không. Khi có lỗi, trả về `0`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
struct timespec ts;

timespec_get(&ts, TIME_UTC);

printf("%ld s, %ld ns\n", ts.tv_sec, ts.tv_nsec);

double float_time = ts.tv_sec + ts.tv_nsec/1000000000.0;
printf("%f seconds since epoch\n", float_time);
```

Ví dụ output:

``` {.default}
1614654187 s, 825540756 ns
1614654187.825541 seconds since epoch
```

Đây là một hàm tiện ích để cộng giá trị vào một `struct timespec`,
có xử lý giá trị âm và tràn nano giây.

``` {.c}
#include <stdlib.h>

// Cộng delta giây và delta nano giây vào ts.
// Cho phép giá trị âm. Mỗi thành phần được cộng riêng rẽ.
//
// Trừ đi 1.5 giây khỏi giá trị hiện tại:
//
// timespec_add(&ts, -1, -500000000L);

struct timespec *timespec_add(struct timespec *ts, long dsec, long dnsec)
{
    long sec = (long)ts->tv_sec + dsec;
    long nsec = ts->tv_nsec + dnsec;

    ldiv_t qr = ldiv(nsec, 1000000000L);

    if (qr.rem < 0) {
        nsec = 1000000000L + qr.rem;
        sec += qr.quot - 1;
    } else {
        nsec = qr.rem;
        sec += qr.quot;
    }

    ts->tv_sec = sec;
    ts->tv_nsec = nsec;

    return ts;
}
```

Và đây là vài hàm để chuyển từ `long double` sang `struct timespec`
và ngược lại, phòng khi bạn thích suy nghĩ dưới dạng số thập phân.
Cách này có ít chữ số có nghĩa hơn so với dùng các giá trị số
nguyên.

``` {.c}
#include <math.h>

// Chuyển struct timespec thành long double
long double timespec_to_ld(struct timespec *ts)
{
    return ts->tv_sec + ts->tv_nsec / 1000000000.0;
}

// Chuyển long double thành struct timespec
struct timespec ld_to_timespec(long double t)
{
    long double f;
    struct timespec ts;
    ts.tv_nsec = modfl(t, &f) * 1000000000L;
    ts.tv_sec = f;

    return ts;
}
```

### Xem thêm {.unnumbered .unlisted}

[`time()`](#man-time),
[`mtx_timedlock()`](#man-mtx_timedlock),
[`cnd_timedwait()`](#man-cnd_timedwait)

[[manbreak]]
## `asctime()` {#man-asctime}

[i[`asctime()` function]i]

Trả về phiên bản dễ đọc cho người của `struct tm`

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <time.h>

char *asctime(const struct tm *timeptr)
```

### Mô tả {.unnumbered .unlisted}

Hàm này lấy thời gian trong `struct tm` và trả về một chuỗi chứa
ngày đó ở dạng:

``` {.default}
Sun Sep 16 01:03:52 1973
```

có kèm một newline ở cuối, khá là không hữu ích.
([`strftime()`](#man-strftime) sẽ cho bạn nhiều linh hoạt hơn.)

Nó y hệt `ctime()`, chỉ khác là nhận `struct tm` thay vì `time_t`.

**CẢNH BÁO**: Hàm này trả về con trỏ tới một vùng `static char*` mà
không phải thread-safe và có thể dùng chung với hàm `ctime()`. Nếu
bạn cần thread-safe, hãy dùng `strftime()` hoặc dùng một mutex bao
cả `ctime()` lẫn `asctime()`.

Hành vi là không xác định đối với:

* Năm nhỏ hơn 1000
* Năm lớn hơn 9999
* Bất cứ thành viên nào của `timeptr` nằm ngoài khoảng

### Giá trị trả về {.unnumbered .unlisted}

Trả về con trỏ tới chuỗi ngày dễ đọc cho người.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <time.h>

int main(void)
{
    time_t now = time(NULL);

    printf("Local: %s", asctime(localtime(&now)));
    printf("UTC  : %s", asctime(gmtime(&now)));
}
```

Ví dụ output:

``` {.default}
Local: Mon Mar  1 21:17:34 2021
UTC  : Tue Mar  2 05:17:34 2021
```

### Xem thêm {.unnumbered .unlisted}

[`ctime()`](#man-ctime),
[`localtime()`](#man-localtime),
[`gmtime()`](#man-gmtime)

[[manbreak]]
## `ctime()` {#man-ctime}

[i[`ctime()` function]i]

Trả về phiên bản dễ đọc cho người của `time_t`

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <time.h>

char *ctime(const time_t *timer);
```

### Mô tả {.unnumbered .unlisted}

Hàm này nhận thời gian trong một `time_t` và trả về một chuỗi chứa
giờ địa phương và ngày ở dạng:

``` {.default}
Sun Sep 16 01:03:52 1973
```

có kèm một newline ở cuối, khá là không hữu ích.
([`strftime()`](#man-strftime) sẽ cho bạn nhiều linh hoạt hơn.)

Nó y hệt `asctime()`, chỉ khác là nhận `time_t` thay vì `struct tm`.

**CẢNH BÁO**: Hàm này trả về con trỏ tới một vùng `static char*` mà
không phải thread-safe và có thể dùng chung với hàm `asctime()`. Nếu
bạn cần thread-safe, hãy dùng `strftime()` hoặc dùng một mutex bao
cả `ctime()` lẫn `asctime()`.

Hành vi là không xác định đối với:

* Năm nhỏ hơn 1000
* Năm lớn hơn 9999
* Bất cứ thành viên nào của `timeptr` nằm ngoài khoảng

### Giá trị trả về {.unnumbered .unlisted}

Một con trỏ tới chuỗi giờ địa phương và ngày dễ đọc cho người.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
time_t now = time(NULL);

printf("Local: %s", ctime(&now));
```

Ví dụ output:

``` {.default}
Local: Mon Mar  1 21:32:23 2021
```

### Xem thêm {.unnumbered .unlisted}

[`asctime()`](#man-asctime)

[[manbreak]]
## `gmtime()` {#man-gmtime}

[i[`gmtime()` function]i]

Chuyển calendar time thành broken-down time theo UTC

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <time.h>

struct tm *gmtime(const time_t *timer);
```

### Mô tả {.unnumbered .unlisted}

Nếu bạn có một `time_t`, bạn có thể cho nó chạy qua hàm này để nhận
về một `struct tm` đầy thông tin broken-down time theo UTC tương
ứng.

Nó y hệt `localtime()`, chỉ khác là làm theo UTC thay vì giờ địa
phương.

Khi đã có `struct tm` đó, bạn có thể đưa nó cho `strftime()` để in
ra.

**CẢNH BÁO**: Hàm này trả về con trỏ tới một vùng `static struct
tm*` mà không phải thread-safe và có thể dùng chung với hàm
`localtime()`. Nếu bạn cần thread-safe, hãy dùng một mutex bao cả
`gmtime()` lẫn `localtime()`.

### Giá trị trả về {.unnumbered .unlisted}

Trả về con trỏ tới broken-down time theo UTC, hoặc `NULL` nếu không
lấy được.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <time.h>

int main(void)
{
    time_t now = time(NULL);

    printf("UTC  : %s", asctime(gmtime(&now)));
    printf("Local: %s", asctime(localtime(&now)));
}
```

Ví dụ output:

``` {.default}
UTC  : Tue Mar  2 05:40:05 2021
Local: Mon Mar  1 21:40:05 2021
```

### Xem thêm {.unnumbered .unlisted}

[`localtime()`](#man-localtime),
[`asctime()`](#man-asctime),
[`strftime()`](#man-strftime)

[[manbreak]]
## `localtime()` {#man-localtime}

[i[`localtime()` function]i]

Chuyển calendar time thành broken-down time theo giờ địa phương

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <time.h>

struct tm *localtime(const time_t *timer);
```

### Mô tả {.unnumbered .unlisted}

Nếu bạn có một `time_t`, bạn có thể cho nó chạy qua hàm này để nhận
về một `struct tm` đầy thông tin broken-down time theo giờ địa
phương tương ứng.

Nó y hệt `gmtime()`, chỉ khác là làm theo giờ địa phương thay vì
UTC.

Khi đã có `struct tm` đó, bạn có thể đưa nó cho `strftime()` để in
ra.

**CẢNH BÁO**: Hàm này trả về con trỏ tới một vùng `static struct
tm*` mà không phải thread-safe và có thể dùng chung với hàm
`gmtime()`. Nếu bạn cần thread-safe, hãy dùng một mutex bao cả
`gmtime()` lẫn `localtime()`.

### Giá trị trả về {.unnumbered .unlisted}

Trả về con trỏ tới broken-down time theo giờ địa phương, hoặc `NULL`
nếu không lấy được.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <time.h>

int main(void)
{
    time_t now = time(NULL);

    printf("Local: %s", asctime(localtime(&now)));
    printf("UTC  : %s", asctime(gmtime(&now)));
}
```

Ví dụ output:

``` {.default}
Local: Mon Mar  1 21:40:05 2021
UTC  : Tue Mar  2 05:40:05 2021
```

### Xem thêm {.unnumbered .unlisted}

[`gmtime()`](#man-gmtime),
[`asctime()`](#man-asctime),
[`strftime()`](#man-strftime)

[[manbreak]]
## `strftime()` {#man-strftime}

[i[`strftime()` function]i]

In output ngày giờ có định dạng

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <time.h>

size_t strftime(char * restrict s, size_t maxsize,
                const char * restrict format,
                const struct tm * restrict timeptr);
```

### Mô tả {.unnumbered .unlisted}

Đây là [`sprintf()`](#man-printf) dành cho các hàm ngày giờ. Nó sẽ
nhận một `struct tm` và tạo ra một chuỗi ở gần như bất cứ dạng nào
bạn muốn, ví dụ:

``` {.default}
2021-03-01
Monday, March 1 at 9:54 PM
It's Monday!
```

Đây là phiên bản siêu linh hoạt của `asctime()`. Và còn thread-safe
nữa, vì nó không dựa vào một buffer static để giữ kết quả.

Về cơ bản thứ bạn làm là đưa cho nó một điểm đích `s`, và kích thước
tối đa tính bằng byte của nó trong `maxsize`. Ngoài ra, cung cấp một
chuỗi `format` tương tự như chuỗi format của `printf()`, nhưng với
các format specifier khác. Và cuối cùng là một `struct tm` chứa
thông tin broken-down time để dùng cho việc in.

Chuỗi `format` hoạt động như thế này, ví dụ:

``` {.c}
"It's %A, %B %d!"
```

Sẽ cho ra:

``` {.default}
It's Monday, March 1!
```

`%A` là tên đầy đủ của ngày-trong-tuần, `%B` là tên đầy đủ của
tháng, và `%d` là ngày trong tháng. `strftime()` thay thế đúng thứ
cần để tạo ra kết quả. Tuyệt vời!

Vậy thì có những format specifier nào? Mừng là bạn đã hỏi!

Tôi sẽ lười và chép nguyên cái bảng này từ spec.

|Specifier|Mô tả|
|----|-----------------------------------|
|`%a`|Tên viết tắt ngày-trong-tuần theo locale. [`tm_wday`]|
|`%A`|Tên đầy đủ ngày-trong-tuần theo locale. [`tm_wday`]|
|`%b`|Tên viết tắt của tháng theo locale. [`tm_mon`]|
|`%B`|Tên đầy đủ của tháng theo locale. [`tm_mon`]|
|`%c`|Cách biểu diễn ngày và giờ phù hợp theo locale.|
|`%C`|Năm chia cho 100 rồi cắt lấy số nguyên, dưới dạng số thập phân (00--99). [`tm_year`]|
|`%d`|Ngày trong tháng dưới dạng số thập phân (01--31). [`tm_mday`]|
|`%D`|Tương đương `"%m/%d/%y"`. [`tm_mon`, `tm_mday`, `tm_year`]|
|`%e`|Ngày trong tháng dưới dạng số thập phân (1--31); một chữ số đơn được đặt trước bởi một dấu cách. [`tm_mday`]|
|`%F`|Tương đương "%Y-%m-%d" (định dạng ngày ISO 8601). [`tm_year`, `tm_mon`, `tm_mday`]|
|`%g`|Hai chữ số cuối của năm dựa-trên-tuần (xem dưới) dưới dạng số thập phân (00--99). [`tm_year`, `tm_wday`, `tm_yday`]|
|`%G`|Năm dựa-trên-tuần (xem dưới) dưới dạng số thập phân (ví dụ 1997). [`tm_year`, `tm_wday`, `tm_yday`]|
|`%h`|Tương đương "%b". [`tm_mon`]|
|`%H`|Giờ (đồng hồ 24 giờ) dưới dạng số thập phân (00--23). [`tm_hour`]|
|`%I`|Giờ (đồng hồ 12 giờ) dưới dạng số thập phân (01--12). [`tm_hour`]|
|`%j`|Ngày trong năm dưới dạng số thập phân (001--366). [`tm_yday`]|
|`%m`|Tháng dưới dạng số thập phân (01--12).|
|`%M`|Phút dưới dạng số thập phân (00--59). [`tm_min`]|
|`%n`|Một ký tự new-line.|
|`%p`|Cái tương đương theo locale của ký hiệu AM/PM gắn với đồng hồ 12 giờ. [`tm_hour`]|
|`%r`|Giờ dạng 12 giờ theo locale. [`tm_hour`, `tm_min`, `tm_sec`]|
|`%R`|Tương đương `"%H:%M"`. [`tm_hour`, `tm_min`]|
|`%S`|Giây dưới dạng số thập phân (00--60). [`tm_sec`]|
|`%t`|Một ký tự tab ngang.|
|`%T`|Tương đương `"%H:%M:%S"` (định dạng giờ ISO 8601). [`tm_hour`, `tm_min`, `tm_sec`]|
|`%u`|Ngày trong tuần theo ISO 8601 dưới dạng số thập phân (1--7), với thứ Hai là 1. [`tm_wday`]|
|`%U`|Số tuần trong năm (Chủ Nhật đầu tiên là ngày đầu của tuần 1) dưới dạng số thập phân (00--53). [`tm_year`, `tm_wday`, `tm_yday`]|
|`%V`|Số tuần theo ISO 8601 (xem dưới) dưới dạng số thập phân (01--53). [`tm_year`, `tm_wday`, `tm_yday`]|
|`%w`|Ngày trong tuần dưới dạng số thập phân (0--6), với Chủ Nhật là 0.|
|`%W`|Số tuần trong năm (thứ Hai đầu tiên là ngày đầu của tuần 1) dưới dạng số thập phân (00--53). [`tm_year`, `tm_wday`, `tm_yday`]|
|`%x`|Cách biểu diễn ngày phù hợp theo locale.|
|`%X`|Cách biểu diễn giờ phù hợp theo locale.|
|`%y`|Hai chữ số cuối của năm dưới dạng số thập phân (00--99). [`tm_year`]|
|`%Y`|Năm dưới dạng số thập phân (ví dụ 1997). [`tm_year`]|
|`%z`|Độ lệch so với UTC ở định dạng ISO 8601 `"-0430"` (nghĩa là chậm hơn UTC 4 tiếng 30 phút, phía tây Greenwich), hoặc không có ký tự nào nếu không xác định được múi giờ. [`tm_isdst`]
|`%Z`|Tên hoặc viết tắt múi giờ theo locale, hoặc không có ký tự nào nếu không xác định được múi giờ. [`tm_isdst`]|
|`%%`|Một dấu % bình thường|

Phù. Đúng là tình yêu.

`%G`, `%g`, và `%v` hơi khác người ở chỗ chúng dùng thứ gọi là năm
dựa-trên-tuần ISO 8601. Tôi chưa từng nghe tới. Nhưng, lại chép từ
spec, các quy tắc là:

> `%g`, `%G`, và `%V` cho các giá trị theo năm dựa-trên-tuần ISO
> 8601. Trong hệ này, tuần bắt đầu vào thứ Hai và tuần 1 của năm là
> tuần bao gồm ngày 4 tháng 1, cũng là tuần bao gồm thứ Năm đầu tiên
> của năm, và cũng là tuần đầu tiên chứa ít nhất bốn ngày trong
> năm. Nếu thứ Hai đầu tiên của tháng Một là ngày 2, 3, hoặc 4, các
> ngày trước đó thuộc về tuần cuối cùng của năm trước; do đó, với
> thứ Bảy ngày 2 tháng 1 năm 1999, `%G` được thay bằng `1998` và
> `%V` được thay bằng `53`. Nếu ngày 29, 30, hoặc 31 tháng 12 là
> thứ Hai, ngày đó và các ngày tiếp theo là phần của tuần 1 của năm
> kế tiếp. Do đó, với thứ Ba ngày 30 tháng 12 năm 1997, `%G` được
> thay bằng `1998` và `%V` được thay bằng `01`.

Mỗi ngày học được điều mới! Nếu bạn muốn biết thêm, [flw[Wikipedia
có một trang về nó|ISO_week_date]].

Nếu bạn đang ở locale "C", các specifier sinh ra như sau (lại chép
từ spec):

|Specifier|Mô tả|
|----|-----------------------------------|
|`%a`|Ba ký tự đầu của `%A`.|
|`%A`|Một trong `Sunday`, `Monday`, ... , `Saturday`.|
|`%b`|Ba ký tự đầu của `%B`.|
|`%B`|Một trong `January`, `February`, ... , `December`.|
|`%c`|Tương đương `%a %b %e %T %Y`.|
|`%p`|Một trong `AM` hoặc `PM`.|
|`%r`|Tương đương `%I:%M:%S %p`.|
|`%x`|Tương đương `%m/%d/%y`.|
|`%X`|Tương đương `%T`.|
|`%Z`|Tuỳ implementation.|

Có thêm các biến thể của format specifier để báo rằng bạn muốn dùng
định dạng thay thế của locale. Chúng không tồn tại với tất cả các
locale. Đó là một trong các format specifier ở trên, với tiền tố
`E` hoặc `O`:

``` {.default}
%Ec %EC %Ex %EX %Ey %EY %Od %Oe %OH %OI
%Om %OM %OS %Ou %OU %OV %Ow %OW %Oy
```

Các tiền tố `E` và `O` bị bỏ qua ở locale "C".

### Giá trị trả về {.unnumbered .unlisted}

Trả về tổng số byte đã đặt vào chuỗi kết quả, không tính ký tự NUL
kết thúc.

Nếu kết quả không vừa trong chuỗi, trả về 0 và giá trị trong `s`
là không xác định.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <time.h>

int main(void)
{
    char s[128];
    time_t now = time(NULL);

    // %c: in ngày theo locale hiện tại
    strftime(s, sizeof s, "%c", localtime(&now));
    puts(s);   // Sun Feb 28 22:29:00 2021

    // %A: tên đầy đủ ngày-trong-tuần
    // %B: tên đầy đủ của tháng
    // %d: ngày trong tháng
    strftime(s, sizeof s, "%A, %B %d", localtime(&now));
    puts(s);   // Sunday, February 28

    // %I: giờ (đồng hồ 12 giờ)
    // %M: phút
    // %S: giây
    // %p: AM hoặc PM
    strftime(s, sizeof s, "It's %I:%M:%S %p", localtime(&now));
    puts(s);   // It's 10:29:00 PM

    // %F: ISO 8601 yyyy-mm-dd
    // %T: ISO 8601 hh:mm:ss
    // %z: độ lệch múi giờ ISO 8601
    strftime(s, sizeof s, "ISO 8601: %FT%T%z", localtime(&now));
    puts(s);   // ISO 8601: 2021-02-28T22:29:00-0800
}
```

### Xem thêm {.unnumbered .unlisted}

[`ctime()`](#man-ctime),
[`asctime()`](#man-asctime)

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
