import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página Principal'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
           // Navigator.pushReplacementNamed(context, '/home');
           Navigator.pushNamed(context, '/agents');
          },
          child: Text('Presióname'),
        ),
      ),
    );
  }
}