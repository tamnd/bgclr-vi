# Beej's Guide to C Programming, Library Reference (Bản tiếng Việt)

> Tiếng Việt &middot; [English](README.en.md)

Bản dịch tiếng Việt của [Beej's Guide to C Programming, Library
Reference][bgclr], tác giả Brian "Beej Jorgensen" Hall. Đây là tập đi
kèm của [Beej's Guide to C Programming][bgc], tập trung vào tra cứu
thư viện chuẩn C: từng hàm, từng macro, từng kiểu. Đọc miễn phí, chia
sẻ thoải mái, giống hệt bản gốc.

> Bạn đang viết C thật và cần biết `strtod()` trả về gì khi overflow?
> Hay `fenv_t` có gì bên trong? Hay `memcpy()` khác `memmove()` chỗ
> nào? Cuốn này là chỗ mở ra khi stdlib cắn bạn.

[bgclr]: https://beej.us/guide/bgclr/
[bgc]: https://beej.us/guide/bgc/

## Có hợp với tôi không?

Hợp nếu bạn đã biết C ở mức dùng được và muốn tra cứu thư viện chuẩn
bằng tiếng Việt. Nếu còn đang học C từ đầu, hãy đọc
[Hướng dẫn Lập trình C][bgc-vi] trước, rồi quay lại đây khi cần tra
hàm cụ thể.

Nếu bạn đọc tiếng Anh thoải mái, cứ [đọc bản gốc][bgclr], nó ở ngay
đó thôi.

[bgc-vi]: https://github.com/tamnd/bgc-vi

## Bạn sẽ tra được gì

Ba mươi hai chương, mỗi header thư viện chuẩn C một chương. Từ
`<assert.h>` đến `<wctype.h>`, đi qua `<stdio.h>`, `<stdlib.h>`,
`<string.h>`, `<math.h>`, `<time.h>`, `<threads.h>`, `<stdatomic.h>`,
`<stdbit.h>` (C23), và mọi header khác. Danh sách đầy đủ ở
[ROADMAP.md](ROADMAP.md).

## Tình trạng

Đường ống build đã dựng sẵn nhưng CI đang tạm tắt trong lúc marathon
dịch diễn ra, để tránh build đi build lại khi mỗi chương merge. Sau
khi 32 chương dịch xong, CI/CD sẽ được bật lại và bản release đầu
tiên được cắt. Theo dõi tiến độ ở [ROADMAP.md](ROADMAP.md) hoặc
[các PR đã merge](https://github.com/tamnd/bgclr-vi/pulls?q=is%3Apr+is%3Amerged).

## Bố cục repo

```
bgclr-vi/
├── src/         # Bản gốc tiếng Anh (lấy từ upstream, không sửa)
├── src_vi/      # Bản dịch tiếng Việt (phần hay ho ở đây)
├── source/      # Chương trình C mẫu (giữ nguyên từ upstream)
├── translations/# Các bản dịch ngôn ngữ khác có sẵn từ upstream
├── website/     # Tài nguyên website của upstream
├── scripts/     # Build helper, release helper
├── bgbspd/      # Submodule build system dùng chung của Beej
├── ROADMAP.md   # Kế hoạch và tiến độ dịch
├── UPSTREAM.md  # Đang bám upstream ở commit nào
├── LICENSE.md   # CC BY-NC-ND 3.0, giống upstream
└── README.md    # Bạn đang ở đây
```

Mỗi chương đã dịch trong `src_vi/` tương ứng một-một với file trong
`src/`, cùng tên file và cùng section anchor. Diff hai file là cách
đơn giản nhất để phát hiện chỗ lệch.

## Cách đọc

**Trên web:** sẽ có tại <https://tamnd.github.io/bgclr-vi/> sau khi
marathon dịch xong và CI được bật lại.

**Offline:** tải file ở trang
[Releases](https://github.com/tamnd/bgclr-vi/releases) sau lần cắt
release đầu tiên (PDF, EPUB, HTML zip, source code). Hoặc đọc thẳng
markdown trong `src_vi/`, GitHub render vẫn ổn.

**Tự build:** xem [Build](#build) bên dưới.

## Đóng góp

Pull request luôn được chào đón. Vài quy tắc để giữ văn bản dễ đọc:

- **Mỗi PR một chương.** Đừng gộp. PR nhỏ được merge nhanh, PR lớn
  nằm đó.
- **Dịch ý, không dịch chữ.** Nếu bản dịch nguyên văn đọc như máy
  viết, viết lại. Giọng Beej đời thường, giọng bạn cũng nên vậy.
- **Không dịch máy.** Nghiêm túc đấy. Đọc là biết liền.
- **Giữ nguyên code block, tên hàm, tên biến, tên header, từ khoá C
  bằng tiếng Anh.** `malloc()` vẫn là `malloc()`. `<stdio.h>` vẫn là
  `<stdio.h>`.
- **Lần đầu xuất hiện một thuật ngữ kỹ thuật:** viết tiếng Anh trước,
  tiếng Việt trong ngoặc nếu có ích. Các lần sau có thể bỏ tiếng Việt.
- **Không dùng em dash trong văn xuôi tiếng Việt.** Viết lại câu hoặc
  dùng dấu phẩy.
- **Giữ nguyên section anchor.** Tiếng Anh là `{#stdio}` thì tiếng
  Việt cũng `{#stdio}`.
- **Giữ nguyên các tag index `[i[...]]`, `[fl[...]]`, `[flw[...]]`,
  `[nh[...]]`.** Chúng là chỉ mục của sách in.

### Quy trình

1. Chọn một chương trong [ROADMAP.md](ROADMAP.md) đang ghi
   "not started".
2. Mở issue nói bạn đang nhận chương đó, tránh trùng việc.
3. Tạo nhánh: `translate/<slug-chương>` (ví dụ `translate/stdio`).
4. Copy `src/bgclr_part_NNNN_<slug>.md` sang `src_vi/` với cùng tên
   file. Dịch trực tiếp trên đó.
5. Mở PR vào nhánh `main`. Cập nhật trạng thái chương trong ROADMAP.
6. Chờ review. Mục tiêu là văn bản đọc như một developer người Việt
   tự viết từ đầu.

## Build

Repo dùng cùng hệ thống build như upstream (`bgbspd`, `pandoc`,
`xelatex`), đóng gói sẵn trong image `ghcr.io/tamnd/beej-vi-docker`.

Build cục bộ qua Docker hoặc Podman:

```
./scripts/build_vi_docker.sh
```

Thư mục `docs/` sẽ chứa HTML, PDF, EPUB và landing page, giống hệt
bản sẽ deploy trên GitHub Pages sau này.

Build thủ công, không dùng container: xem `scripts/build_vi.sh` để
biết các bước (cần `pandoc`, `texlive-xetex`, `python3`, `make`,
`zip`, `imagemagick`, `fonts-libertinus`).

## Đồng bộ với upstream

Commit upstream mà bản dịch này bám theo được ghi trong
[UPSTREAM.md](UPSTREAM.md).

Khi upstream có cập nhật, chúng tôi đồng bộ lại `src/` theo upstream,
rồi diff sẽ cho biết chương dịch nào cần chỉnh. Nếu bạn phát hiện
lệch, mở issue.

## Ghi công

- **Tài liệu gốc:** Brian "Beej Jorgensen" Hall, 2007 đến nay,
  https://beej.us/guide/bgclr/
- **Bản dịch tiếng Việt:** Duc-Tam Nguyen (tamnd@liteio.dev) và
  [cộng đồng đóng góp](https://github.com/tamnd/bgclr-vi/graphs/contributors)

## Giấy phép

[CC BY-NC-ND 3.0](LICENSE.md), giống upstream. Bạn được đọc, được
chia sẻ, và được dịch. Bạn không được bán hay tạo tác phẩm phái sinh
(trừ bản dịch, upstream cho phép rõ ràng). Code trong tài liệu là
public domain.

Toàn văn: [LICENSE.md](LICENSE.md) &middot; [trang của Creative
Commons](https://creativecommons.org/licenses/by-nc-nd/3.0/).
