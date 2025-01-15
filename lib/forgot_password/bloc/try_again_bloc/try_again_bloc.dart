import "package:flutter_bloc/flutter_bloc.dart";

class TryAgainBloc extends Cubit<bool> {
  TryAgainBloc() : super(false);

  void showText() => emit(true);
}
