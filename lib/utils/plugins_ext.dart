import 'dart:convert';
import 'dart:io';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:mix_music/entity/plugins_info.dart';
import 'package:path/path.dart';

///获取所有插件
Future<List<PluginsInfo>> getSystemPlugins({required String rootDir}) async {
  var dir = Directory(rootDir);
  final plugins = <PluginsInfo>[];
  var list = <FileSystemEntity>[];
  try {
    list = dir.listSync();
  } catch (e) {
    debugPrint("插件目录不存在:$e");
  }

  for (final ext in list) {
    if (ext.path.endsWith(".js")) {
      if (kDebugMode) {
        print(basename(ext.path));
      }
      var file = File(ext.path);
      final content = await file.readAsString();

      var info = parseExtension(content);

      if (info?.name?.isNotEmpty == true) {
        info!.path = ext.path;
        plugins.add(info);
      }
    }
  }
  return plugins;
}

///解析插件
PluginsInfo? parseExtension(String extension) {
  RegExp regex = RegExp(r'==MixMusicPlugin==([\s\S]*?)==\/MixMusicPlugin==');
  Match? match = regex.firstMatch(extension);

  if (match != null) {
    var info = match.group(1)?.trim() ?? "";

    Map<String, dynamic> result = {};
    RegExp reg = RegExp(r'@(\w+)\s+(.*)');
    Iterable<RegExpMatch> matches = reg.allMatches(info);
    for (RegExpMatch match in matches) {
      result[match.group(1)!] = match.group(2);
    }

    if (result.isNotEmpty) {
      result["code"] = extension.replaceAll("\r", "");
    } else {
      return null;
    }

    return JsonMapper.deserialize<PluginsInfo>(json.encode(result));
  } else {
    return null;
  }
}

///js扩展
extension JavascriptRuntimeFetchExtension on JavascriptRuntime {
  ///启用axios
  Future<JavascriptRuntime> enableAxios() async {
    String axios = await rootBundle.loadString("assets/axios.js");
    final evalFetchResult = evaluate(axios);
    if (kDebugMode) {
      print('Axios 结果: $evalFetchResult');
    }
    return this;
  }

  ///启用BigInt
  Future<JavascriptRuntime> enableBigInt() async {
    String axios = await rootBundle.loadString("assets/BigInteger.min.js");
    final evalFetchResult = evaluate(axios);
    if (kDebugMode) {
      print('BigInt 结果: $evalFetchResult');
    }
    return this;
  }

  ///启用Base64
  Future<JavascriptRuntime> enableBase64() async {
    String axios = await rootBundle.loadString("assets/base64-js.js");
    final evalFetchResult = evaluate(axios);
    if (kDebugMode) {
      print('Base64 结果: $evalFetchResult');
    }
    return this;
  }

  ///启用sleep
  Future<JavascriptRuntime> enableSleep() async {
    String sleep = await rootBundle.loadString("assets/sleep.js");
    final evalFetchResult = evaluate(sleep);
    if (kDebugMode) {
      print('sleep 结果: $evalFetchResult');
    }
    return this;
  }

  /// 启用加密
  Future<JavascriptRuntime> enableCrypto() async {
    String crypto = await rootBundle.loadString("assets/crypto.js");
    final evalFetchResult = evaluate(crypto);
    if (kDebugMode) {
      print('crypto 结果: $evalFetchResult');
    }
    return this;
  }
}

///js扩展
extension MethodExtension on JavascriptRuntime {
  bool contains({required String key, String obj = "music"}) {
    var check = evaluate("'$key' in $obj").rawResult as bool;
    return check;
  }

  List<String> keys({required String obj}) {
    var check = evaluate("Object.keys($obj)").rawResult as List;

    return check.map((e) => "$e").toList();
  }
}
