import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/feature/home/model/game.dart';

final class HomeState extends Equatable {
  const HomeState(
      {required this.isLoading, this.game, this.gameStream, this.games});

  final bool isLoading;
  final Game? game;
  final Stream<DocumentSnapshot>? gameStream;
  final List<Game>? games;

  @override
  List<Object?> get props => [isLoading, game, gameStream, games];

  HomeState copyWith(
      {bool? isLoading,
      Game? game,
      Stream<DocumentSnapshot>? gameStream,
      List<Game>? games}) {
    return HomeState(
        isLoading: isLoading ?? this.isLoading,
        game: game ?? this.game,
        gameStream: gameStream ?? this.gameStream,
        games: games ?? this.games);
  }
}
