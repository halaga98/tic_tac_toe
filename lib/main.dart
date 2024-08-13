import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/product/init/application_initialize.dart';
import 'package:tic_tac_toe/product/init/product_localization.dart';
import 'package:tic_tac_toe/product/init/state_initialize.dart';
import 'package:tic_tac_toe/product/init/theme/custom_dark_theme.dart';
import 'package:tic_tac_toe/product/navigation/app_router.dart';
import 'package:tic_tac_toe/product/state/view_model/product_view_model.dart';
import 'package:widgets/widgets.dart';

import 'product/init/theme/custom_light_theme.dart';

Future<void> main() async {
  await ApplicationInitialize().make();
  runApp(ProductLocalization(child: const StateInitialize(child: _MyApp())));
}

final class _MyApp extends StatelessWidget {
  const _MyApp();
  static final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      builder: CustomResponsive.build,
      theme: CustomLightTheme().themeData,
      darkTheme: CustomDarkTheme().themeData,
      themeMode: context.watch<ProductViewModel>().state.themeMode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
