import 'package:flutter/material.dart';

class Layout {
  static Widget render({
    Widget appBar,
    Widget content,
    Widget fab,
  }) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: Colors.white,
      body: content,
      floatingActionButton: fab,
    );
  }
}