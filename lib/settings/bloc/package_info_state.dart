import "package:freezed_annotation/freezed_annotation.dart";

part "package_info_state.freezed.dart";

@freezed
class PackageInfoState with _$PackageInfoState {
  const factory PackageInfoState.initial() = PackageInfoInitial;
  const factory PackageInfoState.fetched({required String version}) =
      PackageInfoFetched;
  const factory PackageInfoState.fetchFailure() = PackageInfoFetchFailure;
}
