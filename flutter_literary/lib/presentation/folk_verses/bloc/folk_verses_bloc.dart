import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:tiengviet/tiengviet.dart';

part 'folk_verses_event.dart';

part 'folk_verses_state.dart';

class FolkVersesBloc extends Bloc<FolkVersesEvent, FolkVersesState> {
  List<String> _contentList = [];
  List<String> filteredList = [];

  FolkVersesBloc() : super(FolkVersesInitial()) {
    on<FolkVersesEvent>((event, emit) {});
    on<LoadFolkVersesEvent>(_fetchFolkVerses);
    on<FilterFolkVersesEvent>(_filterFolkVerses);
  }

  void _fetchFolkVerses(
      LoadFolkVersesEvent event, Emitter<FolkVersesState> emit) async {
    emit(LoadingFolkVersesState());
    String content = await _loadContent(event.fileName);
    _contentList = content.split('\n*\n');
    filteredList = _contentList;
    emit(FinishLoadFolkVersesState(isNoData: filteredList.isEmpty));
  }

  Future<String> _loadContent(String fileName) async {
    return await rootBundle.loadString('resources/folk_verses/$fileName');
  }

  void _filterFolkVerses(
      FilterFolkVersesEvent event, Emitter<FolkVersesState> emit) {
    emit(LoadingFolkVersesState());
    filteredList = _contentList.where((element) {
      String key = TiengViet.parse(event.text).toLowerCase();
      String content = TiengViet.parse(element).toLowerCase();
      return content.contains(key);
    }).toList();
    emit(FinishLoadFolkVersesState(isNoData: filteredList.isEmpty));
  }
}
