import "package:freezed_annotation/freezed_annotation.dart";
import "package:image_picker/image_picker.dart";

//part 'image_bloc.dart';
part "image_event.freezed.dart";

@freezed
abstract class ImageEvent with _$ImageEvent {
  const factory ImageEvent.pickImageEvent(ImageSource source) = PickImageEvent;
  const factory ImageEvent.cropImageEvent(String imagePath) = CropImageEvent;
}
