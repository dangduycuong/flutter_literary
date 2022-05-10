import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../folk_verses/ui/folk_verses_page.dart';
import '../bloc/folk_verses_categories_bloc.dart';

class FolkVersesCategoriesPage extends StatelessWidget {
  const FolkVersesCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (BuildContext context) => FolkVersesCategoriesBloc(),
      child: const ForkVersesCategoriesScreen(),
    );
  }
}

class ForkVersesCategoriesScreen extends StatefulWidget {
  const ForkVersesCategoriesScreen({Key? key}) : super(key: key);

  @override
  _ForkVersesCategoriesScreenState createState() =>
      _ForkVersesCategoriesScreenState();
}

class _ForkVersesCategoriesScreenState
    extends State<ForkVersesCategoriesScreen> {
  late FolkVersesCategoriesBloc _bloc;

  @override
  void initState() {
    _bloc = context.read<FolkVersesCategoriesBloc>();
    _bloc.add(LoadFolkVersesCategoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FolkVersesCategoriesBloc, FolkVersesCategoriesState>(
        listener: (context, state) {
      // do stuff here based on BlocA's state
    }, builder: (context, state) {
      if (state is LoadingFolkVersesCategoriesState) {
        return const CircularProgressIndicator();
      }
      return ListView.builder(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FolkVersesPage(),
                  // Pass the arguments as part of the RouteSettings. The
                  // DetailScreen reads the arguments from these settings.
                  settings: RouteSettings(
                    arguments: _bloc.folkVersesCategories[index][0].toString(),
                  ),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(16),
              color: index == 0 ? Colors.amberAccent : Colors.white,
              child: ListTile(
                title: Text(_bloc.folkVersesCategories[index][1].toString()),
              ),
            ),
          );
        },
        itemCount: _bloc.folkVersesCategories.length,
      );
    });
  }
}
