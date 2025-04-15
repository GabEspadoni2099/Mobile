import 'package:flutter/material.dart';
import 'package:sa03_app_navegacao_cadastro/view/tela_cadastro.dart' show TelaCadastro;
import 'package:sa03_app_navegacao_cadastro/view/tela_inicial.dart';

import 'view/tela_confirmacao.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      "/": (context) => TelaInicial(),
      "/cadastro": (context) => TelaCadastro(),
      "/confirmacao": (context) => TelaConfirmacao()
    },
    initialRoute: "/",
  ));
}