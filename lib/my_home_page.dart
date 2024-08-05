import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _videos = List.generate(
    10,
    (index) => {
      'title': 'Video Title $index',
      'thumbnail': 'assets/images/thumbnail${index + 1}.jpg'
    },
  );
  List<Map<String, String>> _filteredVideos = [];

  @override
  void initState() {
    super.initState();
    _filteredVideos = _videos;
    _searchController.addListener(() {
      setState(() {
        _filteredVideos = _videos
            .where((video) =>
                video['title']!.toLowerCase().contains(_searchController.text.toLowerCase()))
            .toList();
      });
    });
  }

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
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search videos',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white54),
          ),
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Color.fromARGB(255, 1, 4, 0), // Neon Green
      ),
      body: ListView.builder(
        itemCount: _filteredVideos.length,
        itemBuilder: (context, index) {
          return VideoCard(
            title: _filteredVideos[index]['title']!,
            thumbnailPath: _filteredVideos[index]['thumbnail']!,
          );
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
  final String title;
  final String thumbnailPath;

  const VideoCard({super.key, required this.title, required this.thumbnailPath});

  @override
  Widget build(BuildContext context) {
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
                      title,
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
