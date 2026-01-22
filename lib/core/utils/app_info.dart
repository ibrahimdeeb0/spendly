import 'package:package_info_plus/package_info_plus.dart';

abstract class AppInfo {
  Future<String> getVersionLabel(); // e.g. "1.0.0 (10)"
}

class PackageAppInfo implements AppInfo {
  @override
  Future<String> getVersionLabel() async {
    final info = await PackageInfo.fromPlatform();
    return '${info.version} (${info.buildNumber})';
  }
}
