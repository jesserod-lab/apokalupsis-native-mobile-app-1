import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  void _showUploadOptions() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null) {
      final file = result.files.single;
      // Handle the file upload here
      // Use Firebase Storage to upload the file
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
        title: const Text('Admin Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _showUploadOptions,
          child: Text('Upload File'),
        ),
      ),
    );
  }
}
