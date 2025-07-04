import 'package:dart_iztro/crape_myrtle/astro/funcation_astrolabe.dart';
import 'package:dart_iztro/crape_myrtle/astro/funcation_palace.dart';
import 'package:dart_iztro/crape_myrtle/astro/funcation_surpalaces.dart';
import 'package:dart_iztro/crape_myrtle/data/types/general.dart';
import 'package:dart_iztro/crape_myrtle/data/types/star.dart';
import 'package:dart_iztro/crape_myrtle/translations/types/brightness.dart';
import 'package:dart_iztro/crape_myrtle/translations/types/mutagen.dart';
import 'package:dart_iztro/crape_myrtle/translations/types/star_name.dart';
import 'package:flutter/foundation.dart';

abstract class IFunctionalStar implements Star {
  /// 获取星耀所在宫位
  IFunctionalPalace? palace();

  /// 设置当前星耀所在宫位
  void setPalace(IFunctionalPalace palace);

  /// 设置当前星耀所在星盘
  void setAstrolabe(IFunctionalAstrolabe astrolabe);

  /// 获取当前星耀的三方四正宫位
  IFunctionlSurpalaces? surroundedPalaces();

  /// 获取当前星耀的对宫
  IFunctionalPalace? oppositePalace();

  /// 判断星耀是否是传入的亮度，也可以传入多个亮度，只要匹配到一个亮度就会返回true
  bool withBrightness(List<BrightnessEnum> brightness);

  /// 判断星耀是否产生了四化
  bool withMutagen(List<Mutagen> mutagen);
}

class FunctionalStar extends IFunctionalStar {
  @override
  late BrightnessEnum? brightness;

  @override
  late Mutagen? mutagen;

  @override
  late StarName name;

  @override
  late Scope scope;

  @override
  late StarType type;

  IFunctionalPalace? _palace;
  IFunctionalAstrolabe? _astrolabe;

  FunctionalStar(Star data) {
    brightness = data.brightness;
    mutagen = data.mutagen;
    name = data.name;
    scope = data.scope;
    type = data.type;
  }

  @override
  IFunctionalPalace? palace() {
    return _palace;
  }

  @override
  void setAstrolabe(IFunctionalAstrolabe astrolabe) {
    _astrolabe = astrolabe;
  }

  @override
  void setPalace(IFunctionalPalace palace) {
    _palace = palace;
  }

  @override
  surroundedPalaces() {
    if (_palace == null) {
      return null;
    }
    // return _astrolabe.su
    return _astrolabe?.surroundedPalaces(_palace?.name);
  }

  @override
  IFunctionalPalace? oppositePalace() {
    // TODO: implement oppositePalace
    if (_palace == null || _astrolabe == null) {
      return null;
    }
    return _astrolabe?.surroundedPalaces(_palace?.name).opposite;
  }

  @override
  bool withBrightness(List<BrightnessEnum> brightness) {
    // TODO: implement withBrightness
    if (brightness.isNotEmpty) {
      var isContain = false;
      for (BrightnessEnum brightness in brightness) {
        if (brightness.key == this.brightness?.key) {
          isContain = true;
          break;
        }
      }
      return isContain;
    }
    return false;
  }

  @override
  bool withMutagen(List<Mutagen> mutagen) {
    if (mutagen.isNotEmpty) {
      var isContain = false;
      for (Mutagen mu in mutagen) {
        if (mu.key == this.mutagen?.key) {
          isContain = true;
          break;
        }
      }
      return isContain;
    }
    return false;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "{name: ${name.title}, type: ${type.title}, brightness: ${brightness?.title}, scope: ${scope.title}, mutagen: ${mutagen?.title}}";
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name.title,
      'type': type.title,
      'scope': scope.title,
      'brightness': brightness?.title,
      'mutagen': mutagen?.title,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FunctionalStar &&
        other.name == name &&
        other.type == type &&
        other.scope == scope;
  }

  @override
  int get hashCode => name.hashCode ^ type.hashCode ^ scope.hashCode;
}
