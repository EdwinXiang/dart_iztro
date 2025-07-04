# dart_iztro

[English](README.md) | [简体中文](README.zh_CN.md) | [繁體中文](README.zh_TW.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [ภาษาไทย](README.th.md) | [Tiếng Việt](README.vi.md)

Plugin Flutter đa nền tảng cho việc tính toán tử vi Trung Quốc (紫微斗數) và phép tính Bát Tự (八字). Cung cấp các chức năng tính toán biểu đồ sao Tử Vi và chuyển đổi giữa lịch âm và lịch dương. Phù hợp cho các ứng dụng phân tích vận mệnh, dự đoán và phân tích chiêm tinh.

> **Tuyên bố từ chối trách nhiệm**: Mã của dự án này được sửa đổi từ [@SylarLong/iztro](https://github.com/SylarLong/iztro). Xin cảm ơn tác giả gốc vì đóng góp mã nguồn mở của họ.

## Tính năng

- Tính toán ngày âm lịch từ ngày dương lịch
- Tính toán thông tin BaZi
- Tính toán thông tin biểu đồ Tử Vi Đẩu Số
- Cung cấp thông tin chi tiết cho mỗi cung trong biểu đồ
- Tính toán chính xác thời gian mặt trời thực (dựa trên thuật toán thiên văn học)
- Truy vấn vị trí địa lý với thông tin vĩ độ và kinh độ
- Hỗ trợ nhiều nền tảng: Android, iOS, macOS, Windows, Linux và Web
- Hỗ trợ đa ngôn ngữ: Tiếng Trung Giản thể, Tiếng Trung Phồn thể, Tiếng Anh, Tiếng Nhật, Tiếng Hàn, Tiếng Thái, Tiếng Việt
- Hỗ trợ tính tuổi theo truyền thống Trung Quốc (tuổi danh nghĩa)
- Hỗ trợ truy xuất dữ liệu bản đồ Thiên, Nhân, Địa trong Tử Vi Đẩu Số

## Cài đặt

```yaml
dependencies:
  dart_iztro: ^2.5.3
```

## Phương pháp cài đặt thay thế

Nếu bạn gặp vấn đề khi cài đặt từ pub.dev, bạn có thể cài đặt thông qua phụ thuộc Git:

```yaml
dependencies:
  dart_iztro:
    git:
      url: https://github.com/EdwinXiang/dart_iztro.git
      ref: v2.5.0
```

## Cách sử dụng

```dart
import 'package:dart_iztro/dart_iztro.dart';

// Tạo một thể hiện
final iztro = DartIztro();

// Nhận thông tin Bát Tự
final birthData = await iztro.calculateBaZi(
  year: 1990, 
  month: 1, 
  day: 1, 
  hour: 12, 
  minute: 0,
  isLunar: false, // Có phải là âm lịch không
  isLeap: true,   // Nếu là âm lịch, có điều chỉnh tháng nhuận không (mặc định là true)
  gender: Gender.male,
);

// Nhận lá số Tử Vi
final chart = await iztro.calculateChart(
  year: 1990, 
  month: 1, 
  day: 1, 
  hour: 12, 
  minute: 0,
  isLunar: false, // Có phải là âm lịch không
  isLeap: true,   // Nếu là âm lịch, có điều chỉnh tháng nhuận không (mặc định là true)
  gender: Gender.male,
);

// Thiết lập ngôn ngữ
// Hỗ trợ nhiều ngôn ngữ, mặc định là Tiếng Trung giản thể (zh_CN)
await iztro.setLanguage('en_US'); // Tiếng Anh
await iztro.setLanguage('zh_TW'); // Tiếng Trung phồn thể
await iztro.setLanguage('ja_JP'); // Tiếng Nhật
await iztro.setLanguage('ko_KR'); // Tiếng Hàn
await iztro.setLanguage('th_TH'); // Tiếng Thái
await iztro.setLanguage('vi_VN'); // Tiếng Việt

// In thông tin cung
print(chart.palaces);
```

### Tính thời gian mặt trời thực

Thư viện này cung cấp tính năng tính toán thời gian mặt trời thực chính xác, dựa trên thuật toán thiên văn học, có tính đến các yếu tố như hình dạng elip của quỹ đạo Trái Đất và độ nghiêng của trục Trái Đất:

```dart
import 'package:dart_iztro/utils/solar_time_util.dart';

// Tạo một đối tượng ngày giờ
final solarTime = SolarTime(
  2023, // Năm
  6,    // Tháng
  15,   // Ngày
  12,   // Giờ
  30,   // Phút
  0     // Giây
);

// Tạo một công cụ tính toán thời gian mặt trời, chỉ định kinh độ và vĩ độ của vị trí (Bắc Kinh)
final solarTimeUtil = SolarTimeUtil(
  longitude: 116.4074, // Kinh độ, dương cho phía đông, âm cho phía tây
  latitude: 39.9042    // Vĩ độ, dương cho phía bắc, âm cho phía nam
);

// Tính thời gian mặt trời trung bình
final meanSolarTime = solarTimeUtil.getMeanSolarTime(solarTime);

// Tính thời gian mặt trời thực
final realSolarTime = solarTimeUtil.getRealSolarTime(solarTime);

// Xuất kết quả
print('Thời gian mặt trời trung bình: ${meanSolarTime.toString()}');
print('Thời gian mặt trời thực: ${realSolarTime.toString()}');
```

### Truy vấn vị trí địa lý

Thư viện này cung cấp chức năng truy vấn vị trí địa lý, hỗ trợ tìm kiếm kinh độ và vĩ độ từ địa chỉ:

```dart
import 'package:dart_iztro/services/geo_lookup_service.dart';

// Tạo dịch vụ truy vấn vị trí địa lý
final geoService = GeoLookupService();

// Truy vấn địa chỉ
final location = await geoService.lookupAddress('Quận Haidian, Bắc Kinh');

if (location != null) {
  print('Địa chỉ: ${location.displayName}');
  print('Kinh độ: ${location.longitude}');
  print('Vĩ độ: ${location.latitude}');
}
```

### Mô tả tham số

- `year`, `month`, `day`, `hour`, `minute`: Năm, tháng, ngày, giờ và phút sinh
- `isLunar`: Có phải là ngày âm lịch không, mặc định là dương lịch (`false`)
- `isLeap`: Có hiệu lực khi `isLunar` là `true`, dùng để xử lý tình huống tháng nhuận
  - Khi đặt thành `true` (mặc định), nửa đầu của tháng nhuận được tính là tháng trước đó, nửa sau được tính là tháng tiếp theo
  - Khi đặt thành `false`, tháng nhuận không được điều chỉnh
- `gender`: Giới tính, sử dụng kiểu enum, giá trị có thể là `Gender.male` (nam) hoặc `Gender.female` (nữ)

## Thêm ví dụ

Để biết thêm ví dụ sử dụng, vui lòng xem ứng dụng mẫu trong thư mục example.

## Giấy phép

Dự án này được cấp phép theo giấy phép MIT - xem tệp [LICENSE](LICENSE) để biết chi tiết

Dự án này tuân theo cùng giấy phép mã nguồn mở như dự án gốc [@SylarLong/iztro](https://github.com/SylarLong/iztro). Nếu có bất kỳ vấn đề về bản quyền, vui lòng liên hệ với chúng tôi để giải quyết ngay lập tức.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/to/develop-plugins),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Hỗ trợ đa ngôn ngữ

Thư viện này sử dụng framework GetX để quản lý dịch đa ngôn ngữ. Dưới đây là các bước để sử dụng chức năng đa ngôn ngữ:

### 1. Khởi tạo dịch vụ dịch

Khởi tạo dịch vụ dịch khi khởi động ứng dụng:

```dart
void main() {
  // Khởi tạo dịch vụ dịch, thiết lập ngôn ngữ ban đầu là tiếng Trung
  IztroTranslationService.init(initialLocale: 'zh_CN');
  
  runApp(MyApp());
}
```

### 2. Sử dụng GetMaterialApp

Đảm bảo bạn sử dụng GetMaterialApp thay vì MaterialApp trong ứng dụng của bạn:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Cấu hình ứng dụng
    );
  }
}
```

### 3. Chuyển đổi ngôn ngữ

Bạn có thể chuyển đổi ngôn ngữ của ứng dụng bất cứ lúc nào:

```dart
// Chuyển sang tiếng Anh
IztroTranslationService.changeLocale('en_US');

