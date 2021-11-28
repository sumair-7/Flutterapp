import "package:flutter/material.dart";
import "./random_words.dart";

void main() => runApp(Myapp());

class Myapp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.redAccent),
      home: Randomwords(),
      );
  }
}