<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<complex.h>` Chức năng Số phức {#complex}

[i[`complex.h` header file]i]

Các hàm số phức trong phần tham chiếu này đều có ba phiên bản: `double
complex`, `float complex`, và `long double complex`.

Biến thể `float` kết thúc bằng `f` còn biến thể `long double` kết thúc
bằng `l`, ví dụ với cosine của số phức:

``` {.c}
ccos()   double complex
ccosf()  float complex
ccosl()  long double complex
```

Bảng dưới chỉ liệt kê phiên bản `double complex` cho gọn.

|Hàm|Mô tả|
|--------|----------------------|
|[`cabs()`](#man-cabs)|Tính giá trị tuyệt đối của số phức|
|[`cacos()`](#man-cacos)|Tính arc-cosine phức|
|[`cacosh()`](#man-cacosh)|Tính arc hyperbolic cosine phức|
|[`carg()`](#man-carg)|Tính argument phức|
|[`casin()`](#man-casin)|Tính arc-sine phức|
|[`casinh()`](#man-casinh)|Tính arc hyperbolic sine phức|
|[`catan()`](#man-catan)|Tính arc-tangent phức|
|[`catanh()`](#man-catanh)|Tính arc hyperbolic tangent phức|
|[`ccos()`](#man-ccos)|Tính cosine phức|
|[`ccosh()`](#man-ccosh)|Tính hyperbolic cosine phức|
|[`cexp()`](#man-cexp)|Tính hàm mũ cơ số $e$ phức|
|[`cimag()`](#man-cimag)|Trả về phần ảo của một số phức|
|[`clog()`](#man-clog)|Tính logarithm phức|
|[`CMPLX()`](#man-CMPLX)|Dựng một giá trị phức từ kiểu thực và ảo|
|[`conj()`](#man-conj)|Tính liên hợp của một số phức|
|[`cproj()`](#man-cproj)|Tính phép chiếu của một số phức|
|[`creal()`](#man-creal)|Trả về phần thực của một số phức|
|[`csin()`](#man-csin)|Tính sine phức|
|[`csinh()`](#man-csinh)|Tính hyperbolic sine phức|
|[`csqrt()`](#man-csqrt)|Tính căn bậc hai phức|
|[`ctan()`](#man-ctan)|Tính tangent phức|
|[`ctanh()`](#man-ctanh)|Tính hyperbolic tangent phức|

Bạn có thể kiểm tra hỗ trợ số phức bằng cách xem macro
[i[`__STDC_NO_COMPLEX__`]i] `__STDC_NO_COMPLEX__`. Nếu nó được định
nghĩa, tức là số phức không có sẵn.

Có thể có hai loại số được định nghĩa: _complex_ và _imaginary_. Hiện
tôi không biết hệ thống nào hiện thực kiểu imaginary cả.

Các kiểu complex, tức một giá trị thực cộng với bội của $i$, là:

[i[`float complex` type]i]
[i[`double complex` type]i]
[i[`long double complex` type]i]

``` {.c}
float complex
double complex
long double complex
```

Các kiểu imaginary, tức chỉ chứa bội của $i$, là:

[i[`float imaginary` type]i]
[i[`double imaginary` type]i]
[i[`long double imaginary` type]i]

``` {.c}
float imaginary
double imaginary
long double imaginary
```


Giá trị toán học $i=\sqrt{-1}$ được biểu diễn bằng ký hiệu
[i[`_Complex_I` macro]i] `_Complex_I` hoặc [i[`_Imaginary_I`
macro]i]`_Imaginary_I`, nếu có.

<!-- __ hackishly turn off the italic syntax highlighting -->

Macro [i[`I` macro]i] `I` sẽ được ưu tiên đặt thành `_Imaginary_I`
(nếu có), hoặc là `_Complex_I` nếu không.

Bạn có thể viết literal ảo (nếu được hỗ trợ) theo cú pháp này:

``` {.c}
double imaginary x = 3.4 * I;
```

Bạn có thể viết literal phức bằng ký pháp phức thông thường:

``` {.c}
double complex x = 1.2 + 3.4 * I;
```

hoặc dựng chúng bằng macro `CMPLX()`:

``` {.c}
double complex x = CMPLX(1.2, 3.4);  // Giống 1.2 + 3.4 * I
```

Cách sau có lợi thế là xử lý đúng các trường hợp đặc biệt của số phức
(như những trường hợp dính vô cùng hoặc số không có dấu) như thể
`_Imaginary_I` đang có mặt, dù thực ra không có.

Mọi giá trị góc đều tính bằng radian.

Một số hàm có các điểm gián đoạn gọi là _branch cut_ (nhát cắt nhánh).
Thú thật tôi không phải dân toán nên không bàn nghiêm túc về chuyện
này được, nhưng nếu bạn đang ở đây thì tôi tin bạn biết mình đang làm
gì ở mảng này.

Nếu hệ của bạn có số không có dấu, bạn có thể biết mình đang ở phía
nào của nhát cắt dựa vào dấu. Còn nếu không có thì chịu. Spec viết
thêm:

> Những hiện thực không hỗ trợ số không có dấu [...] không thể phân
> biệt hai phía của nhát cắt nhánh. Các hiện thực này phải ánh xạ
> nhát cắt sao cho hàm liên tục khi tiếp cận nhát cắt đi quanh điểm
> đầu hữu hạn của nhát cắt theo chiều ngược kim đồng hồ. (Các nhát
> cắt nhánh cho những hàm ở đây đều chỉ có một điểm đầu hữu hạn.) Ví
> dụ, với hàm căn bậc hai, đi ngược kim đồng hồ quanh điểm đầu hữu
> hạn của nhát cắt dọc theo trục thực âm thì tiếp cận nhát cắt từ
> phía trên, vậy nên nhát cắt ánh xạ vào trục ảo dương.

Cuối cùng, có một pragma tên [i[`CX_LIMITED_RANGE` macro]i]
`CX_LIMITED_RANGE` có thể bật/tắt (mặc định là tắt). Bạn bật nó như
thế này:

``` {.c}
#pragma STDC CX_LIMITED_RANGE ON
```

Nó cho phép một số phép toán trung gian được tràn dưới, tràn trên,
hoặc xử lý lỏng tay với vô cùng, đại khái là đánh đổi lấy tốc độ. Nếu
bạn chắc chắn những lỗi kiểu đó không xảy ra với các số bạn đang dùng
VÀ bạn đang cố vắt kiệt tốc độ, bạn có thể bật macro này lên.

Spec cũng viết thêm:

> Mục đích của pragma là cho phép hiện thực dùng các công thức:
>
> $(x+iy)\times(u+iv) = (xu-yv)+i(yu+xv)$
>
> $(x+iy)/(u+iv) = [(xu+yv)+i(yu-xv)]/(u^2+v^2)$
>
> $|x+iy|=\sqrt{x^2+y^2}$
>
> khi lập trình viên xác định được là chúng an toàn.


[[manbreak]]
## `cacos()`, `cacosf()`, `cacosl()` {#man-cacos}

[i[`cacos()` function]i]
[i[`cacosf()` function]i]
[i[`cacosl()` function]i]

Tính arc-cosine phức

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <complex.h>

double complex cacos(double complex z);

float complex cacosf(float complex z);

long double complex cacosl(long double complex z);
```

