/// 应用构建时配置
/// 通过 --dart-define 在编译时注入，避免敏感信息硬编码
class AppEnv {
  /// V2Board API 域名 (示例: https://api.example.com)
  static const String apiDomain = String.fromEnvironment(
    'API_DOMAIN',
    defaultValue: '',
  );

  /// 远程配置文件 CDN 地址
  static const String ossUrl = String.fromEnvironment(
    'OSS_URL',
    defaultValue: '',
  );

  /// 配置文件 XOR 加密密钥 (建议 24+ 字符)
  static const String encryptionKey = String.fromEnvironment(
    'ENCRYPTION_KEY',
    defaultValue: '',
  );

  /// 邮箱验证 AES-128 加密密钥 (固定 16 字符)
  static const String emailVerifyKey = String.fromEnvironment(
    'EMAIL_VERIFY_KEY',
    defaultValue: '',
  );

  /// 从 apiDomain 提取纯域名 (去掉 scheme)，用于路由规则
  static String get apiHost {
    if (apiDomain.isEmpty) return '';
    final uri = Uri.tryParse(apiDomain);
    return uri?.host ?? apiDomain.replaceAll(RegExp(r'^https?://'), '');
  }
}
