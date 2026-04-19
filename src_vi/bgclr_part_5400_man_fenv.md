<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<fenv.h>` Exception và Môi trường Dấu chấm động {#fenv}

[i[`fenv.h` header file]i]

|Hàm|Mô tả|
|--------|----------------------|
|[`feclearexcept()`](#man-feclearexcept)|Xoá các exception dấu chấm động|
|[`fegetexceptflag()`](#man-fegetexceptflag)|Lưu các cờ exception dấu chấm động|
|[`fesetexceptflag()`](#man-fegetexceptflag)|Khôi phục các cờ exception dấu chấm động|
|[`feraiseexcept()`](#man-feraiseexcept)|Raise một exception dấu chấm động bằng phần mềm|
|[`fetestexcept()`](#man-fetestexcept)|Kiểm tra xem một exception đã xảy ra hay chưa|
|[`fegetround()`](#man-fegetround)|Lấy hướng làm tròn|
|[`fesetround()`](#man-fegetround)|Đặt hướng làm tròn|
|[`fegetenv()`](#man-fegetenv)|Lưu toàn bộ môi trường dấu chấm động|
|[`fesetenv()`](#man-fegetenv)|Khôi phục toàn bộ môi trường dấu chấm động|
|[`feholdexcept()`](#man-feholdexcept)|Lưu trạng thái dấu chấm động và bật chế độ non-stop|
|[`feupdateenv()`](#man-feupdateenv)|Khôi phục môi trường dấu chấm động và áp dụng các exception gần nhất|

## Kiểu và Macro

Có hai kiểu được định nghĩa trong header này:

[i[`fenv_t` type]i]
[i[`fexcept_t` type]i]

|Kiểu|Mô tả|
|--------|----------------------|
|`fenv_t`|Toàn bộ môi trường dấu chấm động|
|`fexcept_t`|Một tập exception dấu chấm động|

"Môi trường" có thể xem như trạng thái tại thời điểm hiện tại của hệ
thống xử lý dấu chấm động: gồm exception, làm tròn, v.v. Nó là kiểu
opaque, nên bạn không thể truy cập trực tiếp mà phải làm qua các hàm
đúng cách.

Nếu các hàm nói đến có tồn tại trên hệ của bạn (có thể không!), thì
bạn cũng sẽ có các macro sau được định nghĩa để biểu diễn các
exception khác nhau:

[i[`FE_DIVBYZERO` macro]i]
[i[`FE_INEXACT` macro]i]
[i[`FE_INVALID` macro]i]
[i[`FE_OVERFLOW` macro]i]
[i[`FE_UNDERFLOW` macro]i]
[i[`FE_ALL_EXCEPT` macro]i]

|Macro|Mô tả|
|--------|----------------------|
|`FE_DIVBYZERO`|Chia cho 0|
|`FE_INEXACT`|Kết quả không chính xác, bị làm tròn|
|`FE_INVALID`|Lỗi miền xác định|
|`FE_OVERFLOW`|Tràn trên|
|`FE_UNDERFLOW`|Tràn dưới|
|`FE_ALL_EXCEPT`|Tất cả ở trên gộp lại|

Ý tưởng là bạn có thể bitwise-OR chúng với nhau để biểu diễn nhiều
exception, ví dụ `FE_INVALID|FE_OVERFLOW`.

Các hàm bên dưới có tham số `excepts` sẽ nhận các giá trị này.

Xem [`<math.h>`](#math) để biết hàm nào raise exception nào và khi
nào.

## Pragma

Bình thường C được tự do tối ưu đủ thứ chuyện có thể khiến các cờ
không giống như bạn mong đợi. Vậy nên nếu bạn định dùng mớ này, nhớ
set pragma này:

[i[`FENV_ACCESS` pragma]i]

``` {.c}
#pragma STDC FENV_ACCESS ON
```

Nếu bạn làm vậy ở scope toàn cục, nó có hiệu lực cho đến khi bạn tắt
đi:

``` {.c}
#pragma STDC FENV_ACCESS OFF
```

Nếu bạn làm ở block scope, nó phải đứng trước mọi statement hoặc
declaration. Trong trường hợp đó, nó có hiệu lực cho đến khi block
kết thúc (hoặc đến khi bị tắt đi rõ ràng).

**Một cảnh báo**: pragma này không được hỗ trợ trên cả hai compiler
tôi đang có (gcc và clang) ở thời điểm viết, nên dù tôi có build mớ
code dưới đây, nó không được test kỹ lắm.

[[manbreak]]
## `feclearexcept()` {#man-feclearexcept}

[i[`feclearexcept()` function]i]

Xoá các exception dấu chấm động

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <fenv.h>

int feclearexcept(int excepts);
```

