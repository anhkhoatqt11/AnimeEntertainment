import 'package:flutter/material.dart';

class DetailComicPage extends StatelessWidget {
  final String comicId;

  DetailComicPage({required this.comicId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Details for $comicId',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
