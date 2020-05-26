import 'package:flutter/material.dart';
import 'package:movies/pages/home_page.dart';
import 'package:movies/pages/details_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoviesApp',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'details': (BuildContext context) => DetailsPage()
      },
    );
  }
}