### Mô tả {.unnumbered .unlisted}

Tính arc-cosine phức của một số phức.

Số phức `z` sẽ có phần ảo trong khoảng $[0,\pi]$, còn phần thực không
bị chặn.

Có các nhát cắt nhánh nằm ngoài khoảng $[-1,+1]$ trên trục thực.

### Giá trị trả về {.unnumbered .unlisted}

Trả về arc-cosine phức của `z`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <complex.h>

int main(void)
{
    double complex x = 8 + 1.5708 * I;

    double complex y = cacos(x);

    printf("Result: %f + %fi\n", creal(y), cimag(y));
}
```

Output:

``` {.default}
Result: 0.195321 + -2.788006i
```

### Xem thêm {.unnumbered .unlisted}

[`ccos()`](#man-ccos),
[`casin()`](#man-casin),
[`catan()`](#man-catan)

[[manbreak]]
## `casin()`, `casinf()`, `casinl()` {#man-casin}

[i[`casin()` function]i]
[i[`casinf()` function]i]
[i[`casinl()` function]i]

Tính arc-sine phức

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <complex.h>

double complex casin(double complex z);

float complex casinf(float complex z);

long double complex casinl(long double complex z);
```

### Mô tả {.unnumbered .unlisted}

Tính arc-sine phức của một số phức.

Số phức `z` sẽ có phần ảo trong khoảng $[-\pi/2,+\pi/2]$, còn phần
thực không bị chặn.

