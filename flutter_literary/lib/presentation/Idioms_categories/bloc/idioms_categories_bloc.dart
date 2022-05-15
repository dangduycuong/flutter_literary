import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:tiengviet/tiengviet.dart';
import 'package:uuid/uuid.dart';

import '../../../data/file_name_model.dart';

part 'idioms_categories_event.dart';

part 'idioms_categories_state.dart';

class IdiomsCategoriesBloc
    extends Bloc<IdiomsCategoriesEvent, IdiomsCategoriesState> {
  List<List<dynamic>> _dataSource = [];
  List<FileNameModel> _listIdiomsCategories = [];
  List<FileNameModel> filteredIdiomsCategories = [];

  IdiomsCategoriesBloc() : super(IdiomsCategoriesInitial()) {
    on<IdiomsCategoriesEvent>((event, emit) {});
    on<LoadIdiomsCategoriesEvent>(_fetchIdiomsCategories);
    on<FilterIdiomsCategoriesEvent>(_filterIdiomsCategories);
  }

  void _fetchIdiomsCategories(LoadIdiomsCategoriesEvent event,
      Emitter<IdiomsCategoriesState> emit) async {
    emit(LoadingIdiomsCategoriesState());
    final _rawData = await rootBundle.loadString("resources/Idioms/Idioms.csv");
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    _dataSource = _listData;
    _dataSource.forEach((element) {
      FileNameModel item = FileNameModel(
        id: const Uuid().v4(),
        fileName: element[0].toString(),
        description: element[1].toString(),
        isFavorite: false,
      );
      _listIdiomsCategories.add(item);
    });
    filteredIdiomsCategories = _listIdiomsCategories;
    print('cdd data $_listIdiomsCategories');
    emit(FinishLoadIdiomsCategoriesState(
        isNoData: filteredIdiomsCategories.isEmpty));
  }

  void _filterIdiomsCategories(
      FilterIdiomsCategoriesEvent event, Emitter<IdiomsCategoriesState> emit) {
    emit(LoadingIdiomsCategoriesState());
    filteredIdiomsCategories = _listIdiomsCategories.where((element) {
      String key = TiengViet.parse(event.text).toLowerCase();
      String content = TiengViet.parse(element.description).toLowerCase();
      return content.contains(key);
    }).toList();
    emit(FinishLoadIdiomsCategoriesState(
        isNoData: filteredIdiomsCategories.isEmpty));
  }
}
