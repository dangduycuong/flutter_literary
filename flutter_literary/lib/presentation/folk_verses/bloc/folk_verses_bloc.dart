import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'folk_verses_event.dart';

part 'folk_verses_state.dart';

class FolkVersesBloc extends Bloc<FolkVersesEvent, FolkVersesState> {
  List<String> contentList = [];

  FolkVersesBloc() : super(FolkVersesInitial()) {
    on<FolkVersesEvent>((event, emit) {});
    on<LoadFolkVersesEvent>(_fetchFolkVerses);
  }

  void _fetchFolkVerses(
      LoadFolkVersesEvent event, Emitter<FolkVersesState> emit) async {
    emit(LoadingFolkVersesState());
    String content = await _loadContent(event.fileName);
    contentList = content.split('\n*\n');
    emit(FinishLoadFolkVersesState());
  }

  Future<String> _loadContent(String fileName) async {
    return await rootBundle.loadString('resources/folk_verses/$fileName');
  }
}
