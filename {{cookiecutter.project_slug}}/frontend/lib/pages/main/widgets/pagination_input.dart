import 'package:flutter/material.dart';

class PaginationInput extends StatefulWidget {
  PaginationInput({
    required this.numOfPages,
    required this.currentPage,
    required this.onChanged,
  });

  final int numOfPages;
  final int currentPage;
  final void Function(int page) onChanged;

  @override
  _PaginationInputState createState() => _PaginationInputState();
}

class _PaginationInputState extends State<PaginationInput> {
  @override
  Widget build(BuildContext context) {
    final numOfPages = widget.numOfPages;
    final currentPage = widget.currentPage;
    final pageList = List.generate(numOfPages, (index) => index + 1);
    return Wrap(
      children: pageList.map((page) {
        final isCurrent = page == currentPage;
        return TextButton(
          onPressed: () {
            widget.onChanged(page);
          },
          style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            overlayColor: MaterialStateProperty.resolveWith((states) =>
                states.contains(MaterialState.hovered) ? Colors.black12 : null),
            foregroundColor: MaterialStateProperty.all(
                isCurrent ? Colors.white : Theme.of(context).primaryColor),
            backgroundColor: MaterialStateProperty.all(
                isCurrent ? Theme.of(context).primaryColor : Colors.white),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
            side: MaterialStateProperty.all(
              BorderSide(
                color:
                    isCurrent ? Theme.of(context).primaryColor : Colors.black26,
              ),
            ),
            minimumSize: MaterialStateProperty.all(Size(40, 50)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              page.toString(),
              // TODO: underline on hover
              // style: TextStyle(decoration: TextDecoration.underline),
            ),
          ),
        );
      }).toList(),
    );
  }
}
