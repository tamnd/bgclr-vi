<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# `<float.h>` Giới hạn Dấu chấm động {#float}

[i[`float.h` header file]i]

[i[`FLT_EVAL_METHOD` macro]i]
[i[`FLT_RADIX` macro]i]
[i[`FLT_MANT_DIG` macro]i]
[i[`DBL_MANT_DIG` macro]i]
[i[`LDBL_MANT_DIG` macro]i]
[i[`DECIMAL_DIG` macro]i]
[i[`FLT_MIN_EXP` macro]i]
[i[`DBL_MIN_EXP` macro]i]
[i[`LDBL_MIN_EXP` macro]i]
[i[`FLT_MIN_10_EXP` macro]i]
[i[`DBL_MIN_10_EXP` macro]i]
[i[`LDBL_MIN_10_EXP` macro]i]
[i[`FLT_MAX_EXP` macro]i]
[i[`DBL_MAX_EXP` macro]i]
[i[`LDBL_MAX_EXP` macro]i]
[i[`FLT_MAX_10_EXP` macro]i]
[i[`DBL_MAX_10_EXP` macro]i]
[i[`LDBL_MAX_10_EXP` macro]i]
[i[`FLT_MAX` macro]i]
[i[`DBL_MAX` macro]i]
[i[`LDBL_MAX` macro]i]

|Macro|Độ lớn tối thiểu|Mô tả|
|--|:--:|--------|
|`FLT_ROUNDS`||Chế độ làm tròn hiện tại|
|`FLT_EVAL_METHOD`||Các kiểu dùng để đánh giá|
|`FLT_HAS_SUBNORM`||Hỗ trợ subnormal cho `float`|
|`DBL_HAS_SUBNORM`||Hỗ trợ subnormal cho `double`|
|`LDBL_HAS_SUBNORM`||Hỗ trợ subnormal cho `long double`|
|`FLT_RADIX`|`2`|Cơ số dấu chấm động (radix)|
|`FLT_MANT_DIG`||Số chữ số cơ số `FLT_RADIX` trong `float`|
|`DBL_MANT_DIG`||Số chữ số cơ số `FLT_RADIX` trong `double`|
|`LDBL_MANT_DIG`||Số chữ số cơ số `FLT_RADIX` trong `long double`|
|`FLT_DECIMAL_DIG`|`6`|Số chữ số thập phân cần để mã hoá một `float`|
|`DBL_DECIMAL_DIG`|`10`|Số chữ số thập phân cần để mã hoá một `double`|
|`LDBL_DECIMAL_DIG`|`10`|Số chữ số thập phân cần để mã hoá một `long double`|
|`DECIMAL_DIG`|`10`|Số chữ số thập phân cần để mã hoá số dấu chấm động rộng nhất được hỗ trợ|
|`FLT_DIG`|`6`|Số chữ số thập phân có thể lưu an toàn trong `float`|
|`DBL_DIG`|`10`|Số chữ số thập phân có thể lưu an toàn trong `double`|
|`LDBL_DIG`|`10`|Số chữ số thập phân có thể lưu an toàn trong `long double`|
|`FLT_MIN_EXP`||`FLT_RADIX` mũ `FLT_MIN_EXP-1` là `float` chuẩn hoá nhỏ nhất|
|`DBL_MIN_EXP`||`FLT_RADIX` mũ `DBL_MIN_EXP-1` là `double` chuẩn hoá nhỏ nhất|
|`LDBL_MIN_EXP`||`FLT_RADIX` mũ `LDBL_MIN_EXP-1` là `long double` chuẩn hoá nhỏ nhất|
|`FLT_MIN_10_EXP`|`-37`|Số mũ tối thiểu sao cho `10` luỹ thừa số này là `float` chuẩn hoá|
|`DBL_MIN_10_EXP`|`-37`|Số mũ tối thiểu sao cho `10` luỹ thừa số này là `double` chuẩn hoá
|`LDBL_MIN_10_EXP`|`-37`|Số mũ tối thiểu sao cho `10` luỹ thừa số này là `long_double` chuẩn hoá
|`FLT_MAX_EXP`||`FLT_RADIX` mũ `FLT_MAX_EXP-1` là `float` hữu hạn lớn nhất|
|`DBL_MAX_EXP`||`FLT_RADIX` mũ `DBL_MAX_EXP-1` là `double` hữu hạn lớn nhất|
|`LDBL_MAX_EXP`||`FLT_RADIX` mũ `LDBL_MAX_EXP-1` là `long double` hữu hạn lớn nhất|
|`FLT_MAX_10_EXP`|`-37`|Số mũ tối thiểu sao cho `10` luỹ thừa số này là `float` hữu hạn|
|`DBL_MAX_10_EXP`|`-37`|Số mũ tối thiểu sao cho `10` luỹ thừa số này là `double` hữu hạn
|`LDBL_MAX_10_EXP`|`-37`|Số mũ tối thiểu sao cho `10` luỹ thừa số này là `long_double` hữu hạn
|`FLT_MAX`|`1E+37`|`float` hữu hạn lớn nhất|
|`DBL_MAX`|`1E+37`|`double` hữu hạn lớn nhất|
|`LDBL_MAX`|`1E+37`|`long double` hữu hạn lớn nhất|

