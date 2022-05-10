part of 'folk_verses_bloc.dart';

abstract class FolkVersesEvent extends Equatable {
  const FolkVersesEvent();
}

class LoadFolkVersesEvent extends FolkVersesEvent {
  final String fileName;

  const LoadFolkVersesEvent({
    required this.fileName,
  });

  @override
  List<Object> get props => [fileName];
}
