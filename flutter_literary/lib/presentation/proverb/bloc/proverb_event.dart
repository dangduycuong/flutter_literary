part of 'proverb_bloc.dart';

abstract class ProverbEvent extends Equatable {
  const ProverbEvent();
}

class LoadListProverbEvent extends ProverbEvent {
  final String fileName;

  const LoadListProverbEvent({required this.fileName});

  @override
  List<Object?> get props => [fileName];
}

class FilterListProverbEvent extends ProverbEvent {
  final String text;

  const FilterListProverbEvent({required this.text});

  @override
  List<Object?> get props => [text];
}
