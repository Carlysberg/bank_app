import "package:hive/hive.dart";

part "customer_db_model.g.dart";

@HiveType(typeId: 0, adapterName: "CustomerDbModelAdapter")
class CustomerDbModel extends HiveObject {
  CustomerDbModel({this.customerName, this.title});

  @HiveField(0)
  final String? customerName;
  @HiveField(1)
  final String? title;
}
