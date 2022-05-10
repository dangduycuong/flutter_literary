import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'folk_verses_categories_event.dart';

part 'folk_verses_categories_state.dart';

class FolkVersesCategoriesBloc
    extends Bloc<FolkVersesCategoriesEvent, FolkVersesCategoriesState> {
  List<List<dynamic>> folkVersesCategories = [];

  FolkVersesCategoriesBloc() : super(FolkVersesCategoriesInitial()) {
    on<FolkVersesCategoriesEvent>((event, emit) {});
    on<LoadFolkVersesCategoriesEvent>(_fetchFolkVersesCategories);
  }

  void _fetchFolkVersesCategories(LoadFolkVersesCategoriesEvent event,
      Emitter<FolkVersesCategoriesState> emit) async {
    emit(LoadingFolkVersesCategoriesState());
    final _rawData =
        await rootBundle.loadString("resources/folk_verses/folk_verses_file.csv");
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    folkVersesCategories = _listData;
    print('cdd data $folkVersesCategories');
    emit(FinishLoadFolkVersesCategoriesState());
  }

}
