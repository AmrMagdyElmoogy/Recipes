import 'package:flutter/material.dart';

class Converter extends StatefulWidget {
  const Converter({ Key? key }) : super(key: key);

  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  @override
  Widget build(BuildContext context) {
    return Text( 
      'Converter Page', style: Theme.of(context).textTheme.bodyText1
    );
  }
}