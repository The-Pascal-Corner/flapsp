# Hướng dẫn sử dụng FLAPSP

> Tuyển tập game Flash cho PSP OFW.

---

## Yêu cầu

- PSP 1000 / 2000 / 3000 / Go / Street (OFW hoặc CFW)
- Adobe Flash Player đã kích hoạt (Settings → System Settings → Enable Flash Player)
- Thẻ nhớ Memory Stick (còn trống ~100MB)

## Cài đặt

```bash
# 1. Kết nối PSP với máy tính qua USB, chọn USB Mode
# 2. Copy folder FLAPSP/ vào root thẻ nhớ

cp -r FLAPSP/ /path/to/psp/

# Kết quả:
#   ms0:/FLAPSP/menu.html
#   ms0:/FLAPSP/roms/Adapt.swf
#   ...
```

## Sử dụng

1. Trên PSP, mở **Internet Browser**
2. Cancel nếu nó tự động tìm access point
3. Nhập URL: `file:/FLAPSP/menu.html`
4. **Bookmark** trang để truy cập nhanh (△ → Add to Bookmarks)

### Tính năng

| Thành phần | Chức năng |
|---|---|
| **Search** | Gõ tên game — lọc real-time |
| **↻** | Reload + cache-busting |
| **Game list** | Click vào tên game → mở trong tab hiện tại |

### Mẹo

- **Không bị thoát game khi bấm vai:** Dùng Triangle → "Open link in new tab"
- **Game chạy chậm:** PSP 1000 (32 MB RAM) / 2000-3000 (64 MB RAM). Game PSP-native chạy mượt hơn
- **Bookmark:** Lưu `file:/FLAPSP/menu.html` vào bookmark (△ → Add to Bookmarks)

## Thêm / Xóa game

```bash
# 1. Copy .swf vào FLAPSP/roms/
# 2. Chạy script để quét lại
powershell -ExecutionPolicy Bypass -File FLAPSP/generate.ps1
# 3. Copy lại FLAPSP/ vào PSP
```

Script sẽ tự động:
- Quét tất cả `.swf` trong `roms/`
- Sinh file `menu.html` với danh sách mới

## Điều kiện game chạy trên PSP

| Yếu tố | Yêu cầu |
|---|---|
| Định dạng | `.swf` (Shockwave Flash) |
| ActionScript | **AS1 / AS2** |
| Kích thước | ≤ 10MB (PSP 2000/3000); ≤ 5MB (PSP 1000) |
| Phiên bản Flash | Flash 8 trở xuống |
| Điều khiển | Bàn phím / click đơn giản (không drag-drop phức tạp) |

## Game không chạy được

- Dùng **ActionScript 3.0** (đa số game Flash từ 2009+)
- Cần chuột / drag-drop phức tạp
- Dung lượng > 15 MB
- File không phải `.swf` (HTML5, Unity WebGL, .exe)

## Xử lý lỗi

**"The content cannot be displayed."**
→ Kiểm tra: folder `FLAPSP` phải ở **root** thẻ nhớ, đường dẫn đúng `file:/FLAPSP/menu.html`

**"Cannot load Flash"**
→ Settings → System Settings → Enable Flash Player (cần Internet 1 lần)

**Menu không hiển thị game đúng**
→ Chạy lại `generate.ps1` để quét lại `roms/`

## Generator (`generate.ps1`)

Script PowerShell tự động:
1. Quét tất cả `.swf` trong `roms/`
2. Sinh `menu.html` với danh sách game nhúng trực tiếp

```powershell
.\generate.ps1
# hoặc
powershell -ExecutionPolicy Bypass -File generate.ps1
```
