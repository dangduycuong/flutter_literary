part of 'idioms_categories_bloc.dart';

abstract class IdiomsCategoriesState extends Equatable {
  const IdiomsCategoriesState();
}

class IdiomsCategoriesInitial extends IdiomsCategoriesState {
  @override
  List<Object> get props => [];
}

class LoadingIdiomsCategoriesState extends IdiomsCategoriesState {
  @override
  List<Object> get props => [];
}

class FinishLoadIdiomsCategoriesState extends IdiomsCategoriesState {
  final bool isNoData;

  const FinishLoadIdiomsCategoriesState({required this.isNoData});

  @override
  List<Object> get props => [isNoData];
}