[i[`FLT_EPSILON` macro]i]
[i[`DBL_EPSILON` macro]i]
[i[`LDBL_EPSILON` macro]i]
[i[`FLT_MIN` macro]i]
[i[`DBL_MIN` macro]i]
[i[`LDBL_MIN` macro]i]
[i[`FLT_TRUE_MIN` macro]i]
[i[`DBL_TRUE_MIN` macro]i]
[i[`LDBL_TRUE_MIN` macro]i]

|Macro|Giá trị tối đa|Mô tả|
|--|:--:|--------|
|`FLT_EPSILON`|`1E-5`|Chênh lệch giữa 1 và `float` biểu diễn được lớn hơn kế tiếp|
|`DBL_EPSILON`|`1E-9`|Chênh lệch giữa 1 và `double` biểu diễn được lớn hơn kế tiếp|
|`LDBL_EPSILON`|`1E-9`|Chênh lệch giữa 1 và `long double` biểu diễn được lớn hơn kế tiếp|
|`FLT_MIN`|`1E-37`|`float` chuẩn hoá dương nhỏ nhất|
|`DBL_MIN`|`1E-37`|`double` chuẩn hoá dương nhỏ nhất|
|`LDBL_MIN`|`1E-37`|`long double` chuẩn hoá dương nhỏ nhất|
|`FLT_TRUE_MIN`|`1E-37`|`float` dương nhỏ nhất|
|`DBL_TRUE_MIN`|`1E-37`|`double` dương nhỏ nhất|
|`LDBL_TRUE_MIN`|`1E-37`|`long double` dương nhỏ nhất|

Các giá trị tối thiểu và tối đa ở đây lấy từ spec---đó là mức tối
thiểu bạn có thể mong đợi trên mọi nền tảng. Máy siêu xịn của bạn có
thể làm tốt hơn nữa!

## Bối cảnh

Spec cho phép khá thoáng trong chuyện C biểu diễn số dấu chấm động
như thế nào. Header này đánh vần ra các giới hạn của những con số đó.

Nó đưa ra một mô hình có thể mô tả bất kỳ số dấu chấm động nào mà tôi
_biết_ chắc chắn bạn sẽ mê tít. Trông như vầy:

$\displaystyle x=sb^e\sum_{k=1}^p f_k b^{-k}, e_{min} \le e \le e_{max}$

trong đó:

|Biến|Ý nghĩa|
|:-:|-|
|$s$|Dấu, $-1$ hoặc $1$|
|$b$|Cơ số (radix), trên hệ của bạn chắc là $2$|
|$e$|Số mũ|
|$p$|Độ chính xác: có bao nhiêu chữ số cơ số $b$ trong số|
|$f_k$|Từng chữ số của số, tức significand|

Nhưng tạm thời cứ bỏ qua mớ đó đi cho nhẹ đầu.

Giả sử máy của bạn dùng cơ số 2 cho dấu chấm động (chắc là có). Và
trong ví dụ dưới đây các số 1-và-0 là ở hệ nhị phân, còn lại ở thập
phân.

Tóm lại là bạn có thể có các số dấu chấm động như trong ví dụ này:

$-0.10100101 \times 2^5 = -10100.101 = -20.625$

Đó là phần phân số nhân với cơ số luỹ thừa số mũ. Số mũ điều khiển
dấu thập phân nằm ở đâu. Nó "trôi" loanh quanh!

