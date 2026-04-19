<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<tgmath.h>` Hàm Toán Type-Generic {#tgmath}

[i[`tgmath.h` header file]i]

Đây là các macro type-generic wrap quanh các hàm toán trong
[`<math.h>`](#math) và [`<complex.h>`](#complex). Header này
include cả hai cái đó.

Nhưng nhìn bề mặt, bạn có thể nghĩ về chúng như khả năng dùng, ví
dụ, hàm `sqrt()` với bất kỳ kiểu nào mà không cần nghĩ xem nó là
`double` hay `long double` hay thậm chí `complex`.

Đây là các macro được định nghĩa---vài cái không có đối ứng trong
không gian thực hoặc phức. Type suffix được bỏ qua trong bảng ở
các cột Real và Complex. Không macro generic nào có type suffix.

[i[`acos()` function]i]
[i[`asin()` function]i]
[i[`atan()` function]i]
[i[`acosh()` function]i]
[i[`asinh()` function]i]
[i[`atanh()` function]i]
[i[`cos()` function]i]
[i[`sin()` function]i]
[i[`tan()` function]i]
[i[`cosh()` function]i]
[i[`sinh()` function]i]
[i[`tanh()` function]i]
[i[`exp()` function]i]
[i[`log()` function]i]
[i[`pow()` function]i]
[i[`sqrt()` function]i]
[i[`fabs()` function]i]
[i[`atan2()` function]i]
[i[`fdim()` function]i]
[i[`cbrt()` function]i]
[i[`floor()` function]i]
[i[`ceil()` function]i]
[i[`fma()` function]i]
[i[`copysign()` function]i]
[i[`fmax()` function]i]
[i[`erf()` function]i]
[i[`fmin()` function]i]
[i[`erfc()` function]i]
[i[`fmod()` function]i]
[i[`exp2()` function]i]
[i[`frexp()` function]i]
[i[`expm1()` function]i]
[i[`hypot()` function]i]
[i[`ilogb()` function]i]
[i[`ldexp()` function]i]
[i[`lgamma()` function]i]
[i[`llrint()` function]i]
[i[`llround()` function]i]
[i[`log10()` function]i]
[i[`log1p()` function]i]
[i[`log2()` function]i]
[i[`logb()` function]i]
[i[`lrint()` function]i]
[i[`lround()` function]i]
[i[`nearbyint()` function]i]
[i[`nextafter()` function]i]
[i[`nexttoward()` function]i]
[i[`remainder()` function]i]
[i[`remquo()` function]i]
[i[`rint()` function]i]
[i[`round()` function]i]
[i[`scalbn()` function]i]
[i[`scalbln()` function]i]
[i[`tgamma()` function]i]
[i[`trunc()` function]i]
[i[`carg()` function]i]
[i[`cimag()` function]i]
[i[`conj()` function]i]
[i[`cproj()` function]i]
[i[`creal()` function]i]

|Hàm Thực|Hàm Phức|Macro Generic|
|-|-|-|
|`acos`|`cacos`|`acos`|
|`asin`|`casin`|`asin`|
|`atan`|`catan`|`atan`|
|`acosh`|`cacosh`|`acosh`|
|`asinh`|`casinh`|`asinh`|
|`atanh`|`catanh`|`atanh`|
|`cos`|`ccos`|`cos`|
|`sin`|`csin`|`sin`|
|`tan`|`ctan`|`tan`|
|`cosh`|`ccosh`|`cosh`|
|`sinh`|`csinh`|`sinh`|
|`tanh`|`ctanh`|`tanh`|
|`exp`|`cexp`|`exp`|
|`log`|`clog`|`log`|
|`pow`|`cpow`|`pow`|
|`sqrt`|`csqrt`|`sqrt`|
|`fabs`|`cabs`|`fabs`|
|`atan2`|---|`atan2`|
|`fdim`|---|`fdim`|
|`cbrt`|---|`cbrt`|
|`floor`|---|`floor`|
|`ceil`|---|`ceil`|
|`fma`|---|`fma`|
|`copysign`|---|`copysign`|
|`fmax`|---|`fmax`|
|`erf`|---|`erf`|
|`fmin`|---|`fmin`|
|`erfc`|---|`erfc`|
|`fmod`|---|`fmod`|
|`exp2`|---|`exp2`|
|`frexp`|---|`frexp`|
|`expm1`|---|`expm1`|
|`hypot`|---|`hypot`|
|`ilogb`|---|`ilogb`|
|`ldexp`|---|`ldexp`|
|`lgamma`|---|`lgamma`|
|`llrint`|---|`llrint`|
|`llround`|---|`llround`|
|`log10`|---|`log10`|
|`log1p`|---|`log1p`|
|`log2`|---|`log2`|
|`logb`|---|`logb`|
|`lrint`|---|`lrint`|
|`lround`|---|`lround`|
|`nearbyint`|---|`nearbyint`|
|`nextafter`|---|`nextafter`|
|`nexttoward`|---|`nexttoward`|
|`remainder`|---|`remainder`|
|`remquo`|---|`remquo`|
|`rint`|---|`rint`|
|`round`|---|`round`|
|`scalbn`|---|`scalbn`|
|`scalbln`|---|`scalbln`|
|`tgamma`|---|`tgamma`|
|`trunc`|---|`trunc`|
|---|`carg`|`carg`|
|---|`cimag`|`cimag`|
|---|`conj`|`conj`|
|---|`cproj`|`cproj`|
|---|`creal`|`creal`|

## Ví dụ

Đây là ví dụ ta gọi hàm `sqrt()` type-generic trên nhiều kiểu khác
nhau.

``` {.c .numberLines}
#include <stdio.h>
#include <tgmath.h>

int main(void)
{
    double x = 12.8;
    long double y = 34.9;
    double complex z = 1 + 2 * I;

    double x_result;
    long double y_result;
    double complex z_result;

    // Ta gọi cùng hàm sqrt()--nó là type-generic!
    x_result = sqrt(x);
    y_result = sqrt(y);
    z_result = sqrt(z);

    printf("x_result: %f\n", x_result);
    printf("y_result: %Lf\n", y_result);
    printf("z_result: %f + %fi\n", creal(z_result), cimag(z_result));
}
```

Output:

``` {.default}
x_result: 3.577709
y_result: 5.907622
z_result: 1.272020 + 0.786151i
```
