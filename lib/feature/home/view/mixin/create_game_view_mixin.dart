import 'package:tic_tac_toe/feature/home/view/create_game_view.dart';
import 'package:tic_tac_toe/feature/home/view_model/create_game_view_model.dart';

import 'package:tic_tac_toe/product/state/base/base_state.dart';

/// Manage your home view business logic
mixin CreateGameViewMixin on BaseState<CreateGameView> {
  late final CreateGameViewModel _createGameViewModel;

  CreateGameViewModel get createGameViewModel => _createGameViewModel;

  @override
  void initState() {
    super.initState();

    _createGameViewModel = CreateGameViewModel();
  }
}
