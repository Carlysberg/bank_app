import "package:bank/data/bloc/data_state.dart";
import "package:bank/data/hive_model/customer_db_model.dart";
import "package:bank/data/repository/customer_db.dart";
import "package:bank/data/repository/data_repository.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";
import "package:hive/hive.dart";

class DataCubit extends Cubit<DataState> {
  DataCubit() : super(const DataInitial());

  Future<void> loadData() async {
    try {
      emit(const DataLoading());
      final customerDetail = GetIt.instance.get<CustomerDb>();
      // Simulate loading data from a JSON file
      final data = await DataRepository().loadData();

      // Simulating a delay for loading data
      await Future.delayed(const Duration(seconds: 2), () async {
        final staticDataList = data.tryGetSuccess()?.staticDataList ?? [];
        await customerDetail.writeData(
          {
            "customerDetail": CustomerDbModel(
              customerName: staticDataList[0].customerName,
              title: staticDataList[0].title,
            ),
          },
          Hive.box<CustomerDbModel>("customer-db"),
        );
      });
      final transactionDataList =
          data.tryGetSuccess()?.transactionDataList ?? [];
      final getBox = await customerDetail.readData(
        "customerDetail",
        Hive.box<CustomerDbModel>("customer-db"),
      );
      emit(
        DataLoaded(
          transactionData: transactionDataList,
          customerName: getBox.customerName!,
          title: getBox.title!,
        ),
      );
    } catch (e) {
      emit(const DataError());
    }
  }
}
