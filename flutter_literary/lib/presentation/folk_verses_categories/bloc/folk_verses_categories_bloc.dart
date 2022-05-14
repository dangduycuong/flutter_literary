import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:tiengviet/tiengviet.dart';

import '../../../data/file_name_model.dart';

part 'folk_verses_categories_event.dart';

part 'folk_verses_categories_state.dart';

class FolkVersesCategoriesBloc
    extends Bloc<FolkVersesCategoriesEvent, FolkVersesCategoriesState> {
  List<List<dynamic>> _folkVersesCategories = [];
  List<FileNameModel> _listFolkVerses = [];
  List<FileNameModel> filteredFolkVerses = [];

  FolkVersesCategoriesBloc() : super(FolkVersesCategoriesInitial()) {
    on<FolkVersesCategoriesEvent>((event, emit) {});
    on<LoadFolkVersesCategoriesEvent>(_fetchFolkVersesCategories);
    on<FilterFolkVersesCategoriesEvent>(_filterFolkVersesCategories);
  }

  void _fetchFolkVersesCategories(LoadFolkVersesCategoriesEvent event,
      Emitter<FolkVersesCategoriesState> emit) async {
    emit(LoadingFolkVersesCategoriesState());
    final _rawData = await rootBundle
        .loadString("resources/folk_verses/folk_verses_file.csv");
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    _folkVersesCategories = _listData;
    _folkVersesCategories.forEach((element) {
      FileNameModel item = FileNameModel(
        id: Uuid().v4(),
        fileName: element[0].toString(),
        description: element[1].toString(),
        isFavorite: false,
      );
      _listFolkVerses.add(item);
    });
    filteredFolkVerses = _listFolkVerses;
    print('cdd data $_folkVersesCategories');
    emit(FinishLoadFolkVersesCategoriesState(
        isNoData: filteredFolkVerses.isEmpty));
  }

  void _filterFolkVersesCategories(FilterFolkVersesCategoriesEvent event,
      Emitter<FolkVersesCategoriesState> emit) {
    emit(LoadingFolkVersesCategoriesState());
    filteredFolkVerses = _listFolkVerses.where((element) {
      String key = TiengViet.parse(event.text).toLowerCase();
      String content = TiengViet.parse(element.description).toLowerCase();
      return content.contains(key);
    }).toList();
    emit(FinishLoadFolkVersesCategoriesState(
        isNoData: filteredFolkVerses.isEmpty));
  }
}
