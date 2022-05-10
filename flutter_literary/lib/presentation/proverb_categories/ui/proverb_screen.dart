import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/proverb_bloc.dart';

class ProverbCategoriesPage extends StatelessWidget {
  const ProverbCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (BuildContext context) => ProverbCategoriesBloc(),
      child: const ProverbCategoriesScreen(),
    );
  }
}

class ProverbCategoriesScreen extends StatefulWidget {
  const ProverbCategoriesScreen({Key? key}) : super(key: key);

  @override
  _ProverbCategoriesScreenState createState() => _ProverbCategoriesScreenState();
}

class _ProverbCategoriesScreenState extends State<ProverbCategoriesScreen> {
  late ProverbCategoriesBloc _bloc;

  @override
  void initState() {
    _bloc = context.read<ProverbCategoriesBloc>();
    _bloc.add(LoadProverbCategoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProverbCategoriesBloc, ProverbState>(
        builder: (context, state) {
          if (state is LoadingProverState) {}
          return ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  _bloc.add(ViewListProverbEvent());
                },
                child: Card(
                  margin: const EdgeInsets.all(16),
                  color: index == 0 ? Colors.amberAccent : Colors.white,
                  child: ListTile(
                    leading: Text(_bloc.data[index][0].toString()),
                    title: Text(_bloc.data[index][1].toString()),
                    trailing: Text(_bloc.data[index][2].toString()),
                  ),
                ),
              );
            },
            itemCount: _bloc.data.length,
          );
        },
        listener: (context, state) {});
  }
}