<!--
Or, more specifically, that example uses:

$s=-1$ \
$b=2$ \
$e=5$ \
$p=8$ \
$f_n=10100101$ 
-->

## Chi tiết `FLT_ROUNDS`

[i[`FLT_ROUNDS` macro]i]

Cái này cho bạn biết chế độ làm tròn. Có thể thay đổi bằng một lời
gọi [`fesetround()`](#man-fegetround).

|Chế độ|Mô tả|
|:-:|-|
|`-1`|Không xác định được|
|`0`|Về phía 0|
|`1`|Về gần nhất|
|`2`|Về phía dương vô cực|
|`3`|Về phía âm vô cực... và xa hơn nữa!|

Không giống mọi macro khác trong header này, `FLT_ROUNDS` có thể
không phải là biểu thức hằng.

## Chi tiết `FLT_EVAL_METHOD`

[i[`FLT_EVAL_METHOD` macro]i]

Cái này cơ bản cho bạn biết các giá trị dấu chấm động được promote
sang kiểu khác thế nào trong biểu thức.

|Phương pháp|Mô tả|
|:--:|-----------------------|
|`-1`|Không xác định được|
|`0`|Đánh giá mọi phép toán và hằng ở độ chính xác của kiểu tương ứng|
|`1`|Đánh giá phép toán `float` và `double` như `double`, phép toán `long double` như `long double`|
|`2`|Đánh giá mọi phép toán và hằng như `long double`|

## Số Subnormal

[i[`FLT_HAS_SUBNORM` macro]i]
[i[`DBL_HAS_SUBNORM` macro]i]
[i[`LDBL_HAS_SUBNORM` macro]i]

Các macro `FLT_HAS_SUBNORM`, `DBL_HAS_SUBNORM`, và `LDBL_HAS_SUBNORM`
đều cho bạn biết các kiểu đó có hỗ trợ [flw[số
subnormal|Subnormal_number]] không.

|Giá trị|Mô tả|
|:-:|-|
|`-1`|Không xác định được|
|`0`|Subnormal không được hỗ trợ cho kiểu này|
|`1`|Subnormal được hỗ trợ cho kiểu này|

## Tôi dùng được bao nhiêu chữ số thập phân?

Còn tuỳ bạn muốn làm gì.

[i[`FLT_DIG` macro]i]
[i[`DBL_DIG` macro]i]
[i[`LDBL_DIG` macro]i]

An toàn là nếu bạn không bao giờ dùng quá `FLT_DIG` chữ số cơ số 10
trong `float` của mình, bạn ổn. (Tương tự với `DBL_DIG` và `LDBL_DIG`
cho kiểu của chúng.)

Và "dùng" tôi nói đây là in ra, có trong code, đọc từ bàn phím, v.v.

Bạn có thể in ra từng ấy chữ số thập phân bằng `printf()` và format
specifier `%g`:

``` {.c .numberLines}
#include <stdio.h>
#include <float.h>

int main(void)
{
    float pi = 3.1415926535897932384626433832795028841971;

    // Với %g hoặc %G, precision chỉ số chữ số có nghĩa:

    printf("%.*g\n", FLT_DIG, pi);  // Với tôi: 3.14159

    // Nhưng %f in quá nhiều, vì precision là số chữ số bên phải
    // dấu thập phân--nó không đếm các chữ số bên trái:

    printf("%.*f\n", FLT_DIG, pi);  // Với tôi: 3.14159... 3 ???
}
```

Đấy là hết, nhưng mời đón xem phần kết hấp dẫn của "Tôi dùng được
bao nhiêu chữ số thập phân?"

Vì cơ số 10 và cơ số 2 (`FLT_RADIX` tiêu biểu của bạn) không ăn ý với
nhau lắm, bạn có thể thực sự có nhiều hơn `FLT_DIG` chữ số trong
`float`; các bit lưu trữ kéo dài thêm chút nữa. Nhưng chúng có thể
làm tròn theo cách bạn không ngờ tới.

[i[`FLT_DECIMAL_DIG` macro]i]
[i[`DBL_DECIMAL_DIG` macro]i]
[i[`LDBL_DECIMAL_DIG` macro]i]

Nhưng nếu bạn muốn chuyển một số dấu chấm động sang cơ số 10 rồi có
thể chuyển nó ngược lại thành cùng một số dấu chấm động y hệt, bạn sẽ
cần `FLT_DECIMAL_DIG` chữ số từ `float` để đảm bảo mấy bit lưu trữ
dư ra được thể hiện đầy đủ. (Và `DBL_DECIMAL_DIG` và
`LDBL_DECIMAL_DIG` cho các kiểu tương ứng.)

Dưới đây là ví dụ output cho thấy giá trị được lưu có thể có vài chữ
số thập phân thừa ở cuối.

``` {.c .numberLines}
#include <stdio.h>
#include <math.h>
#include <assert.h>
#include <float.h>

int main(void)
{
    printf("FLT_DIG = %d\n", FLT_DIG);
    printf("FLT_DECIMAL_DIG = %d\n\n", FLT_DECIMAL_DIG);

    assert(FLT_DIG == 6);  // Code dưới giả định điều này

    for (float x = 0.123456; x < 0.12346; x += 0.000001) {
        printf("As written: %.*g\n", FLT_DIG, x);
        printf("As stored:  %.*g\n\n", FLT_DECIMAL_DIG, x);
    }
}
```

Và output trên máy của tôi, bắt đầu tại `0.123456` và tăng dần
`0.000001` mỗi lần:

``` {.default}
FLT_DIG = 6
FLT_DECIMAL_DIG = 9

As written: 0.123456
As stored:  0.123456001

As written: 0.123457
As stored:  0.123457

As written: 0.123458
As stored:  0.123457998

As written: 0.123459
As stored:  0.123458996

As written: 0.12346
As stored:  0.123459995
```

Bạn có thể thấy giá trị lưu không phải lúc nào cũng là giá trị ta
mong đợi, vì cơ số 2 không biểu diễn chính xác được mọi phân số cơ số
10. Tốt nhất nó có thể làm là lưu thêm vài chữ số rồi làm tròn.

Cũng để ý là dù ta đã cố dừng vòng `for` _trước_ `0.123460`, nó thực
sự chạy qua cả giá trị đó vì bản lưu của số đó là `0.123459995`, vẫn
nhỏ hơn `0.123460`.

Số dấu chấm động vui ghê nhỉ?

## Ví dụ Toàn diện

Đây là chương trình in ra chi tiết cho một máy cụ thể:

``` {.c .numberLines}
#include <stdio.h>
#include <float.h>

int main(void)
{
    printf("FLT_RADIX: %d\n", FLT_RADIX);
    printf("FLT_ROUNDS: %d\n", FLT_ROUNDS);
    printf("FLT_EVAL_METHOD: %d\n", FLT_EVAL_METHOD);
    printf("DECIMAL_DIG: %d\n\n", DECIMAL_DIG);

    printf("FLT_HAS_SUBNORM: %d\n", FLT_HAS_SUBNORM);
    printf("FLT_MANT_DIG: %d\n", FLT_MANT_DIG);
    printf("FLT_DECIMAL_DIG: %d\n", FLT_DECIMAL_DIG);
    printf("FLT_DIG: %d\n", FLT_DIG);
    printf("FLT_MIN_EXP: %d\n", FLT_MIN_EXP);
    printf("FLT_MIN_10_EXP: %d\n", FLT_MIN_10_EXP);
    printf("FLT_MAX_EXP: %d\n", FLT_MAX_EXP);
    printf("FLT_MAX_10_EXP: %d\n", FLT_MAX_10_EXP);
    printf("FLT_MIN: %.*e\n", FLT_DECIMAL_DIG, FLT_MIN);
    printf("FLT_MAX: %.*e\n", FLT_DECIMAL_DIG, FLT_MAX);
    printf("FLT_EPSILON: %.*e\n", FLT_DECIMAL_DIG, FLT_EPSILON);
    printf("FLT_TRUE_MIN: %.*e\n\n", FLT_DECIMAL_DIG, FLT_TRUE_MIN);

    printf("DBL_HAS_SUBNORM: %d\n", DBL_HAS_SUBNORM);
    printf("DBL_MANT_DIG: %d\n", DBL_MANT_DIG);
    printf("DBL_DECIMAL_DIG: %d\n", DBL_DECIMAL_DIG);
    printf("DBL_DIG: %d\n", DBL_DIG);
    printf("DBL_MIN_EXP: %d\n", DBL_MIN_EXP);
    printf("DBL_MIN_10_EXP: %d\n", DBL_MIN_10_EXP);
    printf("DBL_MAX_EXP: %d\n", DBL_MAX_EXP);
    printf("DBL_MAX_10_EXP: %d\n", DBL_MAX_10_EXP);
    printf("DBL_MIN: %.*e\n", DBL_DECIMAL_DIG, DBL_MIN);
    printf("DBL_MAX: %.*e\n", DBL_DECIMAL_DIG, DBL_MAX);
    printf("DBL_EPSILON: %.*e\n", DBL_DECIMAL_DIG, DBL_EPSILON);
    printf("DBL_TRUE_MIN: %.*e\n\n", DBL_DECIMAL_DIG, DBL_TRUE_MIN);

    printf("LDBL_HAS_SUBNORM: %d\n", LDBL_HAS_SUBNORM);
    printf("LDBL_MANT_DIG: %d\n", LDBL_MANT_DIG);
    printf("LDBL_DECIMAL_DIG: %d\n", LDBL_DECIMAL_DIG);
    printf("LDBL_DIG: %d\n", LDBL_DIG);
    printf("LDBL_MIN_EXP: %d\n", LDBL_MIN_EXP);
    printf("LDBL_MIN_10_EXP: %d\n", LDBL_MIN_10_EXP);
    printf("LDBL_MAX_EXP: %d\n", LDBL_MAX_EXP);
    printf("LDBL_MAX_10_EXP: %d\n", LDBL_MAX_10_EXP);
    printf("LDBL_MIN: %.*Le\n", LDBL_DECIMAL_DIG, LDBL_MIN);
    printf("LDBL_MAX: %.*Le\n", LDBL_DECIMAL_DIG, LDBL_MAX);
    printf("LDBL_EPSILON: %.*Le\n", LDBL_DECIMAL_DIG, LDBL_EPSILON);
    printf("LDBL_TRUE_MIN: %.*Le\n\n", LDBL_DECIMAL_DIG, LDBL_TRUE_MIN);
    
    printf("sizeof(float): %zu\n", sizeof(float));
    printf("sizeof(double): %zu\n", sizeof(double));
    printf("sizeof(long double): %zu\n", sizeof(long double));
}
```

Và đây là output trên máy của tôi:

``` {.default}
FLT_RADIX: 2
FLT_ROUNDS: 1
FLT_EVAL_METHOD: 0
DECIMAL_DIG: 21

FLT_HAS_SUBNORM: 1
FLT_MANT_DIG: 24
FLT_DECIMAL_DIG: 9
FLT_DIG: 6
FLT_MIN_EXP: -125
FLT_MIN_10_EXP: -37
FLT_MAX_EXP: 128
FLT_MAX_10_EXP: 38
FLT_MIN: 1.175494351e-38
FLT_MAX: 3.402823466e+38
FLT_EPSILON: 1.192092896e-07
FLT_TRUE_MIN: 1.401298464e-45

DBL_HAS_SUBNORM: 1
DBL_MANT_DIG: 53
DBL_DECIMAL_DIG: 17
DBL_DIG: 15
DBL_MIN_EXP: -1021
DBL_MIN_10_EXP: -307
DBL_MAX_EXP: 1024
DBL_MAX_10_EXP: 308
DBL_MIN: 2.22507385850720138e-308
DBL_MAX: 1.79769313486231571e+308
DBL_EPSILON: 2.22044604925031308e-16
DBL_TRUE_MIN: 4.94065645841246544e-324

LDBL_HAS_SUBNORM: 1
LDBL_MANT_DIG: 64
LDBL_DECIMAL_DIG: 21
LDBL_DIG: 18
LDBL_MIN_EXP: -16381
LDBL_MIN_10_EXP: -4931
LDBL_MAX_EXP: 16384
LDBL_MAX_10_EXP: 4932
LDBL_MIN: 3.362103143112093506263e-4932
LDBL_MAX: 1.189731495357231765021e+4932
LDBL_EPSILON: 1.084202172485504434007e-19
LDBL_TRUE_MIN: 3.645199531882474602528e-4951

sizeof(float): 4
sizeof(double): 8
sizeof(long double): 16
```
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
