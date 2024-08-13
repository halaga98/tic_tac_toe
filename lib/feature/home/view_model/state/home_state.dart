import 'package:equatable/equatable.dart';

final class HomeState extends Equatable {
  const HomeState({required this.isLoading, this.users, this.gridColor});

  final bool isLoading;
  final int? gridColor;
  final List<Object>? users;

  @override
  List<Object?> get props => [isLoading, users, gridColor];

  HomeState copyWith({bool? isLoading, List<Object>? users, int? gridColor}) {
    return HomeState(
        isLoading: isLoading ?? this.isLoading,
        users: users ?? this.users,
        gridColor: gridColor ?? this.gridColor);
  }
}
