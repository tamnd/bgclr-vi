#!/usr/bin/env bash
# Emit a simple landing page at $DOCSDIR/index.html with download links.

set -euo pipefail

DOCSDIR="${1:-docs}"
PACKAGE="${PACKAGE:-bgclr}"

cat > "$DOCSDIR/index.html" <<'HTML'
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Tham chiếu Thư viện C của Beej (bản tiếng Việt)</title>
<style>
  body { font-family: -apple-system, "Segoe UI", Roboto, sans-serif; max-width: 48rem; margin: 2rem auto; padding: 0 1rem; line-height: 1.55; color: #222; }
  h1 { margin-bottom: 0.2rem; }
  .sub { color: #666; margin-top: 0; }
  h2 { margin-top: 2rem; border-bottom: 1px solid #ddd; padding-bottom: 0.2rem; }
  ul { padding-left: 1.2rem; }
  li { margin: 0.25rem 0; }
  code { background: #f4f4f4; padding: 0 0.25rem; border-radius: 3px; }
  a { color: #0366d6; }
  footer { margin-top: 3rem; color: #888; font-size: 0.9rem; }
  @media (prefers-color-scheme: dark) {
    body { background: #111; color: #eee; }
    .sub { color: #aaa; }
    h2 { border-color: #333; }
    code { background: #222; }
    a { color: #58a6ff; }
    footer { color: #888; }
  }
</style>
</head>
<body>
<h1>Tham chiếu Thư viện C của Beej</h1>
<p class="sub">Bản dịch tiếng Việt, dịch từ <a href="https://beej.us/guide/bgclr/">Beej's Guide to C Programming, Library Reference</a>.</p>

<h2>Đọc trực tuyến</h2>
<ul>
  <li><a href="html/index.html">HTML, một trang (độ rộng tiêu chuẩn)</a></li>
  <li><a href="html/index-wide.html">HTML, một trang (rộng hơn cho màn hình lớn)</a></li>
  <li><a href="html/split/">HTML, chia theo chương</a></li>
  <li><a href="html/split-wide/">HTML, chia theo chương (rộng)</a></li>
</ul>

<h2>Tải về</h2>
<ul>
  <li><a href="html/bgclr.zip">bgclr.zip</a> — toàn bộ HTML chia theo chương (đóng gói)</li>
  <li><a href="html/bgclr-wide.zip">bgclr-wide.zip</a> — cùng nội dung, bản rộng</li>
  <li><a href="epub/bgclr.epub">bgclr.epub</a> — EPUB cho trình đọc sách điện tử</li>
  <li>
    PDF in (US Letter):
    <a href="pdf/bgclr_usl_c_1.pdf">color, một mặt</a> ·
    <a href="pdf/bgclr_usl_c_2.pdf">color, hai mặt</a> ·
    <a href="pdf/bgclr_usl_bw_1.pdf">đen trắng, một mặt</a> ·
    <a href="pdf/bgclr_usl_bw_2.pdf">đen trắng, hai mặt</a>
  </li>
  <li>
    PDF in (A4):
    <a href="pdf/bgclr_a4_c_1.pdf">color, một mặt</a> ·
    <a href="pdf/bgclr_a4_c_2.pdf">color, hai mặt</a> ·
    <a href="pdf/bgclr_a4_bw_1.pdf">đen trắng, một mặt</a> ·
    <a href="pdf/bgclr_a4_bw_2.pdf">đen trắng, hai mặt</a>
  </li>
  <li><a href="source/bgclr_source.zip">bgclr_source.zip</a> — mã nguồn ví dụ C</li>
</ul>

<h2>Về bản dịch</h2>
<p>
  Nội dung tiếng Việt nằm trong thư mục <code>src_vi/</code> của
  <a href="https://github.com/tamnd/bgclr-vi">repo</a>. Bản gốc tiếng Anh và
  các tài liệu đi kèm thuộc bản quyền của Brian "Beej Jorgensen" Hall, phát hành
  theo giấy phép CC BY-NC-ND 3.0. Bản dịch cũng theo giấy phép đó.
</p>

<footer>
  Dịch bởi Duc-Tam Nguyen. Nguồn trên GitHub:
  <a href="https://github.com/tamnd/bgclr-vi">tamnd/bgclr-vi</a>.
</footer>
</body>
</html>
HTML

echo "==> Wrote $DOCSDIR/index.html"
