
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Text Speichern',
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final TextEditingController textController = TextEditingController();
  String savedText = "";

  @override
  void initState() {
    super.initState();
    _loadSavedText();
  }

  _loadSavedText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedText = prefs.getString('saved_text') ?? "";
    });
  }

  _saveText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('saved_text', textController.text);
    _loadSavedText(); 
  }

  _loadText() {
    textController.text = savedText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Speichern'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(labelText: 'Eingabe'),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _saveText();
                  },
                  child: const Text('Speichern'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _loadText();
                  },
                  child: const Text('Laden'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}