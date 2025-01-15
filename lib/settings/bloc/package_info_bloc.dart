import "dart:async";
import "package:bank/settings/bloc/package_info_event.dart";
import "package:bank/settings/bloc/package_info_state.dart";
import "package:bank/settings/repository/package_info_repository.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class PackageInfoBloc extends Bloc<PackageInfoEvent, PackageInfoState> {
  PackageInfoBloc({required PackageInfoRepository packageInfoRepository})
      : _packageInfoRepository = packageInfoRepository,
        super(const PackageInfoState.initial()) {
    on<FetchPackageInfoEvent>(_onFetchPackageInfoEvent);
  }

  final PackageInfoRepository _packageInfoRepository;

  FutureOr<void> _onFetchPackageInfoEvent(event, Emitter<dynamic> emit) async {
    try {
      final packageInfo = await _packageInfoRepository.getPackageInfo();
      emit(PackageInfoState.fetched(version: packageInfo.version));
    } catch (_) {
      emit(const PackageInfoState.fetchFailure());
    }
  }
}
