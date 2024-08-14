// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CreateGameRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CreateGameView(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeView(),
      );
    },
    PlayGameRoute.name: (routeData) {
      final args = routeData.argsAs<PlayGameRouteArgs>();
      return AutoRoutePage<bool?>(
        routeData: routeData,
        child: PlayGameView(
          id: args.id,
          key: args.key,
        ),
      );
    },
  };
}

/// generated route for
/// [CreateGameView]
class CreateGameRoute extends PageRouteInfo<void> {
  const CreateGameRoute({List<PageRouteInfo>? children})
      : super(
          CreateGameRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateGameRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PlayGameView]
class PlayGameRoute extends PageRouteInfo<PlayGameRouteArgs> {
  PlayGameRoute({
    required String id,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          PlayGameRoute.name,
          args: PlayGameRouteArgs(
            id: id,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'PlayGameRoute';

  static const PageInfo<PlayGameRouteArgs> page =
      PageInfo<PlayGameRouteArgs>(name);
}

class PlayGameRouteArgs {
  const PlayGameRouteArgs({
    required this.id,
    this.key,
  });

  final String id;

  final Key? key;

  @override
  String toString() {
    return 'PlayGameRouteArgs{id: $id, key: $key}';
  }
}
