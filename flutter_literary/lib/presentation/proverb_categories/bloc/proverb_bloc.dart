import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'proverb_event.dart';

part 'proverb_state.dart';

class ProverbCategoriesBloc extends Bloc<ProverbCategoriesEvent, ProverbState> {
  List<List<dynamic>> data = [];

  ProverbCategoriesBloc() : super(ProverbInitial()) {
    on<ProverbCategoriesEvent>((event, emit) {});
    on<LoadProverbCategoriesEvent>(_loadCSV);
    on<ViewListProverbEvent>(_viewListProverb);
  }

  void _loadCSV(LoadProverbCategoriesEvent event, Emitter<ProverbState> emit) async {
    emit(LoadingProverState());
    final _rawData = await rootBundle.loadString("resources/kindacode.csv");
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    data = _listData;
    print('cdd proverb $data');
    emit(LoadProverSuccessState());
  }

  void _viewListProverb(
      ViewListProverbEvent event, Emitter<ProverbState> emit) async {

  }
}
