import 'package:calculadora_flutter/services/calcular.dart';
import 'package:flutter/material.dart';



void main() => runApp(const MaterialApp(
  home: App(),
));


class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  var output = 0; // Variável de output
  var outputString = '0'; // Equação para o cálculo do output
  var regexIsNumeric = RegExp(r'[0-9]$');





  Widget inputButton (Widget inputChild, Function() action) {
    // TODO: Criar diretório '/widgets' e mover os widgets para lá
    return TextButton (
      style: ButtonStyle (
          backgroundColor: const WidgetStatePropertyAll<Color>(Colors.white),
          elevation: const WidgetStatePropertyAll<double>(16.0),
          shadowColor: WidgetStatePropertyAll<Color?>(Colors.blueGrey[600]),
          shape: WidgetStatePropertyAll<OutlinedBorder>(
              RoundedRectangleBorder (
                  borderRadius: BorderRadius.circular(8.0)
              )
          )
      ),
      onPressed: action,
      child: inputChild
    );
  }

  Widget iconInputButton(Icon icon, Function() action) => inputButton(icon, action);
  Widget onlyInputButton(Text text) => inputButton(text, () {
    setState(() {
      if(regexIsNumeric.hasMatch(outputString[outputString.length-1]) && outputString[outputString.length-1] != '.') {
        outputString += text.data.toString();
      }
    });
  });

  Widget textInputButton(Text text) => inputButton(text, () {setState(() {
    if(outputString.length == 1 && outputString == '0') {
      outputString = text.data.toString();
    } else {
      outputString += text.data.toString();
    }
  });});


  List<Widget> createButtonInputs() {
    List<Widget> list = [];
    const Color btnDataColor = Colors.black;
    const TextStyle textStyle = TextStyle(
      color: btnDataColor,
      fontSize: 32.0,
    );

    // Actions:
    actionRemove() {
      setState(() {
        if(outputString.length > 1) {
          if(outputString[outputString.length-2] == '.') {
            outputString = outputString.substring(0, outputString.length-2);
          } else {
            outputString = outputString.substring(0, outputString.length-1);
          }
        } else {
          if(outputString != '0') outputString = '0';
        }
      });
    }

    actionResult() {
      String ultimoChar = outputString[outputString.length-1];
      if(outputString.length > 2) {
        if(regexIsNumeric.hasMatch(ultimoChar) && ultimoChar != '.') {
          RegExp regexOp = RegExp(r'[\*\+\-]');
          if(regexOp.hasMatch(outputString)) {
            setState(() {
              Calculadora calculadora = Calculadora(outputString);
              double resultado = calculadora.calcular();

              outputString = resultado.toString();
            });
          }
        }
      }
    }

    // [Row 1]
    list.add(textInputButton(const Text('1', style: textStyle))); // Add 1
    list.add(textInputButton(const Text('2', style: textStyle))); // Add 2
    list.add(textInputButton(const Text('3', style: textStyle))); // Add 3
    list.add(onlyInputButton(const Text('+', style: textStyle))); // Add +

    // [Row 2]
    list.add(textInputButton(const Text('4', style: textStyle))); // Add 4
    list.add(textInputButton(const Text('5', style: textStyle))); // Add 5
    list.add(textInputButton(const Text('6', style: textStyle))); // Add 6
    list.add(onlyInputButton(const Text('-', style: textStyle))); // Add -

    // [Row 3]
    list.add(textInputButton(const Text('7', style: textStyle))); // Add 7
    list.add(textInputButton(const Text('8', style: textStyle))); // Add 8
    list.add(textInputButton(const Text('9', style: textStyle))); // Add 9
    list.add(onlyInputButton(const Text('*', style: textStyle))); // Add *

    // [Row 4]
    list.add(textInputButton(const Text('0', style: textStyle))); // Add 0
    list.add(onlyInputButton(const Text('.', style: textStyle))); // Add ,
    list.add(iconInputButton(const Icon(Icons.backspace, color: btnDataColor), actionRemove)); // Remove
    list.add(inputButton(const Text('=', style: textStyle), actionResult)); // Calc

    return list;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Resolver erro : (RangeError (index): Invalid value: Not in inclusive range 0..3: 4) - Exemplo : 12 * 4 + 5 -7.4
    // TODO: Transformar de double para algo similar a Long <- resolver RangeError
    // TODO: Configurar propriedades de Widgets em base as dimensões da tela
    // TODO: Alterar configurações de propriedade quando alterado a "Rotação da Tela"
    // TODO: Permitir alterar conjunto de cores
    // TODO: Adicionar Botões para Limpar e de Divisão
    // TODO: Transformar Text() de [Input Container] em uma caixa de texto

    // [Widgets : Variáveis]
    var horizontalPadding = 16.0;

    // [Output Container: Variáveis]
    var backgroundcolorOutputContainer = Colors.grey[700];

    // [Input Container: Variáveis]
    var backgroundcolorInputContainer = Colors.grey[900];
    var shapeBorderRadius = Radius.circular(16.0);
    List<Widget> inputButtons = createButtonInputs();


    return Scaffold (
      backgroundColor: backgroundcolorOutputContainer,
      body: SafeArea (
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
            Expanded(
              // [Output Container]
              flex: 1,
              child: Container (
                alignment: Alignment.centerRight,
                color: backgroundcolorOutputContainer,
                child: Padding(
                  // TODO: "infinito" scroll horizontal
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: horizontalPadding),
                  child: Text(
                    outputString,
                    style: const TextStyle (
                      color: Colors.white,
                      fontSize: 32,
                      letterSpacing: 2.0
                    ),
                  ),
                ),
              )
            ),
            Expanded(
              // [Input Container]
              // TODO: Resolver posicionamento e tamanho de cada Widget
              flex: 3,
              child: Container (
                decoration: ShapeDecoration (
                  color: backgroundcolorInputContainer,
                  shape: RoundedRectangleBorder (
                    borderRadius: BorderRadius.only(topLeft: shapeBorderRadius, topRight: shapeBorderRadius)
                  )
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 45.0, horizontal: horizontalPadding),
                  child: GridView.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 5,
                    children: inputButtons,
                  )
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}