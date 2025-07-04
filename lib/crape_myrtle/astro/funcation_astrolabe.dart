import 'package:dart_iztro/crape_myrtle/astro/analyzer.dart';
import 'package:dart_iztro/crape_myrtle/astro/astro.dart';
import 'package:dart_iztro/crape_myrtle/astro/funcation_horoscope.dart';
import 'package:dart_iztro/crape_myrtle/astro/funcation_palace.dart';
import 'package:dart_iztro/crape_myrtle/astro/funcation_surpalaces.dart';
import 'package:dart_iztro/crape_myrtle/astro/palace.dart';
import 'package:dart_iztro/crape_myrtle/data/constants.dart';
import 'package:dart_iztro/crape_myrtle/data/types/astro.dart';
import 'package:dart_iztro/crape_myrtle/data/types/general.dart';
import 'package:dart_iztro/crape_myrtle/star/funcational_star.dart';
import 'package:dart_iztro/crape_myrtle/star/horoscope_star.dart';
import 'package:dart_iztro/crape_myrtle/tools/crape_util.dart';
import 'package:dart_iztro/crape_myrtle/translations/types/earthly_branch.dart';
import 'package:dart_iztro/crape_myrtle/translations/types/five_element_class.dart';
import 'package:dart_iztro/crape_myrtle/translations/types/heavenly_stem.dart';
import 'package:dart_iztro/crape_myrtle/translations/types/palace.dart';
import 'package:dart_iztro/crape_myrtle/translations/types/star_name.dart';
import 'package:dart_iztro/lunar_lite/utils/convertor.dart';
import 'package:dart_iztro/lunar_lite/utils/ganzhi.dart';
import 'package:dart_iztro/lunar_lite/utils/utils.dart';

abstract class IFunctionalAstrolabe implements Astrolabe {
  /// 插件注入方法
  void use(Plugin plugin);

  /// 获取运限数据
  /// 阳历日期，默认位调用时的日期
  /// 时辰索引，默认位自动读取当前时间的时辰
  /// return 运限数据
  IFunctionalHoroscpoe horoscope({required String date, int? timeIndex});

  /// 通过星耀名称获取到当前星耀的对象实例
  /// starName 星耀名称
  /// return 星耀实例
  IFunctionalStar? star(StarName starName);

  /// 获取星盘的某一个宫位， 通过宫位索引或者宫位名称都可以获取到，
  /// index 宫位索引
  /// starName 宫位名称
  IFunctionalPalace? palace(dynamic indexOfPalace);

  /// 获取三方四正宫位，所谓三方四正就是传入的目标宫位，以及其对宫位，财帛位和官禄位，总共四个宫位 通过宫位索引或者宫位名称获取
  /// index 宫位索引
  /// starName 宫位名称
  IFunctionlSurpalaces surroundedPalaces(dynamic indexOfPalace);

  /// 判断某一个宫位三方四正是否包含目标星耀，必须要全部包含才会返回true
  /// index 宫位索引
  /// starName 宫位名称
  /// stars 星耀名称数组
  bool isSurrounded(dynamic indexOfPalace, List<StarName> stars);

  /// 判断三方四正内是否有传入星耀的其中一个，只要命中一个就会返回true
  /// index 宫位索引
  /// starName 宫位名称
  /// stars 星耀名称数组
  bool isSurroundedOneOf(dynamic indexOfPalace, List<StarName> stars);

  /// 判断某一个宫位三方四正是否不含目标星耀，必须要全部都不在三方四正内含才会返回true
  /// index 宫位索引
  /// starName 宫位名称
  /// stars 星耀名称数组
  bool notSurrounded(dynamic indexOfPalace, List<StarName> stars);
}

class FunctionalAstrolabe implements IFunctionalAstrolabe {
  @override
  late StarName body;

  @override
  late String chineseDate;

  @override
  late String copyright;

  @override
  late EarthlyBranchName earthlyBranchOfBodyPalace;

  @override
  late EarthlyBranchName earthlyBranchOfSoulPalace;

  @override
  late FiveElementsFormat fiveElementClass;

  @override
  late String gender;

  @override
  late String lunarDate;

  @override
  late List<IFunctionalPalace> palaces;