### Mô tả {.unnumbered .unlisted}

Nếu có exception dấu chấm động đã xảy ra, hàm này có thể xoá nó.

Set `excepts` thành danh sách exception nối bằng bitwise-OR cần xoá.

Truyền `0` thì không có tác dụng gì.

### Giá trị trả về {.unnumbered .unlisted}

Trả về `0` nếu thành công và khác 0 nếu thất bại.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>
#include <fenv.h>

int main(void)
{
    #pragma STDC FENV_ACCESS ON 

    double f = sqrt(-1);

    int r = feclearexcept(FE_INVALID);

    printf("%d %f\n", r, f);
}
```

### Xem thêm {.unnumbered .unlisted}

[`feraiseexcept()`](#man-feraiseexcept),
[`fetestexcept()`](#man-fetestexcept)

[[manbreak]]
## `fegetexceptflag()` `fesetexceptflag()` {#man-fegetexceptflag}

[i[`fegetexceptflag()` function]i]
[i[`fesetexceptflag()` function]i]

Lưu hoặc khôi phục các cờ exception dấu chấm động

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <fenv.h>

int fegetexceptflag(fexcept_t *flagp, int excepts);

int fesetexceptflag(fexcept_t *flagp, int excepts);
```

### Mô tả {.unnumbered .unlisted}

Dùng các hàm này để lưu hoặc khôi phục môi trường dấu chấm động hiện
tại trong một biến.

Set `excepts` thành tập exception bạn muốn lưu hoặc khôi phục trạng
thái. Set thành `FE_ALL_EXCEPT` sẽ lưu hoặc khôi phục toàn bộ trạng
thái.

Chú ý `fexcept_t` là kiểu opaque---bạn không biết bên trong nó có
gì.

`excepts` có thể set thành 0 để không có tác dụng gì.

### Giá trị trả về {.unnumbered .unlisted}

Trả về `0` nếu thành công hoặc nếu `excepts` là 0.

Trả về khác 0 nếu thất bại.

### Ví dụ {.unnumbered .unlisted}

Chương trình này lưu trạng thái (trước khi có lỗi nào xảy ra), rồi cố
ý gây lỗi miền xác định bằng cách thử tính $\sqrt{-1}$.

Sau đó, nó khôi phục trạng thái dấu chấm động về trước khi có lỗi, nhờ
đó xoá lỗi đi.

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>
#include <fenv.h>

int main(void)
{
    #pragma STDC FENV_ACCESS ON 

    fexcept_t flag;

    fegetexceptflag(&flag, FE_ALL_EXCEPT);  // Lưu trạng thái

    double f = sqrt(-1);                    // Tôi đoán cái này không chạy được
    printf("%f\n", f);                      // "nan"

    if (fetestexcept(FE_INVALID))
        printf("1: Domain error\n");        // Dòng này in!
    else
        printf("1: No domain error\n");

    fesetexceptflag(&flag, FE_ALL_EXCEPT);  // Khôi phục về trước khi có lỗi

    if (fetestexcept(FE_INVALID))
        printf("2: Domain error\n");
    else
        printf("2: No domain error\n");     // Dòng này in!
}
```

<!--
### See Also {.unnumbered .unlisted}

[`example()`](#man-example),
-->

[[manbreak]]
## `feraiseexcept()` {#man-feraiseexcept}

[i[`feraiseexcept()` function]i]

Raise một exception dấu chấm động bằng phần mềm

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <fenv.h>

int feraiseexcept(int excepts);
```

### Mô tả {.unnumbered .unlisted}

Cái này cố raise một exception dấu chấm động như thể nó đã xảy ra.

Bạn có thể chỉ định nhiều exception để raise.

Nếu `FE_UNDERFLOW` hoặc `FE_OVERFLOW` được raise, C _có thể_ raise
thêm `FE_INEXACT`.

Nếu `FE_UNDERFLOW` hoặc `FE_OVERFLOW` được raise cùng lúc với
`FE_INEXACT`, thì `FE_UNDERFLOW` hoặc `FE_OVERFLOW` sẽ được raise
_trước_ `FE_INEXACT` phía sau hậu trường.

Thứ tự các exception khác được raise thì không xác định.

### Giá trị trả về {.unnumbered .unlisted}

Trả về `0` nếu mọi exception đều được raise hoặc nếu `excepts` là `0`.

