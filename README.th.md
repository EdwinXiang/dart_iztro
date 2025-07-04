# dart_iztro

[English](README.md) | [简体中文](README.zh_CN.md) | [繁體中文](README.zh_TW.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [ภาษาไทย](README.th.md) | [Tiếng Việt](README.vi.md)

ปลั๊กอิน Flutter สำหรับการคำนวณโหราศาสตร์จีน (紫微斗數) และการคำนวณแปดอักษร (八字) ที่รองรับหลายแพลตฟอร์ม มีฟังก์ชันการคำนวณแผนภูมิดาวจื้อเหวย และการแปลงระหว่างปฏิทินจันทรคติและสุริยคติ สามารถใช้สำหรับแอปพลิเคชันวิเคราะห์ชะตาชีวิต, การพยากรณ์ และการวิเคราะห์โหราศาสตร์

> **ข้อความปฏิเสธความรับผิดชอบ**: โค้ดของโปรเจกต์นี้ดัดแปลงมาจาก [@SylarLong/iztro](https://github.com/SylarLong/iztro) ขอขอบคุณผู้เขียนต้นฉบับสำหรับการมีส่วนร่วมในโอเพนซอร์ส

> **เอกสาร**: เอกสารฉบับสมบูรณ์มีให้บริการที่ [https://iztro.com](https://iztro.com) (อ้างอิงจาก [@SylarLong/iztro](https://github.com/SylarLong/iztro))

## คุณสมบัติ

- คำนวณวันที่ปฏิทินจันทรคติจากวันที่ปฏิทินสุริยคติ
- คำนวณข้อมูลแปดอักษร
- คำนวณข้อมูลแผนภูมิดาวจื้อเหวย
- ให้ข้อมูลโดยละเอียดสำหรับแต่ละตำแหน่งในแผนภูมิ
- คำนวณเวลาตามดวงอาทิตย์จริงอย่างแม่นยำ (ตามอัลกอริทึมทางดาราศาสตร์)
- ค้นหาตำแหน่งทางภูมิศาสตร์พร้อมข้อมูลละติจูดและลองจิจูด
- รองรับหลายแพลตฟอร์ม: Android, iOS, macOS, Windows, Linux และเว็บ
- รองรับหลายภาษา: จีนตัวย่อ, จีนตัวเต็ม, อังกฤษ, ญี่ปุ่น, เกาหลี, ไทย, เวียดนาม

## คุณสมบัติที่เสร็จสมบูรณ์

- ✅ การคำนวณแปดอักษรขั้นพื้นฐาน
- ✅ การคำนวณแผนภูมิดาวจื้อเหวย
- ✅ การแปลงระหว่างปฏิทินจันทรคติและสุริยคติ
- ✅ รองรับหลายภาษา
- ✅ การคำนวณเวลาตามดวงอาทิตย์จริง
- ✅ ค้นหาข้อมูลตำแหน่งทางภูมิศาสตร์
- ✅ รองรับข้ามแพลตฟอร์ม (Android, iOS, macOS, Windows, Linux, เว็บ)
- ✅ ข้อมูลตำแหน่งโดยละเอียด
- ✅ รองรับการคำนวณอายุแบบจีนโบราณ (อายุตามประเพณี)
- ✅ รองรับการดึงข้อมูลแผนภูมิสวรรค์ มนุษย์ และโลกในโหราศาสตร์จื้อเหวย


## การติดตั้ง

```yaml
dependencies:
  dart_iztro: ^2.5.3
```

## วิธีการติดตั้งทางเลือก

หากมีปัญหาในการติดตั้งจาก pub.dev คุณสามารถติดตั้งผ่านการอ้างอิง Git:

```yaml
dependencies:
  dart_iztro:
    git:
      url: https://github.com/EdwinXiang/dart_iztro.git
      ref: v2.5.0
```

## วิธีการใช้งาน

```dart
import 'package:dart_iztro/dart_iztro.dart';

// สร้างอินสแตนซ์
final iztro = DartIztro();

// รับข้อมูลแปดอักษร
final birthData = await iztro.calculateBaZi(
  year: 1990, 
  month: 1, 
  day: 1, 
  hour: 12, 
  minute: 0,
  isLunar: false, // เป็นปฏิทินจันทรคติหรือไม่
  isLeap: true,   // ถ้าเป็นปฏิทินจันทรคติ ให้ปรับสำหรับเดือนอธิกมาสหรือไม่ (ค่าเริ่มต้นคือ true)
  gender: Gender.male,
);

// รับแผนภูมิดาวจื้อเหวย
final chart = await iztro.calculateChart(
  year: 1990, 
  month: 1, 
  day: 1, 
  hour: 12, 
  minute: 0,
  isLunar: false, // เป็นปฏิทินจันทรคติหรือไม่
  isLeap: true,   // ถ้าเป็นปฏิทินจันทรคติ ให้ปรับสำหรับเดือนอธิกมาสหรือไม่ (ค่าเริ่มต้นคือ true)
  gender: Gender.male,
);

// ตั้งค่าภาษา
// รองรับหลายภาษา ค่าเริ่มต้นคือจีนตัวย่อ (zh_CN)
await iztro.setLanguage('en_US'); // อังกฤษ
await iztro.setLanguage('zh_TW'); // จีนตัวเต็ม
await iztro.setLanguage('ja_JP'); // ญี่ปุ่น
await iztro.setLanguage('ko_KR'); // เกาหลี
await iztro.setLanguage('th_TH'); // ไทย
await iztro.setLanguage('vi_VN'); // เวียดนาม

// พิมพ์ข้อมูลตำแหน่ง
print(chart.palaces);
```

### การคำนวณเวลาสุริยะจริง

ไลบรารีนี้มีฟังก์ชันการคำนวณเวลาสุริยะจริงที่แม่นยำ ซึ่งอิงตามอัลกอริทึมทางดาราศาสตร์ โดยคำนึงถึงปัจจัยต่างๆ เช่น รูปทรงวงรีของวงโคจรโลก และการเอียงของแกนโลก:

```dart
import 'package:dart_iztro/utils/solar_time_util.dart';

// สร้างวัตถุวันที่เวลา
final solarTime = SolarTime(
  2023, // ปี
  6,    // เดือน
  15,   // วัน
  12,   // ชั่วโมง
  30,   // นาที
  0     // วินาที
);

// สร้างยูทิลิตี้คำนวณเวลาสุริยะ โดยระบุลองจิจูดและละติจูดของตำแหน่ง (ปักกิ่ง)
final solarTimeUtil = SolarTimeUtil(
  longitude: 116.4074, // ลองจิจูด ตะวันออกเป็นค่าบวก ตะวันตกเป็นค่าลบ
  latitude: 39.9042    // ละติจูด เหนือเป็นค่าบวก ใต้เป็นค่าลบ
);

// คำนวณเวลาสุริยะเฉลี่ย
final meanSolarTime = solarTimeUtil.getMeanSolarTime(solarTime);

// คำนวณเวลาสุริยะจริง
final realSolarTime = solarTimeUtil.getRealSolarTime(solarTime);

// แสดงผลลัพธ์
print('เวลาสุริยะเฉลี่ย: ${meanSolarTime.toString()}');
print('เวลาสุริยะจริง: ${realSolarTime.toString()}');
```

### การค้นหาตำแหน่งทางภูมิศาสตร์

ไลบรารีนี้มีฟังก์ชันการค้นหาตำแหน่งทางภูมิศาสตร์ รองรับการค้นหาละติจูดและลองจิจูดจากที่อยู่:

```dart
import 'package:dart_iztro/services/geo_lookup_service.dart';

// สร้างบริการค้นหาตำแหน่งทางภูมิศาสตร์
final geoService = GeoLookupService();

// ค้นหาที่อยู่
final location = await geoService.lookupAddress('เขตไหต่าน, ปักกิ่ง');

if (location != null) {
  print('ที่อยู่: ${location.displayName}');
  print('ลองจิจูด: ${location.longitude}');
  print('ละติจูด: ${location.latitude}');
}
```

### คำอธิบายพารามิเตอร์

- `year`, `month`, `day`, `hour`, `minute`: ปี เดือน วัน ชั่วโมง และนาทีเกิด
- `isLunar`: เป็นวันที่ตามปฏิทินจันทรคติหรือไม่ ค่าเริ่มต้นคือปฏิทินสุริยคติ (`false`)
- `isLeap`: มีผลเมื่อ `isLunar` เป็น `true` ใช้จัดการกับสถานการณ์เดือนอธิกมาส
  - เมื่อตั้งค่าเป็น `true` (ค่าเริ่มต้น) ครึ่งแรกของเดือนอธิกมาสจะถือเป็นเดือนก่อนหน้า ครึ่งหลังจะถือเป็นเดือนถัดไป
  - เมื่อตั้งค่าเป็น `false` จะไม่มีการปรับเดือนอธิกมาส
- `gender`: เพศ ใช้ enum โดยค่าที่เป็นไปได้คือ `Gender.male` (ชาย) หรือ `Gender.female` (หญิง)

## ตัวอย่างเพิ่มเติม

สำหรับตัวอย่างการใช้งานเพิ่มเติม โปรดดูที่แอปพลิเคชันตัวอย่างในโฟลเดอร์ example

## ใบอนุญาต

โปรเจกต์นี้อยู่ภายใต้ใบอนุญาต MIT - ดูรายละเอียดในไฟล์ [LICENSE](LICENSE)

โปรเจกต์นี้ปฏิบัติตามใบอนุญาตโอเพนซอร์สเดียวกันกับโปรเจกต์ต้นฉบับ [@SylarLong/iztro](https://github.com/SylarLong/iztro) หากมีปัญหาด้านลิขสิทธิ์ โปรดติดต่อเราเพื่อดำเนินการทันที

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/to/develop-plugins),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## การรองรับหลายภาษา

ไลบรารีนี้ใช้เฟรมเวิร์ก GetX ในการจัดการการแปลหลายภาษา นี่คือขั้นตอนในการใช้ฟังก์ชันหลายภาษา:

### 1. เริ่มต้นบริการแปลภาษา

เริ่มต้นบริการแปลภาษาเมื่อเริ่มแอปพลิเคชัน:

```dart
void main() {
  // เริ่มต้นบริการแปลภาษา ตั้งค่าภาษาเริ่มต้นเป็นภาษาจีน
  IztroTranslationService.init(initialLocale: 'zh_CN');
  
  runApp(MyApp());
}
```

### 2. ใช้ GetMaterialApp

ตรวจสอบให้แน่ใจว่าคุณใช้ GetMaterialApp แทน MaterialApp ในแอปพลิเคชันของคุณ:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // การกำหนดค่าแอปพลิเคชัน
    );
  }
}
```

### 3. สลับภาษา

คุณสามารถสลับภาษาของแอปพลิเคชันได้ตลอดเวลา:

```dart
// สลับเป็นภาษาอังกฤษ
IztroTranslationService.changeLocale('en_US');

