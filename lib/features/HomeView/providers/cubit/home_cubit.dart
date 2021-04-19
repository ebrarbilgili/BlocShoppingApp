import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/home_model.dart';
import '../../service/home_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeService homeService;
  HomeCubit(this.homeService) : super(HomeInitial());

  Future<void> getHomeModelData() async {
    try {
      // emit(HomeInitial());
      emit(HomeLoading());

      final response = await homeService.getHomeModel();

      emit(HomeCompleted(response));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
