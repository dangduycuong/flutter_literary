part of 'idioms_bloc.dart';

abstract class IdiomsEvent extends Equatable {
  const IdiomsEvent();
}

class LoadIdiomsEvent extends IdiomsEvent {
  final String fileName;

  const LoadIdiomsEvent({
    required this.fileName,
  });

  @override
  List<Object> get props => [fileName];
}

class FilterIdiomsEvent extends IdiomsEvent {
  final String text;

  const FilterIdiomsEvent({required this.text});

  @override
  List<Object?> get props => [text];
}