Trả về khác 0 trong trường hợp khác.

### Ví dụ {.unnumbered .unlisted}

Đoạn code này cố ý raise exception chia cho 0 rồi phát hiện nó.

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>
#include <fenv.h>

int main(void)
{
    #pragma STDC FENV_ACCESS ON 

    feraiseexcept(FE_DIVBYZERO);

    if (fetestexcept(FE_DIVBYZERO) == FE_DIVBYZERO)
        printf("Detected division by zero\n");  // Dòng này in!!
    else
        printf("This is fine.\n");
}
```

### Xem thêm {.unnumbered .unlisted}

[`feclearexcept()`](#man-feclearexcept),
[`fetestexcept()`](#man-fetestexcept)

[[manbreak]]
## `fetestexcept()` {#man-fetestexcept}

[i[`fetestexcept()` function]i]

Kiểm tra xem một exception đã xảy ra hay chưa

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <fenv.h>

int fetestexcept(int excepts);
```

### Mô tả {.unnumbered .unlisted}

Đặt các exception bạn muốn kiểm tra vào `excepts`, bitwise-OR chúng
lại với nhau.

### Giá trị trả về {.unnumbered .unlisted}

Trả về bitwise-OR của các exception đã được raise.

### Ví dụ {.unnumbered .unlisted}

Đoạn code này cố ý raise exception chia cho 0 rồi phát hiện nó.

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>
#include <fenv.h>

int main(void)
{
    #pragma STDC FENV_ACCESS ON 

    feraiseexcept(FE_DIVBYZERO);

    if (fetestexcept(FE_DIVBYZERO) == FE_DIVBYZERO)
        printf("Detected division by zero\n");  // Dòng này in!!
    else
        printf("This is fine.\n");
}
```

### Xem thêm {.unnumbered .unlisted}

[`feclearexcept()`](#man-feclearexcept),
[`feraiseexcept()`](#man-feraiseexcept)

[[manbreak]]
## `fegetround()` `fesetround()` {#man-fegetround}

[i[`fegetround()` function]i]
[i[`fesetround()` function]i]

Lấy hoặc đặt hướng làm tròn

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <fenv.h>

int fegetround(void);

int fesetround(int round);
```

### Mô tả {.unnumbered .unlisted}

Dùng mấy hàm này để lấy hoặc đặt hướng làm tròn được dùng bởi một
đống hàm toán.

Cơ bản là khi một hàm "làm tròn" một số, nó muốn biết làm tròn thế
nào. Mặc định, nó làm theo cách ta hay mong đợi: nếu phần phân số nhỏ
hơn 0.5, làm tròn xuống về phía 0, ngược lại làm tròn lên xa 0.

|Macro|Mô tả|
|--------|----------------------|
|`FE_TONEAREST`|Làm tròn về số nguyên gần nhất, mặc định|
|`FE_TOWARDZERO`|Luôn làm tròn về phía 0|
|`FE_DOWNWARD`|Làm tròn về số nguyên nhỏ hơn kế tiếp|
|`FE_UPWARD`|Làm tròn về số nguyên lớn hơn kế tiếp|

Một số hiện thực không hỗ trợ làm tròn. Nếu có, các macro trên sẽ
được định nghĩa.

Chú ý hàm `round()` luôn là "về-gần-nhất" và không quan tâm đến chế
độ làm tròn.

### Giá trị trả về {.unnumbered .unlisted}

`fegetround()` trả về hướng làm tròn hiện tại, hoặc giá trị âm nếu
lỗi.

`fesetround()` trả về 0 nếu thành công, khác 0 nếu thất bại.

### Ví dụ {.unnumbered .unlisted}

Ví dụ này làm tròn vài số 

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>
#include <fenv.h>

// Hàm phụ in ra chế độ làm tròn
const char *rounding_mode_str(int mode)
{
    switch (mode) {
        case FE_TONEAREST:  return "FE_TONEAREST";
        case FE_TOWARDZERO: return "FE_TOWARDZERO";
        case FE_DOWNWARD:   return "FE_DOWNWARD";
        case FE_UPWARD:     return "FE_UPWARD";
    }

    return "Unknown";
}