Có các nhát cắt nhánh nằm ngoài khoảng $[-1,+1]$ trên trục thực.

### Giá trị trả về {.unnumbered .unlisted}

Trả về arc-sine phức của `z`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <complex.h>

int main(void)
{
    double complex x = 8 + 1.5708 * I;

    double complex y = casin(x);

    printf("Result: %f + %fi\n", creal(y), cimag(y));
}
```

Output:

``` {.default}
Result: 1.375476 + 2.788006i
```

### Xem thêm {.unnumbered .unlisted}

[`csin()`](#man-csin),
[`cacos()`](#man-cacos),
[`catan()`](#man-catan)


[[manbreak]]
## `catan()`, `catanf()`, `catanl()` {#man-catan}

[i[`catan()` function]i]
[i[`catanf()` function]i]
[i[`catanl()` function]i]

Tính arc-tangent phức

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <complex.h>

double complex catan(double complex z);

float complex catanf(float complex z);

long double complex catanl(long double complex z);
```

### Mô tả {.unnumbered .unlisted}

Tính arc-tangent phức của một số phức.

Số phức `z` sẽ có phần thực trong khoảng $[-\pi/2,+\pi/2]$, còn phần
ảo không bị chặn.

Có các nhát cắt nhánh nằm ngoài khoảng $[-i,+i]$ trên trục ảo.

### Giá trị trả về {.unnumbered .unlisted}

Trả về arc-tangent phức của `z`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <complex.h>

int main(void)
{
    double wheat = 8;
    double sheep = 1.5708;

    double complex x = wheat + sheep * I;

    double complex y = catan(x);

    printf("Result: %f + %fi\n", creal(y), cimag(y));
}
```

Output:

``` {.default}
Result: 1.450947 + 0.023299i
```

### Xem thêm {.unnumbered .unlisted}

[`ctan()`](#man-ctan),
[`cacos()`](#man-cacos),
[`casin()`](#man-casin)

[[manbreak]]
## `ccos()`, `ccosf()`, `ccosl()` {#man-ccos}

[i[`ccos()` function]i]
[i[`ccosf()` function]i]
[i[`ccosl()` function]i]

Tính cosine phức

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <complex.h>

double complex ccos(double complex z);

float complex ccosf(float complex z);

long double complex ccosl(long double complex z);
```

### Mô tả {.unnumbered .unlisted}

Tính cosine phức của một số phức.

### Giá trị trả về {.unnumbered .unlisted}

Trả về cosine phức của `z`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <complex.h>

int main(void)
{
    double complex x = 8 + 1.5708 * I;

    double complex y = ccos(x);

    printf("Result: %f + %fi\n", creal(y), cimag(y));
}
```

Output:

``` {.default}
Result: -0.365087 + -2.276818i
```

### Xem thêm {.unnumbered .unlisted}

[`csin()`](#man-csin),
[`ctan()`](#man-ctan),
[`cacos()`](#man-cacos)

[[manbreak]]
## `csin()`, `csinf()`, `csinl()` {#man-csin}

[i[`csin()` function]i]
[i[`csinf()` function]i]
[i[`csinl()` function]i]

Tính sine phức

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <complex.h>

double complex csin(double complex z);

float complex csinf(float complex z);

long double complex csinl(long double complex z);
```

### Mô tả {.unnumbered .unlisted}

Tính sine phức của một số phức.

### Giá trị trả về {.unnumbered .unlisted}

Trả về sine phức của `z`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <complex.h>

int main(void)
{
    double complex x = 8 + 1.5708 * I;

    double complex y = csin(x);

    printf("Result: %f + %fi\n", creal(y), cimag(y));
}
```

Output:

``` {.default}
Result: 2.482485 + -0.334840i
```

### Xem thêm {.unnumbered .unlisted}

[`ccos()`](#man-ccos),
[`ctan()`](#man-ctan),
[`casin()`](#man-casin)


[[manbreak]]
## `ctan()`, `ctanf()`, `ctanl()` {#man-ctan}

[i[`ctan()` function]i]
[i[`ctanf()` function]i]
[i[`ctanl()` function]i]

Tính tangent phức

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <complex.h>

double complex ctan(double complex z);

float complex ctanf(float complex z);

long double complex ctanl(long double complex z);
```

### Mô tả {.unnumbered .unlisted}

