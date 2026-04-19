<!-- Beej's guide to C

# vim: ts=4:sw=4:nosi:et:tw=72
-->

# The C Language

Đây là bản tổng quan nhanh các điểm nhấn thời thượng và vui vẻ của
cú pháp, keyword, và những "con thú" khác trong sở thú C.

## Bối cảnh

Một vài thứ bạn cần để hiểu các ví dụ bên dưới.

### Comment

Comment trong C bắt đầu bằng `//` và kéo đến cuối dòng.

Comment nhiều dòng bắt đầu bằng `/*` và kéo đến khi gặp `*/` đóng.

### Dấu phân cách

Biểu thức trong C được phân cách bằng dấu chấm phẩy (`;`). Chúng
thường xuất hiện ở cuối dòng.

### Biểu thức

Nếu nó không phải keyword hay ký tự đặc biệt, khả năng nó là một
biểu thức. Cứ nghĩ "toán học cộng thêm lời gọi hàm".

### Câu lệnh

Cứ nghĩ `if`, `while`, v.v. Các keyword thực thi.

### Boolean

Bỏ qua kiểu `bool`, số không là false và khác không là true.

### Block

Nhiều biểu thức và keyword điều khiển luồng có thể được gói trong
một block, gồm `{` theo sau là một hay nhiều biểu thức hoặc câu
lệnh, rồi `}`.

### Ví dụ code

Chúng nhằm cho bạn hình dung cách dùng các câu lệnh khác nhau, chứ
không phải liệt kê ví dụ toàn diện.

Trong các ví dụ dưới đây, nếu chỗ đó có thể là biểu thức hoặc câu
lệnh, từ `code` được chèn vào.

## Toán tử

### Toán tử số học

Các toán tử số học: `+`, `-`, `*`, `/`, `%` (phần dư).

Phép chia là chia số nguyên nếu mọi toán hạng đều là số nguyên. Nếu
không, kết quả là số thực.

Bạn cũng có thể đổi dấu một biểu thức bằng cách đặt `-` trước nó.
(Bạn cũng có thể đặt `+` trước, việc này không làm gì về mặt toán
học, nhưng nó khiến Usual Arithmetic Conversions được thực hiện trên
biểu thức đó.)

### Pre- và Post-Increment, Pre- và Post-Decrement

Toán tử post-increment (`++`) và post-decrement (`--`) (đặt sau biến)
làm việc của chúng _sau khi_ phần còn lại của biểu thức đã được tính.

``` {.c}
int x = 10;
int y = 20;
int z = 30;

int w = (x++) + (y--) + (z++);

print("%d %d %d %d\n", x, y, z, w);  // 11 19 31 60
```

Toán tử pre-increment (`++`) và pre-decrement (`--`) (đặt trước biến)
làm việc của chúng _trước khi_ phần còn lại của biểu thức được tính.

``` {.c}
int x = 10;
int y = 20;
int z = 30;

int w = (++x) + (--y) + (++z);

print("%d %d %d %d\n", x, y, z, w);  // 11 19 31 61
```

### Toán tử so sánh

Tất cả đều trả về một giá trị true hoặc false kiểu Boolean.

Nhỏ hơn, lớn hơn, và bằng lần lượt là: `<`, `>`, `==`.

Nhỏ hơn hoặc bằng và lớn hơn hoặc bằng là `<=` và `>=`.

Không bằng là `!=`.

### Toán tử con trỏ

`*` đặt trước biến con trỏ dereference biến đó.

`&` đặt trước biến lấy địa chỉ của biến đó.

Các toán tử số học `+` và `-` cũng chạy trên con trỏ để làm số học
con trỏ.

### Toán tử cho Struct và Union

Toán tử dấu chấm (`.`) lấy giá trị một field từ `struct` hoặc
`union`.

Toán tử mũi tên (`->`) lấy giá trị một field từ con trỏ tới
`struct` hay `union`. Hai cách dưới đây tương đương nhau, giả sử `p`
chính là loại con trỏ đó:

``` {.c}
(*p).bar;
p->bar;
```

### Toán tử mảng

Toán tử ngoặc vuông có thể tham chiếu một giá trị trong mảng:

