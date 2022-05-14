import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_literary/data/file_name_model.dart';
import 'package:uuid/uuid.dart';

part 'proverb_event.dart';

part 'proverb_state.dart';

class ProverbCategoriesBloc extends Bloc<ProverbCategoriesEvent, ProverbState> {
  List<List<dynamic>> _data = [];
  List<FileNameModel> listProverbFile = [];

  ProverbCategoriesBloc() : super(ProverbInitial()) {
    on<ProverbCategoriesEvent>((event, emit) {});
    on<LoadProverbCategoriesEvent>(_loadCSV);
    on<ViewListProverbEvent>(_viewListProverb);
  }

  void _loadCSV(
      LoadProverbCategoriesEvent event, Emitter<ProverbState> emit) async {
    emit(LoadingProverState());
    final _rawData =
        await rootBundle.loadString("resources/proverb/proverb_file.csv");
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    _data = _listData;
    _data.forEach((element) {
      FileNameModel file = FileNameModel(
          id: Uuid().v4(),
          fileName: element[0].toString(),
          description: element[1].toString(),
          isFavorite: false);
      listProverbFile.add(file);
    });
    print('cdd proverb $_data');
    emit(LoadProverSuccessState());
  }

  void _viewListProverb(
      ViewListProverbEvent event, Emitter<ProverbState> emit) async {}
}