Tính tangent phức của một số phức.

### Giá trị trả về {.unnumbered .unlisted}

Trả về tangent phức của `z`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <complex.h>

int main(void)
{
    double complex x = 8 + 1.5708 * I;

    double complex y = ctan(x);

    printf("Result: %f + %fi\n", creal(y), cimag(y));
}
```

Output:

``` {.default}
Result: -0.027073 + 1.085990i
```

### Xem thêm {.unnumbered .unlisted}

[`ccos()`](#man-ccos),
[`csin()`](#man-csin),
[`catan()`](#man-catan)


[[manbreak]]
## `cacosh()`, `cacoshf()`, `cacoshl()` {#man-cacosh}

[i[`cacosh()` function]i]
[i[`cacoshf()` function]i]
[i[`cacoshl()` function]i]

Tính arc hyperbolic cosine phức

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <complex.h>

double complex cacosh(double complex z);

float complex cacoshf(float complex z);

long double complex cacoshl(long double complex z);
```

### Mô tả {.unnumbered .unlisted}

Tính arc hyperbolic cosine phức của một số phức.

Có một nhát cắt nhánh tại các giá trị nhỏ hơn $1$ trên trục thực.

Giá trị trả về sẽ không âm trên trục số thực, và nằm trong khoảng
$[-i\pi,+i\pi]$ trên trục ảo.

### Giá trị trả về {.unnumbered .unlisted}

Trả về arc hyperbolic cosine phức của `z`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <complex.h>

int main(void)
{
    double complex x = 8 + 1.5708 * I;

    double complex y = cacosh(x);

    printf("Result: %f + %fi\n", creal(y), cimag(y));
}
```

Output:

``` {.default}
Result: 2.788006 + 0.195321i
```

### Xem thêm {.unnumbered .unlisted}

[`casinh()`](#man-casinh),
[`catanh()`](#man-catanh),
[`acosh()`](#man-acosh)

[[manbreak]]
## `casinh()`, `casinhf()`, `casinhl()` {#man-casinh}

[i[`casinh()` function]i]
[i[`casinhf()` function]i]
[i[`casinhl()` function]i]

Tính arc hyperbolic sine phức

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <complex.h>

double complex casinh(double complex z);

float complex casinhf(float complex z);

long double complex casinhl(long double complex z);
```

### Mô tả {.unnumbered .unlisted}

Tính arc hyperbolic sine phức của một số phức.

Có các nhát cắt nhánh nằm ngoài $[-i,+i]$ trên trục ảo.

Giá trị trả về không bị chặn trên trục số thực, và nằm trong khoảng
$[-i\pi/2,+i\pi/2]$ trên trục ảo.

### Giá trị trả về {.unnumbered .unlisted}

Trả về arc hyperbolic sine phức của `z`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <complex.h>

int main(void)
{
    double complex x = 8 + 1.5708 * I;

    double complex y = casinh(x);

    printf("Result: %f + %fi\n", creal(y), cimag(y));
}
```

Output:

``` {.default}
Result: 2.794970 + 0.192476i
```

### Xem thêm {.unnumbered .unlisted}

[`cacosh()`](#man-cacosh),
[`catanh()`](#man-catanh),
[`asinh()`](#man-asinh)

[[manbreak]]
## `catanh()`, `catanhf()`, `catanhl()` {#man-catanh}

[i[`catanh()` function]i]
[i[`catanhf()` function]i]
[i[`catanhl()` function]i]

Tính arc hyperbolic tangent phức

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <complex.h>

double complex catanh(double complex z);

float complex catanhf(float complex z);

long double complex catanhl(long double complex z);
```

### Mô tả {.unnumbered .unlisted}

Tính arc hyperbolic tangent phức của một số phức.

Có các nhát cắt nhánh nằm ngoài $[-1,+1]$ trên trục thực.

Giá trị trả về không bị chặn trên trục số thực, và nằm trong khoảng
$[-i\pi/2,+i\pi/2]$ trên trục ảo.

### Giá trị trả về {.unnumbered .unlisted}

Trả về arc hyperbolic tangent phức của `z`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <complex.h>