``` {.c}
a[10] = 99;
```

Đây là "syntactic sugar" bọc ngoài số học con trỏ và dereference.
Dòng trên tương đương với:

``` {.c}
*(a + 10) = 99;
```

### Toán tử bit

Dịch bit phải: `>>`, dịch bit trái: `<<`.

```
int i = x << 3;  // dịch trái 3 bit
```

Việc dịch phải trên một giá trị có dấu có được mở rộng dấu hay không
là implementation-defined.

Bitwise AND, OR, NOT, và XOR lần lượt là `&`, `|`, `~`, và `^`.

### Toán tử gán

`=` đứng một mình là phép gán cơ bản.

Nhưng còn có các phép gán kết hợp, kiểu viết tắt. Ví dụ, hai dòng
sau về cơ bản là tương đương:

``` {.c}
x = x + 1;
x += 1;
```

Có các toán tử gán kết hợp cho phần lớn các toán tử khác.

Số học: `+=`, `-=`, `*=`, `/=`, và `%=`.

Bit: `|=`, `&=`, `~=`, và `^=`.

### Toán tử `sizeof`

Đây là toán tử lúc compile, cho bạn kích thước tính bằng byte của
kiểu của đối số. Kiểu của biểu thức được dùng; biểu thức không được
đánh giá. `sizeof` làm việc với bất kỳ kiểu nào, kể cả kiểu hợp do
người dùng định nghĩa.

Kiểu trả về là kiểu integer `size_t`.

```
float f;
size_t x = sizeof f;

printf("f is %zu bytes\n", x);
```

Bạn cũng có thể chỉ định trực tiếp tên kiểu bằng cách bọc nó trong
ngoặc:

``` {.c}
size_t x = sizeof(int);

printf("int is %zu bytes\n", x);
```

### Type Cast

Bạn có thể ép một biểu thức sang kiểu khác (trong giới hạn hợp lý)
bằng cách _cast_ sang kiểu đó.

Bạn đặt tên kiểu mới trong ngoặc.

Ở đây ta đang ép biểu thức con `x` thành kiểu `float` ngay trước
phép chia^[Việc này không thay đổi kiểu của `x` ở ngữ cảnh khác, nó
chỉ có hiệu lực trong lần dùng cụ thể này trong biểu thức này.]. Cái
này làm cho phép chia, nếu không sẽ là chia số nguyên, trở thành
chia số thực.

``` {.c}
int x = 17;
int y = 2;

float f = (float)x / y;
```

### Toán tử `_Alignof`

Bạn có thể lấy byte alignment của bất kỳ kiểu nào với toán tử
compile-time `_Alignof`. Nếu bạn include `<stdalign.h>`, bạn có thể
dùng `alignof` thay thế.

Bất kỳ kiểu nào cũng có thể là đối số của toán tử, và phải đặt trong
ngoặc. Khác với `sizeof`, đối số không thể là biểu thức.

``` {.c}
printf("Alignment of int is %zu\n", alignof(int));
```

### Toán tử dấu phẩy

Bạn có thể phân tách các biểu thức con bằng dấu phẩy, mỗi biểu thức
sẽ được tính từ trái sang phải, và giá trị của toàn biểu thức sẽ là
giá trị của biểu thức con đứng sau dấu phẩy cuối cùng.

``` {.c}
int x = (1, 2, 3);  // Cách ngốc để gán `x = 3`
```

Thường thì cái này được dùng trong các mệnh đề của vòng lặp. Ví dụ,
ta có thể gán nhiều lần trong vòng `for`, và có nhiều biểu thức post
như thế này:

``` {.c}
for (i = 2, j = 10; i < 100; i++, j += 4) { ... }
```

## Type Specifier

Các kiểu integer từ nhỏ nhất đến lớn nhất: `char`, `short`, `int`,
`long`, `long long`.

Bất kỳ kiểu integer nào cũng có thể có tiền tố `signed` (mặc định,
trừ `char`) hoặc `unsigned`.

Việc `char` có dấu hay không là implementation-defined.

Các kiểu floating từ ít chính xác nhất đến nhiều nhất: `float`,
`double`, `long double`.

