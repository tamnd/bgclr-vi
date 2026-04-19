<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<math.h>` Toán Học {#math}

[i[`math.h` header file]i]

Nhiều hàm trong phần này có các phiên bản `float` và `long double` như
mô tả [ở dưới](#func-idioms) (ví dụ `pow()`, `powf()`, `powl()`). Các
biến thể `float` và `long double` được bỏ qua trong bảng dưới để mắt bạn
khỏi nổ tung.

|Hàm|Mô tả|
|--------|----------------------|
|[`acos()`](#man-acos)|Tính arc cosine của một số.|
|[`acosh()`](#man-acosh)|Tính arc hyperbolic cosine.|
|[`asin()`](#man-asin)|Tính arc sine của một số.|
|[`asinh()`](#man-asinh)|Tính arc hyperbolic sine.|
|[`atan()`](#man-atan), [`atan2()`](#man-atan)|Tính arc tangent của một số.|
|[`atanh()`](#man-atanh)|Tính arc hyperbolic tangent.|
|[`cbrt()`](#man-cbrt)|Tính căn bậc ba.|
|[`ceil()`](#man-ceil)|Ceiling---trả về số nguyên (phần nguyên hướng lên) không nhỏ hơn số đã cho.|
|[`copysign()`](#man-copysign)|Chép dấu của một giá trị sang một giá trị khác.|
|[`cos()`](#man-cos)|Tính cosine của một số.|
|[`cosh()`](#man-cosh)|Tính hyperbolic cosine.|
|[`erf()`](#man-erf)|Tính hàm lỗi (error function) của giá trị cho trước.|
|[`erfc()`](#man-erfc)|Tính hàm lỗi bù (complementary error function) của một giá trị.|
|[`exp()`](#man-exp)|Tính $e$ mũ lên.|
|[`exp2()`](#man-exp2)|Tính 2 mũ lên.|
|[`expm1()`](#man-expm1)|Tính $e^x-1$.|
|[`fabs()`](#man-fabs)|Tính giá trị tuyệt đối.|
|[`fdim()`](#man-fdim)|Trả về hiệu số dương giữa hai số, chặn dưới ở 0.|
|[`floor()`](#man-floor)|Tính số nguyên lớn nhất không lớn hơn giá trị cho trước.|
|[`fma()`](#man-fma)|Nhân và cộng Floating (còn gọi là "Fast").|
|[`fmax()`](#man-fmax), [`fmin()`](#man-fmax)|Trả về giá trị lớn nhất hoặc nhỏ nhất trong hai số.|
|[`fmod()`](#man-fmod)|Tính phần dư floating point.|
|[`fpclassify()`](#man-fpclassify)|Trả về phân loại của một số floating point cho trước.|
|[`frexp()`](#man-frexp)|Tách một số thành phần phân số và phần mũ (theo luỹ thừa của 2).|
|[`hypot()`](#man-hypot)|Tính độ dài cạnh huyền của tam giác.|
|[`ilogb()`](#man-ilogb)|Trả về số mũ của một số floating point.|
|[`isfinite()`](#man-isnan)|True nếu số không phải vô cùng hay NaN.|
|[`isgreater()`](#man-isgreater)|True nếu một đối số lớn hơn đối số khác.|
|[`isgreatereequal()`](#man-isgreater)|True nếu một đối số lớn hơn hoặc bằng đối số khác.|
|[`isinf()`](#man-isnan)|True nếu số là vô cùng.|
|[`isless()`](#man-isgreater)|True nếu một đối số nhỏ hơn đối số khác.|
|[`islesseequal()`](#man-isgreater)|True nếu một đối số nhỏ hơn hoặc bằng đối số khác.|
|[`islessgreater()`](#man-islessgreater)|Kiểm tra số floating point này nhỏ hơn hoặc lớn hơn số kia.|
|[`isnan()`](#man-isnan)|True nếu số là Not-a-Number.|
|[`isnormal()`](#man-isnan)|True nếu số là số "normal".|
|[`isunordered()`](#man-isunordered)|Macro trả về true nếu bất kỳ đối số floating point nào là NaN.|
|[`ldexp()`](#man-ldexp)|Nhân một số với luỹ thừa nguyên của 2.|
|[`lgamma()`](#man-lgamma)|Tính logarithm tự nhiên của giá trị tuyệt đối của $\Gamma(x)$.|
|[`log()`](#man-log)|Tính logarithm tự nhiên.|
|[`log10()`](#man-log10)|Tính log cơ số 10 của một số.|
|[`log2()`](#man-log2)|Tính logarithm cơ số 2 của một số.|
|[`logb()`](#man-logb)|Trích số mũ của một số theo cơ số `FLT_RADIX`.|
|[`log1p()`](#man-log1p)|Tính logarithm tự nhiên của một số cộng 1.|
|[`lrint()`](#man-lrint)|Trả về `x` được làm tròn theo hướng làm tròn hiện tại dưới dạng số nguyên.|
|[`lround()`](#man-lround), [`llround()`](#man-lround)|Làm tròn một số theo cách cổ điển, trả về số nguyên.|
|[`modf()`](#man-modf)|Tách phần nguyên và phần phân số của một số.|
|[`nan()`](#man-nan)|Trả về `NAN`.|
|[`nearbyint()`](#man-nearbyint)|Làm tròn giá trị theo hướng làm tròn hiện tại.|
|[`nextafter()`](#man-nextafter)|Lấy giá trị floating point kế tiếp (hoặc trước đó) biểu diễn được.|
|[`nexttoward()`](#man-nexttoward)|Lấy giá trị floating point kế tiếp (hoặc trước đó) biểu diễn được.|
|[`pow()`](#man-pow)|Tính một giá trị luỹ thừa.|
|[`remainder()`](#man-remainder)|Tính phần dư kiểu IEC 60559.|
|[`remquo()`](#man-remquo)|Tính phần dư và (một phần của) thương.|
|[`rint()`](#man-rint)|Làm tròn một giá trị theo hướng làm tròn hiện tại.|
|[`round()`](#man-round)|Làm tròn một số theo cách cổ điển.|
|[`scalbn()`](#man-scalb), [`scalbln()`](#man-scalb)|Tính $x\times r^n$ hiệu quả, với $r$ là `FLT_RADIX`.|
|[`signbit()`](#man-signbit)|Trả về dấu của một số.|
|[`sin()`](#man-sin)|Tính sine của một số.|
|[`sqrt()`](#man-sqrt)|Tính căn bậc hai của một số.|
|[`tan()`](#man-tan)|Tính tangent của một số.|
|[`tanh()`](#man-tanh)|Tính hyperbolic tangent.|
|[`tgamma()`](#man-tgamma)|Tính hàm gamma, $\Gamma(x)$.|
|[`trunc()`](#man-trunc)|Cắt phần phân số của một giá trị floating point.|


Môn học yêu thích của bạn đây: Toán học! Xin chào, tôi là Tiến sĩ Math,
và tôi sẽ làm cho toán trở nên VUI và DỄ!

_[tiếng ói mửa]_

Được rồi, tôi biết toán không phải thứ tuyệt vời nhất với một số bạn,
nhưng đây chỉ là những hàm làm toán nhanh gọn, thứ toán mà bạn hoặc biết,
hoặc cần, hoặc chẳng quan tâm. Tóm lại là vậy đó.

## Các idiom hàm Toán học {#func-idioms}

Nhiều hàm toán học này tồn tại ở ba dạng, tương ứng với kiểu đối số
và/hoặc kiểu trả về mà hàm sử dụng: `float`, `double`, hoặc `long
double`.

Dạng thay thế cho `float` được tạo bằng cách thêm `f` vào cuối tên hàm.

Dạng thay thế cho `long double` được tạo bằng cách thêm `l` vào cuối tên
hàm.

Ví dụ, hàm `pow()` dùng để tính $x^y$ tồn tại ở các dạng sau:

``` {.c}
double      pow(double x, double y);             // double
float       powf(float x, float y);              // float
long double powl(long double x, long double y);  // long double
```

Nhớ là tham số nhận giá trị như thể bạn gán vào chúng. Vậy nên nếu bạn
truyền một `double` vào `powf()`, nó sẽ chọn `float` gần nhất có thể để
giữ giá trị double đó. Nếu `double` không vừa, hành vi không xác định
(undefined behavior) sẽ xảy ra.

## Các kiểu Toán học

Chúng ta có hai kiểu mới rất hấp dẫn trong `<math.h>`:

* [i[`float_t` type]i] `float_t`
* [i[`double_t` type]i] `double_t`

Kiểu `float_t` ít nhất chính xác bằng `float`, và kiểu `double_t` ít
nhất chính xác bằng `double`.

Ý tưởng của các kiểu này là chúng có thể biểu diễn cách lưu trữ số hiệu
quả nhất để đạt tốc độ tối đa.

Kiểu thực tế thay đổi theo implementation, nhưng có thể xác định qua
giá trị của macro [i[`FLT_EVAL_METHOD` macro]i] `FLT_EVAL_METHOD`.

|`FLT_EVAL_METHOD`|Kiểu `float_t`|Kiểu `double_t`|
|-|-|-|
|`0`|`float`|`double`|
|`1`|`double`|`double`|
|`2`|`long double`|`long double`|
|Khác|Phụ thuộc implementation|Phụ thuộc implementation|

Với mọi giá trị xác định của `FLT_EVAL_METHOD`, `float_t` là kiểu có độ
chính xác thấp nhất được dùng cho mọi phép tính floating point.

## Các Macro Toán học

Thực ra có khá nhiều macro được định nghĩa, nhưng chúng ta sẽ nói hầu
hết chúng trong các phần tham chiếu tương ứng bên dưới.

Nhưng đây là vài cái:

[i[`NAN` macro]i]

`NAN` biểu diễn Not-A-Number.

Định nghĩa trong `<float.h>` là `FLT_RADIX`: cơ số mà floating point
dùng. Thường là `2`, nhưng có thể là bất kỳ giá trị nào.

## Các lỗi Toán học

Như ta biết, không gì có thể sai trong toán học... ngoại trừ _mọi thứ_!

Vậy nên có vài loại lỗi có thể xảy ra khi dùng các hàm này.

* **Range error (lỗi miền giá trị)** nghĩa là kết quả vượt quá những gì
  có thể lưu trong kiểu trả về.

* **Domain error (lỗi miền xác định)** nghĩa là bạn truyền vào một đối
  số không có kết quả xác định với hàm này.

* **Pole error** nghĩa là giới hạn của hàm khi $x$ tiến tới đối số cho
  trước là vô cùng.

* **Overflow error (lỗi tràn trên)** là khi kết quả rất lớn, nhưng không
  thể lưu mà không gây sai số làm tròn (rounding) lớn.

* **Underflow error (lỗi tràn dưới)** giống overflow, nhưng với các số
  rất nhỏ.

Giờ, thư viện toán của C có thể làm vài thứ khi các lỗi này xảy ra:

* Đặt `errno` thành một giá trị nào đó, hoặc...
* Raise một floating point exception.

Hệ thống của bạn có thể xử lý khác nhau. Bạn có thể kiểm tra bằng cách
xem giá trị của biến [i[`math_errhandling` variable]i]
`math_errhandling`. Nó sẽ bằng một trong những giá trị sau^[Dù hệ thống
định nghĩa `MATH_ERRNO` là `1` và `MATH_ERREXCEPT` là `2`, tốt nhất luôn
dùng tên ký hiệu. Phòng hờ.]:

[i[`MATH_ERRNO` macro]i]
[i[`MATH_ERREXCEPT` macro]i]

|`math_errhandling`|Mô tả|
|-|-|
|`MATH_ERRNO`|Hệ thống dùng `errno` cho các lỗi toán.|
|`MATH_ERREXCEPT`|Hệ thống dùng exception cho các lỗi toán.|
|`MATH_ERRNO | MATH_ERREXCEPT`|Hệ thống làm cả hai! (Đó là phép OR bit!)|

Bạn không được phép thay đổi `math_errhandling`.

Muốn mô tả đầy đủ hơn về cách exception hoạt động và ý nghĩa của chúng,
xem phần [`<fenv.h>`](#fenv).

## Các Pragma Toán học

Nói gọn, pragma cho phép ta điều khiển hành vi của trình biên dịch theo
nhiều cách. Ở đây, ta nói về chuyện điều khiển cách thư viện toán của C
hoạt động.

Cụ thể, chúng ta có pragma [i[`FP_CONTRACT` pragma]i] `FP_CONTRACT` có
thể bật/tắt.

Nó có nghĩa gì?

Trước tiên, nhớ rằng bất kỳ phép toán nào trong một biểu thức đều có
thể gây rounding error. Nên mỗi bước của biểu thức có thể tạo thêm
rounding error.

Nhưng sẽ thế nào nếu compiler biết một cách _siêu bí mật_ để lấy biểu
thức bạn viết và chuyển nó thành một lệnh duy nhất, giảm số bước đến
mức rounding error trung gian không xảy ra?

Nó có được dùng cách đó không? Ý là, kết quả sẽ khác so với khi bạn để
rounding error tích tụ qua từng bước...

Vì kết quả sẽ khác, bạn có thể bảo compiler rằng bạn có cho phép làm thế
hay không.

Nếu bạn cho phép:

``` {.c}
#pragma STDC FP_CONTRACT ON
```

và để không cho phép:

``` {.c}
#pragma STDC FP_CONTRACT OFF
```

Nếu bạn làm điều này ở phạm vi toàn cục, nó sẽ giữ trạng thái bạn đặt
cho đến khi bạn đổi nó.

Nếu bạn làm ở phạm vi block, nó sẽ quay về giá trị bên ngoài block khi
block kết thúc.

Giá trị ban đầu của pragma `FP_CONTRACT` thay đổi tuỳ hệ thống.


[[manbreak]]
## `fpclassify()` {#man-fpclassify}

[i[`fpclassify()` function]i]

Trả về phân loại của một số floating point cho trước.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

int fpclassify(any_floating_type x);
```