int main(void)
{
    double complex x = 8 + 1.5708 * I;

    double complex y = catanh(x);

    printf("Result: %f + %fi\n", creal(y), cimag(y));
}
```

Output:

``` {.default}
Result: 0.120877 + 1.546821i
```

### Xem thêm {.unnumbered .unlisted}

[`cacosh()`](#man-cacosh),
[`casinh()`](#man-casinh),
[`atanh()`](#man-atanh)

[[manbreak]]
## `ccosh()`, `ccoshf()`, `ccoshl()` {#man-ccosh}

[i[`ccosh()` function]i]
[i[`ccoshf()` function]i]
[i[`ccoshl()` function]i]

Tính hyperbolic cosine phức

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <complex.h>

double complex ccosh(double complex z);

float complex ccoshf(float complex z);

long double complex ccoshl(long double complex z);
```

### Mô tả {.unnumbered .unlisted}

Tính hyperbolic cosine phức của một số phức.

### Giá trị trả về {.unnumbered .unlisted}

Trả về hyperbolic cosine phức của `z`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <complex.h>

int main(void)
{
    double complex x = 8 + 1.5708 * I;

    double complex y = ccosh(x);

    printf("Result: %f + %fi\n", creal(y), cimag(y));
}
```

Output:

``` {.default}
Result: -0.005475 + 1490.478826i
```

### Xem thêm {.unnumbered .unlisted}

[`csinh()`](#man-csinh),
[`ctanh()`](#man-ctanh),
[`ccos()`](#man-ccos)

[[manbreak]]
## `csinh()`, `csinhf()`, `csinhl()` {#man-csinh}

[i[`csinh()` function]i]
[i[`csinhf()` function]i]
[i[`csinhl()` function]i]

Tính hyperbolic sine phức

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <complex.h>

double complex csinh(double complex z);

float complex csinhf(float complex z);

long double complex csinhl(long double complex z);
```

### Mô tả {.unnumbered .unlisted}

Tính hyperbolic sine phức của một số phức.

### Giá trị trả về {.unnumbered .unlisted}

Trả về hyperbolic sine phức của `z`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <complex.h>

int main(void)
{
    double complex x = 8 + 1.5708 * I;

    double complex y = csinh(x);

    printf("Result: %f + %fi\n", creal(y), cimag(y));
}
```

Output:

``` {.default}
Result: -0.005475 + 1490.479161i
```

### Xem thêm {.unnumbered .unlisted}

[`ccosh()`](#man-ccosh),
[`ctanh()`](#man-ctanh),
[`csin()`](#man-csin)


[[manbreak]]
## `ctanh()`, `ctanhf()`, `ctanhl()` {#man-ctanh}

[i[`ctanh()` function]i]
[i[`ctanhf()` function]i]
[i[`ctanhl()` function]i]

Tính hyperbolic tangent phức

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <complex.h>

double complex ctanh(double complex z);

float complex ctanhf(float complex z);

long double complex ctanhl(long double complex z);
```

### Mô tả {.unnumbered .unlisted}

Tính hyperbolic tangent phức của một số phức.

### Giá trị trả về {.unnumbered .unlisted}

Trả về hyperbolic tangent phức của `z`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <complex.h>

int main(void)
{
    double complex x = 8 + 1.5708 * I;

    double complex y = ctanh(x);

    printf("Result: %f + %fi\n", creal(y), cimag(y));
}
```

Output:

``` {.default}
Result: 1.000000 + -0.000000i
```

### Xem thêm {.unnumbered .unlisted}

[`ccosh()`](#man-ccosh),
[`csinh()`](#man-csinh),
[`ctan()`](#man-ctan)

[[manbreak]]
## `cexp()`, `cexpf()`, `cexpl()` {#man-cexp}

[i[`cexp()` function]i]
[i[`cexpf()` function]i]
[i[`cexpl()` function]i]

Tính hàm mũ cơ số $e$ phức

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <complex.h>

double complex cexp(double complex z);

float complex cexpf(float complex z);

long double complex cexpl(long double complex z);
```

### Mô tả {.unnumbered .unlisted}

Tính hàm mũ cơ số $e$ phức của `z`.

### Giá trị trả về {.unnumbered .unlisted}

Trả về hàm mũ cơ số $e$ phức của `z`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <complex.h>

