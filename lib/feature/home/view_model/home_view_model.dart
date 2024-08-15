import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tic_tac_toe/feature/home/model/game.dart';
import 'package:tic_tac_toe/feature/home/view_model/state/home_state.dart';
import 'package:tic_tac_toe/product/service/interface/authenction_operation.dart';
import 'package:tic_tac_toe/product/state/base/base_cubit.dart';

/// Manage your home view business logic
final class HomeViewModel extends BaseCubit<HomeState> {
  /// [AuthenticationOperation] service
  HomeViewModel()
      : super(const HomeState(
          isLoading: false,
        ));

  /// Change loading state
  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  void changeStream(Stream<DocumentSnapshot> gameStream) {
    emit(state.copyWith(gameStream: gameStream));
  }

  /// Get users
  Future<void> getGames() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection("games").get();

    final games =
        querySnapshot.docs.map((doc) => Game.fromDocument(doc)).toList();
    emit(state.copyWith(games: games));
  }

  void listenGame() {
    final docRef = FirebaseFirestore.instance.collection("games");

    docRef.snapshots().listen(
      (event) {
        final games = event.docs.map((doc) => Game.fromDocument(doc)).toList();
        emit(state.copyWith(games: games));
      },
      onError: (error) => print("Listen failed: $error"),
    );
  }
}
