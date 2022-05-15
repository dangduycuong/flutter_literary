import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:tiengviet/tiengviet.dart';

part 'idioms_event.dart';

part 'idioms_state.dart';

class IdiomsBloc extends Bloc<IdiomsEvent, IdiomsState> {
  List<String> _contentList = [];
  List<String> filteredList = [];

  IdiomsBloc() : super(IdiomsInitial()) {
    on<IdiomsEvent>((event, emit) {});
    on<LoadIdiomsEvent>(_fetchFolkVerses);
    on<FilterIdiomsEvent>(_filterFolkVerses);
  }

  void _fetchFolkVerses(
      LoadIdiomsEvent event, Emitter<IdiomsState> emit) async {
    emit(LoadingIdiomsState());
    String content = await _loadContent(event.fileName);
    _contentList = content.split('\n*\n');
    filteredList = _contentList;
    emit(FinishLoadIdiomsState(isNoData: filteredList.isEmpty));
  }

  Future<String> _loadContent(String fileName) async {
    return await rootBundle.loadString('resources/Idioms/$fileName');
  }

  void _filterFolkVerses(FilterIdiomsEvent event, Emitter<IdiomsState> emit) {
    emit(LoadingIdiomsState());
    filteredList = _contentList.where((element) {
      String key = TiengViet.parse(event.text).toLowerCase();
      String content = TiengViet.parse(element).toLowerCase();
      return content.contains(key);
    }).toList();
    emit(FinishLoadIdiomsState(isNoData: filteredList.isEmpty));
  }
}
