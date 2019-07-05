## Internationalization and Localization

### Mục tiêu:

- User sử dụng nhiều ngôn ngữ trong cùng một app.
- Layout linh hoạt thay đổi theo chiều trái sang phải và phải sang trái.
- Sử dụng built trong xliff generator.
- Không sử dụng nhiều story board.
- Đơn giản.

### Ví dụ

- Sử dụng:
  - English
  - Arabic

### Localization trong file `.xib` với `.lproj`

- Đầu tiên chọn `Use Base Internationalization`.

<center>
    <img src="./Images/InternationalizationLocalization-1.png" width="500">
</center>

- `Base.lproj`:
  - Lần đầu tiên khi khởi tạo project mới, XCode tự động tạo các resource và file structure, trong đó bao gồm cả default language.
  - `Base.lproj` chứa các resource liên quan đến base language.
- Tương tự:
  - `ar.lproj` chứa các resource liên quan đến tiếng Ả rập.
  - `en.lproj` chứa các resource liên quan đến tiếng Anh

<center>
    <img src="./Images/InternationalizationLocalization-2.png" width="400">
</center>

- Nhấn vào nút `+` để thêm ngôn ngữ mà ta muốn support

<center>
    <img src="./Images/InternationalizationLocalization-3.png" width="400">
</center>

- Tạo một view controller mới có file `.xib`:

<center>
    <img src="./Images/InternationalizationLocalization-4.png" width="500">
</center>

- Chọn `Localize...` cho cả `Base`, `English` và `Arabic` để tạo ra các resource giành riêng cho mỗi language. Trong đó, setting cho `English` và `Arabic` sử dụng `Localizable Strings` thay vì `Interface Builder Cocoa Touch XIB`.
- Như vậy:
  - File `.xib` giờ sẽ nằm ở `Base.lproj`
  - Hai file `.string` sẽ nằm ở `ar.lproj` và `en.lpoj`

<center>
    <img src="./Images/InternationalizationLocalization-5.png" width="400">
</center>

<center>
    <img src="./Images/InternationalizationLocalization-6.png" width="500">
</center>

- Sửa các string trong file strings ở `ar.lproj` như trên.
- Chạy thử app và đổi app language bằng cách edit scheme:

<center>
    <img src="./Images/InternationalizationLocalization-7.png" width="250">
</center>

<center>
    <img src="./Images/InternationalizationLocalization-8.png" width="400">
</center>

- Kết qủa thu được như sau:

| Arabic | English |
|---|---|
| <img src="./Images/InternationalizationLocalization-9.png" width="250"> | <img src="./Images/InternationalizationLocalization-10.png" width="250"> |

### More

Quay lại [Daijobu Project][Daijobu]

### Reference

[Working with Internationalization and Localization in swift] [Reference 1]

[Daijobu]: https://github.com/nmint8m/daijobu

[Reference 1]: https://medium.com/if-let-swift-programming/working-with-localization-in-swift-4a87f0d393a4