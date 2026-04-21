import 'package:flutter/services.dart';

/// 把日志从 Dart 转发到 Android 原生 Log
/// 让 release 构建也能用 `adb logcat -s FluxDiag:V` 直接看到
class NativeLogger {
  static const MethodChannel _channel = MethodChannel('com.example.flux/log');

  static Future<void> i(String tag, String message) => _log('i', tag, message);
  static Future<void> w(String tag, String message) => _log('w', tag, message);
  static Future<void> e(String tag, String message) => _log('e', tag, message);
  static Future<void> d(String tag, String message) => _log('d', tag, message);

  static Future<void> _log(String level, String tag, String message) async {
    try {
      await _channel.invokeMethod('log', {
        'tag': tag,
        'message': message,
        'level': level,
      });
    } catch (_) {
      // 静默：iOS/桌面 平台没接通也 ok
    }
  }
}
