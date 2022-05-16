import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_literary/presentation/common/card_view_content.dart';
import 'package:flutter_literary/presentation/common/no_data_component.dart';
import 'package:flutter_literary/presentation/common/search_bar_item.dart';
import 'package:flutter_literary/presentation/common/title_app_bar.dart';

import '../../../data/file_name_model.dart';
import '../bloc/folk_verses_bloc.dart';

class FolkVersesPage extends StatelessWidget {
  const FolkVersesPage({Key? key}) : super(key: key);

  static const routeName = 'FolkVersesPage';

  @override
  Widget build(BuildContext context) {
    final file = ModalRoute.of(context)!.settings.arguments as FileNameModel;
    return BlocProvider(
      create: (context) => FolkVersesBloc(),
      child: FolkVersesScreen(
        file: file,
      ),
    );
  }
}

class FolkVersesScreen extends StatefulWidget {
  const FolkVersesScreen({Key? key, required this.file}) : super(key: key);

  final FileNameModel file;

  @override
  _FolkVersesScreenState createState() => _FolkVersesScreenState();
}

class _FolkVersesScreenState extends State<FolkVersesScreen> {
  late FolkVersesBloc _bloc;

  @override
  void initState() {
    _bloc = context.read<FolkVersesBloc>();
    _bloc.add(LoadFolkVersesEvent(fileName: widget.file.fileName));
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
    return BlocConsumer<FolkVersesBloc, FolkVersesState>(
        builder: (context, state) {
          Widget bodyWidget = noDataComponent();
          if (state is LoadingFolkVersesState) {
            return Text('Loading...');
          }

          if (state is FinishLoadFolkVersesState) {
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
                    _bloc.add(FilterFolkVersesEvent(text: text));
                  }),
                  Expanded(
                    child: bodyWidget,
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
