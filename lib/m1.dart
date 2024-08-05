import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

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
                'assets/images/banner 1.png',
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _showUploadOptions() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);

    if (result != null) {
      final file = result.files.single;
      // Handle the file upload here
      // You can use the file.path to get the path of the selected video
      print('File selected: ${file.path}');
    } else {
      // User canceled the picker
      print('No file selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Gallery'),
        backgroundColor: Color.fromARGB(255, 1, 4, 0), // Neon Green
      ),
      body: ListView.builder(
        itemCount: 10, // Number of items to display
        itemBuilder: (context, index) {
          return VideoCard(index: index);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Handle home button press
              },
            ),
            IconButton(
              icon: Icon(Icons.explore),
              onPressed: () {
                // Handle explore button press
              },
            ),
            SizedBox(width: 48), // Space for the upload button
            IconButton(
              icon: Icon(Icons.upload),
              onPressed: _showUploadOptions,
              color: Color(0xFF39FF14), // Neon Green
            ),
            SizedBox(width: 48), // Space for symmetry
            IconButton(
              icon: Icon(Icons.library_books),
              onPressed: () {
                // Handle library button press
              },
            ),
          ],
        ),
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final int index;

  const VideoCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    // Define the thumbnail image path with .jpg extension
    String thumbnailPath = 'assets/images/thumbnail${index + 1}.jpg';

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            thumbnailPath,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/profile_image.png', // Replace with the correct path if needed
                  ),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Video Title $index',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text('Channel Name'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