`void` là kiểu biểu diễn "không có kiểu".

`_Bool` là kiểu Boolean. Kiểu này thành `bool` trong C23. Các phiên
bản C trước đó phải include `<stdbool.h>` để có `bool`.

`_Complex` chỉ một kiểu số phức floating, khi kết hợp với một kiểu
đó. Include `<complex.h>` để dùng `complex` thay thế.

``` {.c}
complex float x = 1.2 + 2.3*I;
complex double y = 1.2 + 2.3*I;
```

`_Imaginary` là keyword tuỳ chọn, dùng để chỉ một kiểu tưởng tượng
(phần imaginary của một số phức) khi kết hợp với kiểu floating.
Include `<complex.h>` để dùng `imaginary` thay thế. Cả GCC và clang
đều không hỗ trợ cái này.

``` {.c}
imaginary float f = 2.3*I;
```

`_Generic` là "cái chuyển kiểu", cho phép bạn sinh ra code khác nhau
lúc compile tuỳ vào kiểu của dữ liệu.

## Kiểu hằng

Bạn có thể khai báo hằng với kiểu cụ thể (dù đôi khi nó là kiểu lớn
hơn). Trong ví dụ dưới, với các kiểu không qualifier, hoa thường
không quan trọng, và `U` có thể đứng trước hoặc sau `L` hoặc `LL`.

``` {.c}
123              int hoặc lớn hơn
123L             long int hoặc lớn hơn
123LL            long long int

123U             unsigned int hoặc lớn hơn
123UL            unsigned long int hoặc lớn hơn
123ULL           unsigned long long int

123.4F           float
123.4            double
123.4L           long double

'a'              char
"hello, world"   char* (string)
```

Bạn cũng có thể chỉ định hằng ở cơ số khác:

``` {.c}
123              thập phân
0x123            hexa
0123             bát phân
```

Bạn cũng có thể chỉ định hằng floating theo ký hiệu luỹ thừa cơ số 10:

``` {.c}
1.2e3            1.2 x 10^3
```

Và bạn có thể chỉ định float ở hex! Chỉ có điều trong trường hợp
này số mũ vẫn ở thập phân, còn cơ số là 2 thay vì 10:

``` {.c}
0x1.2p3          0x1.2 x 2^3
```

## Kiểu hợp

### Kiểu `struct`

Bạn có thể dựng một kiểu hợp từ các kiểu khác bằng `struct` rồi khai
báo biến có kiểu đó.

``` {.c}
struct animal {
    char *name;
    int leg_count;
};

struct animal a;
struct animal b = {"goat", 4};
struct animal c = {.name="goat", .leg_count=4};
```

Truy cập bằng toán tử dấu chấm (`.`), hoặc nếu biến là con trỏ tới
`struct`, bằng toán tử mũi tên (`->`).

``` {.c}
struct animal *p = &b;  // b ở trên

printf("%d\n", b.leg_count);
printf("%d\n", p->leg_count);
```

### Kiểu `union`

Chúng giống kiểu `struct` về cách dùng, chỉ khác là bạn chỉ dùng được
một field tại một thời điểm. (Các field chia sẻ cùng vùng bộ nhớ.)

``` {.c}
union dt {
    float distance;
    int time;
};

union dt a;
union dt b = {6};            // Khởi tạo "distance", field đầu
union dt c = {.distance=6};  // Khởi tạo "distance"
union dt d = {.time=6};      // Khởi tạo "time"
```

Truy cập bằng toán tử dấu chấm (`.`), hoặc nếu biến là con trỏ tới
`union`, bằng toán tử mũi tên (`->`).

``` {.c}
union dt *p = &b;

printf("%d\n", b.time);
printf("%d\n", p->time);
```

### Kiểu `enum`

Cho bạn cách có kiểu để đặt tên cho các giá trị hằng integer. Chúng
dùng được với `switch()`, hay làm kích thước mảng, hay ở bất cứ chỗ
nào cần giá trị hằng.

Theo thông lệ, tên viết hoa.

``` {.c}
enum animal {
    ANTELOPE,
    BADGER,
    CAT,
    DOG,
    ELEPHANT,
    FISH
};

enum animal a = CAT;

if (a == CAT)
    printf("The animal is a cat.\n");
```

