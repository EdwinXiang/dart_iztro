# dart_iztro

[English](README.md) | [简体中文](README.zh_CN.md) | [繁體中文](README.zh_TW.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [ภาษาไทย](README.th.md) | [Tiếng Việt](README.vi.md)

一个支持多平台的紫微斗数和八字计算Flutter插件。提供紫微斗数星盘和八字计算功能，支持农历阳历转换，可用于命理、占卜和星盘分析应用。

> **声明**：本项目代码源自 [@SylarLong/iztro](https://github.com/SylarLong/iztro)，感谢原作者的开源贡献。

> **文档**：完整文档请访问 [https://iztro.com](https://iztro.com)（基于 [@SylarLong/iztro](https://github.com/SylarLong/iztro)）。

## 功能特点

- 根据阳历日期计算农历日期
- 计算八字信息
- 计算紫微斗数星盘信息
- 提供星盘各宫位的详细信息
- 精确计算真太阳时（基于天文学算法）
- 地理位置查询与经纬度信息
- 支持多平台：Android、iOS、macOS、Windows、Linux和Web
- 多语言支持：简体中文、繁体中文、英语、日语、韩语、泰语、越南语

## 已完成功能

### 输入数据
- ✅ 生日（阳历或农历皆可）
- ✅ 出生时间
- ✅ 性别

### 核心功能
- ✅ 紫微斗数12宫的星盘数据
- ✅ 获取生肖
- ✅ 获取星座
- ✅ 获取四柱（干支纪年法的生辰）
- ✅ 获取运限（大限，小限，流年，流月，流日，流时）的数据
- ✅ 获取流耀（大限和流年的动态星耀）
- ✅ 基础八字计算
- ✅ 农历阳历转换
- ✅ 多语言支持
- ✅ 真太阳时计算
- ✅ 地理位置信息查询
- ✅ 跨平台支持（Android、iOS、macOS、Windows、Linux、Web）

### 分析方法
- ✅ 判断指定宫位是否存在某些星耀
- ✅ 判断指定宫位三方四正是否存在某些星耀
- ✅ 判断指定宫位三方四正是否存在四化
- ✅ 判断指定星耀是否存在四化
- ✅ 判断指定星耀三方四正是否存在四化
- ✅ 判断指定星耀是否是某个亮度
- ✅ 根据天干获取四化
- ✅ 获取指定星耀所在宫位
- ✅ 获取指定宫位三方四正宫位
- ✅ 获取指定星耀三方四正宫位
- ✅ 获取指定星耀对宫
- ✅ 获取指定运限宫位
- ✅ 获取指定运限宫位的三方四正
- ✅ 判断指定运限宫位内是否存在某些星耀
- ✅ 判断指定运限宫位内是否存在四化
- ✅ 判断指定运限三方四正内是否存在某些星耀
- ✅ 判断指定运限三方四正内是否存在四化
- ✅ 判断指定宫位是否是空宫
- ✅ 判断宫位是否产生飞星到目标宫位
- ✅ 获取宫位产生的四化宫位
- ✅ 支持虚岁计算 
- ✅ 支持紫微斗数天盘、人盘、地盘数据获取

## 安装

```yaml
dependencies:
  dart_iztro: ^2.5.3
```

## 备选安装方式

如果从pub.dev安装遇到问题，可以使用Git依赖方式安装:

```yaml
dependencies:
  dart_iztro:
    git:
      url: https://github.com/EdwinXiang/dart_iztro.git
      ref: v2.5.0
```

## 使用方法

```dart
import 'package:dart_iztro/dart_iztro.dart';

// 创建实例
final iztro = DartIztro();

// 获取八字信息
final birthData = await iztro.calculateBaZi(
  year: 1990, 
  month: 1, 
  day: 1, 
  hour: 12, 
  minute: 0,
  isLunar: false, // 是否农历
  isLeap: true,   // 如果是农历，是否调整闰月（默认为true）
  gender: Gender.male,
);

// 获取紫微斗数星盘
final chart = await iztro.calculateChart(
  year: 1990, 
  month: 1, 
  day: 1, 
  hour: 12, 
  minute: 0,
  isLunar: false, // 是否农历
  isLeap: true,   // 如果是农历，是否调整闰月（默认为true）
  gender: Gender.male,
);

// 设置语言（新增）
// 支持多种语言，默认为简体中文（zh_CN）
await iztro.setLanguage('en_US'); // 英语
await iztro.setLanguage('zh_TW'); // 繁体中文
await iztro.setLanguage('ja_JP'); // 日语
await iztro.setLanguage('ko_KR'); // 韩语
await iztro.setLanguage('th_TH'); // 泰语
await iztro.setLanguage('vi_VN'); // 越南语

// 打印宫位信息
print(chart.palaces);
```

### 计算真太阳时

本库提供精确的真太阳时计算功能，基于天文学算法，考虑地球公转轨道椭圆形状、地轴倾斜等因素：

```dart
import 'package:dart_iztro/utils/solar_time_util.dart';

// 创建一个日期时间对象
final solarTime = SolarTime(
  2023, // 年
  6,    // 月
  15,   // 日
  12,   // 时
  30,   // 分
  0     // 秒
);

// 创建太阳时计算工具，指定位置的经纬度（北京）
final solarTimeUtil = SolarTimeUtil(
  longitude: 116.4074, // 经度，东经为正，西经为负
  latitude: 39.9042    // 纬度，北纬为正，南纬为负
);

// 计算平太阳时
final meanSolarTime = solarTimeUtil.getMeanSolarTime(solarTime);

// 计算真太阳时
final realSolarTime = solarTimeUtil.getRealSolarTime(solarTime);

// 输出结果
print('平太阳时: ${meanSolarTime.toString()}');
print('真太阳时: ${realSolarTime.toString()}');
```

### 地理位置查询

本库提供地理位置查询功能，支持通过地址查询经纬度信息：

```dart
import 'package:dart_iztro/services/geo_lookup_service.dart';

// 创建地理位置查询服务
final geoService = GeoLookupService();

// 查询地址
final location = await geoService.lookupAddress('北京市海淀区');

if (location != null) {
  print('地址: ${location.displayName}');
  print('经度: ${location.longitude}');
  print('纬度: ${location.latitude}');
}
```

### 参数说明

- `year`、`month`、`day`、`hour`、`minute`: 出生的年、月、日、时、分
- `isLunar`: 是否为农历日期，默认为阳历（`false`）
- `isLeap`: 当`isLunar`为`true`时有效，用于处理闰月情况
  - 当设置为`true`时（默认值），闰月的前半个月算上个月，后半个月算下个月
  - 当设置为`false`时，不调整闰月
- `gender`: 性别，使用枚举类型，可选值为`Gender.male`（男）或`Gender.female`（女）

## 更多示例

更多使用示例请查看 example 文件夹中的示例应用。

## 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件

本项目遵循与原项目 [@SylarLong/iztro](https://github.com/SylarLong/iztro) 相同的开源许可证。如有任何版权问题，请联系我们立即处理。

## 多语言支持

本库使用GetX框架管理多语言翻译。以下是使用多语言功能的步骤：

### 1. 初始化翻译服务

在应用启动时初始化翻译服务：

```dart
void main() {
  // 初始化翻译服务，设置初始语言为中文
  IztroTranslationService.init(initialLocale: 'zh_CN');
  
  runApp(MyApp());
}
```

### 2. 使用GetMaterialApp

确保在应用中使用GetMaterialApp而不是MaterialApp：

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // 应用配置
    );
  }
}
```

### 3. 切换语言

可以随时切换应用的语言：

```dart
// 切换到英文
IztroTranslationService.changeLocale('en_US');

// 切换到中文
IztroTranslationService.changeLocale('zh_CN');
```

### 4. 获取当前语言信息

```dart
// 获取当前语言的Locale对象
Locale? locale = IztroTranslationService.currentLocale;

// 获取当前语言代码
String languageCode = IztroTranslationService.currentLanguageCode;

// 获取当前国家代码
String countryCode = IztroTranslationService.currentCountryCode;
```

### 5. 支持的语言

目前支持的语言列表：

```dart
List<Map<String, dynamic>> supportedLocales = IztroTranslationService.supportedLocales;
```

### 6. 集成应用层的多语言支持

如果您的应用也需要多语言支持，可以将应用的翻译与库的翻译集成在一起：

```dart
void main() {
  // 初始化翻译服务
  IztroTranslationService.init(initialLocale: 'zh_CN');
  
  // 添加应用层的翻译
  IztroTranslationService.addAppTranslations({
    'zh_CN': {
      'app_name': '我的紫微应用',
      'welcome': '欢迎使用',
      // 其他应用翻译...
    },
    'en_US': {
      'app_name': 'My Zi Wei App',
      'welcome': 'Welcome',
      // 其他应用翻译...
    },
  });
  
  runApp(MyApp());
}
```

这样您就可以在应用中同时使用库的翻译和自己的翻译。

## 贡献指南

如果你对`dart_iztro`有兴趣，也想加入贡献队伍，我们非常欢迎，你可以用以下方式进行：

* 如果你对程序功能有什么建议，请在GitHub创建一个`功能需求`。
* 如果你发现程序有BUG，请在GitHub创建一个`BUG报告`。
* 你也可以将本仓库`fork`到你自己的仓库进行编辑，然后提交PR到本仓库。
* 假如你擅长外语，我们也欢迎你对国际化文件的翻译做出你的贡献。

> **重要提示**: 如果你觉得代码对你有用，请点⭐支持，你的⭐是我持续更新的动力！

> **注意**: 请合理使用本开源代码，禁止用于非法目的。


## 联系我
<div style="display: flex; justify-content: space-around; margin: 20px 0;">
  <div style="text-align: center;">
    <img src="./facai.jpg" width="300" alt="wechat" />
  </div>
</div> 

## 赞助支持

如果你觉得本项目对你有所帮助，可以考虑赞助我一杯咖啡 ☕️

<div style="display: flex; justify-content: space-around; margin: 20px 0;">
  <div style="text-align: center;">
    <img src="./facai.jpg" width="300" alt="支付宝收款码" />
    <p>支付宝</p>
  </div>
  <div style="text-align: center;">
    <img src="./facai.jpg" width="300" alt="微信收款码" />
    <p>微信支付</p>
  </div>
</div> 