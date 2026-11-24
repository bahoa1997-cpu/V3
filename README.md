# Offline TV 2.0 - Android TV

Nâng cấp từ v1.0, giữ nguyên package vn.offlinetv.player và giao diện nền tối, menu trái, lưới video 3 cột. Android 6 trở lên.

## Tính năng mã nguồn
- MediaStore và thư mục USB qua trình chọn thư mục Android; quét thủ công.
- Tìm theo tên, yêu thích, xem tiếp, lịch sử, xem sau, kênh/playlist, nhóm thư mục SAF.
- Nhấn giữ OK trên thẻ video để mở menu: yêu thích, xem sau, thêm/bỏ khỏi kênh, đổi tên hiển thị, ẩn video.
- Cài đặt sắp xếp, tự động phát, ngẫu nhiên, lặp, hiện lại video ẩn, xóa lịch sử, xóa cache ảnh.
- Trình phát: tua 10 giây, tốc độ, chọn track âm thanh/phụ đề tích hợp (tùy thiết bị), hẹn giờ dừng, đánh dấu vị trí, phát tiếp.
- Cache ảnh RAM tối đa 12 MiB; tạo ảnh tối đa 120 video mỗi lần hiển thị.
- Không yêu cầu Internet, không quảng cáo, không tài khoản.

## Chưa triển khai
SMB/NAS/DLNA, điều khiển điện thoại, hồ sơ/PIN, phụ đề rời, xem trước động, nhận diện phim bộ, thống kê, sao lưu, tự quét USB, ảnh bìa tùy chỉnh, đề xuất thông minh. Hỗ trợ 4K/HDR/codec tùy trình phát hệ thống và phần cứng. Chưa kiểm thử TV hoặc biên dịch APK.

## Tạo APK
Mở thư mục dự án trong Android Studio, JDK 17, Android SDK 35, Gradle 8.9. Chọn Build > Generate APKs hoặc chạy gradle assembleDebug. APK tại app/build/outputs/apk/debug/app-debug.apk.
Hoặc tải toàn bộ nội dung dự án (bao gồm .github) lên GitHub, chạy workflow Build APK trong Actions, tải artifact OfflineTV-APK và giải nén. Muốn cập nhật đè lên v1.0 cần dùng cùng khóa ký APK; nếu khác khóa, phải gỡ bản cũ (mất dữ liệu cài đặt).

## GitHub Actions - tu dong tao APK (CI)

1. Tao repository GitHub (co the de Private), nhanh main.
2. Giai nen ZIP, mo thu muc OfflineTV-v2 va dua TOAN BO noi dung len thu muc goc repository, bao gom .github/workflows/build.yml. Khong chi tai ZIP len.
3. Vao Actions > Build APK > Run workflow > Run workflow. Neu GitHub yeu cau, bat Actions trong Settings > Actions > General. Moi lan push vao main/master cung tu dong build.
4. Mo lan chay thanh cong, muc Artifacts > OfflineTV-APK. Giai nen artifact de lay OfflineTV-2.0.apk, SHA256SUMS.txt va apk-info.txt.
5. Sao chep APK vao USB, cai dat tren Android TV.

Workflow tu cai JDK 17, Android SDK 35, Build Tools 35.0.0, Gradle 8.9; build, lint, kiem tra chu ky va SHA-256. Khong can Android Studio tren may tinh neu dung GitHub Actions.

### Khoa ky co dinh (tuy chon, khuyen dung)

Neu khong co secrets, APK duoc ky debug bang khoa tam thoi cua runner. Ban cap nhat co the khong cai de duoc. De giu cung chu ky qua cac lan build, tao khoa rieng bang JDK keytool (Windows: chay tools/create-signing-key.ps1, nhap mat khau theo huong dan). Trong GitHub Settings > Secrets and variables > Actions > New repository secret, tao 4 secrets:

- ANDROID_KEYSTORE_BASE64: chuoi Base64 cua file JKS (script da copy clipboard).
- ANDROID_KEYSTORE_PASSWORD: mat khau kho khoa.
- ANDROID_KEY_ALIAS: offlinetv.
- ANDROID_KEY_PASSWORD: mat khau khoa.

Sao luu JKS va mat khau an toan; khong commit khoa vao repo. Neu da cai APK ky bang khoa khac, can go ban cu truoc (mat du lieu). APK van la ban debug, khong phai ban phat hanh Play Store.

Cau hinh CI chua duoc chay tren GitHub trong moi truong nay.

CI fix: setup-android v4 with packages: platform-tools, avoiding the obsolete tools package.


Java build fix: explicit Java 17 compileOptions and explicit LruCache type arguments. The workflow uploads Java-build-log even on compilation failure. Android build and device testing remain unverified.
