import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_literary/presentation/common/card_view_content.dart';
import 'package:flutter_literary/presentation/common/no_data_component.dart';
import 'package:flutter_literary/presentation/common/search_bar_item.dart';
import 'package:flutter_literary/presentation/common/title_app_bar.dart';

import '../../../data/file_name_model.dart';
import '../bloc/idioms_bloc.dart';

class IdiomsPage extends StatelessWidget {
  static const routeName = 'FolkVersesPage';

  const IdiomsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final file = ModalRoute.of(context)!.settings.arguments as FileNameModel;
    return BlocProvider(
      create: (context) => IdiomsBloc(),
      child: IdiomsView(
        file: file,
      ),
    );
  }
}

class IdiomsView extends StatefulWidget {
  final FileNameModel file;

  const IdiomsView({Key? key, required this.file}) : super(key: key);

  @override
  _IdiomsViewState createState() => _IdiomsViewState();
}

class _IdiomsViewState extends State<IdiomsView> {
  late IdiomsBloc _bloc;

  @override
  void initState() {
    _bloc = context.read<IdiomsBloc>();
    _bloc.add(LoadIdiomsEvent(fileName: widget.file.fileName));
    super.initState();
  }

  Widget _buildListData() {
    return ListView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemBuilder: (context, index) {
        return cardViewContent(_bloc.filteredList[index].toString());
      },
      itemCount: _bloc.filteredList.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IdiomsBloc, IdiomsState>(
        builder: (context, state) {
          Widget bodyWidget = noDataComponent();
          if (state is FinishLoadIdiomsState) {
            if (state.isNoData == false) {
              bodyWidget = _buildListData();
            }
          }
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              appBar: AppBar(
                title: titleAppBar(widget.file.description),
              ),
              body: Column(
                children: [
                  SearchBarItem(textChangValue: (text) {
                    _bloc.add(FilterIdiomsEvent(text: text));
                  }),
                  Expanded(child: bodyWidget),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