int main(void)
{
    double complex x = 1 + 2 * I;

    double complex y = cexp(x);

    printf("Result: %f + %fi\n", creal(y), cimag(y));
}
```

Output:

``` {.default}
Result: -1.131204 + 2.471727i
```

### Xem thêm {.unnumbered .unlisted}

[`cpow()`](#man-cpow),
[`clog()`](#man-clog),
[`exp()`](#man-exp)

[[manbreak]]
## `clog()`, `clogf()`, `clogl()` {#man-clog}

[i[`clog()` function]i]
[i[`clogf()` function]i]
[i[`clogl()` function]i]

Tính logarithm phức

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <complex.h>

double complex clog(double complex z);

float complex clogf(float complex z);

long double complex clogl(long double complex z);
```

### Mô tả {.unnumbered .unlisted}

Tính logarithm cơ số $e$ phức của `z`. Có một nhát cắt nhánh trên
trục thực âm.

Giá trị trả về không bị chặn trên trục thực và nằm trong khoảng
$[-i\pi,+i\pi]$ trên trục ảo.

### Giá trị trả về {.unnumbered .unlisted}

Trả về logarithm cơ số $e$ phức của `z`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <complex.h>

int main(void)
{
    double complex x = 1 + 2 * I;

    double complex y = clog(x);

    printf("Result: %f + %fi\n", creal(y), cimag(y));
}
```

Output:

``` {.default}
Result: 0.804719 + 1.107149i
```

### Xem thêm {.unnumbered .unlisted}

[`cexp()`](#man-cexp),
[`log()`](#man-log)

[[manbreak]]
## `cabs()`, `cabsf()`, `cabsl()` {#man-cabs}

[i[`cabs()` function]i]
[i[`cabsf()` function]i]
[i[`cabsl()` function]i]

Tính giá trị tuyệt đối phức

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <complex.h>

double cabs(double complex z);

float cabsf(float complex z);

long double cabsl(long double complex z);
```

### Mô tả {.unnumbered .unlisted}

Tính giá trị tuyệt đối phức của `z`.

### Giá trị trả về {.unnumbered .unlisted}

Trả về giá trị tuyệt đối phức của `z`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <complex.h>

int main(void)
{
    double complex x = 1 + 2 * I;

    double complex y = cabs(x);

    printf("Result: %f + %fi\n", creal(y), cimag(y));
}
```

Output:

``` {.default}
Result: 2.236068 + 0.000000i
```

### Xem thêm {.unnumbered .unlisted}

[`fabs()`](#man-fabs),
[`abs()`](#man-abs)

[[manbreak]]
## `cpow()`, `cpowf()`, `cpowl()` {#man-cpow}

[i[`cpow()` function]i]
[i[`cpowf()` function]i]
[i[`cpowl()` function]i]

Tính luỹ thừa phức

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <complex.h>

double complex cpow(double complex x, double complex y);

float complex cpowf(float complex x, float complex y);

long double complex cpowl(long double complex x,
                          long double complex y);
```

### Mô tả {.unnumbered .unlisted}

Tính $x^y$ phức.

Có một nhát cắt nhánh cho `x` dọc theo trục thực âm.

### Giá trị trả về {.unnumbered .unlisted}

Trả về $x^y$ phức.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <complex.h>

int main(void)
{
    double complex x = 1 + 2 * I;
    double complex y = 3 + 4 * I;

    double r = cpow(x, y);

    printf("Result: %f + %fi\n", creal(r), cimag(r));
}
```

Result:

``` {.default}
Result: 0.129010 + 0.000000i
```

### Xem thêm {.unnumbered .unlisted}

[`csqrt()`](#man-csqrt),
[`cexp()`](#man-cexp)

[[manbreak]]
## `csqrt()`, `csqrtf()`, `csqrtl()` {#man-csqrt}

[i[`csqrt()` function]i]
[i[`csqrtf()` function]i]
[i[`csqrtl()` function]i]

Tính căn bậc hai phức

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <complex.h>

double complex csqrt(double complex z);

float complex csqrtf(float complex z);

long double complex csqrtl(long double complex z);
```

### Mô tả {.unnumbered .unlisted}

Tính căn bậc hai phức của `z`.

Có một nhát cắt nhánh dọc theo trục thực âm.

Giá trị trả về nằm ở nửa phải của mặt phẳng phức và bao gồm cả trục
ảo.

### Giá trị trả về {.unnumbered .unlisted}

Trả về căn bậc hai phức của `z`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <complex.h>

