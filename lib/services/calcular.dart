class Calculadora {

  String equacao;
  List<double> equacaoNums = [];
  List<String> equacaoOps = [];
  int nivel=0; // 0: Somar e Subtrair | 1: Multiplicar

  Calculadora(var this.equacao);


  void filtrar(String separador, Function calc) {
    if(equacaoNums.isNotEmpty && equacaoOps.isNotEmpty) {
      // Inicializa as novas variáveis
      List<String> newOps = [];
      List<double> newNums = [];

      // Processa calc()
      if (equacaoOps.length == 1) {
        newNums.add(calc(equacaoNums[0], equacaoNums[1]));
      } else {
        for (int indexOp = 0; indexOp < equacaoOps.length; indexOp++) {
          String opChar = equacaoOps[indexOp];
          int start = indexOp * 2;
          int end = start + 1;

          if (opChar == separador) {
            if (end >= equacaoNums.length - 1) {
              if(newNums.isNotEmpty) {
                newNums.add(calc(newNums[newNums.length-1], equacaoNums[start]));
              }
            } else {
              newNums.add(calc(equacaoNums[start], equacaoNums[end]));
            }
          } else {
            newOps.add(opChar);
            newNums.add(equacaoNums[start]);
          }
        }
      }

      // Registra valores calculados
      equacaoNums = newNums;
      equacaoOps = newOps;
    }
  }

  void separarNumeros() {
    Iterable<String> temp = equacao.split('');
    RegExp regexIsNumeric = RegExp(r'[0-9]$');

    print(temp);
    // Auxiliares
    String aux = "";

    // For()
    for(var i in temp) {
      if(regexIsNumeric.hasMatch(i)) {
        aux += i;
      } else if (i == '.') {
        if(!aux.contains('.')) {
          aux += (i);
        }
      } else {
        // Verifica se (i) é *
        if(i == '*') { nivel = 1; }

        // Adiciona o operador e número
        equacaoOps.add(i);
        equacaoNums.add(double.parse(aux));
        aux = ""; // Reinicia aulixiar
      }
    }

    // Adiciona o último número se houver
    if(aux.isNotEmpty) {
      equacaoNums.add(double.parse(aux));
    }
  }

  double calcular() {
    // Separar números
    if(equacaoNums.isEmpty && equacaoOps.isEmpty) {
      separarNumeros();
    }

    // Resolver
    // equacao : 4 * 8 + 2
    if(nivel == 1) {
      filtrar('*', multiplicar);
    }
    filtrar('+', somar);
    filtrar('-', subtrair);

    return equacaoNums.isNotEmpty ? equacaoNums[0] : 0;
  }

  // Funções para cálculo
  double multiplicar(double var1, double var2) => var1*var2;
  double somar(double var1, double var2) => var1+var2;
  double subtrair(double var1, double var2) => var1-var2;
}