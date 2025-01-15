import "package:package_info_plus/package_info_plus.dart";

class PackageInfoRepository {
  Future<PackageInfo> getPackageInfo() => PackageInfo.fromPlatform();
}
