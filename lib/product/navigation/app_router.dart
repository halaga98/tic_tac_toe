import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/feature/home/view/home_view.dart';
import 'package:tic_tac_toe/feature/home/view/play_game_view.dart';
import 'package:tic_tac_toe/feature/home/view/create_game_view.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: AppRouter._replaceRouteName)

/// Project router information class
final class AppRouter extends _$AppRouter {
  static const _replaceRouteName = 'View,Route';
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(
          page: PlayGameRoute.page,
        ),
        AutoRoute(
          page: CreateGameRoute.page,
        ),
      ];
}
