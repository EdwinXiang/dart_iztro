# dart_iztro

[English](README.md) | [简体中文](README.zh_CN.md) | [繁體中文](README.zh_TW.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [ภาษาไทย](README.th.md) | [Tiếng Việt](README.vi.md)

A cross-platform Flutter plugin for Purple Star Astrology (Zi Wei Dou Shu) and BaZi calculations. It provides functionality for calculating Purple Star astrology charts and BaZi, supports lunar and solar calendar conversion, and can be used for destiny analysis, divination, and astrological applications.

> **Disclaimer**: This project code is derived from [@SylarLong/iztro](https://github.com/SylarLong/iztro). Thanks to the original author for the open-source contribution.

## Features

- Calculate lunar date from solar date
- Calculate BaZi information
- Calculate Purple Star Astrology chart information
- Provide detailed information for each palace in the chart
- Accurately calculate true solar time (based on astronomical algorithms)
- Geographic location query with latitude and longitude information
- Support multiple platforms: Android, iOS, macOS, Windows, and Web
- Multi-language support: Simplified Chinese, Traditional Chinese, English, Japanese, Korean, Thai, Vietnamese

## Installation

```yaml
dependencies:
  dart_iztro: ^0.1.0
```

## Alternative Installation

If you encounter issues installing from pub.dev, you can install via Git dependency:

```yaml
dependencies:
  dart_iztro:
    git:
      url: https://github.com/EdwinXiang/dart_iztro.git
      ref: v0.1.0
```

## Usage

```dart
import 'package:dart_iztro/dart_iztro.dart';

// Create an instance
final iztro = DartIztro();

// Get BaZi information
final birthData = await iztro.calculateBaZi(
  year: 1990, 
  month: 1, 
  day: 1, 
  hour: 12, 
  minute: 0,
  isLunar: false, // Whether it's lunar calendar
  isLeap: true,   // If lunar, whether to adjust for leap month (default is true)
  gender: Gender.male,
);

// Get Purple Star Astrology chart
final chart = await iztro.calculateChart(
  year: 1990, 
  month: 1, 
  day: 1, 
  hour: 12, 
  minute: 0,
  isLunar: false, // Whether it's lunar calendar
  isLeap: true,   // If lunar, whether to adjust for leap month (default is true)
  gender: Gender.male,
);

// Set language
// Supports multiple languages, default is Simplified Chinese (zh_CN)
await iztro.setLanguage('en_US'); // English
await iztro.setLanguage('zh_TW'); // Traditional Chinese
await iztro.setLanguage('ja_JP'); // Japanese
await iztro.setLanguage('ko_KR'); // Korean
await iztro.setLanguage('th_TH'); // Thai
await iztro.setLanguage('vi_VN'); // Vietnamese

// Print palace information
print(chart.palaces);
```

### Calculate True Solar Time

This library provides accurate true solar time calculation functionality, based on astronomical algorithms, considering factors such as the elliptical shape of Earth's orbit and the tilt of Earth's axis:

```dart
import 'package:dart_iztro/utils/solar_time_util.dart';

// Create a date-time object
final solarTime = SolarTime(
  2023, // Year
  6,    // Month
  15,   // Day
  12,   // Hour
  30,   // Minute
  0     // Second
);

// Create a solar time calculation utility, specifying the longitude and latitude of the location (Beijing)
final solarTimeUtil = SolarTimeUtil(
  longitude: 116.4074, // Longitude, positive for east, negative for west
  latitude: 39.9042    // Latitude, positive for north, negative for south
);

// Calculate mean solar time
final meanSolarTime = solarTimeUtil.getMeanSolarTime(solarTime);

// Calculate true solar time
final realSolarTime = solarTimeUtil.getRealSolarTime(solarTime);

// Output results
print('Mean Solar Time: ${meanSolarTime.toString()}');
print('True Solar Time: ${realSolarTime.toString()}');
```

### Geographic Location Query

This library provides geographic location query functionality, supporting latitude and longitude lookup by address:

```dart
import 'package:dart_iztro/services/geo_lookup_service.dart';

// Create a geographic location query service
final geoService = GeoLookupService();

// Query address
final location = await geoService.lookupAddress('Haidian District, Beijing');

if (location != null) {
  print('Address: ${location.displayName}');
  print('Longitude: ${location.longitude}');
  print('Latitude: ${location.latitude}');
}
```

### Parameter Description

- `year`, `month`, `day`, `hour`, `minute`: Year, month, day, hour, and minute of birth
- `isLunar`: Whether it's a lunar calendar date, default is solar calendar (`false`)
- `isLeap`: Effective when `isLunar` is `true`, used to handle leap month situations
  - When set to `true` (default), the first half of a leap month is considered as the previous month, the second half as the next month
  - When set to `false`, leap months are not adjusted
- `gender`: Gender, using enum type, possible values are `Gender.male` or `Gender.female`

## More Examples

For more usage examples, please check the sample application in the example folder.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

This project follows the same open-source license as the original project [@SylarLong/iztro](https://github.com/SylarLong/iztro). If there are any copyright issues, please contact us for immediate handling.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/to/develop-plugins),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Multi-language Support

This library uses the GetX framework to manage multilingual translations. Here are the steps to use the multilingual functionality:

### 1. Initialize Translation Service

Initialize the translation service when starting the application:

```dart
void main() {
  // Initialize translation service, set initial language to Chinese
  IztroTranslationService.init(initialLocale: 'zh_CN');
  
  runApp(MyApp());
}
```

### 2. Use GetMaterialApp

Ensure you use GetMaterialApp instead of MaterialApp in your application:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Application configuration
    );
  }
}
```

### 3. Switch Language

You can switch the application's language at any time:

```dart
// Switch to English
IztroTranslationService.changeLocale('en_US');

