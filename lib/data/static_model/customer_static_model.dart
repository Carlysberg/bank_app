import "package:freezed_annotation/freezed_annotation.dart";

part "customer_static_model.freezed.dart";
part "customer_static_model.g.dart";

@freezed
class CustomerStaticModel with _$CustomerStaticModel {
  factory CustomerStaticModel({
    required String customerID,
    required String customerName,
    required String gender,
    required String title,
  }) = _CustomerStaticData;

  factory CustomerStaticModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerStaticModelFromJson(json);
}
