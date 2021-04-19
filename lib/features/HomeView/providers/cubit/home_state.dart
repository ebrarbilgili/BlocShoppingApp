part of 'home_cubit.dart';

@immutable
abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeCompleted extends HomeState {
  final List<HomeModel> listHomeModel;

  const HomeCompleted(this.listHomeModel);
}

class HomeError extends HomeState {
  final String errorMessage;

  const HomeError(this.errorMessage);
}
