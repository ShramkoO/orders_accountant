import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  StatisticsCubit() : super(StatisticsLoaded());

  void setLoading() {
    emit(StatisticsLoading());
  }

  void setLoaded() {
    emit(StatisticsLoaded());
  }
}

abstract class StatisticsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StatisticsLoading extends StatisticsState {}

class StatisticsError extends StatisticsState {}

class StatisticsLoaded extends StatisticsState {}
