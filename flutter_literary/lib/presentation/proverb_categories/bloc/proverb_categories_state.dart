part of 'proverb_categories_bloc.dart';

abstract class ProverbCategoriesState extends Equatable {
  const ProverbCategoriesState();
}

class ProverbCategoriesInitial extends ProverbCategoriesState {
  @override
  List<Object> get props => [];
}

class LoadingProverbCategoriesState extends ProverbCategoriesState {
  @override
  List<Object> get props => [];
}

class FinishLoadProverbCategoriesState extends ProverbCategoriesState {
  final bool isNoData;

  const FinishLoadProverbCategoriesState({required this.isNoData});

  @override
  List<Object> get props => [isNoData];
}
