# dart_iztro

[English](README.md) | [简体中文](README.zh_CN.md) | [繁體中文](README.zh_TW.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [ภาษาไทย](README.th.md) | [Tiếng Việt](README.vi.md)

複数のプラットフォームをサポートする紫微斗数と八字計算のFlutterプラグイン。紫微斗数の星盤と八字計算機能を提供し、旧暦と新暦の変換をサポートし、運命解析、占い、星盤分析アプリケーションに使用できます。

> **免責事項**：このプロジェクトのコードは [@SylarLong/iztro](https://github.com/SylarLong/iztro) から派生しています。オリジナル作者のオープンソース貢献に感謝します。

> **ドキュメント**：完全なドキュメントは [https://iztro.com](https://iztro.com) で利用可能です（[@SylarLong/iztro](https://github.com/SylarLong/iztro) に基づいています）。

## 機能

- 新暦から旧暦日付を計算
- 八字情報を計算
- 紫微斗数星盤情報を計算
- 星盤の各宮位の詳細情報を提供
- 精密な真太陽時の計算（天文学的アルゴリズムに基づく）
- 地理位置情報と経緯度情報の照会
- 複数のプラットフォームをサポート：Android、iOS、macOS、Windows、Linuxおよびウェブ
- 多言語サポート：簡体字中国語、繁体字中国語、英語、日本語、韓国語、タイ語、ベトナム語

## 完了した機能

- ✅ 基本的な八字計算
- ✅ 紫微斗数星盤計算
- ✅ 旧暦と新暦の変換
- ✅ 多言語サポート
- ✅ 真太陽時計算
- ✅ 地理位置情報の照会
- ✅ クロスプラットフォームサポート（Android、iOS、macOS、Windows、Linux、ウェブ）
- ✅ 宮位の詳細情報
- ✅ 虚歳（数え年）計算のサポート
- ✅ 紫微斗数の天盤、人盤、地盤データ取得のサポート

## インストール

```yaml
dependencies:
  dart_iztro: ^2.5.3
```

## 代替インストール方法

pub.devからのインストールに問題がある場合は、Git依存関係を使ってインストールできます：

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

// インスタンスを作成
final iztro = DartIztro();

// 八字情報を取得
final birthData = await iztro.calculateBaZi(
  year: 1990, 
  month: 1, 
  day: 1, 
  hour: 12, 
  minute: 0,
  isLunar: false, // 旧暦かどうか
  isLeap: true,   // 旧暦の場合、閏月を調整するかどうか（デフォルトはtrue）
  gender: Gender.male,
);

// 紫微斗数星盤を取得
final chart = await iztro.calculateChart(
  year: 1990, 
  month: 1, 
  day: 1, 
  hour: 12, 
  minute: 0,
  isLunar: false, // 旧暦かどうか
  isLeap: true,   // 旧暦の場合、閏月を調整するかどうか（デフォルトはtrue）
  gender: Gender.male,
);

// 言語を設定
// 複数の言語をサポート、デフォルトは簡体字中国語（zh_CN）
await iztro.setLanguage('en_US'); // 英語
await iztro.setLanguage('zh_TW'); // 繁体字中国語
await iztro.setLanguage('ja_JP'); // 日本語
await iztro.setLanguage('ko_KR'); // 韓国語
await iztro.setLanguage('th_TH'); // タイ語
await iztro.setLanguage('vi_VN'); // ベトナム語

// 宮位情報を出力
print(chart.palaces);
```

### 真太陽時の計算

このライブラリは、地球の楕円軌道や地軸の傾きなどの要素を考慮した天文学的アルゴリズムに基づいて、正確な真太陽時の計算機能を提供します：

```dart
import 'package:dart_iztro/utils/solar_time_util.dart';

// 日時オブジェクトを作成
final solarTime = SolarTime(
  2023, // 年
  6,    // 月
  15,   // 日
  12,   // 時
  30,   // 分
  0     // 秒
);

// 場所の緯度経度を指定して太陽時計算ユーティリティを作成（北京）
final solarTimeUtil = SolarTimeUtil(
  longitude: 116.4074, // 経度、東経はプラス、西経はマイナス
  latitude: 39.9042    // 緯度、北緯はプラス、南緯はマイナス
);

// 平均太陽時を計算
final meanSolarTime = solarTimeUtil.getMeanSolarTime(solarTime);

// 真太陽時を計算
final realSolarTime = solarTimeUtil.getRealSolarTime(solarTime);

// 結果を出力
print('平均太陽時: ${meanSolarTime.toString()}');
print('真太陽時: ${realSolarTime.toString()}');
```

### 地理位置クエリ

このライブラリは、住所から緯度経度を検索する地理位置クエリ機能を提供します：

```dart
import 'package:dart_iztro/services/geo_lookup_service.dart';

// 地理位置クエリサービスを作成
final geoService = GeoLookupService();

// 住所を検索
final location = await geoService.lookupAddress('北京市海淀区');

if (location != null) {
  print('住所: ${location.displayName}');
  print('経度: ${location.longitude}');
  print('緯度: ${location.latitude}');
}
```

### パラメータの説明

- `year`、`month`、`day`、`hour`、`minute`: 生年月日時分
- `isLunar`: 旧暦かどうか、デフォルトは新暦（`false`）
- `isLeap`: `isLunar`が`true`の場合に有効、閏月の処理方法
  - `true`（デフォルト）に設定すると、閏月の前半は前月として、後半は次月として計算
  - `false`に設定すると、閏月を調整しない
- `gender`: 性別、列挙型を使用、`Gender.male`（男性）または`Gender.female`（女性）の値を取る

## その他の例

より多くの使用例については、exampleフォルダのサンプルアプリケーションを参照してください。

## ライセンス

このプロジェクトはMITライセンスの下で提供されています - 詳細は[LICENSE](LICENSE)ファイルを参照してください。

このプロジェクトは、オリジナルプロジェクト[@SylarLong/iztro](https://github.com/SylarLong/iztro)と同じオープンソースライセンスに従います。著作権に関する問題がある場合は、直ちに対応いたしますので、お問い合わせください。

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/to/develop-plugins),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## 多言語サポート

このライブラリはGetXフレームワークを使用して多言語翻訳を管理しています。多言語機能を使用するためのステップは次のとおりです：

### 1. 翻訳サービスの初期化

アプリケーション起動時に翻訳サービスを初期化します：

```dart
void main() {
  // 翻訳サービスを初期化し、初期言語を中国語に設定
  IztroTranslationService.init(initialLocale: 'zh_CN');
  
  runApp(MyApp());
}
```

### 2. GetMaterialAppの使用

アプリケーションでMaterialAppではなくGetMaterialAppを使用してください：

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // アプリケーション設定
    );
  }
}
```

### 3. 言語の切り替え

いつでもアプリケーションの言語を切り替えることができます：

```dart
// 英語に切り替え
IztroTranslationService.changeLocale('en_US');

// 中国語に切り替え
IztroTranslationService.changeLocale('zh_CN');
```

### 4. 現在の言語情報の取得

```dart
// 現在の言語のLocaleオブジェクトを取得
Locale? locale = IztroTranslationService.currentLocale;

// 現在の言語コードを取得
String languageCode = IztroTranslationService.currentLanguageCode;

// 現在の国コードを取得
String countryCode = IztroTranslationService.currentCountryCode;
```

### 5. サポートされている言語

現在サポートされている言語のリスト：

```dart
List<Map<String, dynamic>> supportedLocales = IztroTranslationService.supportedLocales;
```

### 6. アプリケーションレベルの多言語サポートの統合

アプリケーションも多言語サポートが必要な場合は、アプリケーションの翻訳とライブラリの翻訳を統合できます：

```dart
void main() {
  // 翻訳サービスを初期化
  IztroTranslationService.init(initialLocale: 'zh_CN');
  
  // アプリケーションレベルの翻訳を追加
  IztroTranslationService.addAppTranslations({
    'zh_CN': {
      'app_name': '私の紫微アプリ',
      'welcome': 'ようこそ',
      // その他のアプリケーション翻訳...
    },
    'en_US': {
      'app_name': 'My Zi Wei App',
      'welcome': 'Welcome',
      // その他のアプリケーション翻訳...
    },
  });
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // アプリケーション翻訳を統合した翻訳サービスを使用
      translations: IztroTranslationService.withAppTranslations(),
      locale: IztroTranslationService.currentLocale,
      fallbackLocale: const Locale('zh', 'CN'),
      title: 'app_name'.tr, // アプリケーションレベルの翻訳
      home: HomePage(),
    );
  }
}
```

このようにして、アプリケーション内でライブラリの翻訳と独自の翻訳の両方を使用できます。

## 貢献ガイドライン

`dart_iztro`に興味があり、貢献チームに参加したい場合は、以下の方法で貢献することができます：

* プログラムの機能に関する提案がある場合は、GitHubで「機能リクエスト」を作成してください。
* プログラムにバグを発見した場合は、GitHubで「バグレポート」を作成してください。
* このリポジトリを自分のリポジトリに「フォーク」して編集し、このリポジトリにPRを提出することもできます。
* 外国語に堪能な場合は、国際化ファイルの翻訳への貢献も歓迎します。

> **重要な注意事項**：コードが役立つと思われる場合は、⭐を付けてサポートしてください。あなたの⭐は私が更新を続ける動機です！

> **注意**：このオープンソースコードを適切に使用し、違法な目的には使用しないでください。

## Contact me
<div style="display: flex; justify-content: space-around; margin: 20px 0;">
  <div style="text-align: center;">
    <img src="./facai.jpg" width="300" alt="wechat" />
  </div>
</div> 

## スポンサーシップサポート

このプロジェクトが役立つと思われる場合は、コーヒー☕️一杯分のスポンサーを検討してください。

<div style="display: flex; justify-content: space-around; margin: 20px 0;">
  <div style="text-align: center;">
    <img src="./facai.jpg" width="300" alt="Alipay QRコード" />
    <p>Alipay</p>
  </div>
  <div style="text-align: center;">
    <img src="./facai.jpg" width="300" alt="WeChat Pay QRコード" />
    <p>WeChat Pay</p>
  </div>
</div> 