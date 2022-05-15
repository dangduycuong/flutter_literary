import 'package:flutter/cupertino.dart';

Padding noDataComponent() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    child: Text(
      'Data Not Found',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