int main(void)
{
    #pragma STDC FENV_ACCESS ON 

    int rm;

    rm = fegetround();

    printf("%s\n", rounding_mode_str(rm));    // In chế độ hiện tại
    printf("%f %f\n", rint(2.1), rint(2.7));  // Thử làm tròn

    fesetround(FE_TOWARDZERO);                // Đổi chế độ

    rm = fegetround();

    printf("%s\n", rounding_mode_str(rm));    // In ra
    printf("%f %f\n", rint(2.1), rint(2.7));  // Thử lại xem!
}
```

Output:

``` {.default}
FE_TONEAREST
2.000000 3.000000
FE_TOWARDZERO
2.000000 2.000000
```

### Xem thêm {.unnumbered .unlisted}

[`nearbyint()`](#man-nearbyint),
[`nearbyintf()`](#man-nearbyint),
[`nearbyintl()`](#man-nearbyint),
[`rint()`](#man-rint),
[`rintf()`](#man-rint),
[`rintl()`](#man-rint),
[`lrint()`](#man-lrint),
[`lrintf()`](#man-lrint),
[`lrintl()`](#man-lrint),
[`llrint()`](#man-lrint),
[`llrintf()`](#man-lrint),
[`llrintl()`](#man-lrint)

[[manbreak]]
## `fegetenv()` `fesetenv()` {#man-fegetenv}

[i[`fegetenv()` function]i]
[i[`fesetenv()` function]i]

Lưu hoặc khôi phục toàn bộ môi trường dấu chấm động

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <fenv.h>

int fegetenv(fenv_t *envp);
int fesetenv(const fenv_t *envp);
```

### Mô tả {.unnumbered .unlisted}

Bạn có thể lưu môi trường (exception, hướng làm tròn, v.v.) bằng cách
gọi `fegetenv()` và khôi phục bằng `fesetenv()`.

Dùng cái này nếu bạn muốn khôi phục trạng thái sau khi gọi hàm, nghĩa
là giấu đi khỏi caller rằng có vài exception dấu chấm động hoặc thay
đổi đã xảy ra.

### Giá trị trả về {.unnumbered .unlisted}

`fegetenv()` và `fesetenv()` trả về `0` nếu thành công, khác 0 trong
trường hợp khác.

### Ví dụ {.unnumbered .unlisted}

Ví dụ này lưu môi trường, quậy với rounding và exception, rồi khôi
phục lại. Sau khi môi trường được khôi phục, ta thấy rounding đã về
mặc định và exception đã bị xoá.

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>
#include <fenv.h>

void show_status(void)
{
    printf("Rounding is FE_TOWARDZERO: %d\n",
           fegetround() == FE_TOWARDZERO);

    printf("FE_DIVBYZERO is set: %d\n",
           fetestexcept(FE_DIVBYZERO) != 0);
}

int main(void)
{
    #pragma STDC FENV_ACCESS ON 

    fenv_t env;

    fegetenv(&env);  // Lưu môi trường

    fesetround(FE_TOWARDZERO);    // Đổi rounding
    feraiseexcept(FE_DIVBYZERO);  // Raise exception

    show_status();

    fesetenv(&env);  // Khôi phục môi trường

    show_status();
}
```

Output:

``` {.default}
Rounding is FE_TOWARDZERO: 1
FE_DIVBYZERO is set: 1
Rounding is FE_TOWARDZERO: 0
FE_DIVBYZERO is set: 0
```

### Xem thêm {.unnumbered .unlisted}

[`feholdexcept()`](#man-feholdexcept),
[`feupdateenv()`](#man-feupdateenv)

[[manbreak]]
## `feholdexcept()` {#man-feholdexcept}

[i[`feholdexcept()` function]i]

Lưu trạng thái dấu chấm động và bật chế độ non-stop

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <fenv.h>

int feholdexcept(fenv_t *envp);
```

### Mô tả {.unnumbered .unlisted}

Cái này giống `fegetenv()` chỉ khác là nó cập nhật môi trường hiện
tại sang chế độ _non-stop_, tức là nó sẽ không dừng lại ở bất kỳ
exception nào.

Nó giữ nguyên trạng thái này cho đến khi bạn khôi phục trạng thái
bằng `fesetenv()` hoặc `feupdateenv()`.


### Giá trị trả về {.unnumbered .unlisted}

### Ví dụ {.unnumbered .unlisted}

Ví dụ này lưu môi trường và vào chế độ non-stop, quậy với rounding và
exception, rồi khôi phục lại. Sau khi khôi phục môi trường, ta thấy
rounding đã về mặc định và exception đã bị xoá. Ta cũng sẽ không còn
ở chế độ non-stop nữa.

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>
#include <fenv.h>

void show_status(void)
{
    printf("Rounding is FE_TOWARDZERO: %d\n",
           fegetround() == FE_TOWARDZERO);

    printf("FE_DIVBYZERO is set: %d\n",
           fetestexcept(FE_DIVBYZERO) != 0);
}

