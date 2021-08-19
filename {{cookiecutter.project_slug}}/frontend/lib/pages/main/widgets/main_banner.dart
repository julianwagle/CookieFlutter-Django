import 'package:flutter/material.dart';

class MainBanner extends StatelessWidget {
  const MainBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Theme.of(context).primaryColor,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0, 0.03],
                colors: [Color(0x30000000), Colors.transparent],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 0.03],
                colors: [Color(0x30000000), Colors.transparent],
              ),
            ),
          ),
          Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectableText(
                    'conduit',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                            blurRadius: 1,
                            color: Colors.black26,
                            offset: Offset(0, 2)),
                      ],
                    ),
                  ),
                  SelectableText(
                    'A place to share your Flutter knowledge.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