Các tên có giá trị số bắt đầu từ 0 và đếm lên. (Trong ví dụ trên,
`DOG` sẽ là `3`.)

Có thể ghi đè giá trị số bằng cách chỉ định một số nguyên chính xác.
Các giá trị sau tăng từ giá trị đã chỉ định đó.

``` {.c}
enum animal {
    ANTELOPE = 4,
    BADGER,         // Sẽ là 5
    CAT,            // Sẽ là 6
    DOG = 3,
    ELEPHANT,       // Sẽ là 4
    FISH            // Sẽ là 5
};
```

Như trên, giá trị trùng không phải là bất hợp pháp, nhưng hữu dụng
thì cũng chẳng bao.

## Initializer

Bạn có thể làm vầy khi biến được định nghĩa, nhưng không được làm ở
chỗ khác.

Khởi tạo các kiểu cơ bản:

``` {.c}
int x = 12;
float y = 1.2;
char c = 'a';
char *s = "Hello, world!";
```

Khởi tạo các kiểu mảng:

``` {.c}
int a[3] = {1,2,3};
int a[] = {1,2,3};   // Giống a[3]

int a[3] = {1, 2};   // Giống {1, 2, 0}
int a[3] = {1};      // Giống {1, 0, 0}
int a[3] = {0};      // Giống {0, 0, 0}
```

Khởi tạo các kiểu con trỏ:

``` {.c}
int q;
int *p = &q;
```

Khởi tạo `struct`:

``` {.c}
struct s {
    int a;
    float b;
};

struct s x0 = {1, 2.2}; // Khởi tạo các field theo thứ tự

struct s x0 = {.a=1, .b=2.2}; // Khởi tạo các field theo tên
struct s x0 = {.b=2.2, .a=1}; // Cùng ý nghĩa

struct s x0 = {.b=2.2}; // Các field còn lại được khởi tạo về 0
struct s x0 = {.b=2.2, .a-=0};  // Cùng ý nghĩa
```

Khởi tạo `union`:

``` {.c}
union u {
    int a;
    float b;
};

union u x0 = {1};  // Khởi tạo field đầu tiên (a)

union u x0 = {.a=1};  // Khởi tạo field theo tên
union u x0 = {.b=2.2};

//union u x0 = {1, 2};       // BẤT HỢP PHÁP
//union u x0 = {.a=1, .b=2};  // BẤT HỢP PHÁP
```

## Compound Literal

Bạn có thể khai báo object "không tên" trong C. Cái này thường hữu
dụng khi truyền một `struct` cho hàm mà không cần đặt tên nó.

Bạn dùng tên kiểu trong ngoặc, theo sau là một initializer để tạo
object.

Đây là ví dụ truyền một compound literal cho hàm. Chú ý không có
biến `struct s` nào trong `main()`:

``` {.c .numberLines}
#include <stdio.h>

struct s {
    int a, b;
};

int add(struct s x)
{
    return x.a + x.b;
}

int main(void)
{
    int t = add((struct s){.a=2, .b=4});  // <-- Đây

    printf("%d\n", t);
}
```

Compound literal có thời gian sống đúng bằng scope của chúng.

Bạn cũng có thể truyền con trỏ tới một compound literal bằng cách
lấy địa chỉ của nó:

``` {.c}
foo(&(struct s){1, 2});
```

## Type Alias

Bạn có thể dựng type alias cho tiện hoặc để trừu tượng hoá.

Ở đây ta sẽ tạo kiểu mới tên `time_counter`, thực ra chỉ là `int`.
Nó chỉ dùng được hệt như `int`. Nó chỉ là alias của `int`.

``` {.c}
typedef int time_counter;

time_counter t = 3490;
```

Cũng chạy với `struct` hay `union`:

``` {.c}
struct foo {
    int bar;
    float baz;
};

typedef struct foo funtype;

funtype f = {1, 2}; // "funtype" là alias của "struct foo";
```

Nó cũng chạy inline, với `struct` hay `union` có tên hoặc không tên:

