import "package:freezed_annotation/freezed_annotation.dart";

//part  "image_bloc.dart";
part "image_state.freezed.dart";

@freezed
abstract class ImageState with _$ImageState {
  const factory ImageState.imageInitial() = ImageInitial;
  const factory ImageState.imagePickedState({required String imagePath}) =
      ImagePickedState;
  const factory ImageState.imageCroppedState({String? croppedImagePath}) =
      ImageCroppedState;
}
