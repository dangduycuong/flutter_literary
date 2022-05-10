import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class LoadStringFromFile extends StatefulWidget {
  const LoadStringFromFile({Key? key}) : super(key: key);

  @override
  State<LoadStringFromFile> createState() => _LoadStringFromFileState();
}

class _LoadStringFromFileState extends State<LoadStringFromFile> {
  Future<String> _loadAsset() async {
    return await rootBundle
        .loadString('resources/folk_verses/ca_dao_tinh_yeu.text');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () async {
          String s = await _loadAsset();
          print('sssss $s');
        },
        child: const Text('Loading...'),
      ),
    );
  }
}

class FolkVersesScreen extends StatefulWidget {
  const FolkVersesScreen({Key? key}) : super(key: key);

  @override
  State<FolkVersesScreen> createState() => _FolkVersesScreenState();
}

class _FolkVersesScreenState extends State<FolkVersesScreen> {
  String _content = '';

  Future<String> _loadAsset() async {
    return await rootBundle
        .loadString('resources/folk_verses/ca_dao_tinh_yeu.text');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _loadAsset(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                'Result: \n${snapshot.data}',
                style: const TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  fontSize: 20,
                ),
              ),
            )
          ];
        } else if (snapshot.hasError) {
          children = <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            )
          ];
        } else {
          children = const <Widget>[
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting result...'),
            )
          ];
        }
        return Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          ),
        );
      },
    );
  }
}
