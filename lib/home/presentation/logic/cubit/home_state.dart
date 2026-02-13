part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  final int index;
  const HomeInitial({this.index = 0});

  @override
  List<Object> get props => [index];
}

class HomeTabChanged extends HomeState {
  final int index;
  const HomeTabChanged({required this.index});

  @override
  List<Object> get props => [index];
}
