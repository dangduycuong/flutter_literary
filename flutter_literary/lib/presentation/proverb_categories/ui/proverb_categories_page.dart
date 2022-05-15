import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_literary/presentation/common/card_view_content.dart';
import 'package:flutter_literary/presentation/common/card_view_title.dart';
import 'package:flutter_literary/presentation/common/search_bar_item.dart';
import '../../proverb/ui/proverb_page.dart';
import '../bloc/proverb_categories_bloc.dart';

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
  _ProverbCategoriesScreenState createState() =>
      _ProverbCategoriesScreenState();
}

class _ProverbCategoriesScreenState extends State<ProverbCategoriesScreen> {
  late ProverbCategoriesBloc _bloc;

  @override
  void initState() {
    _bloc = context.read<ProverbCategoriesBloc>();
    _bloc.add(LoadProverbCategoriesEvent());
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
                builder: (context) => const ProverbPage(),
                settings: RouteSettings(
                  arguments: _bloc.filteredProverbCategories[index],
                ),
              ),
            );
          },
          child:
              cardViewTitle(_bloc.filteredProverbCategories[index].description),
        );
      },
      itemCount: _bloc.filteredProverbCategories.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProverbCategoriesBloc, ProverbCategoriesState>(
      builder: (context, state) {
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
        if (state is LoadingProverbCategoriesState) {}
        if (state is FinishLoadProverbCategoriesState) {
          if (state.isNoData == false) {
            bodyWidget = _buildListView();
          }
        }
        return Column(
          children: [
            SearchBarItem(textChangValue: (text) {
              _bloc.add(FilterProverbCategoriesEvent(text: text));
            }),
            Expanded(child: bodyWidget),
          ],
        );
      },
      listener: (context, state) {},
    );
  }
}