// สลับเป็นภาษาจีน
IztroTranslationService.changeLocale('zh_CN');
```

### 4. รับข้อมูลภาษาปัจจุบัน

```dart
// รับวัตถุ Locale ของภาษาปัจจุบัน
Locale? locale = IztroTranslationService.currentLocale;

// รับรหัสภาษาปัจจุบัน
String languageCode = IztroTranslationService.currentLanguageCode;

// รับรหัสประเทศปัจจุบัน
String countryCode = IztroTranslationService.currentCountryCode;
```

### 5. ภาษาที่รองรับ

รายการภาษาที่รองรับในปัจจุบัน:

```dart
List<Map<String, dynamic>> supportedLocales = IztroTranslationService.supportedLocales;
```

### 6. บูรณาการการรองรับหลายภาษาในระดับแอปพลิเคชัน

หากแอปพลิเคชันของคุณต้องการการรองรับหลายภาษาเช่นกัน คุณสามารถบูรณาการการแปลของแอปพลิเคชันกับการแปลของไลบรารีได้:

```dart
void main() {
  // เริ่มต้นบริการแปลภาษา
  IztroTranslationService.init(initialLocale: 'zh_CN');
  
  // เพิ่มการแปลระดับแอปพลิเคชัน
  IztroTranslationService.addAppTranslations({
    'zh_CN': {
      'app_name': 'แอปจื้อเหวยของฉัน',
      'welcome': 'ยินดีต้อนรับ',
      // การแปลแอปพลิเคชันอื่นๆ...
    },
    'en_US': {
      'app_name': 'My Zi Wei App',
      'welcome': 'Welcome',
      // การแปลแอปพลิเคชันอื่นๆ...
    },
  });
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // ใช้บริการแปลที่ได้รวมการแปลของแอปพลิเคชันแล้ว
      translations: IztroTranslationService.withAppTranslations(),
      locale: IztroTranslationService.currentLocale,
      fallbackLocale: const Locale('zh', 'CN'),
      title: 'app_name'.tr, // การแปลระดับแอปพลิเคชัน
      home: HomePage(),
    );
  }
}
```

ด้วยวิธีนี้ คุณสามารถใช้ทั้งการแปลของไลบรารีและการแปลของคุณเองในแอปพลิเคชันได้ 

## แนวทางการมีส่วนร่วม

หากคุณสนใจ `dart_iztro` และต้องการเข้าร่วมทีมผู้มีส่วนร่วม เรายินดีอย่างยิ่งที่จะให้คุณมีส่วนร่วมในวิธีต่อไปนี้:

* หากคุณมีข้อเสนอแนะเกี่ยวกับฟังก์ชันของโปรแกรม กรุณาสร้าง `คำขอคุณสมบัติ` บน GitHub
* หากคุณพบข้อบกพร่องในโปรแกรม กรุณาสร้าง `รายงานข้อบกพร่อง` บน GitHub
* คุณยังสามารถ `fork` ที่เก็บนี้ไปยังที่เก็บของคุณเองเพื่อแก้ไข แล้วส่ง PR มายังที่เก็บนี้
* หากคุณมีความเชี่ยวชาญในภาษาต่างประเทศ เรายินดีต้อนรับการมีส่วนร่วมของคุณในการแปลไฟล์การแปลภาษา

> **หมายเหตุสำคัญ**: หากคุณคิดว่าโค้ดมีประโยชน์ กรุณากด ⭐ เพื่อสนับสนุน ⭐ ของคุณคือแรงจูงใจให้ฉันอัปเดตต่อไป!

> **หมายเหตุ**: กรุณาใช้โค้ดโอเพนซอร์สนี้อย่างเหมาะสม ห้ามใช้เพื่อวัตถุประสงค์ที่ผิดกฎหมาย

## Contact me
<div style="display: flex; justify-content: space-around; margin: 20px 0;">
  <div style="text-align: center;">
    <img src="./facai.jpg" width="300" alt="wechat" />
  </div>
</div> 

## การสนับสนุนผ่านการบริจาค

หากคุณคิดว่าโปรเจกต์นี้มีประโยชน์ คุณอาจพิจารณาสนับสนุนฉันด้วยกาแฟหนึ่งแก้ว ☕️

<div style="display: flex; justify-content: space-around; margin: 20px 0;">
  <div style="text-align: center;">
    <img src="./facai.jpg" width="300" alt="รหัส QR Alipay" />
    <p>Alipay</p>
  </div>
  <div style="text-align: center;">
    <img src="./facai.jpg" width="300" alt="รหัส QR WeChat Pay" />
    <p>WeChat Pay</p>
  </div>
</div> 