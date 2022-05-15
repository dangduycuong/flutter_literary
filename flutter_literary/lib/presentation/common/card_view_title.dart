import 'package:flutter/material.dart';

Card cardViewTitle(String title) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    color: Colors.white,
    child: ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 20,
        ),
      ),
    ),
  );
}
