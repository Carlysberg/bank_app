import "package:bank/data/static_model/customer_static_model.dart";
import "package:bank/data/transaction_model/customer_transaction_model.dart";

class CustomerData {
  CustomerData(this.staticDataList, this.transactionDataList);
  final List<CustomerStaticModel> staticDataList;
  final List<CustomerTransactionModel> transactionDataList;
}
