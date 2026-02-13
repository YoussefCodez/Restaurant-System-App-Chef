import 'package:bloc/bloc.dart';

class ObscureCubit extends Cubit<bool> {
  ObscureCubit() : super(true);
  void toggleVisibility() {
    emit(!state);
  }
}