import 'dart:developer';
import 'dart:ffi';

import 'package:dart_iztro_example/widgets/astrolabe_chart_view.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:dart_iztro/dart_iztro.dart';
import 'package:dart_iztro/crape_myrtle/astro/astro.dart';
import 'package:get/get.dart';

// 导入真太阳时工具示例页面
import 'solar_time_util_example.dart';

void main() {
  // 初始化翻译服务
  IztroTranslationService.init(initialLocale: 'zh_CN');

  // 添加应用自己的翻译
  IztroTranslationService.addAppTranslations({
    'zh_CN': {
      'app_title': '紫微斗数示例应用',
      'birth_info': '出生信息',
      'year': '年',
      'month': '月',
      'day': '日',
      'hour': '时',
      'minute': '分',
      'gender': '性别',
      'male': '男',
      'female': '女',
      'date_type': '日期类型:',
      'solar': '阳历',
      'lunar': '农历',
      'calculate_bazi': '计算八字',
      'calculate_chart': '计算紫微星盘',
      'bazi_result': '八字结果',
      'chart_result': '紫微星盘结果',
      'detail_info': '详细信息:',
      'platform': '运行平台',
    },
    'en_US': {
      'app_title': 'ZiWei Dou Shu Demo',
      'birth_info': 'Birth Information',
      'year': 'Year',
      'month': 'Month',
      'day': 'Day',
      'hour': 'Hour',
      'minute': 'Minute',
      'gender': 'Gender',
      'male': 'Male',
      'female': 'Female',
      'date_type': 'Date Type:',
      'solar': 'Solar',
      'lunar': 'Lunar',
      'calculate_bazi': 'Calculate BaZi',
      'calculate_chart': 'Calculate ZiWei Chart',
      'bazi_result': 'BaZi Result',
      'chart_result': 'ZiWei Chart Result',
      'detail_info': 'Details:',
      'platform': 'Platform',
    },
  });

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _dartIztroPlugin = DartIztro();
  String _platformVersion = 'Unknown';
  Map<String, dynamic>? _baziResult;
  FunctionalAstrolabe? _chartResult;
  bool _isLoading = false;

  // 日期时间控制器
  final _yearController = TextEditingController(text: '1990');
  final _monthController = TextEditingController(text: '1');
  final _dayController = TextEditingController(text: '1');
  final _hourController = TextEditingController(text: '12');
  final _minuteController = TextEditingController(text: '0');

  // 性别和日期类型
  String _gender = 'male';
  bool _isLunar = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _dartIztroPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  // 计算八字
  Future<void> _calculateBaZi() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await _dartIztroPlugin.calculateBaZi(
        year: int.parse(_yearController.text),
        month: int.parse(_monthController.text),
        day: int.parse(_dayController.text),
        hour: int.parse(_hourController.text),
        minute: int.parse(_minuteController.text),
        isLunar: _isLunar,
        gender: _gender,
      );

      setState(() {
        _baziResult = result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('计算出错: ${e.toString()}')));
    }
  }

  // 计算紫微星盘
  _calculateChart() {
    setState(() {
      _isLoading = true;
    });
    print('计算紫微斗数');
    // 计算时辰索引
    final timeIndex = (int.parse(_hourController.text) / 2).floor();
    // 构建日期字符串
    final dateStr =
        '${_yearController.text}-${_monthController.text.padLeft(2, '0')}-'
        '${_dayController.text.padLeft(2, '0')}';
    final genderToUse =
        (_gender == GenderName.male.name) ? GenderName.male : GenderName.female;

    if (_isLunar) {
      final result = byLunar(dateStr, timeIndex, genderToUse, true);
      // print('result  $result');
      log('result  ${jsonEncode(result.toJson())}');
      setState(() {
        _chartResult = result;
        _isLoading = false;
      });
    } else {
      final result = bySolar(dateStr, timeIndex, genderToUse, true);
      // print('result  $result');
      log('result  ${jsonEncode(result.toJson())}');
      setState(() {
        _chartResult = result;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // 使用合并了应用翻译的翻译服务
      translations: IztroTranslationService.withAppTranslations(),
      locale: IztroTranslationService.currentLocale,
      fallbackLocale: const Locale('zh', 'CN'),
      home: Scaffold(
        appBar: AppBar(
          title: Text('app_title'.tr),
          actions: [
            // 添加语言切换按钮
            IconButton(
              icon: Icon(Icons.language),
              onPressed: () {
                // 这里可以添加语言切换功能
                // 例如：切换语言 - 演示目的（实际中可能需要更多语言支持）
                if (IztroTranslationService.currentLanguageCode == 'zh') {
                  IztroTranslationService.changeLocale('en_US');
                } else {
                  IztroTranslationService.changeLocale('zh_CN');
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${'platform'.tr}: $_platformVersion'),
              const SizedBox(height: 20),

              // 输入表单
              Text(
                'birth_info'.tr,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _yearController,
                      decoration: InputDecoration(labelText: 'year'.tr),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _monthController,
                      decoration: InputDecoration(labelText: 'month'.tr),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _dayController,
                      decoration: InputDecoration(labelText: 'day'.tr),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _hourController,
                      decoration: InputDecoration(labelText: 'hour'.tr),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _minuteController,
                      decoration: InputDecoration(labelText: 'minute'.tr),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _gender,
                      decoration: InputDecoration(labelText: 'gender'.tr),
                      onChanged: (value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                      items: [
                        DropdownMenuItem(value: 'male', child: Text('male'.tr)),
                        DropdownMenuItem(
                          value: 'female',
                          child: Text('female'.tr),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // 日期类型
              Row(
                children: [
                  Text('date_type'.tr),
                  Radio<bool>(
                    value: false,
                    groupValue: _isLunar,
                    onChanged: (value) {
                      setState(() {
                        _isLunar = value!;
                      });
                    },
                  ),
                  Text('solar'.tr),
                  Radio<bool>(
                    value: true,
                    groupValue: _isLunar,
                    onChanged: (value) {
                      setState(() {
                        _isLunar = value!;
                      });
                    },
                  ),
                  Text('lunar'.tr),
                ],
              ),

              const SizedBox(height: 20),

              // 计算按钮
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _isLoading ? null : _calculateBaZi,
                    child: Text('calculate_bazi'.tr),
                  ),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _calculateChart,
                    child: Text('calculate_chart'.tr),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 添加真太阳时功能入口
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '新增功能: 真太阳时',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '基于观测地点的实际太阳位置计算真实太阳时间',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.watch_later_outlined),
                          label: const Text('查看真太阳时'),
                          onPressed: () {
                            Get.to(() => const SolarTimeUtilExample());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              if (_isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ),
                ),

              // 八字结果
              if (_baziResult != null) ...[
                const SizedBox(height: 20),
                Text(
                  'bazi_result'.tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      const JsonEncoder.withIndent('  ').convert(_baziResult),
                      style: const TextStyle(fontFamily: 'monospace'),
                    ),
                  ),
                ),
              ],

              // 紫微星盘结果
              if (_chartResult != null) ...[
                const SizedBox(height: 20),
                Text(
                  'chart_result'.tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ZiWeiChartView(chart: _chartResult!),
                // Card(
                //   child: Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: Text(
                //       const JsonEncoder.withIndent('  ').convert(_chartResult),
                //       style: const TextStyle(fontFamily: 'monospace'),
                //     ),
                //   ),
                // ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
