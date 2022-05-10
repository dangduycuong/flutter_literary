import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/folk_verses_bloc.dart';

class FolkVersesPage extends StatelessWidget {
  const FolkVersesPage({Key? key}) : super(key: key);

  static const routeName = 'FolkVersesPage';

  @override
  Widget build(BuildContext context) {
    final fileName = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider(
      create: (context) => FolkVersesBloc(),
      child: FolkVersesScreen(
        fileName: fileName,
      ),
    );
  }
}

class FolkVersesScreen extends StatefulWidget {
  const FolkVersesScreen({Key? key, required this.fileName}) : super(key: key);

  final String fileName;

  @override
  _FolkVersesScreenState createState() => _FolkVersesScreenState();
}

class _FolkVersesScreenState extends State<FolkVersesScreen> {
  late FolkVersesBloc _bloc;

  @override
  void initState() {
    _bloc = context.read<FolkVersesBloc>();
    _bloc.add(LoadFolkVersesEvent(fileName: widget.fileName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FolkVersesBloc, FolkVersesState>(
        builder: (context, state) {
          if (state is LoadingFolkVersesState) {
            return Text('Loading...');
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.fileName),
            ),
            body: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(16),
                  color: index == 0 ? Colors.amberAccent : Colors.white,
                  child: ListTile(
                    title: Text(_bloc.contentList[index].toString()),
                  ),
                );
              },
              itemCount: _bloc.contentList.length,
            ),
          );
        },
        listener: (context, state) {});
  }
}
