import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:orders_accountant/core/common/domain/data_state.dart';

abstract class BaseRepository {
  @protected
  Future<DataState<T>> call<T>(
    Future Function() request,
  ) async {
    try {
      final (data) = await request();
      return DataSuccess(data);
    } on Exception catch (error) {
      return DataFailed(error);
    }
  }
}