  @override
  late LunarDateObj rawDates;

  @override
  late String sign;

  @override
  late String solarDate;

  @override
  late StarName soul;

  @override
  late String time;

  @override
  late String timeRage;

  @override
  late String zodiac;

  late final List<Plugin> _plugins = [];

  FunctionalAstrolabe(Astrolabe data) {
    gender = data.gender;
    solarDate = data.solarDate;
    lunarDate = data.lunarDate;
    chineseDate = data.chineseDate;
    rawDates = data.rawDates;
    time = data.time;
    timeRage = data.timeRage;
    sign = data.sign;
    zodiac = data.zodiac;
    earthlyBranchOfBodyPalace = data.earthlyBranchOfBodyPalace;
    earthlyBranchOfSoulPalace = data.earthlyBranchOfSoulPalace;
    soul = data.soul;
    body = data.body;
    fiveElementClass = data.fiveElementClass;
    palaces = data.palaces;
    copyright = data.copyright;
  }

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln('FunctionalAstrolabe {');
    buffer.writeln('  gender: $gender,');
    buffer.writeln('  solarDate: $solarDate,');
    buffer.writeln('  lunarDate: $lunarDate,');
    buffer.writeln('  chineseDate: $chineseDate,');
    buffer.writeln('  rawDates: $rawDates,');
    buffer.writeln('  time: $time,');
    buffer.writeln('  timeRange: $timeRage,');
    buffer.writeln('  sign: $sign,');
    buffer.writeln('  zodiac: $zodiac,');
    buffer.writeln('  earthlyBranchOfSoulPalace: ${earthlyBranchOfSoulPalace.title},');
    buffer.writeln('  earthlyBranchOfBodyPalace: ${earthlyBranchOfBodyPalace.title},');
    buffer.writeln('  soul: ${soul.title},');
    buffer.writeln('  body: ${body.title},');
    buffer.writeln('  fiveElementClass: ${fiveElementClass.title},');
    buffer.writeln('  palaces: [');

    for (var palace in palaces) {
      buffer.writeln('    {');
      buffer.writeln('      index: ${palace.index},');
      buffer.writeln('      name: ${palace.name.title},');
      buffer.writeln('      isBodyPalace: ${palace.isBodyPalace},');
      buffer.writeln('      isOriginalPalace: ${palace.isOriginalPalace},');
      buffer.writeln('      heavenlyStem: ${palace.heavenlySten.title},');
      buffer.writeln('      earthlyBranch: ${palace.earthlyBranch.title},');

      buffer.writeln('      majorStars: [${palace.majorStars.map((s) => s.name.title).join(', ')}],');
      buffer.writeln('      minorStars: [${palace.minorStars.map((s) => s.name.title).join(', ')}],');
      buffer.writeln('      adjectiveStars: [${palace.adjectiveStars.map((s) => s.name.title).join(', ')}],');

      buffer.writeln('      changsheng12: ${palace.changShen12.title},');
      buffer.writeln('      boshi12: ${palace.boShi12.title},');
      buffer.writeln('      jiangqian12: ${palace.jiangQian12.title},');
      buffer.writeln('      suiqian12: ${palace.suiQian12.title},');

      buffer.writeln('      decadal: {');
      buffer.writeln('        range: ${palace.decadal.range},');
      buffer.writeln('        heavenlyStem: ${palace.decadal.heavenlyStem.title},');
      buffer.writeln('        earthlyBranch: ${palace.decadal.earthlyBranch.title}');
      buffer.writeln('      },');

      buffer.writeln('      ages: ${palace.ages}');
      buffer.writeln('    },');
    }

    buffer.writeln('  ]');
    buffer.writeln('}');

