import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_literary/presentation/common/card_view_title.dart';
import 'package:flutter_literary/presentation/common/search_bar_item.dart';
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

  Widget _buildListView() {
    return ListView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FolkVersesPage(),
                // Pass the arguments as part of the RouteSettings. The
                // DetailScreen reads the arguments from these settings.
                settings: RouteSettings(
                  arguments: _bloc.filteredFolkVerses[index],
                ),
              ),
            );
          },
          child: cardViewTitle(_bloc.filteredFolkVerses[index].description),
        );
      },
      itemCount: _bloc.filteredFolkVerses.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FolkVersesCategoriesBloc, FolkVersesCategoriesState>(
        listener: (context, state) {
      // do stuff here based on BlocA's state
    }, builder: (context, state) {
      Widget bodyWidget = const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Text(
          'Data Not Found',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      if (state is LoadingFolkVersesCategoriesState) {
        return const CircularProgressIndicator();
      }
      if (state is FinishLoadFolkVersesCategoriesState) {
        if (state.isNoData == false) {
          bodyWidget = _buildListView();
        }
      }
      return Column(
        children: [
          SearchBarItem(textChangValue: (text) {
            _bloc.add(FilterFolkVersesCategoriesEvent(text: text));
          }),
          Expanded(
            child: bodyWidget,
          ),
        ],
      );
    });
  }
}
