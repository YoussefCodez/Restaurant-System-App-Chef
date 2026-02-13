import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TotalOrdersCubit extends Cubit<int> {
  final SharedPreferences _prefs;
  static const _key = 'total_orders_count';

  TotalOrdersCubit(this._prefs) : super(_prefs.getInt(_key) ?? 0);

  void increment(int count) {
    final newValue = state + count;
    _prefs.setInt(_key, newValue);
    emit(newValue);
  }
}
