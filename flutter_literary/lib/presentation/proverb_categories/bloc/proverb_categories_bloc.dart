import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:tiengviet/tiengviet.dart';
import 'package:uuid/uuid.dart';

import '../../../data/file_name_model.dart';

part 'proverb_categories_event.dart';

part 'proverb_categories_state.dart';

class ProverbCategoriesBloc
    extends Bloc<ProverbCategoriesEvent, ProverbCategoriesState> {
  List<List<dynamic>> _data = [];
  final List<FileNameModel> _listProverbCategories = [];
  List<FileNameModel> filteredProverbCategories = [];

  ProverbCategoriesBloc() : super(ProverbCategoriesInitial()) {
    on<ProverbCategoriesEvent>((event, emit) {});
    on<LoadProverbCategoriesEvent>(_loadCSV);
    on<FilterProverbCategoriesEvent>(_filterProverbCategories);
  }

  void _loadCSV(LoadProverbCategoriesEvent event,
      Emitter<ProverbCategoriesState> emit) async {
    emit(LoadingProverbCategoriesState());
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
      _listProverbCategories.add(file);
    });
    print('cdd proverb $_data');
    filteredProverbCategories = _listProverbCategories;
    emit(FinishLoadProverbCategoriesState(
        isNoData: filteredProverbCategories.isEmpty));
  }

  void _filterProverbCategories(FilterProverbCategoriesEvent event,
      Emitter<ProverbCategoriesState> emit) {
    emit(LoadingProverbCategoriesState());
    filteredProverbCategories = _listProverbCategories.where((element) {
      String key = TiengViet.parse(event.text).toLowerCase();
      String content = TiengViet.parse(element.description).toLowerCase();
      return content.contains(key);
    }).toList();
    emit(FinishLoadProverbCategoriesState(
        isNoData: filteredProverbCategories.isEmpty));
  }
}