// Chuyển sang tiếng Trung
IztroTranslationService.changeLocale('zh_CN');
```

### 4. Lấy thông tin ngôn ngữ hiện tại

```dart
// Lấy đối tượng Locale của ngôn ngữ hiện tại
Locale? locale = IztroTranslationService.currentLocale;

// Lấy mã ngôn ngữ hiện tại
String languageCode = IztroTranslationService.currentLanguageCode;

// Lấy mã quốc gia hiện tại
String countryCode = IztroTranslationService.currentCountryCode;
```

### 5. Ngôn ngữ được hỗ trợ

Danh sách ngôn ngữ hiện được hỗ trợ:

```dart
List<Map<String, dynamic>> supportedLocales = IztroTranslationService.supportedLocales;
```

### 6. Tích hợp hỗ trợ đa ngôn ngữ cấp ứng dụng

Nếu ứng dụng của bạn cũng cần hỗ trợ đa ngôn ngữ, bạn có thể tích hợp bản dịch của ứng dụng với bản dịch của thư viện:

```dart
void main() {
  // Khởi tạo dịch vụ dịch
  IztroTranslationService.init(initialLocale: 'zh_CN');
  
  // Thêm bản dịch cấp ứng dụng
  IztroTranslationService.addAppTranslations({
    'zh_CN': {
      'app_name': 'Ứng dụng Tử Vi của tôi',
      'welcome': 'Chào mừng',
      // Các bản dịch khác của ứng dụng...
    },
    'en_US': {
      'app_name': 'My Zi Wei App',
      'welcome': 'Welcome',
      // Các bản dịch khác của ứng dụng...
    },
  });
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Sử dụng dịch vụ dịch đã kết hợp bản dịch của ứng dụng
      translations: IztroTranslationService.withAppTranslations(),
      locale: IztroTranslationService.currentLocale,
      fallbackLocale: const Locale('zh', 'CN'),
      title: 'app_name'.tr, // Bản dịch cấp ứng dụng
      home: HomePage(),
    );
  }
}
```

Bằng cách này, bạn có thể sử dụng cả bản dịch của thư viện và bản dịch của riêng bạn trong ứng dụng.

## Hướng dẫn đóng góp

Nếu bạn quan tâm đến `dart_iztro` và muốn tham gia vào nhóm đóng góp, chúng tôi rất hoan nghênh bạn đóng góp theo các cách sau:

* Nếu bạn có đề xuất về chức năng của chương trình, vui lòng tạo một `Feature Request` trên GitHub
* Nếu bạn tìm thấy lỗi trong chương trình, vui lòng tạo một `Bug Report` trên GitHub
* Bạn cũng có thể `fork` repo này vào repo của riêng bạn để sửa đổi, sau đó gửi PR đến repo này
* Nếu bạn có chuyên môn về ngôn ngữ nước ngoài, chúng tôi hoan nghênh sự đóng góp của bạn trong việc dịch các tệp dịch ngôn ngữ

> **Lưu ý quan trọng**: Nếu bạn thấy mã này hữu ích, vui lòng nhấn ⭐ để hỗ trợ! ⭐ của bạn là động lực để tôi tiếp tục cập nhật!

> **Lưu ý**: Vui lòng sử dụng mã nguồn mở này một cách phù hợp. Không sử dụng cho mục đích bất hợp pháp.


## Contact me
<div style="display: flex; justify-content: space-around; margin: 20px 0;">
  <div style="text-align: center;">
    <img src="./facai.jpg" width="300" alt="wechat" />
  </div>
</div> 

## Hỗ trợ thông qua quyên góp

Nếu bạn thấy dự án này hữu ích, bạn có thể cân nhắc hỗ trợ tôi với một ly cà phê ☕️

<div style="display: flex; justify-content: space-around; margin: 20px 0;">
  <div style="text-align: center;">
    <img src="./facai.jpg" width="300" alt="Mã QR Alipay" />
    <p>Alipay</p>
  </div>
  <div style="text-align: center;">
    <img src="./facai.jpg" width="300" alt="Mã QR WeChat Pay" />
    <p>WeChat Pay</p>
  </div>
</div> 