``` {.c}
typedef struct {
    int bar;
    float baz;
} funtype;

funtype f = {1, 2}; // "funtype" là alias cho struct không tên
```

## Specifier khác liên quan đến kiểu

Bạn có thể cho compiler nhiều gợi ý hơn về tính chất mà một kiểu nên
có thông qua các specifier và qualifier này.

### Storage Class Specifier

Chúng có thể đặt trước một kiểu để chỉ dẫn thêm về cách dùng kiểu đó.

``` {.c}
auto int a
register int a
static int a
extern int a
thread_local int a
```

`auto` là mặc định, nên về cơ bản chẳng ai dùng. Nó chỉ ra storage
duration tự động (những thứ như biến local được tự động giải phóng
khi hết scope). Trong C23 keyword này đổi nghĩa thành "suy luận
kiểu" kiểu C++.

`register` chỉ ra rằng việc truy cập biến này nên càng nhanh càng
tốt. Nó hạn chế một số cách dùng biến để compiler có cơ hội tối ưu.
Ít gặp trong công việc hàng ngày.

`static` ở function scope chỉ ra giá trị biến này nên tồn tại qua
các lần gọi. Ở file scope nó chỉ ra biến này không nên visible ngoài
file nguồn này.

`extern` chỉ ra biến này tham chiếu tới một biến được khai báo ở
file nguồn khác.

`_Thread_local` nghĩa là mỗi thread có bản copy riêng của biến này.
Bạn có thể dùng `thread_local` nếu include `<threads.h>`.

### Type Qualifier

Chúng có thể đặt trước một kiểu để chỉ dẫn thêm về cách dùng kiểu đó.

``` {.c}
const int a
const int *p
int * const p
const int * const p
int * restrict p
volatile int a
atomic int a
```

`const` nghĩa là giá trị không được sửa. Bạn cũng có thể dùng với
con trỏ:

``` {.c}
const int a = 10;        // Không sửa được "a"

const int *p = &b        // Không sửa được thứ "p" trỏ tới ("b")
int *const p = &b        // Không sửa được "p"
const int *const p = &b  // Không sửa được cả "p" lẫn thứ nó trỏ tới
```

`restrict` trên con trỏ nghĩa là sẽ chỉ có một con trỏ trỏ tới item
đó, cho compiler tự do hơn để tối ưu.

`volatile` chỉ ra giá trị trong biến có thể thay đổi bất cứ lúc
nào, và nên được load từ bộ nhớ thay vì giữ trong register. Thường
dùng với phần cứng memory-mapped.

`_Atomic` (hoặc `atomic` nếu bạn include `<stdatomic.h>`) bảo
compiler rằng việc đọc hoặc ghi kiểu này phải xảy ra atomic. (Việc
này có thể được thực hiện bằng lock, tuỳ platform và kiểu.)

#### Pseudo-Type có qualifier của C23: `QVoid*`, `QChar*`, v.v.

Trong C23 có một số hàm generic sẽ trả về kiểu đã được
`const`-qualify nếu một trong các tham số là `const`, và không như
vậy trong các trường hợp khác.

Spec tự chế một kiểu giả cho mục đích này, với chữ `Q` đằng trước
(cho "qualified"). Đây không phải kiểu thật và sẽ không compile
được, chỉ để làm tài liệu.

Các pseudo-type này là:

* `QVoid *`
* `QChar *`
* `QWchar_t *`

Ví dụ, hàm `strchr()`, tìm một ký tự trong chuỗi, có prototype thế
này trong spec:

``` {.c}
QChar *strchr(QChar *s, int c);
```

Nó là gì? Nó có nghĩa là nếu `s` có kiểu `const char *`, thì kiểu
trả về của hàm cũng sẽ là `const char *`.

Nếu `s` chỉ là `char *`, thì kiểu trả về của hàm cũng chỉ là
`char *`.

Nói cách khác, tính `const` của `s` được giữ nguyên ở giá trị trả
về.

Nhìn kiểu khác, thì dòng này:

``` {.c}
QChar *strchr(QChar *s, int c);
```

tương đương với:

``` {.c}
char *strchr(char *s, int c);
const char *strchr(const char *s, int c);
```

