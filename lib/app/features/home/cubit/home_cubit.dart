import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoaded());

  void setLoading() {
    emit(HomeLoading());
  }

  void setLoaded() {
    emit(HomeLoaded());
  }
}