// Switch to Chinese
IztroTranslationService.changeLocale('zh_CN');
```

### 4. Get Current Language Information

```dart
// Get the Locale object of the current language
Locale? locale = IztroTranslationService.currentLocale;

// Get the current language code
String languageCode = IztroTranslationService.currentLanguageCode;

// Get the current country code
String countryCode = IztroTranslationService.currentCountryCode;
```

### 5. Supported Languages

List of currently supported languages:

```dart
List<Map<String, dynamic>> supportedLocales = IztroTranslationService.supportedLocales;
```

### 6. Integrate Application-level Multi-language Support

If your application also needs multi-language support, you can integrate your application's translations with the library's translations:

```dart
void main() {
  // Initialize translation service
  IztroTranslationService.init(initialLocale: 'zh_CN');
  
  // Add application-level translations
  IztroTranslationService.addAppTranslations({
    'zh_CN': {
      'app_name': 'My Purple Star App',
      'welcome': 'Welcome',
      // Other application translations...
    },
    'en_US': {
      'app_name': 'My Zi Wei App',
      'welcome': 'Welcome',
      // Other application translations...
    },
  });
  
  runApp(MyApp());
}
```

In this way, you can use both the library's translations and your own translations in your application.

## Contribution Guidelines

If you are interested in `dart_iztro` and want to join the contributor team, we greatly welcome your contribution in the following ways:

* If you have suggestions about the functionality of the program, please create a `Feature Request` on GitHub
* If you find bugs in the program, please create a `Bug Report` on GitHub
* You can also `fork` this repository to your own repository for modification, then send a PR to this repository
* If you have expertise in foreign languages, we welcome your contribution in translating the language translation files

> **Important note**: If you find the code useful, please hit ⭐ to support! Your ⭐ is my motivation to continue updating!

> **Note**: Please use this open-source code appropriately. Do not use it for illegal purposes.

## Support Through Donations

If you find this project helpful, you might consider supporting me with a cup of coffee ☕️

<div style="display: flex; justify-content: space-around; margin: 20px 0;">
  <div style="text-align: center;">
    <img src="./alipay.jpg" width="300" alt="Alipay QR Code" />
    <p>Alipay</p>
  </div>
  <div style="text-align: center;">
    <img src="./wechat_pay.jpg" width="300" alt="WeChat Pay QR Code" />
    <p>WeChat Pay</p>
  </div>
</div>

