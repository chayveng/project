import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TesterScreen extends StatefulWidget {
  const TesterScreen({Key? key}) : super(key: key);

  @override
  _TesterScreenState createState() => _TesterScreenState();
}

class _TesterScreenState extends State<TesterScreen> {
  onApi() async {
    var response =
        await http.delete(Uri.parse("http://localhost:80/time/deleteId/999"));
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () async => await onApi(),
            child: Text('API'),
          ),
        ),
      ),
    );
  }
}
