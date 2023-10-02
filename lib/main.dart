import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: JokenPo(),
  ));
}

class JokenPo extends StatefulWidget {
  const JokenPo({Key? key}) : super(key: key);

  @override
  _JokenPoState createState() => _JokenPoState();
}

class _JokenPoState extends State<JokenPo> {
  String escolhaUsuario = "padrao";
  String escolhaApp = "padrao";

  void _sortearEscolhaApp() {
    final List<String> opcoes = ["pedra", "papel", "tesoura"];
    final Random random = Random();
    final int indiceSorteado = random.nextInt(opcoes.length);
    setState(() {
      escolhaApp = opcoes[indiceSorteado];
    });
  }

  void _verificarVencedor() {
    if (escolhaUsuario == escolhaApp) {
      // Empate
      _exibirResultado('Empate! Tente novamente.');
    } else if (
    (escolhaUsuario == "pedra" && escolhaApp == "tesoura") ||
        (escolhaUsuario == "papel" && escolhaApp == "pedra") ||
        (escolhaUsuario == "tesoura" && escolhaApp == "papel")) {
      // Usuário venceu
      _exibirResultado('Você venceu!');
    } else {
      // APP venceu
      _exibirResultado('O APP venceu!');
    }
  }

  void _exibirResultado(String mensagem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Resultado'),
          content: Text(mensagem),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _resetarEscolha() {
    setState(() {
      escolhaUsuario = "padrao";
      escolhaApp = "padrao";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Joken Po'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _resetarEscolha,
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Escolha do APP',
            style: TextStyle(fontSize: 20),
          ),
          Image.asset("images/$escolhaApp.png"),
          Text(
            "Escolha uma opção abaixo",
            style: TextStyle(fontSize: 20),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        escolhaUsuario = "papel";
                      });
                      _sortearEscolhaApp();
                      _verificarVencedor();
                    },
                    child: Image.asset(
                      "images/papel.png",
                      width: 90,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        escolhaUsuario = "pedra";
                      });
                      _sortearEscolhaApp();
                      _verificarVencedor();
                    },
                    child: Image.asset(
                      "images/pedra.png",
                      width: 90,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        escolhaUsuario = "tesoura";
                      });
                      _sortearEscolhaApp();
                      _verificarVencedor();
                    },
                    child: Image.asset(
                      "images/tesoura.png",
                      width: 90,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