int main(void)
{
    double complex x = 1 + 2 * I;

    double complex y = csqrt(x);

    printf("Result: %f + %fi\n", creal(y), cimag(y));
}
```

Output:

``` {.default}
Result: 1.272020 + 0.786151i
```

### Xem thêm {.unnumbered .unlisted}

[`cpow()`](#man-cpow),
[`sqrt()`](#man-sqrt)

[[manbreak]]
## `carg()`, `cargf()`, `cargl()` {#man-carg}

[i[`carg()` function]i]
[i[`cargf()` function]i]
[i[`cargl()` function]i]

Tính argument phức

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <complex.h>

double carg(double complex z);

float cargf(float complex z);

long double cargl(long double complex z);
```

### Mô tả {.unnumbered .unlisted}

Tính argument phức (còn gọi là góc pha) của `z`.

Có một nhát cắt nhánh dọc theo trục thực âm.

Trả về giá trị trong khoảng $[-\pi,+\pi]$.

### Giá trị trả về {.unnumbered .unlisted}

Trả về argument phức của `z`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <complex.h>

int main(void)
{
    double complex x = 1 + 2 * I;

    double y = carg(x);

    printf("Result: %f\n", y);
}
```

Output:

``` {.default}
Result: 1.107149
```

<!--
### See Also {.unnumbered .unlisted}

[`example()`](#man-example),
-->

[[manbreak]]
## `cimag()`, `cimagf()`, `cimagl()` {#man-cimag}

[i[`cimag()` function]i]
[i[`cimagf()` function]i]
[i[`cimagl()` function]i]

Trả về phần ảo của một số phức

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <complex.h>

double cimag(double complex z);

float cimagf(float complex z);

long double cimagl(long double complex z);
```

### Mô tả {.unnumbered .unlisted}

Trả về phần ảo của `z`.

Nói ngoài lề, spec chỉ ra rằng bất kỳ số phức `x` nào cũng tuân theo
đẳng thức sau:

``` {.c}
x == creal(x) + cimag(x) * I;
```

### Giá trị trả về {.unnumbered .unlisted}

Trả về phần ảo của `z`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <complex.h>

int main(void)
{
    double complex x = 1 + 2 * I;

    double y = cimag(x);

    printf("Result: %f\n", y);
}
```

Output---chỉ phần ảo:

``` {.default}
Result: 2.000000
```

### Xem thêm {.unnumbered .unlisted}

[`creal()`](#man-creal)

[[manbreak]]
## `CMPLX()`, `CMPLXF()`, `CMPLXL()` {#man-CMPLX}

[i[`CMPLX()` macro]i]
[i[`CMPLXF()` macro]i]
[i[`CMPLXL()` macro]i]

Dựng một giá trị phức từ kiểu thực và ảo

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <complex.h>

double complex CMPLX(double x, double y);

float complex CMPLXF(float x, float y);

long double complex CMPLXL(long double x, long double y);
```

### Mô tả {.unnumbered .unlisted}

Các macro này dựng một giá trị phức từ các kiểu thực và ảo.

Chắc là bạn đang nghĩ, "Nhưng tôi đã có thể dựng giá trị phức từ kiểu
thực và ảo bằng macro `I` rồi mà, như trong ví dụ sắp tới."

``` {.c}
double complex x = 1 + 2 * I;
```

Và điều đó đúng.

Nhưng thực tế vấn đề lạ và phức.

Có thể `I` đã bị undefine, hoặc có thể bạn đã redefine nó.

Hoặc có thể `I` được định nghĩa là `_Complex_I`, thứ không nhất thiết
giữ được dấu của giá trị không.

Như spec chỉ ra, các macro này dựng số phức như thể `_Imaginary_I`
đang có mặt (nhờ đó giữ được dấu không của bạn) ngay cả khi nó không
có. Cụ thể, chúng được định nghĩa tương đương với:

``` {.c}
#define CMPLX(x, y)  ((double complex)((double)(x) + \
                     _Imaginary_I * (double)(y)))

#define CMPLXF(x, y) ((float complex)((float)(x) + \
                     _Imaginary_I * (float)(y)))

#define CMPLXL(x, y) ((long double complex)((long double)(x) + \
                     _Imaginary_I * (long double)(y)))
```

### Giá trị trả về {.unnumbered .unlisted}

Trả về số phức cho các phần thực `x` và ảo `y` đã cho.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <complex.h>

