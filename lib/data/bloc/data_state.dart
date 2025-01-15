import "package:bank/data/transaction_model/customer_transaction_model.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "data_state.freezed.dart";

@freezed
abstract class DataState with _$DataState {
  const factory DataState.dataInitial() = DataInitial;
  const factory DataState.dataLoading() = DataLoading;
  const factory DataState.dataLoaded({
    required String customerName,
    required String title,
    required List<CustomerTransactionModel> transactionData,
  }) = DataLoaded;
  const factory DataState.dataError() = DataError;
}
