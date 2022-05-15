import 'package:flutter/material.dart';

Card cardViewContent(String content) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    color: Colors.white,
    child: ListTile(
      title: Text(
        content,
        style: const TextStyle(fontSize: 20),
      ),
    ),
  );
}
