import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:tabletop_gui/src/blocs/login_bloc_provider.dart';

import 'package:tabletop_gui/src/models/user.dart';

import 'package:tabletop_gui/src/screens/games.dart';
import 'package:tabletop_gui/src/screens/profile.dart';
import 'package:tabletop_gui/src/screens/user_settings.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({Key key, @required this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _controller = PageController(
    initialPage: 0,
  );
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[_buildPageView(), _buildCircleIndicator()]);
  }

  Widget _buildPageView() {
    return PageView(
      controller: _controller,
      children: <Widget>[
        GamesScreen(),
        ProfileScreen(user: widget.user),
        LoginBlocProvider(
          child: SettingsScreen(),
        )
      ],
      onPageChanged: (int index) {
        _currentPageNotifier.value = index;
      },
    );
  }

  Widget _buildCircleIndicator() {
    return Positioned(
        left: 0,
        right: 0,
        bottom: 20,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: CirclePageIndicator(
            size: 12.0,
            selectedSize: 12.0,
            dotSpacing: 30.0,
            currentPageNotifier: _currentPageNotifier,
            itemCount: 3,
          ),
        ));
  }
}
