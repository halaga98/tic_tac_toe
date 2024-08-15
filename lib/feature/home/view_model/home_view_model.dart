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

  void changeStream(Stream<DocumentSnapshot>? gameStream) {
    emit(state.copyWith(gameStream: gameStream));
  }

  /// Get games
  Future<void> getGames() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection("games")
        .where("status", whereIn: ["waiting", "done"])
        .orderBy("status", descending: true)
        .get();

    final games =
        querySnapshot.docs.map((doc) => Game.fromDocument(doc)).toList();
    emit(state.copyWith(games: games));
  }

  void listenGames() {
    final docRef = FirebaseFirestore.instance.collection("games").where(
        "status",
        whereIn: ["waiting", "done"]).orderBy("status", descending: true);

    docRef.snapshots().listen(
      (event) {
        final games = event.docs.map((doc) => Game.fromDocument(doc)).toList();
        emit(state.copyWith(games: games));
      },
      onError: (error) => print("Listen failed: $error"),
    );
  }

  // game
  Future<void> getGame(String gameId) async {
    final documentSnapshot = await FirebaseFirestore.instance
        .collection("games")
        .doc(gameId)
        .get(); // get() kullanarak veriyi çekiyoruz.
    if (documentSnapshot.exists) {
      final games = Game.fromDocument(documentSnapshot);
      emit(state.copyWith(game: games));
    } else {
      // Belge bulunamadığında yapılacak işlem
      print("Game not found");
    }
  }

  void listenGame(String gameId) {
    final docRef = FirebaseFirestore.instance.collection("games").doc(gameId);

    docRef.snapshots().listen(
      (event) {
        if (event.exists) {
          final game = Game.fromDocument(event);
          emit(state.copyWith(game: game));
        } else {
          print("Game not found");
        }
      },
      onError: (error) => print("Listen failed: $error"),
    );
  }
}
