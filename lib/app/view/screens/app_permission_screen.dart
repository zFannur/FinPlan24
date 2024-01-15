import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class StoragePermissionScreen extends StatefulWidget {
  const StoragePermissionScreen({super.key});

  @override
  StoragePermissionScreenState createState() => StoragePermissionScreenState();
}

class StoragePermissionScreenState extends State<StoragePermissionScreen> {
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    checkPermissionStatus();
  }

  Future<void> checkPermissionStatus() async {
    bool hasPermission = await Permission.storage.isGranted;
    setState(() {
      _hasPermission = hasPermission;
    });
  }

  Future<void> requestPermission() async {
    PermissionStatus status = await Permission.storage.request();
    setState(() {
      _hasPermission = status.isGranted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Storage Permission'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _hasPermission ? 'Permission Granted' : 'Permission Not Granted',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: requestPermission,
              child: Text('Request Permission'),
            ),
          ],
        ),
      ),
    );
  }
}