int main(void)
{
    double complex x = CMPLX(1, 2);  // Giống 1 + 2 * I

    printf("Result: %f + %fi\n", creal(x), cimag(x));
}
```

Output:

``` {.default}
Result: 1.000000 + 2.000000i
```

### Xem thêm {.unnumbered .unlisted}

[`creal()`](#man-creal),
[`cimag()`](#man-cimag)

[[manbreak]]
## `conj()`, `conjf()`, `conjl()` {#man-conj}

[i[`conj()` function]i]
[i[`conjf()` function]i]
[i[`conjl()` function]i]

Tính liên hợp của một số phức

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <complex.h>

double complex conj(double complex z);

float complex conjf(float complex z);

long double complex conjl(long double complex z);
```

### Mô tả {.unnumbered .unlisted}

Hàm này tính [flw[liên hợp phức|Complex_conjugate]] của `z`. Hình như
nó làm vậy bằng cách đảo dấu phần ảo, nhưng trời ạ, tôi là lập trình
viên chứ không phải dân toán, Jim ơi!

### Giá trị trả về {.unnumbered .unlisted}

Trả về liên hợp phức của `z`

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <complex.h>

int main(void)
{
    double complex x = 1 + 2 * I;

    double complex y = conj(x);

    printf("Result: %f + %fi\n", creal(y), cimag(y));
}
```

Output:

``` {.default}
Result: 1.000000 + -2.000000i
```

<!--
### See Also {.unnumbered .unlisted}

[`example()`](#man-example),
-->

[[manbreak]]
## `cproj()`, `cproj()`, `cproj()` {#man-cproj}

[i[`cproj()` function]i]
[i[`cprojf()` function]i]
[i[`cprojl()` function]i]

Tính phép chiếu của một số phức

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <complex.h>

double complex cproj(double complex z);

float complex cprojf(float complex z);

long double complex cprojl(long double complex z);
```

### Mô tả {.unnumbered .unlisted}

Tính phép chiếu của `z` lên một [flw[mặt cầu
Riemann|Riemann_sphere]].

Giờ thì _thực sự_ ngoài vùng chuyên môn của tôi rồi. Spec viết thế
này, tôi trích nguyên văn vì không đủ hiểu biết để viết lại cho gọn.
Mong là nó hiểu được với ai cần dùng hàm này.

> `z` chiếu thành `z` trừ khi mọi vô cùng phức (kể cả những vô cùng
> có một phần vô cùng và một phần `NaN`) đều chiếu thành vô cùng
> dương trên trục thực. Nếu `z` có phần vô cùng, thì `cproj(z)`
> tương đương với
>
>     INFINITY + I * copysign(0.0, cimag(z))

Đấy, có vậy thôi.

### Giá trị trả về {.unnumbered .unlisted}

Trả về phép chiếu của `z` lên một mặt cầu Riemann.

### Ví dụ {.unnumbered .unlisted}

Bắt chéo ngón tay cầu cho ví dụ này có tí hợp lý...

``` {.c .numberLines}
#include <stdio.h>
#include <complex.h>
#include <math.h>

int main(void)
{
    double complex x = 1 + 2 * I;

    double complex y = cproj(x);

    printf("Result: %f + %fi\n", creal(y), cimag(y));

    x = INFINITY + 2 * I;
    y = cproj(x);

    printf("Result: %f + %fi\n", creal(y), cimag(y));
}
```

Output:

``` {.default}
Result: 1.000000 + 2.000000i
Result: inf + 0.000000i
```

<!--
### See Also {.unnumbered .unlisted}

[`example()`](#man-example),
-->

[[manbreak]]
## `creal()`, `crealf()`, `creall()` {#man-creal}

[i[`creal()` function]i]
[i[`crealf()` function]i]
[i[`creall()` function]i]

Trả về phần thực của một số phức

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <complex.h>

double creal(double complex z);

float crealf(float complex z);

long double creall(long double complex z);
```

### Mô tả {.unnumbered .unlisted}

Trả về phần thực của `z`.

Nói ngoài lề, spec chỉ ra rằng bất kỳ số phức `x` nào cũng tuân theo
đẳng thức sau:

``` {.c}
x == creal(x) + cimag(x) * I;
```

### Giá trị trả về {.unnumbered .unlisted}

Trả về phần thực của `z`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <complex.h>

int main(void)
{
    double complex x = 1 + 2 * I;

    double y = creal(x);

    printf("Result: %f\n", y);
}
```

Output---chỉ phần thực:

``` {.default}
Result: 1.000000
```

### Xem thêm {.unnumbered .unlisted}

[`cimag()`](#man-cimag)

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
