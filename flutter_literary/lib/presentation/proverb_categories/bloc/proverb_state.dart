part of 'proverb_bloc.dart';

abstract class ProverbState extends Equatable {
  const ProverbState();
}

class ProverbInitial extends ProverbState {
  @override
  List<Object> get props => [];
}

class LoadingProverState extends ProverbState {
  @override
  List<Object> get props => [];
}

class LoadProverSuccessState extends ProverbState {
  @override
  List<Object> get props => [];
}
