part of 'folk_verses_categories_bloc.dart';

abstract class FolkVersesCategoriesEvent extends Equatable {
  const FolkVersesCategoriesEvent();
}

class LoadFolkVersesCategoriesEvent extends FolkVersesCategoriesEvent {
  @override
  List<Object?> get props => [];
}

class FilterFolkVersesCategoriesEvent extends FolkVersesCategoriesEvent {
  final String text;
  const FilterFolkVersesCategoriesEvent({required this.text});
  @override
  List<Object?> get props => [text];
}
