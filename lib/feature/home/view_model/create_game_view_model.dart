import 'package:flutter/material.dart';
import 'package:tic_tac_toe/feature/home/view_model/state/create_game_state.dart';
import 'package:tic_tac_toe/product/service/interface/authenction_operation.dart';
import 'package:tic_tac_toe/product/state/base/base_cubit.dart';

/// Manage your home view business logic
final class CreateGameViewModel extends BaseCubit<CreateGameState> {
  /// [AuthenticationOperation] service
  CreateGameViewModel() : super(const CreateGameState());

  void changeColor(Color gridColor) {
    emit(state.copyWith(gridColor: gridColor));
  }
}
