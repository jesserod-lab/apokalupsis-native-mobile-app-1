import 'package:flutter/material.dart';
import 'home_screen.dart';


void main() {
  runApp(ApokalupsisApp());
}

class ApokalupsisApp extends StatefulWidget {
  @override
  _ApokalupsisAppState createState() => _ApokalupsisAppState();
}

class _ApokalupsisAppState extends State<ApokalupsisApp> {
  bool _isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apokalupsis UI',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: HomeScreen(
        isDarkMode: _isDarkMode,
        onThemeChanged: (bool value) {
          setState(() {
            _isDarkMode = value;
          });
        },
      ),
    );
  }
}
