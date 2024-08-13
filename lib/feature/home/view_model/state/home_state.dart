import 'package:equatable/equatable.dart';

final class HomeState extends Equatable {
  const HomeState({required this.isLoading, this.users});

  final bool isLoading;
  final List<Object>? users;

  @override
  List<Object?> get props => [isLoading, users];

  HomeState copyWith({bool? isLoading, List<Object>? users}) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      users: users ?? this.users,
    );
  }
}
