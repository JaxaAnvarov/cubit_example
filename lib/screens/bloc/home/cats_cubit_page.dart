import 'package:cubit_example/core/model/cats_repository.dart';
import 'package:cubit_example/screens/bloc/home/cats_state_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatsCubit extends Cubit<CatsState> {
  final CatsRepository catsRepository;
  CatsCubit(this.catsRepository) : super(const CatsInitial()) {
    getCats();
  }

  Future<void> getCats() async {
    try {
      emit(const CatsLoading());
      await Future.delayed(const Duration(seconds: 3));
      final response = await catsRepository.getCatsFromApi();
      emit(CatsCompledet(response));
    } catch (e) {
      emit(CatsError(e.toString()));
    }
  }
}
