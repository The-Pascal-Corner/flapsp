# Hướng dẫn Đóng góp

Vui lòng đọc kỹ trước khi bắt đầu đóng góp.

---

## 1. Thiết lập môi trường

```bash
git clone https://github.com/The-Pascal-Corner/flapsp.git
cd flapsp
powershell -File FLAPSP/generate.ps1
```

## 2. Quy trình gửi đóng góp

1. **Fork** dự án về tài khoản cá nhân
2. **Tạo Branch mới:**
   - Thêm game: `feat/ten-game`
   - Sửa lỗi: `fix/ten-loi`
   - Tài liệu: `docs/ten-tai-lieu`
3. **Commit** rõ nghĩa (tiếng Việt hoặc tiếng Anh)
4. **Push & PR** lên GitHub

## 3. Quy chuẩn viết mã

- **HTML + JS:** Tương thích PSP browser — chỉ dùng ES3 (`var`, `function`, `for`, `indexOf`). Không `let`, `const`, arrow function, `forEach`, `addEventListener`
- **CSS:** Tránh `display:flex`, `grid`
- **Script (`generate.ps1`):** PowerShell 5.1+, cmdlet có sẵn

## 4. Kiểm thử

```bash
powershell -File FLAPSP/generate.ps1
```

Sau đó mở `FLAPSP/menu.html` trên trình duyệt để kiểm tra danh sách game và search.

### Kiểm tra trên PSP thật

Copy `FLAPSP/` vào **root** thẻ nhớ PSP, mở `file:/FLAPSP/menu.html`

## Liên hệ

- [Mở Issue](https://github.com/The-Pascal-Corner/flapsp/issues)
- [Discussions](https://github.com/The-Pascal-Corner/flapsp/discussions)
