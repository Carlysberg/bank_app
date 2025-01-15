import "package:freezed_annotation/freezed_annotation.dart";

part "customer_transaction_model.freezed.dart";
part "customer_transaction_model.g.dart";

@freezed
class CustomerTransactionModel with _$CustomerTransactionModel {
  factory CustomerTransactionModel({
    required String customerID,
    required String transactionDate,
    required int transactionAmount,
    required String transactionDirection,
    required String transactionNarration,
  }) = _CustomerTransactionModel;

  factory CustomerTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerTransactionModelFromJson(json);
}