    return buffer.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      "gender": gender,
      "solarDate": solarDate,
      "lunarDate": lunarDate,
      "chineseDate": chineseDate,
      "time": time,
      "timeRange": timeRage,
      "sign": sign,
      "zodiac": zodiac,
      "earthlyBranchOfSoulPalace": earthlyBranchOfSoulPalace.title,
      "earthlyBranchOfBodyPalace": earthlyBranchOfBodyPalace.title,
      "soul": soul.title,
      "body": body.title,
      "fiveElementsClass": fiveElementClass.title,
      "palaces": palaces.map((p) {
        return {
          "index": p.index,
          "name": p.name.title,
          "isBodyPalace": p.isBodyPalace,
          "isOriginalPalace": p.isOriginalPalace,
          "heavenlyStem": p.heavenlySten.title,
          "earthlyBranch": p.earthlyBranch.title,
          "majorStars": p.majorStars.map((s) => s.toJson()).toList(),
          "minorStars": p.minorStars.map((s) => s.toJson()).toList(),
          "adjectiveStars": p.adjectiveStars.map((s) => s.toJson()).toList(),
          "changsheng12": p.changShen12.title,
          "boshi12": p.boShi12.title,
          "jiangqian12": p.jiangQian12.title,
          "suiqian12": p.suiQian12.title,
          "decadal": {
            "range": [p.decadal.range[0], p.decadal.range[1]],
            "heavenlyStem": p.decadal.heavenlyStem.title,
            "earthlyBranch": p.decadal.earthlyBranch.title,
          },
          "ages": p.ages,
        };
      }).toList()
    };
  }

  @override
  IFunctionalHoroscpoe horoscope({required String date, int? timeIndex}) {
    // TODO: implement horoscope
    return _getHoroscopeBySolarDate(this, date, timeIndex);
  }

  @override
  IFunctionalStar? star(StarName starName) {
    // TODO: implement star
    IFunctionalStar? target;
    for (int i = 0; i < palaces.length; i++) {
      final palace = palaces[i];
      final stars =
          [
            ...palace.majorStars,
            ...palace.minorStars,
            ...palace.adjectiveStars,
          ].toList();
      for (int j = 0; j < stars.length; j++) {
        if (stars[j].name.starKey == starName.starKey) {
          target = stars[j];
          target.setPalace(palace);
          target.setAstrolabe(this);
          break;
        }
      }
    }
    if (target == null) {
      Exception('星耀名称错误，请检查星耀名称是否正确');
    }
    return target;
  }

  @override
  void use(Plugin plugin) {
    // TODO: implement use
    _plugins.add(plugin);
  }

  @override
  bool isSurrounded(dynamic indexOfPalace, List<StarName> stars) {
    // TODO: implement isSurrounded
    return surroundedPalaces(indexOfPalace).have(stars);
  }

  @override
  bool isSurroundedOneOf(dynamic indexOfPalace, List<StarName> stars) {
    // TODO: implement isSurroundedOneOf
    return surroundedPalaces(indexOfPalace).haveOneOf(stars);
  }

  @override
  bool notSurrounded(dynamic indexOfPalace, List<StarName> stars) {
    // TODO: implement notSurrounded
    return surroundedPalaces(indexOfPalace).notHave(stars);
  }

  @override
  IFunctionalPalace? palace(indexOfPalace) {
    // TODO: implement palace
    return getPalace(this, indexOfPalace);
  }

  @override
  IFunctionlSurpalaces surroundedPalaces(dynamic indexOfPalace) {
    // TODO: implement surroundedPalaces
    return getSurroundedPalaces(this, indexOfPalace);
  }

  /// 私有方法
  /// 获取运限数据
  ///
  /// @version v0.2.1
  ///
  /// @private 私有方法
  ///
  /// @param $ 星盘对象
  /// @param targetDate 阳历日期【可选】，默认为调用时日期
  /// @param timeIndex 时辰序号【可选】，若不传会返回 `targetDate` 中时间所在的时辰
  /// @returns 运限数据
  IFunctionalHoroscpoe _getHoroscopeBySolarDate(
    FunctionalAstrolabe astrolabe,
    String targetDate,
    int? timeIndex,
  ) {
    final birthday = solar2Lunar(astrolabe.solarDate);
    final date = solar2Lunar(targetDate);

    if (timeIndex == null) {
      final convertTimeIndex = timeToIndex(DateTime.parse(targetDate).hour);
      timeIndex = convertTimeIndex;
    }
    final heavenlyStemAndEarthly = getHeavenlyStemAndEarthlyBranchSolarDate(
      targetDate,
      timeIndex,
      getConfig().horoscopeDivide,
      monthOption: getConfig().horoscopeDivide,
    );
    final yearly = heavenlyStemAndEarthly.yearly;
    final monthly = heavenlyStemAndEarthly.monthly;
    final daily = heavenlyStemAndEarthly.daily;
    final hourly = heavenlyStemAndEarthly.hourly;

    // 虚岁
    var nomialAge = date.lunarYear - birthday.lunarYear;
    // 是否童限
    var isChildHood = false;

    if (getConfig().ageDivide == AgeDivide.birthday) {
      // 假如目标日期已经过了生日，则需要加1岁
      // 比如2022年九月初一 出生的人，在出生后虚岁为1岁
      // 2022年九月初二 出生的人，在出生后虚岁为2岁
      if ((date.lunarYear == birthday.lunarYear &&
              date.lunarMonth == birthday.lunarMonth &&
              date.lunarDay > birthday.lunarDay) ||
          date.lunarMonth > birthday.lunarMonth) {
        nomialAge += 1;
      }
    } else {
      nomialAge += 1;
    }

    // 大限索引
    var decadalIndex = -1;
    // 天干
    var heavenlyStemOfDecade = HeavenlyStemName.jiaHeavenly;
    // 地支
    var earthlyBranchOfDecade = EarthlyBranchName.ziEarthly;
    // 小限索引
    var ageIndex = -1;
    // 流年索引
    final yearlyIndex = fixEarthlyBranchIndex(
      getMyEarthlyBranchNameFrom(yearly[1]),
    );
    // 流月索引
    var monthlyIndex = -1;
    // 流日索引
    var dailyIndex = -1;
    // 流时索引
    var hourlyIndex = -1;
    // 小限天干
    var heavenlyStenOfAge = HeavenlyStemName.jiaHeavenly;
    // 小限地支
    var earthlyBranchOfAge = EarthlyBranchName.ziEarthly;
    // 查询大限索引
    for (int index = 0; index < astrolabe.palaces.length; index++) {
      final palace = astrolabe.palaces[index];
      if (nomialAge >= palace.decadal.range[0] &&
          nomialAge <= palace.decadal.range[1]) {
        decadalIndex = index;
        heavenlyStemOfDecade = palace.decadal.heavenlyStem;
        earthlyBranchOfDecade = palace.decadal.earthlyBranch;
        break; // 跳出循环
      }
    }

    if (decadalIndex < 0) {
      // ['命宫', '财帛', '疾厄', '夫妻', '福德', '官禄'];
      final palaces = [
        PalaceName.soulPalace,
        PalaceName.wealthPalace,
        PalaceName.healthPalace,
        PalaceName.spousePalace,
        PalaceName.spiritPalace,
        PalaceName.careerPalace,
      ];
      if (nomialAge > 0) {
        final targetIndex = palaces[nomialAge - 1];
        final targetPalace = astrolabe.palace(targetIndex);

        if (targetPalace != null) {
          isChildHood = true;
          decadalIndex = targetPalace.index;
          heavenlyStemOfDecade = targetPalace.heavenlySten;
          earthlyBranchOfDecade = targetPalace.earthlyBranch;
        }
      }
    }
    for (int index = 0; index < astrolabe.palaces.length; index++) {
      final palace = astrolabe.palaces[index];
      if (palace.ages.contains(nomialAge)) {
        ageIndex = astrolabe.palaces.indexOf(palace);
        heavenlyStenOfAge = palace.heavenlySten;
        earthlyBranchOfAge = palace.earthlyBranch;
        break;
      }
    }
    final earthlyBranchHourly = getMyEarthlyBranchNameFrom(
      astrolabe.rawDates.chineseDate.hourly[1],
    );
    // 计算流月时需要考虑生月闰月情况，如果是后15天则计算时需要加1月
    final leapAddtion = birthday.isLeap && birthday.lunarDay > 15 ? 1 : 0;
    final dateLeapAddtion = date.isLeap && date.lunarDay > 15 ? 1 : 0;
    monthlyIndex = fixIndex(
      yearlyIndex -
          (birthday.lunarMonth + leapAddtion) +
          earthlyBranches.indexOf(earthlyBranchHourly.key) +
          date.lunarMonth +
          dateLeapAddtion,
    );
    dailyIndex = fixIndex(monthlyIndex + date.lunarDay - 1);
    final currentHourlyBranches = getMyEarthlyBranchNameFrom(
      heavenlyStemAndEarthly.hourly[1],
    );
    hourlyIndex = fixIndex(
      dailyIndex + earthlyBranches.indexOf(currentHourlyBranches.key),
    );

    final scope = Horoscope(
      lunarDate: date.toChString(true),
      solarDate: normalDateFromStr(targetDate).getRange(0, 3).join('-'),
      decadal: HoroscopeItem(
        index: decadalIndex,
        name: isChildHood ? "childhood" : "decadal",
        heavenlyStem: heavenlyStemOfDecade,
        earthlyBranch: earthlyBranchOfDecade,
        palaceNames: getPalaceNames(decadalIndex),
        mutagen: getMutagensByHeavenlyStem(heavenlyStemOfDecade),
        stars: getHoroscopeStar(
          heavenlyStemOfDecade,
          earthlyBranchOfDecade,
          Scope.decadal,
        ),
      ),
      age: AgeHoroscope(
        heavenlyStem: heavenlyStenOfAge,
        earthlyBranch: earthlyBranchOfAge,
        palaceNames: getPalaceNames(ageIndex),
        mutagen: getMutagensByHeavenlyStem(
          getMyHeavenlyStemNameFrom(heavenlyStemAndEarthly.yearly[0]),
        ),
        nominalAge: nomialAge,
        index: ageIndex,
        name: 'turn',
      ),
      yearly: YearlyHoroscope(
        heavenlyStem: getMyHeavenlyStemNameFrom(yearly[0]),
        earthlyBranch: getMyEarthlyBranchNameFrom(yearly[1]),
        palaceNames: getPalaceNames(yearlyIndex),
        mutagen: getMutagensByHeavenlyStem(
          getMyHeavenlyStemNameFrom(yearly[0]),
        ),
        stars: getHoroscopeStar(
          getMyHeavenlyStemNameFrom(yearly[0]),
          getMyEarthlyBranchNameFrom(yearly[1]),
          Scope.yearly,
        ),
        index: yearlyIndex,
        name: "yearly",
      ),
      monthly: HoroscopeItem(
        index: monthlyIndex,
        name: "monthly",
        heavenlyStem: getMyHeavenlyStemNameFrom(monthly[0]),
        earthlyBranch: getMyEarthlyBranchNameFrom(monthly[1]),
        palaceNames: getPalaceNames(monthlyIndex),
        mutagen: getMutagensByHeavenlyStem(
          getMyHeavenlyStemNameFrom(monthly[0]),
        ),
        stars: getHoroscopeStar(
          getMyHeavenlyStemNameFrom(monthly[0]),
          getMyEarthlyBranchNameFrom(monthly[1]),
          Scope.monthly,
        ),
      ),
      daily: HoroscopeItem(
        index: dailyIndex,
        name: "daily",
        heavenlyStem: getMyHeavenlyStemNameFrom(daily[0]),
        earthlyBranch: getMyEarthlyBranchNameFrom(daily[1]),
        palaceNames: getPalaceNames(dailyIndex),
        mutagen: getMutagensByHeavenlyStem(getMyHeavenlyStemNameFrom(daily[0])),
        stars: getHoroscopeStar(
          getMyHeavenlyStemNameFrom(daily[0]),
          getMyEarthlyBranchNameFrom(daily[1]),
          Scope.daily,
        ),
      ),
      hourly: HoroscopeItem(
        index: hourlyIndex,
        name: "hourly",
        heavenlyStem: getMyHeavenlyStemNameFrom(hourly[0]),
        earthlyBranch: getMyEarthlyBranchNameFrom(hourly[1]),
        palaceNames: getPalaceNames(hourlyIndex),
        mutagen: getMutagensByHeavenlyStem(
          getMyHeavenlyStemNameFrom(hourly[0]),
        ),
        stars: getHoroscopeStar(
          getMyHeavenlyStemNameFrom(hourly[0]),
          getMyEarthlyBranchNameFrom(hourly[1]),
          Scope.hourly,
        ),
      ),
    );

    return FunctionalHoroscope(scope, astrolabe);
  }
}
