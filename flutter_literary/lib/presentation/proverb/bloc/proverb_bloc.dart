import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:tiengviet/tiengviet.dart';

part 'proverb_event.dart';

part 'proverb_state.dart';

class ProverbBloc extends Bloc<ProverbEvent, ProverbState> {
  List<String> _contentList = [];
  List<String> filteredList = [];

  ProverbBloc() : super(ProverbInitial()) {
    on<ProverbEvent>((event, emit) {});
    on<LoadListProverbEvent>(_loadListProverb);
    on<FilterListProverbEvent>(_filterFolkVerses);
  }

  void _loadListProverb(
      LoadListProverbEvent event, Emitter<ProverbState> emit) async {
    emit(LoadingListProverbState());
    String content = await _loadContent(event.fileName);
    _contentList = content.split('\n*\n');
    filteredList = _contentList;
    emit(FinishLoadListProverbState(isNoData: filteredList.isEmpty));
  }

  Future<String> _loadContent(String fileName) async {
    return await rootBundle.loadString('resources/proverb/$fileName');
  }

  void _filterFolkVerses(
      FilterListProverbEvent event, Emitter<ProverbState> emit) {
    emit(LoadingListProverbState());
    filteredList = _contentList.where((element) {
      String key = TiengViet.parse(event.text).toLowerCase();
      String content = TiengViet.parse(element).toLowerCase();
      return content.contains(key);
    }).toList();
    emit(FinishLoadListProverbState(isNoData: filteredList.isEmpty));
  }
}
