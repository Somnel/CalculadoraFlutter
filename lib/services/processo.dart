class Processo {

  String equacao = '0'; // Equação original

  Processo();
  setEquacao(equacao) => this.equacao = equacao;



  double processar(String str1, String str2, String operacao) {
    final double var1 = double.parse(str1);
    final double var2 = double.parse(str2);

    switch(operacao) {
      case "*":
        return var1 * var2;
      case "/":
        return var1 / var2;
      default:
        throw ArgumentError('Operação inválida: $operacao');
    }
  }

  List<double> identificar() {
    // Váriaveis
    Iterable<String> itEquacao = equacao.split('');
    List<double> resultado = [];
    
    // Processo

    // - Variáveis auxiliares
    RegExp eNumerico = RegExp(r'^[0-9]+(\.[0-9]+)?$'); // Expressão Regular para confirmar se o item é um número
    String aux=""; // armezena o valor atual
    String temp=""; // guarda o valor de aux
    String opTemp=""; // armazena o operador atual


    for (var item in itEquacao) {
      bool eNumericoItem = eNumerico.hasMatch(item) || item == '.'; // SE é númerico ou igual ao separador
      bool eTempEmpty = temp.isEmpty; // SE a variável temp está vazia
      bool paraProcessar = (!eTempEmpty && !eNumericoItem); // SE é para executar processar()


      print('resultado: $resultado :||: item: $item :|>=> temp: $temp | aux: $aux | operador: $opTemp');


      if(!paraProcessar) {
        if(!eNumericoItem) {
          temp = aux;
          aux = "";
          opTemp = item;

          // SE o número for negativo
          if(item == '-') aux += '-';
        } else {
          aux += item;
        }
      } else {
        if(opTemp != '+' && opTemp != '-') {
          resultado.add(
              processar(temp, aux, opTemp)
          );

          aux = "";
          temp = "";
        } else {
          resultado.add(double.parse(temp));
          temp = aux;
          aux = "";
        }

        opTemp = item;

        // SE o número for negativo
        if(opTemp == '-') aux += '-';
      }
    }

    if(aux.isNotEmpty) {
      // SE faltar algum processo que não seja subtrair ou somar
      if(temp.isNotEmpty) {
        if(opTemp != '+' && opTemp != '-') {
          resultado.add(
              processar(temp, aux, opTemp)
          );
        } else {
          resultado.add(double.parse(temp));
          resultado.add(double.parse(aux));
        }
      } else {
        resultado.add(double.parse(aux));
      }
    }


    return resultado;
  }

  double interpretar() {
    double resultado=0;
    List<double> nums = identificar();
    for (var item in nums) {
      resultado += item;
    }

    return resultado;
  }
}