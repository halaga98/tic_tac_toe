import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

final class CreateGameState extends Equatable {
  const CreateGameState({this.gridColor = Colors.blue});

  final Color gridColor;

  @override
  List<Object?> get props => [gridColor];

  CreateGameState copyWith({Color? gridColor}) {
    return CreateGameState(gridColor: gridColor ?? this.gridColor);
  }
}
