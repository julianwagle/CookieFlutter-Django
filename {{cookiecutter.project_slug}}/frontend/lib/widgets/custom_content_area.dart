import 'package:flutter/material.dart';

class CustomContentArea extends StatelessWidget {
  const CustomContentArea({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      constraints: BoxConstraints(maxWidth: 1200),
      child: child,
    );
  }
}
