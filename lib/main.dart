import 'package:calculadora_flutter/services/calculadora.dart';
import 'package:calculadora_flutter/widget/inputContainer.dart';
import 'package:calculadora_flutter/widget/outputcontainer.dart';
import 'package:flutter/material.dart';



void main() => runApp(const MaterialApp(
  home: App(),
  title: 'Calculadora Flutter',
  locale: Locale('pt', 'BR'),
));



class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String output="0";
  late Calculadora calculadora;
  late Widget _input;


  @override
  void initState() {
    super.initState();
    calculadora = Calculadora(update: (String out) {
      setState(() {
        output = out;
      });
    });
    _input = inputContainer(calculadora.getInput());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Colors.grey[700],
      body: SafeArea (
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
            Expanded(
              // [Output Container]
              flex: 1,
              child: outputContainer(output),
            ),
            Expanded(
              // [Input Container]
              flex: 3,
              child: _input,
            ),
          ],
        ),
      ),
    );
  }
}