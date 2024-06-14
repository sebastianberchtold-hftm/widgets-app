import 'package:flutter/material.dart';

import 'checkbox_widget.dart';
import 'elevated_button_widget.dart';
import 'outlined_button_widget.dart';
import 'text_button_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI Controls Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isChecked = false;
  String _buttonMessage = '';

  void _handleCheckboxChange(bool? value) {
    setState(() {
      _isChecked = value!;
    });
  }

  void _handleButtonPress(String message) {
    setState(() {
      _buttonMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UI Controls Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButtonWidget(
                onPressed: () => _handleButtonPress('ElevatedButton pressed')),
            SizedBox(height: 10),
            TextButtonWidget(
                onPressed: () => _handleButtonPress('TextButton pressed')),
            SizedBox(height: 10),
            OutlinedButtonWidget(
                onPressed: () => _handleButtonPress('OutlinedButton pressed')),
            SizedBox(height: 20),
            CheckboxWidget(value: _isChecked, onChanged: _handleCheckboxChange),
            SizedBox(height: 20),
            Text('Checkbox is ${_isChecked ? 'checked' : 'unchecked'}'),
            SizedBox(height: 20),
            Text(_buttonMessage,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