int main(void)
{
    #pragma STDC FENV_ACCESS ON 

    fenv_t env;

    // Lưu môi trường và không dừng lại khi gặp exception
    feholdexcept(&env);

    fesetround(FE_TOWARDZERO);    // Đổi rounding
    feraiseexcept(FE_DIVBYZERO);  // Raise exception

    show_status();

    fesetenv(&env);  // Khôi phục môi trường

    show_status();
}
```

### Xem thêm {.unnumbered .unlisted}

[`fegetenv()`](#man-fegetenv),
[`fesetenv()`](#man-fegetenv),
[`feupdateenv()`](#man-feupdateenv)

[[manbreak]]
## `feupdateenv()` {#man-feupdateenv}

[i[`feupdateenv()` function]i]

Khôi phục môi trường dấu chấm động và áp dụng các exception gần nhất

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <fenv.h>

int feupdateenv(const fenv_t *envp);
```

### Mô tả {.unnumbered .unlisted}

Cái này giống `fesetenv()` chỉ khác là nó chỉnh lại môi trường truyền
vào sao cho được cập nhật với các exception đã xảy ra trong lúc đó.

Ví dụ bạn có một hàm có thể raise exception, nhưng bạn muốn giấu
chúng đi khỏi caller. Một lựa chọn là:

1. Lưu môi trường bằng `fegetenv()` hoặc `feholdexcept()`.
2. Làm gì thì làm mà có thể raise exception.
3. Khôi phục môi trường bằng `fesetenv()`, qua đó giấu đi các
   exception đã xảy ra ở bước 2.

Nhưng cách đó giấu _toàn bộ_ exception. Lỡ bạn chỉ muốn giấu vài cái
thì sao? Bạn có thể dùng `feupdateenv()` như sau:

1. Lưu môi trường bằng `fegetenv()` hoặc `feholdexcept()`.
2. Làm gì thì làm mà có thể raise exception.
3. Gọi `feclearexcept()` để xoá các exception bạn muốn giấu khỏi
   caller.
4. Gọi `feupdateenv()` để khôi phục môi trường trước đó và cập nhật
   nó với các exception khác đã xảy ra.

Nên nó giống một cách khôi phục môi trường có năng lực hơn so với chỉ
đơn giản `fegetenv()`/`fesetenv()`.

### Giá trị trả về {.unnumbered .unlisted}

Trả về `0` nếu thành công, khác 0 trong trường hợp khác.

### Ví dụ {.unnumbered .unlisted}

Chương trình này lưu trạng thái, raise vài exception, rồi xoá một
trong các exception, rồi khôi phục và cập nhật trạng thái.

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>
#include <fenv.h>

void show_status(void)
{
    printf("FE_DIVBYZERO: %d\n", fetestexcept(FE_DIVBYZERO) != 0);
    printf("FE_INVALID  : %d\n", fetestexcept(FE_INVALID) != 0);
    printf("FE_OVERFLOW : %d\n\n", fetestexcept(FE_OVERFLOW) != 0);
}

int main(void)
{
    #pragma STDC FENV_ACCESS ON 

    fenv_t env;

    feholdexcept(&env);  // Lưu môi trường

    // Giả vờ có chút toán tệ xảy ra ở đây:
    feraiseexcept(FE_DIVBYZERO);  // Raise exception
    feraiseexcept(FE_INVALID);    // Raise exception
    feraiseexcept(FE_OVERFLOW);   // Raise exception

    show_status();

    feclearexcept(FE_INVALID);

    feupdateenv(&env);  // Khôi phục môi trường

    show_status();
}
```

Trong output, lúc đầu ta không có exception nào. Rồi ta có ba cái đã
raise. Sau đó khi khôi phục/cập nhật môi trường, ta thấy cái đã xoá
(`FE_INVALID`) không được áp dụng:

``` {.default}
FE_DIVBYZERO: 0
FE_INVALID  : 0
FE_OVERFLOW : 0

FE_DIVBYZERO: 1
FE_INVALID  : 1
FE_OVERFLOW : 1

FE_DIVBYZERO: 1
FE_INVALID  : 0
FE_OVERFLOW : 1
```

### Xem thêm {.unnumbered .unlisted}

[`fegetenv()`](#man-fegetenv),
[`fesetenv()`](#man-fegetenv),
[`feholdexcept()`](#man-feholdexcept),
[`feclearexcept()`](#man-feclearexcept)

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
