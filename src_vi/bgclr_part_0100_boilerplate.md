# Foreword
<!-- Beej's guide to C
# vim: ts=4:sw=4:nosi:et:tw=72
-->

<!-- No hyphenation -->
[nh[scalbn]]
[nh[scalbnf]]
[nh[scalbnl]]
[nh[scalbln]]
[nh[scalblnf]]
[nh[scalblnl]]
<!-- Can't do things that aren't letters
[nh[atan2]]
[nh[atan2f]]
[nh[atan2l]]
-->
[nh[lrint]]
[nh[lrintf]]
[nh[lrintl]]
[nh[llrint]]
[nh[llrintf]]
[nh[llrintl]]
[nh[lround]]
[nh[lroundf]]
[nh[lroundl]]
[nh[llround]]
[nh[llroundf]]
[nh[llroundl]]

<!-- Index see alsos -->
[is[String==>see `char *`]]
[is[New line==>see `\n` newline]]
[is[Ternary operator==>see `?:` ternary operator]]
[is[Addition operator==>see `+` addition operator]]
[is[Subtraction operator==>see `-` subtraction operator]]
[is[Multiplication operator==>see `*` multiplication operator]]
[is[Division operator==>see `/` division operator]]
[is[Modulus operator==>see `%` modulus operator]]
[is[Boolean NOT==>see `!` operator]]
[is[Boolean AND==>see `&&` operator]]
[is[Boolean OR==>see `||` operator]]
[is[Bell==>see `\a` operator]]
[is[Tab (is better)==>see `\t` operator]]
[is[Carriage return==>see `\r` operator]]
[is[Hexadecimal==>see `0x` hexadecimal]]

Cánh cửa từ từ kẽo kẹt mở ra, để lộ một hành lang dài với những chồng
sách truyền thuyết phủ bụi...

Thôi, có lẽ không phải vậy đâu.

Nhưng bạn đã tìm ra phần Tham chiếu Thư viện (Library Reference) của
Beej's Guide to C!

Đây không phải một tutorial, mà là một bộ manual page đầy đủ (hay
_man page_ theo kiểu gọi của mấy dân Unix), định nghĩa _mọi_ hàm
trong Thư viện chuẩn C, kèm ví dụ.

> _"Thưa ngài, cuốn này chứa mọi chữ của thứ tiếng mà chúng ta yêu
> quý."_\
> _"Từng chữ một, thưa ngài?"_\
> _"Từng chữ một, thưa ngài!"_\
> _"Ồ, vậy thì, thưa ngài, tôi mong ngài không phiền nếu tôi cũng gửi
> đến vị bác sĩ lời chúc phản-miếng-bánh-ngụm (contrafribularities)
> nồng nhiệt nhất của mình."_
>
> ---Blackadder trêu Tiến sĩ Samuel Johnson

Thực ra có một số hàm bị bỏ ngoài guide này, đáng chú ý nhất là mấy
hàm "safe" tuỳ chọn (có hậu tố `_s`).

Nhưng mọi thứ bạn có thể muốn thì chắc chắn đều có ở đây. Kèm ví dụ.

Chắc vậy.

## Đối tượng

Guide này dành cho người đã thạo C ở mức kha khá.

