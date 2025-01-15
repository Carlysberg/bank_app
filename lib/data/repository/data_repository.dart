import "dart:convert";

import "package:bank/data/customer_model/customer_data.dart";
import "package:bank/data/static_model/customer_static_model.dart";
import "package:bank/data/transaction_model/customer_transaction_model.dart";
import "package:flutter/services.dart" show rootBundle;
import "package:multiple_result/multiple_result.dart";

class DataRepository {
  Future<Result<CustomerData, String>> loadData() async {
    try {
      final jsonString =
          await rootBundle.loadString("assets/customer_data.json");
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;

      final staticDataList = (jsonData["customerStaticData"] as List<dynamic>?)
              ?.map(
                (item) =>
                    CustomerStaticModel.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [];

      final transactionDataList =
          (jsonData["customerTransactionData"] as List<dynamic>?)
                  ?.map(
                    (item) => CustomerTransactionModel.fromJson(
                      item as Map<String, dynamic>,
                    ),
                  )
                  .toList() ??
              [];

      final customerData = CustomerData(staticDataList, transactionDataList);

      return Result.success(customerData);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
