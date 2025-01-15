import "package:bank/data/transaction_model/customer_transaction_model.dart";

class HomeScreenLogics {
  (List<int>, List<int>, int) balanceCalculator(
    List<CustomerTransactionModel> transactionData,
  ) {
    var totalBalance = 0;
    final balanceBeforeTransaction = <int>[];
    final balanceAfterTransaction = <int>[];

    for (var index = 0; index < transactionData.length; index++) {
      final balanceBefore =
          index > 0 ? balanceAfterTransaction[index - 1] : totalBalance;
      balanceBeforeTransaction.add(balanceBefore);

      if (transactionData[index].transactionDirection == "C") {
        totalBalance += transactionData[index].transactionAmount;
      } else {
        totalBalance -= transactionData[index].transactionAmount;
      }
      balanceAfterTransaction.add(totalBalance);
    }
    return (balanceAfterTransaction, balanceBeforeTransaction, totalBalance);
  }
}
