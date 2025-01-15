import "package:auto_route/auto_route.dart";

import "package:bank/routes/app_router.gr.dart";

@AutoRouterConfig(replaceInRouteName: "Page,Route")
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SignInRoute.page, initial: true),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: SetNewPasswordRoute.page),
        AutoRoute(page: VerifyEmailDetailsRoute.page),
        AutoRoute(page: VerifyPhoneDetailsRoute.page),
        AutoRoute(page: PersonalInformationRoute.page),
        AutoRoute(page: PictureUploadRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: ChangePasswordRoute.page),
        AutoRoute(page: ChangeEmailRoute.page),
        AutoRoute(page: VerifyEmailRoute.page),
        AutoRoute(page: SetNewEmailRoute.page),
        AutoRoute(page: EditProfileRoute.page),
        AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(page: VerifyAccessRoute.page),
        AutoRoute(page: LoadingRoute.page),
        AutoRoute(
          page: DashboardRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page, initial: true),
            AutoRoute(page: TransactionRoute.page),
          ],
        ),
      ];
}
