import 'package:flutter/material.dart';
import 'package:smart_dustbin/ui/views/dustbin/dustbin_view.dart';
import 'package:smart_dustbin/ui/views/settings/settings_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0, keepPage: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.vertical,
        children: [
          DustbinView(
            onNavigationPressed: () => _controller.animateToPage(
              1,
              duration: Duration(milliseconds: 600),
              curve: Curves.easeInOut,
            ),
          ),
          SettingsView(
            onNavigationPressed: () => _controller.animateToPage(
              0,
              duration: Duration(milliseconds: 600),
              curve: Curves.easeInOut,
            ),
          ),
        ],
      ),
    );
  }
}
