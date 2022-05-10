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
    on<LoadListFolkVersesEvent>(_fetchListFolkVerses);
  }

  void _fetchListFolkVerses(LoadListFolkVersesEvent event, Emitter<FolkVersesState> emit) async {
    emit(LoadingFolkVersesState());
    String content = await _loadAsset();
    contentList = content.split('*');
    emit(LoadFolkVersesSuccessState());
  }

  Future<String> _loadAsset() async {
    return await rootBundle
        .loadString('resources/folk_verses/ca_dao_viet_nam_hay_nhat.text');
  }
}
