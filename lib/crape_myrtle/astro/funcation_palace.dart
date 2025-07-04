import 'package:dart_iztro/crape_myrtle/astro/analyzer.dart';
import 'package:dart_iztro/crape_myrtle/astro/funcation_astrolabe.dart';
import 'package:dart_iztro/crape_myrtle/data/types/astro.dart';
import 'package:dart_iztro/crape_myrtle/data/types/general.dart';
import 'package:dart_iztro/crape_myrtle/data/types/palace.dart';
import 'package:dart_iztro/crape_myrtle/star/funcational_star.dart';
import 'package:dart_iztro/crape_myrtle/translations/types/earthly_branch.dart';
import 'package:dart_iztro/crape_myrtle/translations/types/heavenly_stem.dart';
import 'package:dart_iztro/crape_myrtle/translations/types/mutagen.dart';
import 'package:dart_iztro/crape_myrtle/translations/types/palace.dart';
import 'package:dart_iztro/crape_myrtle/translations/types/star_name.dart';

/// 宫位类的接口定义。
///
/// 文档地址：https://docs.iztro.com/posts/palace.html#functionalastrolabe
abstract class IFunctionalPalace implements Palace {
  /// 判断某个宫位内是否有传入的星耀，要所有星耀都在宫位内才会返回true
  ///
  /// @version v1.0.0
  ///
  /// @param stars 星耀名称，可以包含主星、辅星、杂耀
  /// @returns true | false
  bool has(List<StarName> stars);

  /// 判断某个宫位内是否有传入的星耀，要所有星耀都不在宫位内才会返回true
  ///
  /// @version v1.0.0
  ///
  /// @param stars 星耀名称，可以包含主星、辅星、杂耀
  /// @returnstrue | false
  bool notHave(List<StarName> stars);

  /// 判断某个宫位内是否有传入星耀的其中一个，只要命中一个就会返回true
  ///
  /// @version v1.0.0
  ///
  /// @param stars 星耀名称，可以包含主星、辅星、杂耀
  /// @returns true | false
  bool hasOneOf(List<StarName> stars);

  /// 判断宫位内是否有生年四化
  ///
  /// @version v1.2.0
  ///
  /// @param mutagen 四化名称【禄｜权｜科｜忌】
  /// @returns true | false
  bool hasMutagen(Mutagen mutagen);

  /// 判断宫位内是否没有生年四化
  ///
  /// @version v1.2.0
  ///
  /// @param mutagen 四化名称【禄｜权｜科｜忌】
  /// @returns true | false
  bool nothaveMutagen(Mutagen mutagen);

  /// 判断一个宫位是否为空宫（没有主星），
  /// 有些派别在宫位内有某些星耀的情况下，
  /// 是不会将该宫位判断为空宫的。
  /// 所以加入一个参数来传入星耀。
  ///
  /// @version v2.0.6
  ///
  /// @param excludeStars 星耀名称数组
  ///
  /// @returns {boolean}  true | false
  bool isEmpty(List<StarName> excludeStars);

  /// 给宫位设置星盘对象
  ///
  /// @version v2.1.0
  ///
  /// @param astro 星盘对象
  /// @returns {void}
  void setAstrolabe(IFunctionalAstrolabe astro);

  /// 获取当前宫位所在的星盘对象
  ///
  /// @version v2.1.0
  ///
  /// @returns {IFunctionalAstrolabe}
  IFunctionalAstrolabe? astrolabe();

  /// 判断是否从源宫位飞化到目标宫位，四化可传入一个数组或者一个字符串，传入四化全部飞化到目标宫位即返回true
  ///
  /// @version v2.1.0
  ///
  /// @param  to 目标宫位
  /// @param withMutagens 四化（禄、权、科、忌）
  /// @returns {boolean}
  bool fliesTo(dynamic to, List<Mutagen> mutagens);

  /// 判断是否从源宫位飞化其中一颗四化星到目标宫位，传入四化只要有一颗飞化到目标宫位即返回true
  ///
  /// @version v2.1.0
  ///
  /// @param  to 目标宫位
  /// @param withMutagens 四化（禄、权、科、忌）
  /// @returns {boolean}
  bool fliesOneOfTo(dynamic to, List<Mutagen> mutagens);

