part of 'idioms_bloc.dart';

abstract class IdiomsState extends Equatable {
  const IdiomsState();
}

class IdiomsInitial extends IdiomsState {
  @override
  List<Object> get props => [];
}

class LoadingIdiomsState extends IdiomsState {
  @override
  List<Object> get props => [];
}

class FinishLoadIdiomsState extends IdiomsState {
  final bool isNoData;

  const FinishLoadIdiomsState({required this.isNoData});

  @override
  List<Object?> get props => [isNoData];
}
