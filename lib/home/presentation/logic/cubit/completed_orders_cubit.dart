import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompletedOrdersCubit extends Cubit<int> {
  final SharedPreferences _prefs;
  static const _key = 'completed_orders_count';

  CompletedOrdersCubit(this._prefs) : super(_prefs.getInt(_key) ?? 0);

  void increment() {
    final newValue = state + 1;
    _prefs.setInt(_key, newValue);
    emit(newValue);
  }
}
