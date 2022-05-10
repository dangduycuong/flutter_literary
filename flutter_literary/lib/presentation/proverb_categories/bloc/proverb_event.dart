part of 'proverb_bloc.dart';

abstract class ProverbCategoriesEvent extends Equatable {
  const ProverbCategoriesEvent();
}

class LoadProverbCategoriesEvent extends ProverbCategoriesEvent {
  @override
  List<Object?> get props => [];
}

class ViewListProverbEvent extends ProverbCategoriesEvent {
  @override
  List<Object?> get props => [];
}
