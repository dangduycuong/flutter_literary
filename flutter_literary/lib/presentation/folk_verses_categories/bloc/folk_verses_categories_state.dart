part of 'folk_verses_categories_bloc.dart';

abstract class FolkVersesCategoriesState extends Equatable {
  const FolkVersesCategoriesState();
}

class FolkVersesCategoriesInitial extends FolkVersesCategoriesState {
  @override
  List<Object> get props => [];
}

class LoadingFolkVersesCategoriesState extends FolkVersesCategoriesState {
  @override
  List<Object> get props => [];
}

class FinishLoadFolkVersesCategoriesState extends FolkVersesCategoriesState {
  final bool isNoData;

  const FinishLoadFolkVersesCategoriesState({required this.isNoData});

  @override
  List<Object> get props => [isNoData];
}
