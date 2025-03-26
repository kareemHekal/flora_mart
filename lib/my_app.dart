import 'package:easy_localization/easy_localization.dart';
import 'package:flora_mart/core/cache/shared_pref.dart';
import 'package:flora_mart/core/constant.dart';
import 'package:flora_mart/presentation/auth/login/cubit/Login_cubit.dart';
import 'package:flora_mart/presentation/auth/login/login_screen.dart';
import 'package:flora_mart/presentation/tabs/home_tab/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/theme/app_theme.dart';
import 'core/di/di.dart';
import 'core/utils/routes_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool? rememberMe = CacheHelper.getData<bool>(Constant.isRememberMe);

    String initialRoute(bool? rememberMe) {
      print(rememberMe);
      return rememberMe == true
          ? RouteManager.homeScreen
          : RouteManager.loginScreen;
    }

    return ScreenUtilInit(
      designSize: Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            RouteManager.homeScreen: (context) => HomeTabScreen(),
            RouteManager.loginScreen: (context) => BlocProvider(
                  create: (context) => getIt<LoginCubit>(),
                  child: SignInScreen(),
                ),
          },
          initialRoute: initialRoute(rememberMe),
          theme: AppTheme.lightTheme,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },
    );
  }
}