Tóm lại khi bạn thấy cái này, bỏ `Q` đầu đi rồi đổi chữ tiếp theo
thành chữ thường là xong.

### Function Specifier

Được dùng trên hàm để chỉ dẫn thêm cho compiler.

`_Noreturn` chỉ ra rằng một hàm sẽ không bao giờ return. Nó chỉ có
thể chạy mãi hoặc thoát hẳn chương trình. Nếu bạn include
`<stdnoreturn.h>`, bạn có thể dùng `noreturn` thay thế.

`inline` chỉ ra rằng các lời gọi hàm này nên càng nhanh càng tốt. Ý
định là code của hàm được dời _inline_ để bỏ overhead của lời gọi
và return. Compiler coi `inline` là gợi ý, không phải yêu cầu.

### Alignment Specifier

Bạn có thể ép alignment của một biến trong bộ nhớ bằng `_Alignas`.
Nếu bạn include `<stdalign.h>` bạn có thể dùng `alignas` thay thế.

`alignas(0)` không có tác dụng gì.

``` {.c}
alignas(16) int a = 12;    // alignment 16-byte
alignas(long) int b = 34;  // cùng alignment với "long"
```

## Câu lệnh `if`

``` {.c}
if (boolean_expression) code;

if (boolean_expression) {
    code;
    code;
    code;
}

if (boolean_expression) {
    code;
    code;
} else
    code;

if (boolean_expression) {
    code;
    code;
} else if {
    code;
    code;
    code;
} else {
    code;
}
```

## Câu lệnh `for`

Vòng `for` cổ điển.

Phần trong ngoặc gồm ba phần phân cách bằng dấu chấm phẩy:

* Khởi tạo, chạy một lần.
* Điều kiện vào block, được đánh giá trước mỗi lần vào thân vòng
  lặp.
* Biểu thức post, đánh giá sau mỗi lần chạy thân vòng lặp.

Ví dụ, khởi tạo `i` về `0`, vào thân vòng lặp khi `i < 10`, và tăng
`i` sau mỗi vòng lặp:

``` {.c}
for (i = 0; i < 10; i++) {
    code;
    code;
    code;
}
```

Bạn có thể khai báo biến cục bộ trong vòng lặp bằng cách chỉ định
kiểu:

``` {.c}
for (int i = 0; i < 10; i++) {
    code;
    code;
}
```

Bạn có thể phân tách các phần của biểu thức bằng toán tử dấu phẩy:

``` {.c}
for (i = 0, j = 5; i < 10; i++, j *= 3) {
    code;
    code;
}
```

## Câu lệnh `while`

Vòng lặp này sẽ không vào nếu biểu thức Boolean là false. Kiểm tra
điều kiện tiếp tục xảy ra trước thân vòng lặp.

``` {.c}
while (boolean_expression) code;

while (boolean_expression) {
    code;
    code;
}
```

## Câu lệnh `do`-`while`

Vòng lặp này sẽ chạy ít nhất một lần ngay cả khi biểu thức Boolean
là false. Kiểm tra điều kiện tiếp tục không xảy ra cho đến sau thân
vòng lặp.

``` {.c}

do code while (boolean_expression);

do {
    code;
    code;
} while (boolean_expression);
```

## Câu lệnh `switch`

Thực hiện hành động dựa trên giá trị của một biểu thức. Các case so
khớp phải là giá trị hằng.

Nếu có `default` tuỳ chọn, code đó được chạy khi không case nào
khớp. Không bắt buộc có ngoặc nhọn quanh các case.

``` {.c}
switch (expression) {
    case constant:
        code;
        code;
        break;

    case constant:
        code;
        code;
        break;

    default:
        code;
        break;
}
```

`break` cuối trong `switch` là không cần thiết nếu không còn case
nào sau nó.

Nếu `break` không có, `case` rơi qua case kế tiếp. Nên ghi comment
cho chuyện đó để các dev khác không ghét bạn.

``` {.c}
switch (expression) {
    case constant:
        code;
        code;
        // fall through!

    case constant:
        code;
        break;
}
```

## Câu lệnh `break`

Lệnh này thoát khỏi một case trong `switch`, nhưng cũng có thể thoát
khỏi bất kỳ vòng lặp nào.

