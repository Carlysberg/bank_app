import "package:bank/common/bank_bloc_observer.dart";
import "package:bank/common/my_text_filled/bloc/my_form_bloc/my_form_bloc.dart";
import "package:bank/common/my_text_filled/bloc/password_visibility_bloc/password_visibility_bloc.dart";
import "package:bank/data/bloc/data_cubit.dart";
import "package:bank/data/hive_model/customer_db_model.dart";
import "package:bank/data/repository/customer_db.dart";
import "package:bank/pickImage_and_cropImage/bloc/image_bloc.dart";
import "package:bank/pickImage_and_cropImage/repository/image_repository.dart";
import "package:bank/routes/app_router.dart";
import "package:bank/routes/my_route_observer.dart";
import "package:bank/settings/bloc/package_info_bloc.dart";
import "package:bank/settings/bloc/package_info_event.dart";
import "package:bank/settings/repository/package_info_repository.dart";
import "package:device_preview/device_preview.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";
import "package:hive/hive.dart";
import "package:hydrated_bloc/hydrated_bloc.dart";
import "package:path_provider/path_provider.dart";

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   GetIt.instance.registerSingleton<ImageRepository>(DefaultImageRepository());
//   GetIt.instance.registerSingleton<CustomerDb>(CustomerDb());
//   final appDirectory = await getApplicationDocumentsDirectory();
//   HydratedBloc.storage = await HydratedStorage.build(
//     storageDirectory: appDirectory,
//   );
//   Hive
//     ..init(appDirectory.path)
//     ..registerAdapter(CustomerDbModelAdapter());
//   await GetIt.instance.get<CustomerDb>().openBox;
//   final imageRepository = GetIt.instance<ImageRepository>();
//   Bloc.observer = const BankBlocObserver();
//   runApp(
//     DevicePreview(
//       builder: (context) {
//         return Bank(
//           imageRepository: imageRepository,
//         );
//       },
//     ),
//   );
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.instance.registerSingleton<ImageRepository>(DefaultImageRepository());
  GetIt.instance.registerSingleton<CustomerDb>(CustomerDb());
  final appDirectory = await getApplicationDocumentsDirectory();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: appDirectory,
  );
  Hive
    ..init(appDirectory.path)
    ..registerAdapter(CustomerDbModelAdapter());
  await GetIt.instance.get<CustomerDb>().openBox;
  final imageRepository = GetIt.instance<ImageRepository>();
  Bloc.observer = const BankBlocObserver();
  runApp(
    Bank(
      imageRepository: imageRepository,
    ),
  );
}

class Bank extends StatelessWidget {
  Bank({required this.imageRepository, super.key});

  final ImageRepository imageRepository;
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DataCubit(),
        ),
        BlocProvider(
          create: (context) => ImageBloc(imageRepository),
        ),
        BlocProvider(
          create: (context) => MyFormBloc(),
        ),
        BlocProvider(
          create: (context) => PackageInfoBloc(
            packageInfoRepository: PackageInfoRepository(),
          )..add(const PackageInfoEvent.fetchPackageInfo()),
        ),
        BlocProvider(
          create: (context) => PasswordVisibilityBloc(),
        ),
      ],
      child: MaterialApp.router(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: ThemeData(
          fontFamily: "OpenSans",
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: _appRouter.config(
          navigatorObservers: () => [MyRouteObserver()],
        ),
      ),
    );
  }
}