  /// 判断是否没有从源宫位飞化到目标宫位，四化可传入一个数组或者一个字符串，传入四化全部没有飞化到目标宫位才返回true
  ///
  /// @version v2.1.0
  ///
  /// @param to 目标宫位
  /// @param withMutagens 四化（禄、权、科、忌）
  /// @returns {boolean}
  bool notFlyTo(dynamic to, List<Mutagen> mutagens);

  /// 判断宫位是否有自化，传入四化数组时需要全部满足才返回true
  ///
  /// @version v2.1.0
  ///
  /// @param withMutagens 四化（禄、权、科、忌）
  /// @returns {boolean}
  bool selfMutaged(List<Mutagen> mutagens);

  /// 判断宫位是否有自化，若不传入参数则会判断所有四化，满足一颗即返回true
  ///
  /// @version v2.1.0
  ///
  /// @param withMutagens 四化（禄、权、科、忌）
  /// @returns {boolean}
  bool selfMutagedOneOf(List<Mutagen> mutagens);

  /// 判断宫位是否有自化，如果传入参数，则只判断传入的四化是否有自化，否则将会判断所有四化
  ///
  /// @version v2.1.0
  ///
  /// @param withMutagens 【可选】四化（禄、权、科、忌）
  /// @returns {boolean}
  bool notSelfMutaged(List<Mutagen> mutagens);

  /// 获取当前宫位产生四化的4个宫位数组，下标分别对【禄，权，科，忌】
  ///
  /// @version v2.1.0
  ///
  /// @returns {(IFunctionalPalace | undefined)[]}
  List<IFunctionalPalace>? mutagedPalaces();
}

class FunctionalPalace implements IFunctionalPalace {
  IFunctionalAstrolabe? _astrolabe;

  @override
  late List<FunctionalStar> adjectiveStars;

  @override
  late StarName boShi12;

  @override
  late StarName changShen12;

  @override
  late EarthlyBranchName earthlyBranch;

  @override
  late HeavenlyStemName heavenlySten;

  @override
  late int index;

  @override
  late bool isBodyPalace;

  @override
  late StarName jiangQian12;

  @override
  late List<FunctionalStar> majorStars;

  @override
  late List<FunctionalStar> minorStars;

  @override
  late PalaceName name;

  @override
  late StarName suiQian12;

  @override
  late bool isOriginalPalace;
  @override
  late Decadal decadal;
  @override
  late List<int> ages;

  @override
  late List<int> yearlies;

  FunctionalPalace(Palace palace) {
    index = palace.index;
    name = palace.name;
    isBodyPalace = palace.isBodyPalace;
    isOriginalPalace = palace.isOriginalPalace;
    heavenlySten = palace.heavenlySten;
    earthlyBranch = palace.earthlyBranch;
    majorStars = palace.majorStars;
    minorStars = palace.minorStars;
    adjectiveStars = palace.adjectiveStars;
    changShen12 = palace.changShen12;
    boShi12 = palace.boShi12;
    jiangQian12 = palace.jiangQian12;
    suiQian12 = palace.suiQian12;
    decadal = palace.decadal;
    ages = palace.ages;
    yearlies = palace.yearlies;
  }

  @override
  bool has(List<StarName> stars) {
    // TODO: implement has
    return hasStar(this, stars);
  }

  @override
  IFunctionalAstrolabe? astrolabe() {
    // TODO: implement astrolabe
    return _astrolabe;
  }

  @override
  bool fliesOneOfTo(to, mutagens) {
    // TODO: implement fliesOneOfTo
    final toPalace = astrolabe()?.palace(to);
    if (toPalace == null) {
      return false;
    }
    final stars = mutagensToStars(heavenlySten, mutagens);
    if (stars.isEmpty) {
      return false;
    }
    return toPalace.hasOneOf(stars);
  }

  @override
  bool fliesTo(to, mutagens) {
    // TODO: implement fliesTo
    final toPalace = astrolabe()?.palace(to);
    if (toPalace == null) {
      return false;
    }
    final stars = mutagensToStars(heavenlySten, mutagens);
    if (stars.isEmpty) {
      return false;
    }
    return toPalace.has(stars);
  }

