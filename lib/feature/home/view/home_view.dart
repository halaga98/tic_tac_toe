import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/feature/home/model/game.dart';
import 'package:tic_tac_toe/feature/home/view/widget/home_app_bar.dart';
import 'package:tic_tac_toe/feature/home/view/widget/home_game_list.dart';
import 'package:tic_tac_toe/feature/home/view_model/home_view_model.dart';
import 'package:tic_tac_toe/feature/home/view_model/state/home_state.dart';
import 'package:tic_tac_toe/product/navigation/app_router.dart';

import 'mixin/home_view_mixin.dart';
import 'package:tic_tac_toe/product/state/base/base_state.dart';

@RoutePage()
final class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> with HomeViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeViewModel,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            context.router.push(CreateGameRoute());
          },
          child: Center(child: Icon(Icons.add)),
        ),
        appBar: const HomeAppBar(),
        body: ValueListenableBuilder<String>(
          valueListenable: userName,
          builder: (BuildContext context, String value, child) {
            return value == ""
                ? Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: userNameController,
                            decoration: InputDecoration(labelText: "Name"),
                            validator: (String? value) {
                              return (value == null || value.isEmpty)
                                  ? 'Cannot be empty'
                                  : null;
                            },
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: saveName,
                            child: Text("Save"),
                          ),
                        ],
                      ),
                    ),
                  )
                : _UserBlocList();
          },
        ),
      ),
    );
  }
}

final class _UserBlocList extends StatelessWidget {
  const _UserBlocList();

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeViewModel, HomeState>(
      listener: (context, state) {},
      child: BlocSelector<HomeViewModel, HomeState, List<Game>>(
        selector: (state) {
          return state.games ?? [];
        },
        builder: (context, state) {
          if (state.isEmpty) return const SizedBox.shrink();

          return HomeGameList(games: state);
        },
      ),
    );
  }
}
