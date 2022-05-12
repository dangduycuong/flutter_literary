part of 'folk_verses_bloc.dart';

abstract class FolkVersesState extends Equatable {
  const FolkVersesState();
}

class FolkVersesInitial extends FolkVersesState {
  @override
  List<Object> get props => [];
}

class LoadingFolkVersesState extends FolkVersesState {
  @override
  List<Object> get props => [];
}

class FinishLoadFolkVersesState extends FolkVersesState {
  @override
  List<Object> get props => [];
}
