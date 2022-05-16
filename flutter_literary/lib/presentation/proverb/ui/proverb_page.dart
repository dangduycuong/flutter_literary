import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_literary/presentation/common/card_view_content.dart';
import 'package:flutter_literary/presentation/common/search_bar_item.dart';

import '../../../data/file_name_model.dart';
import '../bloc/proverb_bloc.dart';

class ProverbPage extends StatelessWidget {
  static const routeName = 'ProverbPage';

  const ProverbPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final file = ModalRoute.of(context)!.settings.arguments as FileNameModel;
    return BlocProvider(
      create: (BuildContext context) => ProverbBloc(),
      child: ProverbScreen(
        file: file,
      ),
    );
  }
}

class ProverbScreen extends StatefulWidget {
  final FileNameModel file;

  const ProverbScreen({Key? key, required this.file}) : super(key: key);

  @override
  _ProverbScreenState createState() => _ProverbScreenState();
}

class _ProverbScreenState extends State<ProverbScreen> {
  late ProverbBloc _bloc;

  @override
  void initState() {
    _bloc = context.read<ProverbBloc>();
    _bloc.add(LoadListProverbEvent(fileName: widget.file.fileName));
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
    return BlocConsumer<ProverbBloc, ProverbState>(
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
        if (state is FinishLoadListProverbState) {
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
              title: Text(
                widget.file.description,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            body: Column(
              children: [
                SearchBarItem(textChangValue: (text) {
                  _bloc.add(FilterListProverbEvent(text: text));
                }),
                Expanded(child: bodyWidget),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
