part of 'idioms_categories_bloc.dart';

abstract class IdiomsCategoriesEvent extends Equatable {
  const IdiomsCategoriesEvent();
}

class LoadIdiomsCategoriesEvent extends IdiomsCategoriesEvent {
  @override
  List<Object> get props => [];
}

class FilterIdiomsCategoriesEvent extends IdiomsCategoriesEvent {
  final String text;

  const FilterIdiomsCategoriesEvent({required this.text});

  @override
  List<Object> get props => [text];
}
