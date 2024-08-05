import 'package:flutter/material.dart';
import 'my_home_page.dart'; // Import MyHomePage


class HomeScreen extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  HomeScreen({required this.isDarkMode, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AspectRatio(
              aspectRatio: MediaQuery.of(context).orientation == Orientation.portrait ? 3 / 1 : 3 / 2,
              child: Image.asset(
                'assets/images/banner 2.png',
                fit: MediaQuery.of(context).orientation == Orientation.portrait ? BoxFit.cover : BoxFit.contain,
              ),
            ),
            SwitchListTile(
              title: Text('Dark Mode'),
              value: isDarkMode,
              onChanged: onThemeChanged,
              secondary: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'About Us',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Apokalupsis is a life changing ministry with a mandate and vision to open men\'s eyes to the realities of the word of God.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '  ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            _buildButton(context, 'Sermons', 'Mindset change', MyHomePage()),
            _buildButton(context, 'Upcoming events', 'See you there'),
            _buildButton(context, 'Tribe', 'Divine Apokalupsis Tribe'),
            _buildButton(context, 'Devotionals', 'Fresh Insights'),
            _buildButton(context, 'Giving', 'Patnership'),
            _buildButton(context, 'Marriage', 'Check details'),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title, String subtitle, [Widget? nextPage]) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Color(0xFF39FF14), // Neon Green
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(vertical: 20),
          textStyle: TextStyle(fontSize: 18),
          elevation: 10,
        ),
        onPressed: () {
          if (nextPage != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => nextPage),
            );
          }
        },
        child: Column(
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(subtitle),
          ],
        ),
      ),
    );
  }
}