### Mô tả {.unnumbered .unlisted}

Số floating point này biểu diễn loại thực thể nào? Có những lựa chọn
nào?

Chúng ta quen thuộc với số floating point là những thứ bình thường như
`3.14` hay `3490.0001`.

Nhưng số floating point cũng có thể biểu diễn những thứ như vô cùng. Hay
Not-A-Number (NAN). Hàm này cho bạn biết đối số là loại floating point
nào.

Đây là một macro, nên bạn có thể dùng với `float`, `double`, `long
double`, hay bất kỳ kiểu tương tự nào.

### Giá trị trả về {.unnumbered .unlisted}

Trả về một trong các macro sau tuỳ theo phân loại của đối số:

|Phân loại|Mô tả|
|-|-|
|`FP_INFINITE`|Số là vô cùng.|
|`FP_NAN`|Số là Not-A-Number (NAN).|
|`FP_NORMAL`|Chỉ là một số bình thường.|
|`FP_SUBNORMAL`|Số là số sub-normal.|
|`FP_ZERO`|Số là không.|

Bàn về số subnormal nằm ngoài phạm vi guide này, và là thứ mà phần lớn
dev đi hết đời mà không phải đụng tới. Nói ngắn gọn, đó là cách biểu
diễn các số rất nhỏ mà bình thường sẽ bị làm tròn về không. Nếu muốn
biết thêm, xem trang Wikipedia về [flw[số denormal|Denormal_number]].

### Ví dụ {.unnumbered .unlisted}

In các phân loại số khác nhau.

```{.c .numberLines}
#include <stdio.h>
#include <math.h>

const char *get_classification(double n)
{
    switch (fpclassify(n)) {
        case FP_INFINITE: return "infinity";
        case FP_NAN: return "not a number";
        case FP_NORMAL: return "normal";
        case FP_SUBNORMAL: return "subnormal";
        case FP_ZERO: return "zero";
    }

    return "unknown";
}
 
int main(void)
{
    printf("    1.23: %s\n", get_classification(1.23));
    printf("     0.0: %s\n", get_classification(0.0));
    printf("sqrt(-1): %s\n", get_classification(sqrt(-1)));
    printf("1/tan(0): %s\n", get_classification(1/tan(0)));
    printf("  1e-310: %s\n", get_classification(1e-310));  // rất nhỏ!
}
```

Output^[Đây là trên máy tôi. Một số hệ thống sẽ có ngưỡng mà số trở
thành subnormal khác, hoặc có thể không hỗ trợ giá trị subnormal.]:

``` {.default}
    1.23: normal
     0.0: zero
sqrt(-1): not a number
1/tan(0): infinity
  1e-310: subnormal
```

