import 'dart:io';
import 'package:flutter/material.dart';
import 'package:checklist_app/helpers/preferences_helper.dart';

class ImageDisplayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Display'),
      ),
      body: FutureBuilder<String?>(
        future: PreferencesHelper.getImagePath(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data != null) {
              return Image.file(File(snapshot.data!));
            } else {
              return Center(child: Text('No image selected'));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