  @override
  bool hasMutagen(Mutagen mutagen) {
    // TODO: implement hasMutagen
    return hasMutagenInPalace(this, mutagen);
  }

  @override
  bool hasOneOf(List<StarName> stars) {
    // TODO: implement hasOneOf
    return hasOneOfStars(this, stars);
  }

  @override
  bool isEmpty(List<StarName> excludeStars) {
    if (majorStars.where((item) => item.type == StarType.major).isNotEmpty) {
      return false;
    }
    if (excludeStars.isNotEmpty && hasOneOf(excludeStars)) {
      return false;
    }
    return true;
  }

  @override
  bool notFlyTo(to, mutagens) {
    // TODO: implement notFlyTo
    final toPalace = astrolabe()?.palace(to);
    if (toPalace == null) {
      return false;
    }
    final stars = mutagensToStars(heavenlySten, mutagens);
    if (stars.isEmpty) {
      return true;
    }
    return toPalace.notHave(stars);
  }

  @override
  bool notHave(List<StarName> stars) {
    return notHaveStars(this, stars);
  }

  @override
  bool notSelfMutaged(mutagens) {
    dynamic muts;
    if (mutagens is Mutagen) {
      if (mutagens == null) {
        muts = [
          Mutagen.siHuaLu,
          Mutagen.siHuaQuan,
          Mutagen.siHuaKe,
          Mutagen.siHuaJi,
        ];
      } else {
        muts = mutagens;
      }
    }
    final stars = mutagensToStars(heavenlySten, muts);
    return notHave(stars);
  }

  @override
  bool nothaveMutagen(Mutagen mutagen) {
    return has(mutagensToStars(heavenlySten, [mutagen]));
  }

  @override
  bool selfMutaged(mutagens) {
    final stars = mutagensToStars(heavenlySten, mutagens);
    return has(stars);
  }

  @override
  bool selfMutagedOneOf(List<Mutagen> mutagens) {
    List<Mutagen> muts;
    if (mutagens.isEmpty) {
      muts = [
        Mutagen.siHuaLu,
        Mutagen.siHuaQuan,
        Mutagen.siHuaKe,
        Mutagen.siHuaJi,
      ];
    } else {
      muts = mutagens;
    }
    final stars = mutagensToStars(heavenlySten, muts);
    return hasOneOf(stars);
  }

  @override
  void setAstrolabe(IFunctionalAstrolabe astro) {
    _astrolabe = astro;
  }

  @override
  List<IFunctionalPalace>? mutagedPalaces() {
    if (_astrolabe == null) {
      return [];
    }
    final stars = mutagensToStars(heavenlySten, [
      Mutagen.siHuaLu,
      Mutagen.siHuaQuan,
      Mutagen.siHuaKe,
      Mutagen.siHuaJi,
    ]);
    final result =
        stars.map((star) => _astrolabe?.star(star)?.palace()).toList();

    // print('mutagedPalaces length ${result.length} $result');
    List<IFunctionalPalace> list = [];
    for (var item in result) {
      if (item != null) {
        list.add(item!);
      }
    }
    return list;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'index = $index, palace name = ${name.title}, decadals $decadal, ages $ages, star names ${majorStars.map((e) => e.name).toList()}, ${minorStars.map((e) => e.name).toList()}, ${adjectiveStars.map((e) => e.name).toList()}';
  }

  Map<String, dynamic> toJson() {
    return {
      "index": index,
      "name": name.title,
      "isBodyPalace": isBodyPalace,
      "isOriginalPalace": isOriginalPalace,
      "heavenlyStem": heavenlySten.title,
      "earthlyBranch": earthlyBranch.title,
      "majorStars": majorStars.map((s) => s.toJson()).toList(),
      "minorStars": minorStars.map((s) => s.toJson()).toList(),
      "adjectiveStars": adjectiveStars.map((s) => s.toJson()).toList(),
      "changsheng12": changShen12.title,
      "boshi12": boShi12.title,
      "jiangqian12": jiangQian12.title,
      "suiqian12": suiQian12.title,
      "decadal": {
        "range": decadal.range,
        "heavenlyStem": decadal.heavenlyStem.title,
        "earthlyBranch": decadal.earthlyBranch.title,
      },
      "ages": ages,
      "yearlies": yearlies,
    };
  }

}
