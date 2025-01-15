import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";

class CountdownBloc extends Cubit<int> {
  CountdownBloc() : super(180); // 3 minutes countdown (180 seconds)

  late Timer _timer;

  FutureOr<void> startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        emit(state - 1);
      } else {
        _timer.cancel();
      }
    });
  }
}
