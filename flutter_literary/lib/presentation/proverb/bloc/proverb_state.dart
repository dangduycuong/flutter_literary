part of 'proverb_bloc.dart';

abstract class ProverbState extends Equatable {
  const ProverbState();
}

class ProverbInitial extends ProverbState {
  @override
  List<Object> get props => [];
}

class LoadingListProverbState extends ProverbState {
  @override
  List<Object> get props => [];
}

class FinishLoadListProverbState extends ProverbState {
  final bool isNoData;

  const FinishLoadListProverbState({required this.isNoData});

  @override
  List<Object> get props => [isNoData];
}
