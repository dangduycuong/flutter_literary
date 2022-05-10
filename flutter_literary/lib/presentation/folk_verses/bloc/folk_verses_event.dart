part of 'folk_verses_bloc.dart';

abstract class FolkVersesEvent extends Equatable {
  const FolkVersesEvent();
}

class LoadListFolkVersesEvent extends FolkVersesEvent {
  @override
  List<Object?> get props => [];
}