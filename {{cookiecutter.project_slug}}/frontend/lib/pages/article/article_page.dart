import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

class ArticlePage extends StatelessWidget {
  ArticlePage({@PathParam() required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('Page2'),
      ),
    );
  }
}