### Xem thêm {.unnumbered .unlisted}
[`isfinite()`](#man-isnan),
[`isinf()`](#man-isnan),
[`isnan()`](#man-isnan),
[`isnormal()`](#man-isnan),
[`signbit()`](#man-signbit)

[[manbreak]]
## `isfinite()`, `isinf()`, `isnan()`, `isnormal()` {#man-isnan}

[i[`isfinite()` function]i]
[i[`isinf()` function]i]
[i[`isnan()` function]i]
[i[`isnormal()` function]i]

Trả về true nếu số khớp một phân loại.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

int isfinite(any_floating_type x);

int isinf(any_floating_type x);

int isnan(any_floating_type x);

int isnormal(any_floating_type x);
```

### Mô tả {.unnumbered .unlisted}

Đây là các macro trợ giúp cho `fpclassify()`. Vì là macro, chúng hoạt
động trên mọi kiểu floating point.

|Macro|Mô tả|
|-|-|
|`isfinite()`|True nếu số không phải vô cùng hoặc NaN.|
|`isinf()`|True nếu số là vô cùng.|
|`isnan()`|True nếu số là Not-a-Number.|
|`isnormal()`|True nếu số là normal.|

Để biết thêm thảo luận sơ lược về số normal và subnormal, xem
[`fpclassify()`](#man-fpclassify).

### Giá trị trả về {.unnumbered .unlisted}

Trả về khác không nếu true, và không nếu false.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
    printf("  isfinite(1.23): %d\n", isfinite(1.23));    // 1
    printf(" isinf(1/tan(0)): %d\n", isinf(1/tan(0)));   // 1
    printf(" isnan(sqrt(-1)): %d\n", isnan(sqrt(-1)));   // 1
    printf("isnormal(1e-310): %d\n", isnormal(1e-310));  // 0
}
```

### Xem thêm {.unnumbered .unlisted}

[`fpclassify()`](#man-fpclassify),
[`signbit()`](#man-signbit),


[[manbreak]]
## `signbit()` {#man-signbit}

[i[`signbit()` function]i]

Trả về dấu của một số.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

int signbit(any_floating_type x);
```

### Mô tả {.unnumbered .unlisted}

Macro này nhận vào một số floating point bất kỳ và trả về giá trị cho
biết dấu của số đó, dương hay âm.

### Giá trị trả về {.unnumbered .unlisted}

Trả về `1` nếu dấu là âm, ngược lại là `0`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	printf("%d\n", signbit(3490.0));  // 0
	printf("%d\n", signbit(-37.0));   // 1
}
```

### Xem thêm {.unnumbered .unlisted}

[`fpclassify()`](#man-fpclassify),
[`isfinite()`](#man-isnan),
[`isinf()`](#man-isnan),
[`isnan()`](#man-isnan),
[`isnormal()`](#man-isnan),
[`copysign()`](#man-copysign)


[[manbreak]]
## `acos()`, `acosf()`, `acosl()` {#man-acos}

[i[`acos()` function]i]
[i[`acosf()` function]i]
[i[`acosl()` function]i]

Tính arc cosine của một số.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double acos(double x);
float acosf(float x);
long double acosl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Tính arc cosine của một số theo radian. (Tức là giá trị mà cosine của
nó bằng `x`.) Số phải nằm trong khoảng -1.0 đến 1.0.

Với những bạn đã quên, radian là một cách đo góc khác, giống như độ.
Để chuyển đổi giữa độ và radian, dùng đoạn code sau:

``` {.c}
pi = 3.14159265358979;
degrees = radians * 180 / pi;
radians = degrees * pi / 180;
```

### Giá trị trả về {.unnumbered .unlisted}

Trả về arc cosine của `x`, trừ khi `x` ngoài khoảng. Trong trường hợp
đó, `errno` sẽ được đặt thành EDOM và giá trị trả về sẽ là NaN. Các
biến thể trả về kiểu khác nhau.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	double acosx;
	long double ldacosx;

	acosx = acos(0.2);
	ldacosx = acosl(0.3L);

	printf("%f\n", acosx);
	printf("%Lf\n", ldacosx);
}
```

### Xem thêm {.unnumbered .unlisted}

[`asin()`](#man-asin),
[`atan()`](#man-atan),
[`atan2()`](#man-atan),
[`cos()`](#man-cos)


[[manbreak]]
## `asin()`, `asinf()`, `asinl()` {#man-asin}

[i[`asin()` function]i]
[i[`asinf()` function]i]
[i[`asinl()` function]i]

Tính arc sine của một số.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double asin(double x);
float asinf(float x);
long double asinl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Tính arc sine của một số theo radian. (Tức là giá trị mà sine của nó
bằng `x`.) Số phải nằm trong khoảng -1.0 đến 1.0.

Với những bạn đã quên, radian là một cách đo góc khác, giống như độ.
Để chuyển đổi giữa độ và radian, dùng đoạn code sau:

``` {.c}
pi = 3.14159265358979;
degrees = radians * 180 / pi;
radians = degrees * pi / 180;
```

### Giá trị trả về {.unnumbered .unlisted}

Trả về arc sine của `x`, trừ khi `x` ngoài khoảng. Trong trường hợp đó,
`errno` sẽ được đặt thành EDOM và giá trị trả về sẽ là NaN. Các biến
thể trả về kiểu khác nhau.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	double asinx;
	long double ldasinx;

	asinx = asin(0.2);
	ldasinx = asinl(0.3L);

	printf("%f\n", asinx);
	printf("%Lf\n", ldasinx);
}
```

### Xem thêm {.unnumbered .unlisted}

[`acos()`](#man-acos),
[`atan()`](#man-atan),
[`atan2()`](#man-atan),
[`sin()`](#man-sin)


[[manbreak]]
## `atan()`, `atanf()`, `atanl()`, `atan2()`, `atan2f()`, `atan2l()` {#man-atan}

[i[`atan()` function]i]
[i[`atanf()` function]i]
[i[`atanl()` function]i]
[i[`atan2()` function]i]
[i[`atan2f()` function]i]
[i[`atan2l()` function]i]

Tính arc tangent của một số.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double atan(double x);
float atanf(float x);
long double atanl(long double x);

double atan2(double y, double x);
float atan2f(float y, float x);
long double atan2l(long double y, long double x);
```

### Mô tả {.unnumbered .unlisted}

Tính arc tangent của một số theo radian. (Tức là giá trị mà tangent
của nó bằng `x`.)

Các biến thể `atan2()` khá giống gọi `atan()` với tham số `y`/`x`...
ngoại trừ chuyện `atan2()` sẽ dùng các giá trị đó để xác định đúng góc
phần tư (quadrant) của kết quả.

Với những bạn đã quên, radian là một cách đo góc khác, giống như độ.
Để chuyển đổi giữa độ và radian, dùng đoạn code sau:

``` {.c}
pi = 3.14159265358979;
degrees = radians * 180 / pi;
radians = degrees * pi / 180;
```

### Giá trị trả về {.unnumbered .unlisted}

Các hàm `atan()` trả về arc tangent của `x`, nằm giữa PI/2 và -PI/2.
Các hàm `atan2()` trả về một góc giữa PI và -PI.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	double atanx;
	long double ldatanx;

	atanx = atan(0.7);
	ldatanx = atanl(0.3L);

	printf("%f\n", atanx);
	printf("%Lf\n", ldatanx);

	atanx = atan2(7, 10);
	ldatanx = atan2l(3L, 10L);

	printf("%f\n", atanx);
	printf("%Lf\n", ldatanx);
}
```

### Xem thêm {.unnumbered .unlisted}

[`tan()`](#man-tan),
[`asin()`](#man-asin),
[`atan()`](#man-acos)

[[manbreak]]
## `cos()`, `cosf()`, `cosl()` {#man-cos}

[i[`cos()` function]i]
[i[`cosf()` function]i]
[i[`cosl()` function]i]

Tính cosine của một số.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double cos(double x)
float cosf(float x)
long double cosl(long double x)
```

### Mô tả {.unnumbered .unlisted}

Tính cosine của giá trị `x`, với `x` tính bằng radian.

Với những bạn đã quên, radian là một cách đo góc khác, giống như độ.
Để chuyển đổi giữa độ và radian, dùng đoạn code sau:

``` {.c}
pi = 3.14159265358979;
degrees = radians * 180 / pi;
radians = degrees * pi / 180;
```

### Giá trị trả về {.unnumbered .unlisted}

Trả về cosine của `x`. Các biến thể trả về kiểu khác nhau.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	double cosx;
	long double ldcosx;

	cosx = cos(3490.0); // quay mòng mòng!
	ldcosx = cosl(3.490L);

	printf("%f\n", cosx);
	printf("%Lf\n", ldcosx);
}
```

### Xem thêm {.unnumbered .unlisted}

[`sin()`](#man-sin),
[`tan()`](#man-tan),
[`acos()`](#man-acos)

[[manbreak]]
## `sin()`, `sinf()`, `sinl()` {#man-sin}

[i[`sin()` function]i]
[i[`sinf()` function]i]
[i[`sinl()` function]i]

Tính sine của một số.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double sin(double x);
float sinf(float x);
long double sinl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Tính sine của giá trị `x`, với `x` tính bằng radian.

Với những bạn đã quên, radian là một cách đo góc khác, giống như độ.
Để chuyển đổi giữa độ và radian, dùng đoạn code sau:

``` {.c}
pi = 3.14159265358979;
degrees = radians * 180 / pi;
radians = degrees * pi / 180;
```

### Giá trị trả về {.unnumbered .unlisted}

Trả về sine của `x`. Các biến thể trả về kiểu khác nhau.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	double sinx;
	long double ldsinx;

	sinx = sin(3490.0); // quay mòng mòng!
	ldsinx = sinl(3.490L);

	printf("%f\n", sinx);
	printf("%Lf\n", ldsinx);
}
```

### Xem thêm {.unnumbered .unlisted}

[`cos()`](#man-cos),
[`tan()`](#man-tan),
[`asin()`](#man-asin)

[[manbreak]]
## `tan()`, `tanf()`, `tanl()` {#man-tan}

[i[`tan()` function]i]
[i[`tanf()` function]i]
[i[`tanl()` function]i]

Tính tangent của một số.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double tan(double x)
float tanf(float x)
long double tanl(long double x)
```

### Mô tả {.unnumbered .unlisted}

Tính tangent của giá trị `x`, với `x` tính bằng radian.

Với những bạn đã quên, radian là một cách đo góc khác, giống như độ.
Để chuyển đổi giữa độ và radian, dùng đoạn code sau:

``` {.c}
pi = 3.14159265358979;
degrees = radians * 180 / pi;
radians = degrees * pi / 180;
```

### Giá trị trả về {.unnumbered .unlisted}

Trả về tangent của `x`. Các biến thể trả về kiểu khác nhau.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	double tanx;
	long double ldtanx;

	tanx = tan(3490.0); // quay mòng mòng!
	ldtanx = tanl(3.490L);

	printf("%f\n", tanx);
	printf("%Lf\n", ldtanx);
}
```

### Xem thêm {.unnumbered .unlisted}

[`sin()`](#man-sin),
[`cos()`](#man-cos),
[`atan()`](#man-atan),
[`atan2()`](#man-atan)

[[manbreak]]
## `acosh()`, `acoshf()`, `acoshl()` {#man-acosh}

[i[`acosh()` function]i]
[i[`acoshf()` function]i]
[i[`acoshl()` function]i]

Tính arc hyperbolic cosine.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double acosh(double x);

float acoshf(float x);

long double acoshl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Fan trig mừng đi! C có arc hyperbolic cosine!

Các hàm này trả về acosh không âm của `x`, với `x` phải lớn hơn hoặc
bằng `1`.

### Giá trị trả về {.unnumbered .unlisted}

Trả về arc hyperbolic cosine trong khoảng $[0,+\infty]$.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	printf("acosh 1.8 = %f\n", acosh(1.8));  // 1.192911
}
```

### Xem thêm {.unnumbered .unlisted}

[`asinh()`](#man-asinh)

[[manbreak]]
## `asinh()`, `asinhf()`, `asinhl()` {#man-asinh}

[i[`asinh()` function]i]
[i[`asinhf()` function]i]
[i[`asinhl()` function]i]

Tính arc hyperbolic sine.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double asinh(double x);

float asinhf(float x);

long double asinhl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Fan trig mừng đi! C có arc hyperbolic sine!

Các hàm này trả về asinh của `x`.

### Giá trị trả về {.unnumbered .unlisted}

Trả về arc hyperbolic sine.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	printf("asinh 1.8 = %f\n", asinh(1.8));  // 1.350441
}
```

### Xem thêm {.unnumbered .unlisted}

[`acosh()`](#man-acosh)

[[manbreak]]
## `atanh()`, `atanhf()`, `atanhl()` {#man-atanh}

[i[`atanh()` function]i]
[i[`atanhf()` function]i]
[i[`atanhl()` function]i]

Tính arc hyperbolic tangent.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double atanh(double x);

float atanhf(float x);

long double atanhl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Các hàm này tính arc hyperbolic tangent của `x`, với `x` phải nằm trong
khoảng $[-1,+1]$. Truyền đúng $-1$ hoặc $+1$ có thể gây pole error.

### Giá trị trả về {.unnumbered .unlisted}

Trả về arc hyperbolic tangent của `x`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	printf("atanh 0.5 = %f\n", atanh(0.5));  // 0.549306
}
```

### Xem thêm {.unnumbered .unlisted}
[`acosh()`](#man-acosh),
[`asinh()`](#man-asinh)


[[manbreak]]
## `cosh()`, `coshf()`, `coshl()` {#man-cosh}

[i[`cosh()` function]i]
[i[`coshf()` function]i]
[i[`coshl()` function]i]

Tính hyperbolic cosine.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double cosh(double x);

float coshf(float x);

long double coshl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Như bạn đoán, các hàm này tính hyperbolic cosine của `x`. Range error
có thể xảy ra nếu `x` quá lớn.

### Giá trị trả về {.unnumbered .unlisted}

Trả về hyperbolic cosine của `x`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	printf("cosh 0.5 = %f\n", cosh(0.5));  // 1.127626
}
```

### Xem thêm {.unnumbered .unlisted}

[`sinh()`](#man-sinh),
[`tanh()`](#man-tanh)

[[manbreak]]
## `sinh()`, `sinhf()`, `sinhl()` {#man-sinh}

[i[`sinh()` function]i]
[i[`sinhf()` function]i]
[i[`sinhl()` function]i]

Tính hyperbolic sine.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double sinh(double x);

float sinhf(float x);

long double sinhl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Như bạn đoán, các hàm này tính hyperbolic sine của `x`. Range error có
thể xảy ra nếu `x` quá lớn.

### Giá trị trả về {.unnumbered .unlisted}

Trả về hyperbolic sine của `x`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	printf("sinh 0.5 = %f\n", sinh(0.5));  // 0.521095
}
```

### Xem thêm {.unnumbered .unlisted}

[`sinh()`](#man-cosh),
[`tanh()`](#man-tanh)

[[manbreak]]
## `tanh()`, `tanhf()`, `tanhl()` {#man-tanh}

[i[`tanh()` function]i]
[i[`tanhf()` function]i]
[i[`tanhl()` function]i]

Tính hyperbolic tangent.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double tanh(double x);

float tanhf(float x);

long double tanhl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Như bạn đoán, các hàm này tính hyperbolic tangent của `x`.

May thay, đây là trang man liên quan trig cuối cùng tôi sẽ viết.

### Giá trị trả về {.unnumbered .unlisted}

Trả về hyperbolic tangent của `x`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	printf("tanh 0.5 = %f\n", tanh(0.5));  // 0.462117
}
```

### Xem thêm {.unnumbered .unlisted}

[`cosh()`](#man-cosh),
[`sinh()`](#man-sinh)

[[manbreak]]
## `exp()`, `expf()`, `expl()` {#man-exp}

[i[`exp()` function]i]
[i[`expf()` function]i]
[i[`expl()` function]i]

Tính $e$ mũ lên.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double exp(double x);

float expf(float x);

long double expl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Tính $e^x$ với $e$ là [flw[hằng số Euler|E_(mathematical_constant)]].

Số $e$ được đặt theo tên Leonard Euler, sinh ngày 15/4/1707, ông là
người chịu trách nhiệm, ngoài những việc khác, cho việc làm trang tham
chiếu này dài hơn cần thiết.

### Giá trị trả về {.unnumbered .unlisted}

Trả về $e^x$.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
    printf("exp(1) = %f\n", exp(1));  // 2.718282
    printf("exp(2) = %f\n", exp(2));  // 7.389056
}
```

### Xem thêm {.unnumbered .unlisted}

[`exp2()`](#man-exp2),
[`expm1()`](#man-expm1),
[`pow()`](#man-pow),
[`log()`](#man-log)

[[manbreak]]
## `exp2()`, `exp2f()`, `exp2l()` {#man-exp2}

[i[`exp2()` function]i]
[i[`exp2f()` function]i]
[i[`exp2l()` function]i]

Tính 2 mũ lên.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double exp2(double x);

float exp2f(float x);

long double exp2l(long double x);
```

### Mô tả {.unnumbered .unlisted}

Các hàm này tính 2 mũ một số. Rất thú vị, vì máy tính chơi đùa toàn với
luỹ thừa của 2!

Các hàm này có thể nhanh hơn dùng `pow()` để làm cùng việc.

Chúng cũng hỗ trợ số mũ phân số.

Range error xảy ra nếu `x` quá lớn.

### Giá trị trả về {.unnumbered .unlisted}

`exp2()` trả về $2^x$.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
    printf("2^3 = %f\n", exp2(3));      // 2^3 = 8.000000
    printf("2^8 = %f\n", exp2(8));      // 2^8 = 256.000000
    printf("2^0.5 = %f\n", exp2(0.5));  // 2^0.5 = 1.414214    
}
```

### Xem thêm {.unnumbered .unlisted}
[`exp()`](#man-exp),
[`pow()`](#man-pow)


[[manbreak]]
## `expm1()`, `expm1f()`, `expm1l()` {#man-expm1}

[i[`expm1()` function]i]
[i[`expm1f()` function]i]
[i[`expm1l()` function]i]

Tính $e^x-1$.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double expm1(double x);

float expm1f(float x);

long double expm1l(long double x);
```

### Mô tả {.unnumbered .unlisted}

Cái này giống hệt `exp()` ngoại trừ---_twist bất ngờ!_---nó tính kết quả
đó trừ đi một.

Để thảo luận thêm về $e$ là gì, xem [trang man
`exp()`](#man-exp).

Nếu `x` khổng lồ, range error có thể xảy ra.

Với các giá trị `x` nhỏ gần không, `expm1(x)` có thể chính xác hơn
`exp(x)-1`.

### Giá trị trả về {.unnumbered .unlisted}

Trả về $e^x-1$.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
    printf("%f\n", expm1(2.34));  // 9.381237
}
```

### Xem thêm {.unnumbered .unlisted}

[`exp()`](#man-exp)


[[manbreak]]
## `frexp()`, `frexpf()`, `frexpl()` {#man-frexp}

[i[`frexp()` function]i]
[i[`frexpf()` function]i]
[i[`frexpl()` function]i]

Tách một số thành phần phân số và phần mũ (theo luỹ thừa của 2).

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double frexp(double value, int *exp);

float frexpf(float value, int *exp);

long double frexpl(long double value, int *exp);
```

### Mô tả {.unnumbered .unlisted}

Nếu có một số floating point, bạn có thể tách nó thành phần phân số và
phần mũ (theo luỹ thừa của 2).

Ví dụ, nếu có số $1234.56$, nó có thể biểu diễn dưới dạng bội của luỹ
thừa 2 như sau:

$1234.56=0.6028125\times2^{11}$

Và bạn có thể dùng hàm này để lấy phần $0.6028125$ và $11$ của phương
trình đó.

Còn vì sao, câu trả lời của tôi đơn giản thôi: tôi không biết. Tìm không
ra chỗ nào dùng. K&R2 và mọi nguồn tôi tìm được chỉ nói _cách_ dùng,
chứ không nói _vì sao_ bạn lại muốn dùng.

Tài liệu C99 Rationale viết:

> Các hàm `frexp`, `ldexp`, và `modf` là nguyên thuỷ được phần còn lại
> của thư viện sử dụng.
>
> Có ý kiến muốn bỏ chúng vì lý do tương tự như `ecvt`, `fcvt`, và
> `gcvt` bị bỏ, nhưng phe ủng hộ giữ chúng lại cho dùng chung. Việc
> dùng chúng có vấn đề: trên kiến trúc không nhị phân, ldexp có thể mất
> độ chính xác và frexp có thể không hiệu quả.

Vậy đó. Nếu bạn cần dùng.

### Giá trị trả về {.unnumbered .unlisted}

`frexp()` trả về phần phân số của `value` trong khoảng 0.5 (bao gồm)
đến 1 (không bao gồm), hoặc 0. Và nó lưu số mũ luỹ thừa 2 vào biến mà
`exp` trỏ tới.

Nếu bạn truyền vào không, cả giá trị trả về lẫn biến `exp` trỏ tới đều
là không.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
    double frac;
    int expt;

    frac = frexp(1234.56, &expt);
    printf("1234.56 = %.7f x 2^%d\n", frac, expt);  
}
```

Output:

``` {.default}
1234.56 = 0.6028125 x 2^11
```

### Xem thêm {.unnumbered .unlisted}

[`ldexp()`](#man-ldexp),
[`ilogb()`](#man-ldexp),
[`modf()`](#man-modf)


[[manbreak]]
## `ilogb()`, `ilogbf()`, `ilogbl()` {#man-ilogb}

[i[`ilogb()` function]i]
[i[`ilogbf()` function]i]
[i[`ilogbl()` function]i]

Trả về số mũ của một số floating point.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

int ilogb(double x);

int ilogbf(float x);

int ilogbl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Cái này cho bạn số mũ của số cho trước... hơi lạ, vì số mũ phụ thuộc
vào giá trị của `FLT_RADIX`. Giờ, giá trị này rất thường là `2`---nhưng
không có gì đảm bảo!

Thực ra nó trả về $\log_r|x|$ với $r$ là `FLT_RADIX`.

Domain hoặc range error có thể xảy ra với giá trị `x` không hợp lệ, hoặc
với giá trị trả về nằm ngoài phạm vi của kiểu trả về.

### Giá trị trả về {.unnumbered .unlisted}

Số mũ của giá trị tuyệt đối của số đã cho, phụ thuộc `FLT_RADIX`.

Cụ thể là $\log_r|x|$ với $r$ là `FLT_RADIX`.

Nếu bạn truyền vào `0`, nó sẽ trả về `FP_ILOGB0`.

Nếu bạn truyền vào vô cùng, nó sẽ trả về `INT_MAX`.

Nếu bạn truyền vào NaN, nó sẽ trả về `FP_ILOGBNAN`.

Spec còn nói giá trị của `FP_ILOGB0` sẽ là `INT_MIN` hoặc `-INT_MAX`. Và
giá trị của `FP_ILOGBNAN` sẽ là `INT_MAX` hoặc `INT_MIN`, phòng khi có
ích.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
    printf("%d\n", ilogb(257));  // 8
    printf("%d\n", ilogb(256));  // 8
    printf("%d\n", ilogb(255));  // 7
}
```

### Xem thêm {.unnumbered .unlisted}

[`frexp()`](#man-frexp),
[`logb()`](#man-logb)


[[manbreak]]
## `ldexp()`, `ldexpf()`, `ldexpl()` {#man-ldexp}

[i[`ldexp()` function]i]
[i[`ldexpf()` function]i]
[i[`ldexpl()` function]i]

Nhân một số với luỹ thừa nguyên của 2.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double ldexp(double x, int exp);

float ldexpf(float x, int exp);

long double ldexpl(long double x, int exp);
```

### Mô tả {.unnumbered .unlisted}

Các hàm này nhân số `x` với 2 mũ `exp`.

### Giá trị trả về {.unnumbered .unlisted}

Trả về $x\times2^{exp}$.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
    printf("1 x 2^10 = %f\n", ldexp(1, 10));
    printf("5.67 x 2^7 = %f\n", ldexp(5.67, 7));
}
```

Output:

``` {.default}
1 x 2^10 = 1024.000000
5.67 x 2^7 = 725.760000
```

### Xem thêm {.unnumbered .unlisted}

[`exp()`](#man-exp)


[[manbreak]]
## `log()`, `logf()`, `logl()` {#man-log}

[i[`log()` function]i]
[i[`logf()` function]i]
[i[`logl()` function]i]

Tính logarithm tự nhiên.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double log(double x);

float logf(float x);

long double logl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Logarithm tự nhiên! Và mọi người cùng reo mừng.

Các hàm này tính logarithm cơ số $e$ của một số, $\log_ex$, $\ln x$.

Nói cách khác, với một $x$ cho trước, giải $x=e^y$ tìm $y$.

### Giá trị trả về {.unnumbered .unlisted}

Logarithm cơ số $e$ của giá trị đã cho, $\log_ex$, $\ln x$.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
    const double e = 2.718281828459045;

    printf("%f\n", log(3490.2));  // 8.157714
    printf("%f\n", log(e));       // 1.000000
}
```

### Xem thêm {.unnumbered .unlisted}
[`exp()`](#man-exp),
[`log10()`](#man-log10),
[`log1p()`](#man-log10)

[[manbreak]]
## `log10()`, `log10f()`, `log10l()` {#man-log10}

[i[`log10()` function]i]
[i[`log10f()` function]i]
[i[`log10l()` function]i]

Tính log cơ số 10 của một số.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double log10(double x);

float log10f(float x);

long double log10l(long double x);
```

### Mô tả {.unnumbered .unlisted}

Ngay khi bạn tưởng mình sắp phải dùng Định luật Logarithm để tính cái
này, đây là một hàm xuất hiện bất ngờ để cứu bạn.

Các hàm này tính logarithm cơ số $10$ của một số, $\log_{10}x$.

Nói cách khác, với một $x$ cho trước, giải $x=10^y$ tìm $y$.

### Giá trị trả về {.unnumbered .unlisted}

Trả về log cơ số 10 của `x`, $\log_{10}x$.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
    printf("%f\n", log10(3490.2));   // 3.542850
    printf("%f\n", log10(10));       // 1.000000
}
```

### Xem thêm {.unnumbered .unlisted}

[`pow()`](#man-pow),
[`log()`](#man-log)

[[manbreak]]
## `log1p()`, `log1pf()`, `log1pl()` {#man-log1p}

[i[`log1p()` function]i]
[i[`log1pf()` function]i]
[i[`log1pl()` function]i]

Tính logarithm tự nhiên của một số cộng 1.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double log1p(double x);

float log1pf(float x);

long double log1pl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Hàm này tính $\log_e(1 + x)$, $\ln(1+x)$.

Nó hoạt động y như gọi:

``` {.c}
log(1 + x)
```

ngoại trừ là có thể chính xác hơn với giá trị `x` nhỏ.

Vậy nếu `x` có độ lớn nhỏ, hãy dùng cái này.

### Giá trị trả về {.unnumbered .unlisted}

Trả về $\log_e(1 + x)$, $\ln(1+x)$.

### Ví dụ {.unnumbered .unlisted}

Tính vài giá trị logarithm lớn và nhỏ để xem khác biệt giữa `log1p()`
và `log()`:

``` {.c .numberLines}
#include <stdio.h>
#include <float.h> // cho LDBL_DECIMAL_DIG
#include <math.h>

int main(void)
{
    printf("Big log1p()  : %.*Lf\n", LDBL_DECIMAL_DIG-1, log1pl(9));
    printf("Big log()    : %.*Lf\n", LDBL_DECIMAL_DIG-1, logl(1 + 9));

    printf("Small log1p(): %.*Lf\n", LDBL_DECIMAL_DIG-1, log1pl(0.01));
    printf("Small log()  : %.*Lf\n", LDBL_DECIMAL_DIG-1, logl(1 + 0.01));
}
```

Output trên máy tôi:

``` {.default}
Big log1p()  : 2.30258509299404568403
Big log()    : 2.30258509299404568403
Small log1p(): 0.00995033085316808305
Small log()  : 0.00995033085316809164
```

### Xem thêm {.unnumbered .unlisted}

[`log()`](#man-log)


[[manbreak]]
## `log2()`, `log2f()`, `log2l()` {#man-log2}

[i[`log2()` function]i]
[i[`log2f()` function]i]
[i[`log2l()` function]i]

Tính logarithm cơ số 2 của một số.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double log2(double x);

float log2f(float x);

long double log2l(long double x);
```

### Mô tả {.unnumbered .unlisted}

Wow! Bạn nghĩ mình đã xong với các hàm logarithm? Chúng ta chỉ mới bắt
đầu!

Hàm này tính $\log_2 x$. Tức là, tính $y$ thoả mãn $x=2^y$.

Yêu luỹ thừa của 2 đó!

### Giá trị trả về {.unnumbered .unlisted}

Trả về logarithm cơ số 2 của giá trị đã cho, $\log_2 x$.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
    printf("%f\n", log2(3490.2));  // 11.769094
    printf("%f\n", log2(256));     // 8.000000
}
```

### Xem thêm {.unnumbered .unlisted}

[`log()`](#man-log)

[[manbreak]]
## `logb()`, `logbf()`, `logbl()` {#man-logb}

[i[`logb()` function]i]
[i[`logbf()` function]i]
[i[`logbl()` function]i]

Trích số mũ của một số theo cơ số `FLT_RADIX`.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double logb(double x);

float logbf(float x);

long double logbl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Hàm này trả về phần nguyên của số mũ của số với cơ số `FLT_RADIX`, cụ
thể là phần nguyên của $\log_r|x|$ với $r$ là `FLT_RADIX`. Phần phân số
bị cắt.

Nếu số là [flw[subnormal|Denormal_number]], `logb()` xử lý như thể nó
đã được chuẩn hoá.

Nếu `x` là `0`, có thể có domain error hoặc pole error.

### Giá trị trả về {.unnumbered .unlisted}

Hàm này trả về phần nguyên của $\log_r|x|$ với $r$ là `FLT_RADIX`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <float.h>  // Cho FLT_RADIX
#include <math.h>

int main(void)
{
    printf("FLT_RADIX = %d\n", FLT_RADIX);
    printf("%f\n", logb(3490.2));
    printf("%f\n", logb(256));
}
```

Output:

``` {.default}
FLT_RADIX = 2
11.000000
8.000000
```

### Xem thêm {.unnumbered .unlisted}

[`ilogb()`](#man-ilogb)


[[manbreak]]
## `modf()`, `modff()`, `modfl()` {#man-modf}

[i[`modf()` function]i]
[i[`modff()` function]i]
[i[`modfl()` function]i]

Tách phần nguyên và phần phân số của một số.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double modf(double value, double *iptr);

float modff(float value, float *iptr);

long double modfl(long double value, long double *iptr);
```

### Mô tả {.unnumbered .unlisted}

Nếu bạn có một số floating point, như `123.456`, hàm này sẽ trích phần
nguyên (`123.0`) và phần phân số (`0.456`). Trùng hợp tuyệt đối là đây
cũng là nội dung cốt truyện phim hành động mới nhất của Jason Statham.

Cả phần nguyên và phần phân số đều giữ dấu của `value` được truyền vào.

Phần nguyên được lưu vào địa chỉ mà `iptr` trỏ tới.

Xem ghi chú trong [`frexp()`](#man-frexp) về lý do nó nằm trong thư viện.

### Giá trị trả về {.unnumbered .unlisted}

Các hàm này trả về phần phân số của số. Phần nguyên được lưu vào địa
chỉ mà `iptr` trỏ tới. Cả phần nguyên và phần phân số đều giữ dấu của
`value` được truyền vào.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

void print_parts(double x)
{
    double i, f;

    f = modf(x, &i);

    printf("Entire number  : %f\n", x);
    printf("Integral part  : %f\n", i);
    printf("Fractional part: %f\n\n", f);
}

int main(void)
{
    print_parts(123.456);
    print_parts(-123.456);
}
```

Output:

``` {.default}
Entire number  : 123.456000
Integral part  : 123.000000
Fractional part: 0.456000

Entire number  : -123.456000
Integral part  : -123.000000
Fractional part: -0.456000
```

### Xem thêm {.unnumbered .unlisted}

[`frexp()`](#man-frexp)

[[manbreak]]
## `scalbn()`, `scalbnf()`, `scalbnl()` `scalbln()`, `scalblnf()`, `scalblnl()` {#man-scalb}

[i[`scalbn()` function]i]
[i[`scalbnf()` function]i]
[i[`scalbnl()` function]i]
[i[`scalbln()` function]i]
[i[`scalblnf()` function]i]
[i[`scalblnl()` function]i]

Tính $x\times r^n$ hiệu quả, với $r$ là `FLT_RADIX`.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double scalbn(double x, int n);

float scalbnf(float x, int n);

long double scalbnl(long double x, int n);

double scalbln(double x, long int n);

float scalblnf(float x, long int n);

long double scalblnl(long double x, long int n);
```

### Mô tả {.unnumbered .unlisted}
Các hàm này tính $x\times r^n$ hiệu quả, với $r$ là `FLT_RADIX`.

Nếu `FLT_RADIX` tình cờ là `2` (không hứa hẹn gì đâu!), cái này chạy
giống [`exp2()`](#man-exp2).

Tên hàm chắc hẳn phải có ý nghĩa rõ ràng với bạn. Rõ ràng là tất cả đều
bắt đầu bằng tiền tố "scalb" nghĩa là...

...OK, tôi thú nhận! Tôi chẳng biết nó nghĩa gì. Tra hoài không ra!

Nhưng hãy nhìn vào các hậu tố:

|Hậu tố|Ý nghĩa|
|-|-|
|`n`|`scalbn()`---số mũ `n` là `int`|
|`nf`|`scalbnf()`---phiên bản `float` của `scalbn()`|
|`nl`|`scalbnl()`---phiên bản `long double` của `scalbn()`|
|`ln`|`scalbln()`---số mũ `n` là `long int`|
|`lnf`|`scalblnf()`---phiên bản `float` của `scalbln()`|
|`lnl`|`scalblnl()`---phiên bản `long double` của `scalbln()`|

Nên dù vẫn mù tịt về "scalb", ít nhất tôi đã nắm được phần đó.

Range error có thể xảy ra với giá trị lớn.

### Giá trị trả về {.unnumbered .unlisted}

Trả về $x\times r^n$, với $r$ là `FLT_RADIX`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>
#include <float.h>

int main(void)
{
    printf("FLT_RADIX = %d\n\n", FLT_RADIX);
    printf("scalbn(3, 8)      = %f\n", scalbn(2, 8));
    printf("scalbnf(10.2, 20) = %f\n", scalbnf(10.2, 20));
}
```

Output trên máy tôi:

``` {.default}
FLT_RADIX = 2

scalbn(3, 8)       = 512.000000
scalbn(10.2, 20.7) = 10695475.200000
```

### Xem thêm {.unnumbered .unlisted}

[`exp2()`](#man-exp2),
[`pow()`](#man-pow)


[[manbreak]]
## `cbrt()`, `cbrtf()`, `cbrtl()` {#man-cbrt}

[i[`cbrt()` function]i]
[i[`cbrtf()` function]i]
[i[`cbrtl()` function]i]

Tính căn bậc ba.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double cbrt(double x);

float cbrtf(float x);

long double cbrtl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Tính căn bậc ba của `x`, $x^{1/3}$, $\sqrt[3]{x}$.

### Giá trị trả về {.unnumbered .unlisted}

Trả về căn bậc ba của `x`, $x^{1/3}$, $\sqrt[3]{x}$.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
    printf("cbrt(1729.03) = %f\n", cbrt(1729.03));
}
```

Output:

``` {.default}
cbrt(1729.03) = 12.002384
```

### Xem thêm {.unnumbered .unlisted}

[`sqrt()`](#man-sqrt),
[`pow()`](#man-pow)

[[manbreak]]
## `fabs()`, `fabsf()`, `fabsl()` {#man-fabs}

[i[`fabs()` function]i]
[i[`fabsf()` function]i]
[i[`fabsl()` function]i]

Tính giá trị tuyệt đối.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double fabs(double x);

float fabsf(float x);

long double fabsl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Các hàm này trả về thẳng giá trị tuyệt đối của `x`, tức $|x|$.

Nếu bạn đã quên giá trị tuyệt đối, nó chỉ đơn giản nghĩa là kết quả sẽ
dương, kể cả khi `x` là âm. Đơn giản là lột bỏ dấu âm thôi.

### Giá trị trả về {.unnumbered .unlisted}

Trả về giá trị tuyệt đối của `x`, $|x|$.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
    printf("fabs(3490.0)  = %f\n", fabs(3490.0));  // 3490.000000
    printf("fabs(-3490.0) = %f\n", fabs(3490.0));  // 3490.000000
}
```

### Xem thêm {.unnumbered .unlisted}

[`abs()`](#man-abs),
[`copysign()`](#man-copysign),
[`imaxabs()`](#man-imaxabs)

[[manbreak]]
## `hypot()`, `hypotf()`, `hypotl()` {#man-hypot}

[i[`hypot()` function]i]
[i[`hypotf()` function]i]
[i[`hypotl()` function]i]

Tính độ dài cạnh huyền của tam giác.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double hypot(double x, double y);

float hypotf(float x, float y);

long double hypotl(long double x, long double y);
```

### Mô tả {.unnumbered .unlisted}

Fan [flw[Định lý Pythagoras|Pythagorean_theorem]] mừng lên! Đây là hàm
bạn đã chờ đợi!

Nếu bạn biết độ dài hai cạnh góc vuông của tam giác vuông, `x` và `y`,
bạn có thể tính độ dài cạnh huyền (cạnh dài nhất, chéo) bằng hàm này.

Cụ thể, nó tính căn bậc hai của tổng bình phương hai cạnh: $\sqrt{x^2 +
y^2}$.

### Giá trị trả về {.unnumbered .unlisted}

Trả về độ dài cạnh huyền của tam giác vuông có độ dài các cạnh là `x`
và `y`: $\sqrt{x^2 + y^2}$.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
printf("%f\n", hypot(3, 4));  // 5.000000
```

### Xem thêm {.unnumbered .unlisted}

[`sqrt()`](#man-sqrt)

[[manbreak]]
## `pow()`, `powf()`, `powl()` {#man-pow}

[i[`pow()` function]i]
[i[`powf()` function]i]
[i[`powl()` function]i]

Tính một giá trị luỹ thừa.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double pow(double x, double y);

float powf(float x, float y);

long double powl(long double x, long double y);
```

### Mô tả {.unnumbered .unlisted}

Tính `x` luỹ thừa `y`: $x^y$.

Các đối số có thể là phân số.

### Giá trị trả về {.unnumbered .unlisted}

Trả về `x` luỹ thừa `y`: $x^y$.

Domain error có thể xảy ra nếu:

* `x` là số âm hữu hạn và `y` là số không nguyên hữu hạn
* `x` là không và `y` là không.

Domain error hoặc pole error có thể xảy ra nếu `x` là không và `y` là
âm.

Range error có thể xảy ra với giá trị lớn.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
printf("%f\n", pow(3, 4));    // 3^4    = 81.000000
printf("%f\n", pow(2, 0.5));  // sqrt 2 = 1.414214
```

### Xem thêm {.unnumbered .unlisted}

[`exp()`](#man-exp),
[`exp2()`](#man-exp2),
[`sqrt()`](#man-sqrt),
[`cbrt()`](#man-cbrt)

[[manbreak]]
## `sqrt()` {#man-sqrt}

[i[`sqrt()` function]i]
[i[`sqrtf()` function]i]
[i[`sqrtl()` function]i]

Tính căn bậc hai của một số.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double sqrt(double x);

float sqrtf(float x);

long double sqrtl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Tính căn bậc hai của một số: $\sqrt{x}$. Với ai chưa biết căn bậc hai
là gì, tôi sẽ không giải thích. Chỉ cần nói, căn bậc hai của một số
cho ra một giá trị mà khi bình phương (nhân với chính nó) sẽ cho lại
số ban đầu.

Ok, được rồi---tôi đã giải thích rồi, nhưng chỉ vì tôi muốn khoe thôi.
Không phải kiểu tôi cho bạn ví dụ hay gì đâu, ví dụ như căn bậc hai
của chín là ba, bởi vì khi nhân ba với ba bạn được chín, hay gì đó.
Không ví dụ. Tôi ghét ví dụ!

Và tôi đoán bạn cũng muốn có vài thông tin thực tế ở đây. Bạn có thể
thấy bộ ba hàm quen thuộc ở đây---tất cả đều tính căn bậc hai, nhưng
nhận các kiểu đối số khác nhau. Khá đơn giản thôi.

Domain error xảy ra nếu `x` là âm.

### Giá trị trả về {.unnumbered .unlisted}

Trả về (và tôi biết đây hẳn là điều bất ngờ với bạn) căn bậc hai của
`x`: $\sqrt{x}$.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
// ví dụ dùng sqrt()

float something = 10;

double x1 = 8.2, y1 = -5.4;
double x2 = 3.8, y2 = 34.9;
double dx, dy;

printf("square root of 10 is %.2f\n", sqrtf(something));

dx = x2 - x1;
dy = y2 - y1;
printf("distance between points (x1, y1) and (x2, y2): %.2f\n",
    sqrt(dx*dx + dy*dy));
```

Và output là:

``` {.default}
square root of 10 is 3.16
distance between points (x1, y1) and (x2, y2): 40.54
```

### Xem thêm {.unnumbered .unlisted}

[`hypot()`](#man-hypot),
[`pow()`](#man-pow)

[[manbreak]]
## `erf()`, `erff()`, `erfl()` {#man-erf}

[i[`erf()` function]i]
[i[`erff()` function]i]
[i[`erfl()` function]i]

Tính hàm lỗi của giá trị cho trước.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double erfc(double x);

float erfcf(float x);

long double erfcl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Các hàm này tính [flw[hàm lỗi|Error_function]] của một giá trị.

### Giá trị trả về {.unnumbered .unlisted}

Trả về hàm lỗi của `x`:

${\displaystyle \frac{2}{\sqrt\pi} \int_0^x e^{-t^2}\,dt}$

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
for (float i = -2; i <= 2; i += 0.5)
    printf("% .1f: %f\n", i, erf(i));
```

Output:

``` {.default}
-2.0: -0.995322
-1.5: -0.966105
-1.0: -0.842701
-0.5: -0.520500
 0.0: 0.000000
 0.5: 0.520500
 1.0: 0.842701
 1.5: 0.966105
 2.0: 0.995322
```

### Xem thêm {.unnumbered .unlisted}

[`erfc()`](#man-erfc)

[[manbreak]]
## `erfc()`, `erfcf()`, `erfcl()` {#man-erfc}

[i[`erfc()` function]i]
[i[`erfcf()` function]i]
[i[`erfcl()` function]i]

Tính hàm lỗi bù của một giá trị.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double erfc(double x);

float erfcf(float x);

long double erfcl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Các hàm này tính [flw[hàm lỗi bù|Error_function]] của một giá trị.

Cái này giống như:

``` {.c}
1 - erf(x)
```

Range error có thể xảy ra nếu `x` quá lớn.

### Giá trị trả về {.unnumbered .unlisted}

Trả về `1 - erf(x)`, cụ thể là:

${\displaystyle \frac{2}{\sqrt\pi} \int_x^{\infty} e^{-t^2}\,dt}$

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
for (float i = -2; i <= 2; i += 0.5)
    printf("% .1f: %f\n", i, erfc(i));
```

Output:

``` {.default}
-2.0: 1.995322
-1.5: 1.966105
-1.0: 1.842701
-0.5: 1.520500
 0.0: 1.000000
 0.5: 0.479500
 1.0: 0.157299
 1.5: 0.033895
 2.0: 0.004678
```

### Xem thêm {.unnumbered .unlisted}

[`erf()`](#man-erf)

[[manbreak]]
## `lgamma()`, `lgammaf()`, `lgammal()` {#man-lgamma}

[i[`lgamma()` function]i]
[i[`lgammaf()` function]i]
[i[`lgammal()` function]i]

Tính logarithm tự nhiên của giá trị tuyệt đối của $\Gamma(x)$.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double lgamma(double x);

float lgammaf(float x);

long double lgammal(long double x);
```

### Mô tả {.unnumbered .unlisted}

Tính log tự nhiên của giá trị tuyệt đối của hàm
[flw[gamma|Gamma_function]] `x`, $\log_e|\Gamma(x)|$.

Range error có thể xảy ra nếu `x` quá lớn.

Pole error có thể xảy ra nếu `x` không dương.

### Giá trị trả về {.unnumbered .unlisted}

Trả về $\log_e|\Gamma(x)|$.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
for (float i = 0.5; i <= 4; i += 0.5)
    printf("%.1f: %f\n", i, lgamma(i));
```

Output:

``` {.default}
0.5: 0.572365
1.0: 0.000000
1.5: -0.120782
2.0: 0.000000
2.5: 0.284683
3.0: 0.693147
3.5: 1.200974
4.0: 1.791759
```

### Xem thêm {.unnumbered .unlisted}

[`tgamma()`](#man-tgamma)

[[manbreak]]
## `tgamma()`, `tgammaf()`, `tgammal()` {#man-tgamma}

[i[`tgamma()` function]i]
[i[`tgammaf()` function]i]
[i[`tgammal()` function]i]

Tính hàm gamma, $\Gamma(x)$.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double tgamma(double x);

float tgammaf(float x);

long double tgammal(long double x);
```

### Mô tả {.unnumbered .unlisted}

Tính [flw[hàm gamma|Gamma_function]] của `x`, $\Gamma(x)$.

Domain hoặc pole error có thể xảy ra nếu `x` không dương.

Range error có thể xảy ra nếu `x` quá lớn hoặc quá nhỏ.

### Giá trị trả về {.unnumbered .unlisted}

Trả về hàm gamma của `x`, $\Gamma(x)$.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
for (float i = 0.5; i <= 4; i += 0.5)
    printf("%.1f: %f\n", i, tgamma(i));
```

Output:

``` {.default}
0.5: 1.772454
1.0: 1.000000
1.5: 0.886227
2.0: 1.000000
2.5: 1.329340
3.0: 2.000000
3.5: 3.323351
4.0: 6.000000
```

### Xem thêm {.unnumbered .unlisted}

[`lgamma()`](#man-lgamma)

[[manbreak]]
## `ceil()`, `ceilf()`, `ceill()` {#man-ceil}

[i[`ceil()` function]i]
[i[`ceilf()` function]i]
[i[`ceill()` function]i]

Ceiling---trả về số nguyên không nhỏ hơn số đã cho.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double ceil(double x);

float ceilf(float x);

long double ceill(long double x);
```

### Mô tả {.unnumbered .unlisted}

Trả về ceiling của `x`: $\lceil{x}\rceil$.

Đây là số nguyên kế tiếp không nhỏ hơn `x`.

Coi chừng con rồng nhỏ này: nó không đơn giản là "làm tròn lên". Ờ, với
số dương thì đúng vậy, nhưng với số âm thực ra lại làm tròn về không.
(Vì hàm ceiling hướng tới số nguyên lớn hơn kế tiếp, và $-4$ lớn hơn
$-5$.)

### Giá trị trả về {.unnumbered .unlisted}

Trả về số nguyên lớn hơn kế tiếp lớn hơn `x`.

### Ví dụ {.unnumbered .unlisted}

Chú ý với số âm nó hướng về không, tức là hướng tới số nguyên lớn hơn
kế tiếp---giống như số dương hướng tới số nguyên lớn hơn kế tiếp.

``` {.c .numberLines}
printf("%f\n", ceil(4.0));   //  4.000000
printf("%f\n", ceil(4.1));   //  5.000000
printf("%f\n", ceil(-2.0));  // -2.000000
printf("%f\n", ceil(-2.1));  // -2.000000
printf("%f\n", ceil(-3.1));  // -3.000000
```

### Xem thêm {.unnumbered .unlisted}

[`floor()`](#man-floor),
[`round()`](#man-round)

[[manbreak]]
## `floor()`, `floorf()`, `floorl()` {#man-floor}

[i[`floor()` function]i]
[i[`floorf()` function]i]
[i[`floorl()` function]i]

Tính số nguyên lớn nhất không lớn hơn giá trị cho trước.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>
double floor(double x);
float floorf(float x);
long double floorl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Trả về floor của giá trị: $\lfloor{x}\rfloor$. Đây là ngược lại của
`ceil()`.

Đây là số nguyên lớn nhất không lớn hơn `x`.

Với số dương, cái này giống làm tròn xuống: `4.5` thành `4.0`.

Với số âm, nó giống làm tròn lên: `-3.6` thành `-4.0`.

Trong cả hai trường hợp, những kết quả đó là số nguyên lớn nhất không
lớn hơn số đã cho.

### Giá trị trả về {.unnumbered .unlisted}

Trả về số nguyên lớn nhất không lớn hơn `x`: $\lfloor{x}\rfloor$.

### Ví dụ {.unnumbered .unlisted}

Chú ý cách số âm thực ra làm tròn ra xa không, không giống số dương.

``` {.c .numberLines}
printf("%f\n", floor(4.0));   //  4.000000
printf("%f\n", floor(4.1));   //  4.000000
printf("%f\n", floor(-2.0));  // -2.000000
printf("%f\n", floor(-2.1));  // -3.000000
printf("%f\n", floor(-3.1));  // -4.000000
```

### Xem thêm {.unnumbered .unlisted}

[`ceil()`](#man-ceil),
[`round()`](#man-round)


[[manbreak]]
## `nearbyint()`, `nearbyintf()`, `nearbyintl()` {#man-nearbyint}

[i[`nearbyint()` function]i]
[i[`nearbyintf()` function]i]
[i[`nearbyintl()` function]i]

Làm tròn giá trị theo hướng làm tròn hiện tại.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double nearbyint(double x);

float nearbyintf(float x);

long double nearbyintl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Hàm này làm tròn `x` đến số nguyên gần nhất theo hướng làm tròn
(rounding) hiện tại.

Hướng làm tròn có thể được đặt bằng
[`fesetround()`](#man-fegetround) trong `<fenv.h>`.

`nearbyint()` không raise floating point exception "inexact".

### Giá trị trả về {.unnumbered .unlisted}

Trả về `x` được làm tròn theo hướng làm tròn hiện tại.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>
#include <fenv.h>

int main(void)
{
    #pragma STDC FENV_ACCESS ON        // Nếu được hỗ trợ

    fesetround(FE_TONEAREST);          // làm tròn đến gần nhất

    printf("%f\n", nearbyint(3.14));   // 3.000000
    printf("%f\n", nearbyint(3.74));   // 4.000000

    fesetround(FE_TOWARDZERO);         // làm tròn về không

    printf("%f\n", nearbyint(1.99));   // 1.000000
    printf("%f\n", nearbyint(-1.99));  // -1.000000
}
```

### Xem thêm {.unnumbered .unlisted}

[`rint()`](#man-rint),
[`lrint()`](#man-lrint),
[`round()`](#man-round),
[`fesetround()`](#man-fegetround),
[`fegetround()`](#man-fegetround)

[[manbreak]]
## `rint()`, `rintf()`, `rintl()` {#man-rint}

[i[`rint()` function]i]
[i[`rintf()` function]i]
[i[`rintl()` function]i]

Làm tròn giá trị theo hướng làm tròn hiện tại.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double rint(double x);

float rintf(float x);

long double rintl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Hàm này hoạt động y như [`nearbyint()`](#man-nearbyint) ngoại trừ là nó
có thể raise floating point exception "inexact".

### Giá trị trả về {.unnumbered .unlisted}

Trả về `x` được làm tròn theo hướng làm tròn hiện tại.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>
#include <fenv.h>

int main(void)
{
    #pragma STDC FENV_ACCESS ON

    fesetround(FE_TONEAREST);

    printf("%f\n", rint(3.14));   // 3.000000
    printf("%f\n", rint(3.74));   // 4.000000

    fesetround(FE_TOWARDZERO);

    printf("%f\n", rint(1.99));   // 1.000000
    printf("%f\n", rint(-1.99));  // -1.000000
}
```

### Xem thêm {.unnumbered .unlisted}

[`nearbyint()`](#man-nearbyint),
[`lrint()`](#man-lrint),
[`round()`](#man-round),
[`fesetround()`](#man-fegetround),
[`fegetround()`](#man-fegetround)

[[manbreak]]
## `lrint()`, `lrintf()`, `lrintl()`, `llrint()`, `llrintf()`, `llrintl()` {#man-lrint}

[i[`lrint()` function]i]
[i[`lrintf()` function]i]
[i[`lrintl()` function]i]
[i[`llrint()` function]i]
[i[`llrintf()` function]i]
[i[`llrintl()` function]i]

Trả về `x` được làm tròn theo hướng làm tròn hiện tại dưới dạng số nguyên.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

long int lrint(double x);
long int lrintf(float x);
long int lrintl(long double x);

long long int llrint(double x);
long long int llrintf(float x);
long long int llrintl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Làm tròn một số floating point theo hướng làm tròn hiện tại, nhưng lần
này trả về số nguyên thay vì float. Bạn biết đó, chỉ để thay đổi không
khí.

Các hàm này có hai biến thể:

* `lrint()`---trả về `long int`
* `llrint()`---trả về `long long int`

Nếu kết quả không vừa kiểu trả về, domain hoặc range error có thể xảy
ra.

### Giá trị trả về {.unnumbered .unlisted}

Giá trị `x` được làm tròn thành số nguyên theo hướng làm tròn hiện tại.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>
#include <fenv.h>

int main(void)
{
    #pragma STDC FENV_ACCESS ON

    fesetround(FE_TONEAREST);

    printf("%ld\n", lrint(3.14));   // 3
    printf("%ld\n", lrint(3.74));   // 4

    fesetround(FE_TOWARDZERO);

    printf("%ld\n", lrint(1.99));   // 1
    printf("%ld\n", lrint(-1.99));  // -1
}
```

### Xem thêm {.unnumbered .unlisted}

[`nearbyint()`](#man-nearbyint),
[`rint()`](#man-lrint),
[`round()`](#man-round),
[`fesetround()`](#man-fegetround),
[`fegetround()`](#man-fegetround)

[[manbreak]]
## `round()`, `roundf()`, `roundl()` {#man-round}

[i[`round()` function]i]
[i[`roundf()` function]i]
[i[`roundl()` function]i]

Làm tròn một số theo cách cổ điển.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double round(double x);

float roundf(float x);

long double roundl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Làm tròn một số đến giá trị nguyên gần nhất.

Với trường hợp chính giữa, làm tròn ra xa không (tức "tròn lên" về độ
lớn).

Trò Jedi của hướng làm tròn hiện tại không có tác dụng với hàm này.

### Giá trị trả về {.unnumbered .unlisted}

Giá trị làm tròn của `x`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	printf("%f\n", round(3.14));   // 3.000000
	printf("%f\n", round(3.5));    // 4.000000

	printf("%f\n", round(-1.5));   // -2.000000
	printf("%f\n", round(-1.14));  // -1.000000
}
```

### Xem thêm {.unnumbered .unlisted}

[`lround()`](#man-lround),
[`nearbyint()`](#man-nearbyint),
[`rint()`](#man-lrint),
[`lrint()`](#man-lrint),
[`trunc()`](#man-trunc)

[[manbreak]]
## `lround()`, `lroundf()`, `lroundl()` `llround()`, `llroundf()`, `llroundl()` {#man-lround}

[i[`lround()` function]i]
[i[`lroundf()` function]i]
[i[`lroundl()` function]i]
[i[`llround()` function]i]
[i[`llroundf()` function]i]
[i[`llroundl()` function]i]

Làm tròn một số theo cách cổ điển, trả về số nguyên.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

long int lround(double x);
long int lroundf(float x);
long int lroundl(long double x);

long long int llround(double x);
long long int llroundf(float x);
long long int llroundl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Các hàm này giống như [`round()`](#man-round) ngoại trừ chúng trả về số
nguyên.

Giá trị chính giữa làm tròn ra xa không, ví dụ $1.5$ làm tròn thành $2$
và $-1.5$ làm tròn thành $-2$.

Các hàm được nhóm theo kiểu trả về:

* `lround()`---trả về `long int`
* `llround()`---trả về `long long int`

Nếu giá trị làm tròn không vừa kiểu trả về, domain hoặc range error có
thể xảy ra.

### Giá trị trả về {.unnumbered .unlisted}

Trả về giá trị làm tròn của `x` dưới dạng số nguyên.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	printf("%ld\n", lround(3.14));   // 3
	printf("%ld\n", lround(3.5));    // 4

	printf("%ld\n", lround(-1.5));   // -2
	printf("%ld\n", lround(-1.14));  // -1
}
```

### Xem thêm {.unnumbered .unlisted}

[`round()`](#man-lround),
[`nearbyint()`](#man-nearbyint),
[`rint()`](#man-lrint),
[`lrint()`](#man-lrint),
[`trunc()`](#man-trunc)

[[manbreak]]
## `trunc()`, `truncf()`, `truncl()` {#man-trunc}

[i[`trunc()` function]i]
[i[`truncf()` function]i]
[i[`truncl()` function]i]

Cắt phần phân số của một giá trị floating point.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double trunc(double x);

float truncf(float x);

long double truncl(long double x);
```

### Mô tả {.unnumbered .unlisted}

Các hàm này đơn giản bỏ phần phân số của một số floating point. Bùm.

Nói cách khác, chúng luôn làm tròn về không.

### Giá trị trả về {.unnumbered .unlisted}

Trả về số floating point đã bị cắt.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	printf("%f\n", trunc(3.14));   // 3.000000
	printf("%f\n", trunc(3.8));    // 3.000000

	printf("%f\n", trunc(-1.5));   // -1.000000
	printf("%f\n", trunc(-1.14));  // -1.000000
}
```

### Xem thêm {.unnumbered .unlisted}
[`round()`](#man-lround),
[`lround()`](#man-lround),
[`nearbyint()`](#man-nearbyint),
[`rint()`](#man-lrint),
[`lrint()`](#man-lrint)

[[manbreak]]
## `fmod()`, `fmodf()`, `fmodl()` {#man-fmod}

[i[`fmod()` function]i]
[i[`fmodf()` function]i]
[i[`fmodl()` function]i]

Tính phần dư floating point.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double fmod(double x, double y);

float fmodf(float x, float y);

long double fmodl(long double x, long double y);
```

### Mô tả {.unnumbered .unlisted}

Trả về phần dư của $\frac{x}{y}$. Kết quả có cùng dấu với `x`.

Dưới vỏ bọc, phép tính thực hiện là:

``` {.c}
x - trunc(x / y) * y
```

Nhưng dễ hơn thì cứ nghĩ về phần dư thôi.

### Giá trị trả về {.unnumbered .unlisted}

Trả về phần dư của $\frac{x}{y}$ cùng dấu với `x`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	printf("%f\n", fmod(-9.2, 5.1));  // -4.100000
	printf("%f\n", fmod(9.2, 5.1));   //  4.100000
}
```

### Xem thêm {.unnumbered .unlisted}

[`remainder()`](#man-remainder)

[[manbreak]]
## `remainder()`, `remainderf()`, `remainderl()` {#man-remainder}

[i[`remainder()` function]i]
[i[`remainderf()` function]i]
[i[`remainderl()` function]i]

Tính phần dư kiểu IEC 60559.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double remainder(double x, double y);

float remainderf(float x, float y);

long double remainderl(long double x, long double y);
```

### Mô tả {.unnumbered .unlisted}

Cái này tương tự `fmod()`, nhưng không hoàn toàn giống. `fmod()` có lẽ
là cái bạn muốn nếu bạn mong phần dư xoay vòng như đồng hồ đo đường xe
chạy (odometer).

Spec C trích IEC 60559 về cách nó hoạt động:

> Khi $y\neq0$, phần dư $r=x$ REM $y$ được xác định bất kể mode làm
> tròn bằng quan hệ toán học $r=x-ny$, với $n$ là số nguyên gần nhất
> với giá trị chính xác của $x/y$; khi $|n-x/y|=1/2$, thì $n$ là số
> chẵn. Nếu $r=0$, dấu của nó sẽ là dấu của $x$.

Hy vọng đã sáng tỏ!

OK, có thể chưa. Tóm lại:

Bạn biết là nếu `fmod()` cho gì đó, ví dụ `2.0`, bạn được kết quả nào
đó nằm giữa `0.0` và `2.0`? Và nếu bạn cứ tăng số mà bạn đang lấy mod
với `2.0`, bạn thấy kết quả leo lên `2.0` rồi xoay vòng về `0.0` như
đồng hồ đo đường của ô tô?

`remainder()` hoạt động y vậy, ngoại trừ nếu `y` là `2.0`, nó xoay
vòng từ `-1.0` đến `1.0` thay vì từ `0.0` đến `2.0`.

Nói cách khác, phạm vi của hàm chạy từ `-y/2` đến `y/2`. Khác với
`fmod()` chạy từ `0.0` đến `y`, output của `remainder()` chỉ là dịch
xuống nửa `y`.

Và không-dư-bất-kỳ-cái-gì là `0`.

Ngoại trừ nếu `y` là không, hàm có thể trả về không hoặc domain error
có thể xảy ra.

### Giá trị trả về {.unnumbered .unlisted}

Kết quả IEC 60559 của `x`-dư-`y`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	printf("%f\n", remainder(3.7, 4));  // -0.300000
	printf("%f\n", remainder(4.3, 4));  //  0.300000
}
```

### Xem thêm {.unnumbered .unlisted}

[`fmod()`](#man-fmod),
[`remquo()`](#man-remquo)

[[manbreak]]
## `remquo()`, `remquof()`, `remquol()` {#man-remquo}

[i[`remquo()` function]i]
[i[`remquof()` function]i]
[i[`remquol()` function]i]

Tính phần dư và (một phần của) thương.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double remquo(double x, double y, int *quo);

float remquof(float x, float y, int *quo);

long double remquol(long double x, long double y, int *quo);
```

### Mô tả {.unnumbered .unlisted}

Đây là một thứ hơi lạ đời.

Thứ nhất, giá trị trả về là phần dư, giống hàm
[`remainder()`](#man-remainder), nên xem cái đó.

Và thương trở về trong con trỏ `quo`.

Hoặc ít nhất _một phần của nó_. Bạn sẽ nhận ít nhất 3 bit của thương.

Nhưng _vì sao_?

Vài lý do.

Một là thương của một số floating point rất lớn có thể dễ dàng quá
khổng lồ để vừa cả `long long unsigned int`. Nên dù sao cũng phải cắt
bớt một phần.

Nhưng 3 bit? Có ích gì? Chỉ cho bạn từ 0 đến 7!

Tài liệu C99 Rationale nói:

> Các hàm `remquo` dành cho việc triển khai các phép giảm đối số có thể
> khai thác vài bit thấp của thương. Lưu ý rằng $x$ có thể quá lớn về
> độ lớn so với $y$ đến mức biểu diễn chính xác của thương là không
> khả thi.

Vậy là... triển khai các phép giảm đối số... có thể khai thác vài bit
thấp... Ờ ờ okay.

[fl[CPPReference có nói thế
này|https://en.cppreference.com/w/c/numeric/math/remquo]] về chuyện
này, nói hay quá nên tôi sẽ trích nguyên văn:

> Hàm này hữu ích khi triển khai các hàm tuần hoàn có chu kỳ biểu diễn
> chính xác được bằng giá trị floating point: khi tính $\sin(πx)$ với
> `x` rất lớn, gọi `sin` trực tiếp có thể cho sai số lớn, nhưng nếu
> đối số hàm được giảm trước bằng `remquo`, các bit thấp của thương có
> thể dùng để xác định dấu và octant của kết quả trong chu kỳ, còn
> phần dư có thể dùng để tính giá trị với độ chính xác cao.

Đấy. Nếu bạn có ví dụ khác dùng được... xin chúc mừng! :)

### Giá trị trả về {.unnumbered .unlisted}

Trả về giống [`remainder`](#man-remainder): Kết quả IEC 60559 của
`x`-dư-`y`.

Ngoài ra, ít nhất 3 bit thấp nhất của thương sẽ được lưu vào `quo` với
cùng dấu của `x/y`.

### Ví dụ {.unnumbered .unlisted}

Có [fl[ví dụ `cos()` hay ở
CPPReference|https://en.cppreference.com/w/c/numeric/math/remquo]] bao
quát một use case thực tế.

Nhưng thay vì "mượn" nó, tôi sẽ đăng một ví dụ đơn giản ở đây và bạn có
thể ghé trang họ để xem ví dụ thật.

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	int quo;
	double rem;

	rem = remquo(12.75, 2.25, &quo);

	printf("%d remainder %f\n", quo, rem);  // 6 remainder -0.750000
}
```

### Xem thêm {.unnumbered .unlisted}

[`remainder()`](#man-remainder),
[`imaxdiv()`](#man-imaxdiv)

[[manbreak]]
## `copysign()`, `copysignf()`, `copysignl()` {#man-copysign}

[i[`copysign()` function]i]
[i[`copysignf()` function]i]
[i[`copysignl()` function]i]

Chép dấu của một giá trị sang một giá trị khác.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double copysign(double x, double y);

float copysignf(float x, float y);

long double copysignl(long double x, long double y);
```

### Mô tả {.unnumbered .unlisted}

Các hàm này trả về một số có độ lớn của `x` và dấu của `y`. Bạn có thể
dùng chúng để ép dấu theo giá trị khác.

Tất nhiên là cả `x` lẫn `y` đều không bị thay đổi. Giá trị trả về chứa
kết quả.

### Giá trị trả về {.unnumbered .unlisted}

Trả về giá trị có độ lớn của `x` và dấu của `y`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	double x = 34.9;
	double y = -999.9;
	double z = 123.4;

	printf("%f\n", copysign(x, y)); // -34.900000
	printf("%f\n", copysign(x, z)); //  34.900000
}
```

### Xem thêm {.unnumbered .unlisted}

[`signbit()`](#man-signbit)

[[manbreak]]
## `nan()`, `nanf()`, `nanl()` {#man-nan}

[i[`nan()` function]i]
[i[`nanf()` function]i]
[i[`nanl()` function]i]

Trả về `NAN`.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double nan(const char *tagp);

float nanf(const char *tagp);

long double nanl(const char *tagp);
```

### Mô tả {.unnumbered .unlisted}

Các hàm này trả về một quiet NaN^[Một _quiet NaN_ là NaN không raise
bất kỳ exception nào.]. Nó được tạo như thể gọi
[`strtod()`](#man-strtod) với `"NAN"` (hoặc biến thể của nó) làm đối số.

`tagp` trỏ tới một chuỗi có thể là nhiều thứ, bao gồm cả rỗng. Nội dung
của chuỗi quyết định biến thể NaN nào có thể được trả về tuỳ
implementation.

_Phiên bản_ NaN nào? Bạn có biết là có thể đi sâu tới mức này với một
thứ không phải là số không?

Trường hợp 1, bạn truyền vào chuỗi rỗng, trong trường hợp đó các dòng
sau tương đương:

``` {.c}
nan("");

strtod("NAN()", NULL);
```

Trường hợp 2, chuỗi chỉ chứa chữ số 0-9, chữ cái a-z, chữ cái A-Z,
và/hoặc gạch dưới:

``` {.c}
nan("goats");

strtod("NAN(goats)", NULL);
```

Và Trường hợp 3, chuỗi chứa bất cứ thứ gì khác và bị bỏ qua:

``` {.c}
nan("!");

strtod("NAN", NULL);
```

Còn `strtod()` làm gì với các giá trị trong ngoặc đơn, xem trang tham
chiếu [`strtod()`]. Spoiler: phụ thuộc implementation.

### Giá trị trả về {.unnumbered .unlisted}

Trả về quiet NaN được yêu cầu, hoặc 0 nếu hệ thống của bạn không hỗ trợ
những thứ này.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	printf("%f\n", nan(""));       // nan
	printf("%f\n", nan("goats"));  // nan
	printf("%f\n", nan("!"));      // nan
}
```

### Xem thêm {.unnumbered .unlisted}

[`strtod()`](#man-strtod)

[[manbreak]]
## `nextafter()`, `nextafterf()`, `nextafterl()` {#man-nextafter}

[i[`nextafter()` function]i]
[i[`nextafterf()` function]i]
[i[`nextafterl()` function]i]

Lấy giá trị floating point kế tiếp (hoặc trước đó) biểu diễn được.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double nextafter(double x, double y);

float nextafterf(float x, float y);

long double nextafterl(long double x, long double y);
```

### Mô tả {.unnumbered .unlisted}

Như bạn có lẽ đã biết, số floating point không thể biểu diễn _mọi_ số
thực khả dĩ. Có giới hạn.

Và, như vậy, tồn tại một số "kế tiếp" và "trước đó" sau hoặc trước bất
kỳ số floating point nào.

Các hàm này trả về số kế tiếp (hoặc trước đó) biểu diễn được. Nghĩa là,
không có số floating point nào tồn tại giữa số đã cho và số kế tiếp.

Cách nó xác định là nó chạy từ `x` theo hướng `y`, trả lời câu hỏi "số
kế tiếp biểu diễn được từ `x` khi ta đi về phía `y` là gì".

### Giá trị trả về {.unnumbered .unlisted}

Trả về giá trị floating point kế tiếp biểu diễn được từ `x` theo hướng
`y`.

Nếu `x` bằng `y`, trả về `y`. Và cả `x` nữa, tôi đoán vậy.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	printf("%.*f\n", DBL_DECIMAL_DIG, nextafter(0.5, 1.0));
	printf("%.*f\n", DBL_DECIMAL_DIG, nextafter(0.349, 0.0));
}
```

Output trên máy tôi:

``` {.default}
0.50000000000000011
0.34899999999999992
```

### Xem thêm {.unnumbered .unlisted}

[`nexttoward()`](#man-nexttoward)

[[manbreak]]
## `nexttoward()`, `nexttowardf()`, `nexttowardl()` {#man-nexttoward}

[i[`nexttoward()` function]i]
[i[`nexttowardf()` function]i]
[i[`nexttowardl()` function]i]

Lấy giá trị floating point kế tiếp (hoặc trước đó) biểu diễn được.

### Synopsis {.unnumbered .unlisted}

``` {.c}
include <math.h>

double nexttoward(double x, long double y);

float nexttowardf(float x, long double y);

long double nexttowardl(long double x, long double y);
```

### Mô tả {.unnumbered .unlisted}

Các hàm này giống [`nextafter()`](#man-nextafter) ngoại trừ tham số thứ
hai luôn là `long double`.

### Giá trị trả về {.unnumbered .unlisted}

Trả về giống [`nextafter()`](#man-nextafter) ngoại trừ nếu `x` bằng
`y`, trả về `y` cast sang kiểu trả về của hàm.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <float.h>
#include <math.h>

int main(void)
{
	printf("%.*f\n", DBL_DECIMAL_DIG, nexttoward(0.5, 1.0));
	printf("%.*f\n", DBL_DECIMAL_DIG, nexttoward(0.349, 0.0));
}
```

Output trên máy tôi:

``` {.default}
0.50000000000000011
0.34899999999999992
```

### Xem thêm {.unnumbered .unlisted}

[`nextafter()`](#man-nextafter)

[[manbreak]]
## `fdim()`, `fdimf()`, `fdiml()` {#man-fdim}

[i[`fdim()` function]i]
[i[`fdimf()` function]i]
[i[`fdiml()` function]i]

Trả về hiệu số dương giữa hai số, chặn dưới ở 0.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double fdim(double x, double y);

float fdimf(float x, float y);

long double fdiml(long double x, long double y);
```

### Mô tả {.unnumbered .unlisted}

Hiệu số dương giữa `x` và `y` là hiệu... ngoại trừ nếu hiệu nhỏ hơn
`0`, nó bị kẹp ở `0`.

Các hàm này có thể ném range error.

### Giá trị trả về {.unnumbered .unlisted}

Trả về hiệu của `x-y` nếu hiệu lớn hơn `0`. Ngược lại trả về `0`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	printf("%f\n", fdim(10.0, 3.0));   // 7.000000
	printf("%f\n", fdim(3.0, 10.0));   // 0.000000, bị kẹp
}
```

<!--
### See Also {.unnumbered .unlisted}

[`example()`](#man-example),
-->

[[manbreak]]
## `fmax()`, `fmaxf()`, `fmaxl()`, `fmin()`, `fminf()`, `fminl()` {#man-fmax}

[i[`fmax()` function]i]
[i[`fmaxf()` function]i]
[i[`fmaxl()` function]i]
[i[`fmin()` function]i]
[i[`fminf()` function]i]
[i[`fminl()` function]i]

Trả về giá trị lớn nhất hoặc nhỏ nhất trong hai số.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double fmax(double x, double y);

float fmaxf(float x, float y);

long double fmaxl(long double x, long double y);

double fmin(double x, double y);

float fminf(float x, float y);

long double fminl(long double x, long double y);
```

### Mô tả {.unnumbered .unlisted}

Đơn giản, các hàm này trả về giá trị nhỏ nhất hoặc lớn nhất trong hai
số đã cho.

Nếu một trong các số là NaN, các hàm trả về số không phải NaN. Nếu cả
hai đối số đều là NaN, các hàm trả về NaN.

### Giá trị trả về {.unnumbered .unlisted}

Trả về giá trị nhỏ nhất hoặc lớn nhất, với NaN được xử lý như trên.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	printf("%f\n", fmin(10.0, 3.0));   //  3.000000
	printf("%f\n", fmax(3.0, 10.0));   // 10.000000
}
```

<!--
### See Also {.unnumbered .unlisted}

[`example()`](#man-example),
-->

[[manbreak]]
## `fma()`, `fmaf()`, `fmal()` {#man-fma}

[i[`fma()` function]i]
[i[`fmaf()` function]i]
[i[`fmal()` function]i]

Nhân và cộng Floating (còn gọi là "Fast").

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

double fma(double x, double y, double z);

float fmaf(float x, float y, float z);

long double fmal(long double x, long double y, long double z);
```

### Mô tả {.unnumbered .unlisted}

Hàm này thực hiện phép toán $(x\times{y})+z$, nhưng theo một cách rất
đỉnh. Nó làm phép tính như thể có độ chính xác vô hạn, rồi làm tròn kết
quả cuối cùng về kiểu dữ liệu cuối cùng theo mode làm tròn hiện tại.

So với cách bạn tự làm toán, trong đó có thể làm tròn ở mỗi bước.

Ngoài ra, một số kiến trúc có lệnh CPU để làm đúng phép tính này, nên
có thể làm siêu nhanh. (Nếu không có, đáng kể chậm hơn.)

Bạn có thể biết CPU của mình có hỗ trợ phiên bản nhanh không bằng cách
kiểm tra macro `FP_FAST_FMA` được đặt thành `1`. (Biến thể `float` và
`long` của `fma()` có thể được kiểm tra với `FP_FAST_FMAF` và
`FP_FAST_FMAL` tương ứng.)

Các hàm này có thể gây range error.

### Giá trị trả về {.unnumbered .unlisted}

Trả về `(x * y) + z`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
printf("%f\n", fma(1.0, 2.0, 3.0));  // 5.000000
```

<!--
### See Also {.unnumbered .unlisted}

[`example()`](#man-example),
-->

[[manbreak]]
## `isgreater()`, `isgreaterequal()`, `isless()`, `islessequal()` {#man-isgreater}

[i[`isgreater()` function]i]
[i[`isgreaterequal()` function]i]
[i[`isless()` function]i]
[i[`islessequal()` function]i]

Các macro so sánh floating point.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

int isgreater(any_floating_type x, any_floating_type y);

int isgreaterequal(any_floating_type x, any_floating_type y);

int isless(any_floating_type x, any_floating_type y);

int islessequal(any_floating_type x, any_floating_type y);
```

### Mô tả {.unnumbered .unlisted}

Các macro này so sánh các số floating point. Vì là macro, ta có thể
truyền bất kỳ kiểu floating point nào.

Bạn có thể nghĩ mình đã làm được điều đó chỉ với các toán tử so sánh
bình thường---và bạn nói đúng!

Trừ một ngoại lệ: toán tử so sánh raise floating exception "invalid"
nếu một hoặc nhiều toán hạng là NaN. Các macro này không như vậy.

Lưu ý là bạn chỉ được truyền kiểu floating point vào các hàm này.
Truyền số nguyên hay bất kỳ kiểu nào khác là hành vi không xác định.

### Giá trị trả về {.unnumbered .unlisted}

`isgreater()` trả về kết quả của `x > y`.

`isgreaterequal()` trả về kết quả của `x >= y`.

`isless()` trả về kết quả của `x < y`.

`islessequal()` trả về kết quả của `x <= y`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	printf("%d\n", isgreater(10.0, 3.0));        // 1
	printf("%d\n", isgreaterequal(10.0, 10.0));  // 1
	printf("%d\n", isless(10.0, 3.0));           // 0
	printf("%d\n", islessequal(10.0, 3.0));      // 0
}
```

### Xem thêm {.unnumbered .unlisted}

[`islessgreater()`](#man-islessgreater),
[`isunordered()`](#man-isunordered)

[[manbreak]]
## `islessgreater()` {#man-islessgreater}

[i[`islessgreater()` function]i]

Kiểm tra số floating point này nhỏ hơn hoặc lớn hơn số kia.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

int islessgreater(any_floating_type x, any_floating_type y);
```

### Mô tả {.unnumbered .unlisted}

Macro này tương tự `isgreater()` và đồng bọn, nhưng nó làm tên section
quá dài nếu tôi bao nó vào trên kia. Nên nó được có chỗ riêng.

Cái này trả về true nếu $x < y$ hoặc $x > y$.

Dù là macro, ta có thể yên tâm rằng `x` và `y` chỉ được tính giá trị
một lần.

Và kể cả khi `x` hoặc `y` là NaN, cái này sẽ không ném exception
"invalid", không giống các toán tử so sánh thường.

Nếu bạn truyền kiểu không phải floating point, hành vi không xác định.

### Giá trị trả về {.unnumbered .unlisted}

Trả về `(x < y) || (x > y)`.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	printf("%d\n", islessgreater(10.0, 3.0));   // 1
	printf("%d\n", islessgreater(10.0, 30.0));  // 1
	printf("%d\n", islessgreater(10.0, 10.0));  // 0
}
```

### Xem thêm {.unnumbered .unlisted}

[`isgreater()`](#man-isgreater),
[`isgreaterequal()`](#man-isgreater),
[`isless()`](#man-isgreater),
[`islessequal()`](#man-isgreater),
[`isunordered()`](#man-isunordered)

[[manbreak]]
## `isunordered()` {#man-isunordered}

[i[`isunordered()` function]i]

Macro trả về true nếu bất kỳ đối số floating point nào là NaN.

### Synopsis {.unnumbered .unlisted}

``` {.c}
#include <math.h>

int isunordered(any_floating_type x, any_floating_type y);
```

### Mô tả {.unnumbered .unlisted}

Spec viết:

> Macro isunordered xác định xem các đối số của nó có unordered không.

Thấy chưa? Tôi đã nói C dễ mà!

Nó cũng nói thêm là các đối số là unordered nếu một hoặc cả hai là NaN.

### Giá trị trả về {.unnumbered .unlisted}

Macro này trả về true nếu một hoặc cả hai đối số là NaN.

### Ví dụ {.unnumbered .unlisted}

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>

int main(void)
{
	printf("%d\n", isunordered(1.0, 2.0));       // 0
	printf("%d\n", isunordered(1.0, sqrt(-1)));  // 1
	printf("%d\n", isunordered(NAN, 30.0));      // 1
	printf("%d\n", isunordered(NAN, NAN));       // 1
}
```

### Xem thêm {.unnumbered .unlisted}

[`isgreater()`](#man-isgreater),
[`isgreaterequal()`](#man-isgreater),
[`isless()`](#man-isgreater),
[`islessequal()`](#man-isgreater),
[`islessgreater()`](#man-islessgreater)

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