``` {.c}
while (boolean_expression) {
    code;

    if (boolean_expression)
        break;

    code;
}
```

## Câu lệnh `continue`

Có thể dùng để short-circuit một vòng lặp và đi tới kiểm tra điều
kiện tiếp theo mà không hoàn tất thân vòng lặp.

``` {.c}
while (boolean_expression) {
    code;
    code;

    if (boolean_expression_2)
        continue;

    // Nếu boolean_expression_2, code dưới đây sẽ bị bỏ qua:

    code;
    code;
}
```

## Câu lệnh `goto`

Bạn có thể nhảy đến bất kỳ đâu trong một hàm bằng `goto`. (Bạn không
thể `goto` giữa các hàm, chỉ trong cùng hàm với `goto`.)

Đích của `goto` là một _label_, là một identifier theo sau là dấu
hai chấm (`:`). Label thường được canh sát lề trái để dễ nhìn.

``` {.c}
{
    // Code minh hoạ kiểu lạm dụng mà đáng lẽ phải là vòng while

    int i = 0;

loop:

    printf("%d\n", i++);

    if (i < 10)
        goto loop;
}
```

## Câu lệnh `return`

Đây là cách bạn về từ một hàm. Bạn có thể `return` nhiều lần hoặc
chỉ một lần.

Nếu một hàm kiểu trả về `void` chạy hết, `return` là ngầm định.

Nếu kiểu trả về không phải `void`, câu lệnh `return` phải chỉ định
giá trị trả về cùng kiểu.

Không cần ngoặc quanh giá trị return (vì đây là câu lệnh, không phải
hàm).

``` {.c}
int increment(int a)
{
    return a + 1;
}
```

## Câu lệnh `_Static_assert`

Đây là cách ngăn _compilation_ một chương trình nếu một điều kiện
hằng nào đó không thoả.

``` {.c}
_Static_assert(__STDC_VERSION__ >= 201112L, "You need at least C11!")
```

## Hàm

Bạn cần chỉ định kiểu trả về và kiểu tham số cho hàm, thân hàm đặt
trong block sau đó.

Biến trong hàm là local với hàm đó.

``` {.c}
// Hàm cộng hai số

int add(int x, int y)
{
    int sum = x + y;

    return sum;
}
```

Hàm không return gì nên có kiểu trả về `void`. Hàm không nhận tham
số nên có `void` làm danh sách tham số.

``` {.c}
// Toàn tác dụng phụ, mọi lúc!

void foo(void)
{
    some_global = 12;
    printf("Here we go!\n");
}
```

### Hàm `main()`

Đây là hàm chạy khi bạn bắt đầu chương trình. Nó sẽ ở một trong các
dạng sau:

``` {.c}
int main(void)
int main(int argc, char *argv[])
```

Dạng đầu bỏ qua mọi tham số command line.

Dạng thứ hai lưu số lượng tham số command line vào `argc`, và lưu
chính các tham số đó thành mảng chuỗi trong `argv`. Cái đầu tiên,
`argv[0]`, thường là tên của file thực thi. Con trỏ `argv` cuối cùng
có giá trị `NULL`.

Giá trị trả về thường xuất hiện thành exit status code trong OS.
Nếu không có `return`, chạy hết `main()` được ngầm coi là
`return 0`^[Lưu ý ngầm định này chỉ áp dụng cho `main()`, không áp
dụng cho bất cứ hàm nào khác.].

### Hàm Variadic

Một số hàm có thể nhận số lượng tham số biến đổi. Mọi hàm đều phải
có ít nhất một tham số. Các tham số còn lại được chỉ định bằng `...`
và có thể đọc qua các macro `va_start()`, `va_arg()`, và `va_end()`.

Đây là ví dụ cộng số lượng biến đổi các giá trị integer.

``` {.c}
int add(int count, ...)
{
    int total = 0;
    va_list va;

    va_start(va, count);   // Bắt đầu với tham số sau "count"

    for (int i = 0; i < count; i++) {
        int n = va_arg(va, int);   // Lấy int kế tiếp

        total += n;
    }

    va_end(va);  // Xong

    return total;
}
```
