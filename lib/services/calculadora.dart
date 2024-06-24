import 'package:flutter/material.dart';
import 'package:calculadora_flutter/services/processo.dart';
import 'package:calculadora_flutter/widget/inputButton.dart';

class Calculadora {
  String output = "0";
  final Function(String) update;
  final regexIsNumeric = RegExp(r'[0-9]$');
  final processo = Processo();

  Calculadora({ required this.update });

  Widget getInput() {
    return GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 10,
      crossAxisSpacing: 5,
      children: setInputButton(),
    );
  }

  List<Widget> setInputButton() {
    List<Widget> retorno = [];

    const Color btnDataColor = Colors.black;
    const TextStyle textStyle = TextStyle(
      color: btnDataColor,
      fontSize: 32.0,
    );

    // [Actions] :
    // - Remover o último caractere da String de output
    actionRemove() {
      if(output.length > 1) {
        String temp = output[output.length-2];
        if(temp == '.' || temp == '-') {
          output = output.substring(0, output.length-2);
        } else {
          output = output.substring(0, output.length-1);
        }
      } else {
        if(output != '0') output = '0';
      }

      update(output);
    }

    // - Calcular resultado
    actionResult() {
      String ultimoChar = output[output.length-1];
      if(output.length > 2) {
        if(regexIsNumeric.hasMatch(ultimoChar) && ultimoChar != '.') {
          RegExp regexOp = RegExp(r'[\*\+\-]');
          if(regexOp.hasMatch(output)) {
            processo.setEquacao(output);
            double resultado = processo.interpretar();

            output = resultado.toString();
            update(output);
          }
        }
      }
    }
    // [/Actions]


    // [Botões de input]
    // - Coluna 1
    retorno.add(textInputButton(const Text('1', style: textStyle))); // Add 1
    retorno.add(textInputButton(const Text('2', style: textStyle))); // Add 2
    retorno.add(textInputButton(const Text('3', style: textStyle))); // Add 3
    retorno.add(onlyInputButton(const Text('+', style: textStyle))); // Add +

    // - Coluna 2
    retorno.add(textInputButton(const Text('4', style: textStyle))); // Add 4
    retorno.add(textInputButton(const Text('5', style: textStyle))); // Add 5
    retorno.add(textInputButton(const Text('6', style: textStyle))); // Add 6
    retorno.add(onlyInputButton(const Text('-', style: textStyle))); // Add -

    // - Coluna 3
    retorno.add(textInputButton(const Text('7', style: textStyle))); // Add 7
    retorno.add(textInputButton(const Text('8', style: textStyle))); // Add 8
    retorno.add(textInputButton(const Text('9', style: textStyle))); // Add 9
    retorno.add(onlyInputButton(const Text('*', style: textStyle))); // Add *

    // - Coluna 4
    retorno.add(textInputButton(const Text('0', style: textStyle))); // Add 0
    retorno.add(onlyInputButton(const Text('.', style: textStyle))); // Add ,
    retorno.add(iconInputButton(const Icon(Icons.backspace, color: btnDataColor), actionRemove)); // Remove
    retorno.add(inputButton(const Text('=', style: textStyle), actionResult)); // Calc

    // [/Botões de input]

    return retorno;
  }




  Widget iconInputButton(Icon icon, Function() action) => inputButton(icon, action);

  Widget onlyInputButton(Text text) {
    action() {
      String str = output[output.length - 1];
      if (regexIsNumeric.hasMatch(str) && str != '.') {
        output += text.data.toString();
      }

      update(output);
    }

     return inputButton(text, action);
  }

  Widget textInputButton(Text text) {
    action() {
      if(output.length == 1 && output == '0') {
        output = text.data.toString();
      } else {
        output += text.data.toString();
      }

      update(output);
    }

    return inputButton(text, action);
  }
}