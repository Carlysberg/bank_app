import "dart:async";
import "package:bank/enum/enums.dart";
import "package:bank/pickImage_and_cropImage/bloc/image_event.dart";
import "package:bank/pickImage_and_cropImage/bloc/image_state.dart";
import "package:bank/pickImage_and_cropImage/repository/image_repository.dart";
import "package:bloc_concurrency/bloc_concurrency.dart";
import "package:hydrated_bloc/hydrated_bloc.dart";

class ImageBloc extends HydratedBloc<ImageEvent, ImageState> {
  ImageBloc(this.repository) : super(const ImageInitial()) {
    on<PickImageEvent>(_mapPickImageToState, transformer: droppable());
    on<CropImageEvent>(_mapCropImageToState);
  }
  final ImageRepository repository;

  FutureOr<void> _mapPickImageToState(
    PickImageEvent event,
    Emitter<ImageState> emit,
  ) async {
    final pickedFile = await repository.pickImage(event.source);

    if (pickedFile != null) {
      add(CropImageEvent(pickedFile.path));
    }
  }

  FutureOr<void> _mapCropImageToState(
    CropImageEvent event,
    Emitter<ImageState> emit,
  ) async {
    final croppedFile = await repository.cropImage(event.imagePath);
    if (croppedFile != null) {
      emit(ImageCroppedState(croppedImagePath: croppedFile.path));
    }
  }

  @override
  ImageState? fromJson(Map<String, dynamic> json) {
    try {
      final dynamic type = json["type"];
      if (type == ImageStateType.imagePickedState.toString()) {
        return ImagePickedState(imagePath: json["image"] as String);
      } else if (type == ImageStateType.imageCroppedState.toString()) {
        return ImageCroppedState(
          croppedImagePath: json["croppedImage"] as String,
        );
      }
    } catch (e) {
      return const ImageInitial();
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(ImageState state) {
    try {
      if (state is ImagePickedState) {
        return {
          "type": ImageStateType.imagePickedState.toString(),
          "image": state.imagePath,
        };
      } else if (state is ImageCroppedState) {
        return {
          "type": ImageStateType.imageCroppedState.toString(),
          "croppedImage": state.croppedImagePath,
        };
      }
    } catch (e) {
      return {"type": "ErrorState", "message": "Serialization Error"};
    }
    return null;
  }
}