Nếu bạn chưa thuộc nhóm đó mà muốn trở thành, tôi xin hết lòng, hoàn
toàn không thiên vị, giới thiệu cuốn
[fl[_Beej's Guide to C Programming_|https://beej.us/guide/bgc/]], có
sẵn miễn phí ở bất cứ đâu Internet được bán.

## Cách đọc cuốn này

Dùng mục lục hoặc index để tìm hàm hoặc chủ đề bạn cần.

Rồi lấy một tô ngũ cốc yêu thích ra, và chén thoải mái đống chữ nghĩa
ngon lành trong đây.

## Nền tảng và Compiler

Tôi sẽ cố bám vào [flw[ISO-standard C|ANSI_C]] cổ điển. Ừ, phần lớn
là vậy. Thi thoảng tôi có thể nổi hứng nói về
[flw[POSIX|POSIX]] hay gì đó, để xem đã.

**Unix** (Linux, BSD, v.v.) thử gõ `cc` hoặc `gcc` ngoài command
line, có thể bạn đã có sẵn compiler rồi. Nếu chưa, tìm cách cài `gcc`
hoặc `clang` trên distro của bạn.

**Windows** thử [fl[Visual Studio
Community|https://visualstudio.microsoft.com/vs/community/]]. Hoặc,
nếu bạn muốn trải nghiệm kiểu Unix (khuyến khích!), cài
[fl[WSL|https://docs.microsoft.com/en-us/windows/wsl/install-win10]]
rồi cài `gcc`.

**Mac** thì cài
[fl[XCode|https://developer.apple.com/xcode/]], nhớ bật command line
tools.

Có rất nhiều compiler, và hầu như cái nào cũng dùng được cho cuốn
này. Và compiler C++ sẽ compile được khá nhiều code C (nhưng không
phải tất cả!). Tốt nhất là dùng compiler C thực thụ nếu có.

## Trang chủ chính thức

Địa chỉ chính thức của tài liệu này là
[fl[`https://beej.us/guide/bgclr/`|https://beej.us/guide/bgclr/]].
Trước đây ở đây có một ghi chú về việc di chuyển khỏi máy chủ ở Chico
State (trường cũ của tôi), nhưng đó là chuyện tỷ năm trước rồi và
câu chữ vẫn còn đây chỉ vì nó được copy từ Network Guide sang, [_hít
thở_] mà tôi đã khá lâu rồi không đọc lại toàn bộ.

Hết chuyện.

## Chính sách Email

Nói chung tôi luôn sẵn lòng giúp trả lời câu hỏi qua email, cứ viết
thoải mái, nhưng tôi không đảm bảo sẽ trả lời. Tôi sống khá bận, có
những lúc đơn giản là không trả lời nổi. Những lúc đó tôi thường xoá
luôn tin nhắn. Không phải chuyện cá nhân gì đâu; chỉ là tôi không bao
giờ đủ thời gian để đưa ra câu trả lời chi tiết mà bạn cần.

Theo kinh nghiệm, câu hỏi càng phức tạp, tôi càng ít khả năng trả
lời. Nếu bạn chịu khó thu hẹp câu hỏi trước khi gửi, và nhớ kèm mọi
thông tin liên quan (như nền tảng, compiler, các thông báo lỗi bạn
gặp, và bất cứ gì bạn nghĩ sẽ giúp tôi debug), bạn có cơ hội được
trả lời cao hơn nhiều.

Nếu bạn không được trả lời, cứ cày thêm, thử tự tìm ra đáp án, và
nếu nó vẫn lẩn trốn, hãy viết lại cho tôi với thông tin bạn đã thu
thập được, và hy vọng chừng đó là đủ để tôi giúp được.

Giờ khi đã cằn nhằn bạn về cách nên và không nên viết thư cho tôi,
tôi cũng muốn nói là tôi _hết sức_ trân trọng mọi lời khen mà cuốn
guide nhận được qua nhiều năm nay. Đó là một liều tinh thần thực sự,
và tôi mừng khi biết nó đang được dùng cho mục đích tốt! `:-)` Cảm
ơn nhé!

## Mirror

Bạn hoàn toàn được hoan nghênh mirror trang này, dù công khai hay
riêng tư. Nếu bạn mirror công khai và muốn tôi link tới từ trang
chính, gửi cho tôi một dòng ở
[`beej@beej.us`](mailto:beej@beej.us).

## Ghi chú cho người dịch

Nếu bạn muốn dịch guide sang ngôn ngữ khác, viết cho tôi ở
[`beej@beej.us`](beej@beej.us) và tôi sẽ link tới bản dịch của bạn
từ trang chính. Bạn có thể thêm tên và thông tin liên hệ của mình
vào bản dịch.

Lưu ý các ràng buộc giấy phép ở mục Bản quyền và Phân phối bên dưới.

## Bản quyền và Phân phối

Beej's Guide to C Programming, Library Reference là Copyright ©
2021 Brian "Beej Jorgensen" Hall.

Với một số ngoại lệ cụ thể cho source code và bản dịch (xem bên
dưới), tác phẩm này được cấp phép theo Creative Commons
Attribution-Noncommercial-No Derivative Works 3.0 License. Để xem
bản sao của giấy phép, vào
[`https://creativecommons.org/licenses/by-nc-nd/3.0/`](https://creativecommons.org/licenses/by-nc-nd/3.0/)
hoặc gửi thư tới Creative Commons, 171 Second Street, Suite 300, San
Francisco, California, 94105, USA.

Một ngoại lệ cụ thể đối với phần "No Derivative Works" của giấy
phép là: guide này có thể được dịch tự do sang bất cứ ngôn ngữ nào,
miễn là bản dịch chính xác và guide được in lại trọn vẹn. Các ràng
buộc giấy phép áp dụng cho bản dịch giống như với bản gốc. Bản dịch
cũng có thể kèm tên và thông tin liên hệ của người dịch.

Source code C xuất hiện trong tài liệu này được tuyên bố đưa vào
public domain, hoàn toàn không bị ràng buộc giấy phép.

Các nhà giáo dục được khuyến khích tự do giới thiệu hoặc cung cấp
bản sao của guide này cho học viên của mình.

Liên hệ [`beej@beej.us`](beej@beej.us) để biết thêm.

## Lời đề tặng

Những chuyện khó nhất khi viết mấy cuốn guide này là:

* Học đủ sâu để có thể giải thích được
* Tìm ra cách giải thích sao cho rõ, một quá trình lặp đi lặp lại
  tưởng chừng vô tận
* Đặt mình ra đó như một cái gọi là _chuyên gia_, trong khi thực ra
  tôi chỉ là một con người bình thường đang cố hiểu mọi thứ, giống
  mọi người khác
* Giữ lửa với nó khi nhiều thứ khác cứ đòi sự chú ý của tôi

Rất nhiều người đã giúp tôi qua quá trình này, và tôi muốn ghi công
những ai đã góp phần làm nên cuốn sách này.

* Mọi người trên Internet đã quyết định chia sẻ kiến thức của mình
  theo cách này hay cách khác. Việc chia sẻ kiến thức hướng dẫn một
  cách tự do chính là thứ làm nên một Internet tuyệt vời như ta
  thấy.
* Các tình nguyện viên ở
  [fl[cppreference.com|https://en.cppreference.com/]], những người
  xây cây cầu nối từ spec sang thực tế.
* Những người tốt bụng và hiểu biết ở
  [fl[comp.lang.c|https://groups.google.com/g/comp.lang.c]] và
  [fl[r/C_Programming|https://www.reddit.com/r/C_Programming/]],
  những người đã kéo tôi qua các phần khó của ngôn ngữ.
* Tất cả những ai đã gửi corrections và pull-request cho đủ thứ từ
  hướng dẫn gây hiểu lầm đến lỗi chính tả.

Cảm ơn! ♥
