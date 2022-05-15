import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_literary/presentation/Idioms_categories/bloc/idioms_categories_bloc.dart';
import 'package:flutter_literary/presentation/common/card_view_title.dart';
import 'package:flutter_literary/presentation/common/no_data_component.dart';
import 'package:flutter_literary/presentation/common/search_bar_item.dart';

import '../../Idioms/ui/Idioms_page.dart';

class IdiomsCategoriesPage extends StatelessWidget {
  const IdiomsCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IdiomsCategoriesBloc(),
      child: const IdiomsCategoriesView(),
    );
  }
}

class IdiomsCategoriesView extends StatefulWidget {
  const IdiomsCategoriesView({Key? key}) : super(key: key);

  @override
  _IdiomsCategoriesViewState createState() => _IdiomsCategoriesViewState();
}

class _IdiomsCategoriesViewState extends State<IdiomsCategoriesView> {
  late IdiomsCategoriesBloc _bloc;

  @override
  void initState() {
    _bloc = context.read<IdiomsCategoriesBloc>();
    _bloc.add(LoadIdiomsCategoriesEvent());
    super.initState();
  }

  ListView _buildListView() {
    return ListView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const IdiomsPage(),
                settings: RouteSettings(
                  arguments: _bloc.filteredIdiomsCategories[index],
                ),
              ),
            );
          },
          child:
              cardViewTitle(_bloc.filteredIdiomsCategories[index].description),
        );
      },
      itemCount: _bloc.filteredIdiomsCategories.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IdiomsCategoriesBloc, IdiomsCategoriesState>(
        builder: (context, state) {
          Widget bodyWidget = noDataComponent();
          if (state is FinishLoadIdiomsCategoriesState) {
            if (state.isNoData == false) {
              bodyWidget = _buildListView();
            }
          }
          return Column(
            children: [
              SearchBarItem(textChangValue: (text) {}),
              Expanded(child: bodyWidget),
            ],
          );
        },
        listener: (context, state) {});
  }
}
