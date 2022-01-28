import 'package:flutter/material.dart';
class FeedBackPage extends StatefulWidget {
  const FeedBackPage({Key? key}) : super(key: key);

  @override
  State<FeedBackPage> createState() => _FeedBackPage();
}

class _FeedBackPage extends State<FeedBackPage> {
  String _content = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed Back Us!'),
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child:  TextField(
                maxLines: 24,
                onChanged: (String value) {
                  setState(() {
                    _content = value;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Type your feedback here',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 8),
              child: ElevatedButton(
                onPressed: () {

                },
                child: const Text('Send'),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50)
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
