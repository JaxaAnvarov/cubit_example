import 'package:cubit_example/screens/bloc/home/cats_state_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatsCubit extends Cubit<CatsState> {
  CatsCubit() : super(const CatsInitial());

  Future<void> getCats() async {
    try {
      emit(const CatsLoading());
      await Future.delayed(const Duration(seconds: 3));
      final response = await Future.value(['Tom', 'Angella']);
      emit(CatsCompledet(response));
    } catch (e) {
      emit(CatsError(e.toString()));
    }
  }
}
