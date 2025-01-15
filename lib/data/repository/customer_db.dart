import "package:bank/data/hive_model/customer_db_model.dart";
import "package:hive/hive.dart";

class CustomerDb {
  CustomerDb();

  Future<void> _openBox() async {
    await Hive.openBox<CustomerDbModel>("customer-db");
  }

  Future<void> writeData(
    Map<String, CustomerDbModel> entry,
    Box<CustomerDbModel> box,
  ) async {
    await box.putAll(entry);
  }

  Future<CustomerDbModel> readData(String key, Box<CustomerDbModel> box) async {
    return box.get(key)!;
  }

  Future<void> _closeBox() async {
    await Hive.box<CustomerDbModel>("customer-db").close();
  }

  Future<void> get openBox => _openBox();
  Future<void> get closeBox => _closeBox();
}
