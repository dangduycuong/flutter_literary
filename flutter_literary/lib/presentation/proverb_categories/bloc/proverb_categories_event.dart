part of 'proverb_categories_bloc.dart';

abstract class ProverbCategoriesEvent extends Equatable {
  const ProverbCategoriesEvent();
}

class LoadProverbCategoriesEvent extends ProverbCategoriesEvent {
  @override
  List<Object?> get props => [];
}

class FilterProverbCategoriesEvent extends ProverbCategoriesEvent {
  final String text;

  const FilterProverbCategoriesEvent({required this.text});

  @override
  List<Object?> get props => [text];
}
