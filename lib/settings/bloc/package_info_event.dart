import "package:freezed_annotation/freezed_annotation.dart";

part "package_info_event.freezed.dart";

@freezed
class PackageInfoEvent with _$PackageInfoEvent {
  const factory PackageInfoEvent.fetchPackageInfo() = FetchPackageInfoEvent;
}
