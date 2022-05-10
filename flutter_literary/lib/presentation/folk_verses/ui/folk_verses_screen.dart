import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/folk_verses_bloc.dart';

class FolkVersesPage extends StatelessWidget {
  const FolkVersesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (BuildContext context) => FolkVersesBloc(),
      child: const ForkVersesScreen(),
    );
  }
}

class ForkVersesScreen extends StatefulWidget {
  const ForkVersesScreen({Key? key}) : super(key: key);

  @override
  _ForkVersesScreenState createState() => _ForkVersesScreenState();
}

class _ForkVersesScreenState extends State<ForkVersesScreen> {
  late FolkVersesBloc _bloc;

  @override
  void initState() {
    _bloc = context.read<FolkVersesBloc>();
    _bloc.add(LoadListFolkVersesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FolkVersesBloc, FolkVersesState>(
        listener: (context, state) {
      // do stuff here based on BlocA's state
    }, builder: (context, state) {
      if (state is LoadingFolkVersesState) {
        return const CircularProgressIndicator();
      }
      return ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Text(
              _bloc.contentList[index],
              style: const TextStyle(fontSize: 20),
            ),
          );
        },
        itemCount: _bloc.contentList.length,
      );
    });
  }
}
