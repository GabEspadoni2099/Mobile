import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MeuPerfilApp());

class MeuPerfilApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Perfil Persistente',
      home: PerfilPage(),
    );
  }
}

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  String? _corFavorita;
  String? _nomeSalvo;
  int? _idadeSalva;
  String? _corSalva;

  final List<String> _cores = ['Azul', 'Verde', 'Vermelho', 'Amarelo', 'Roxo'];

  Map<String, Color> corMapa = {
    'Azul': Colors.blue,
    'Verde': Colors.green,
    'Vermelho': Colors.red,
    'Amarelo': Colors.yellow,
    'Roxo': Colors.purple,
  };

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nomeSalvo = prefs.getString('nome');
      _idadeSalva = prefs.getInt('idade');
      _corSalva = prefs.getString('cor');
    });
  }

  Future<void> _salvarDados() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nome', _nomeController.text);
    await prefs.setInt('idade', int.tryParse(_idadeController.text) ?? 0);
    await prefs.setString('cor', _corFavorita ?? 'Azul');
    _carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corMapa[_corSalva] ?? Colors.white,
      appBar: AppBar(
        title: Text('Meu Perfil'),
        backgroundColor: corMapa[_corSalva] ?? Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _idadeController,
              decoration: InputDecoration(labelText: 'Idade'),
              keyboardType: TextInputType.number,
            ),
            DropdownButtonFormField<String>(
              value: _corFavorita,
              items: _cores.map((String cor) {
                return DropdownMenuItem<String>(
                  value: cor,
                  child: Text(cor),
                );
              }).toList(),
              hint: Text('Escolha sua cor favorita'),
              onChanged: (String? novaCor) {
                setState(() {
                  _corFavorita = novaCor;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _salvarDados,
              child: Text('Salvar Dados'),
            ),
            Divider(height: 40),
            Text(
              'Dados Salvos:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (_nomeSalvo != null)
              Text('Nome: $_nomeSalvo', style: TextStyle(fontSize: 16)),
            if (_idadeSalva != null)
              Text('Idade: $_idadeSalva', style: TextStyle(fontSize: 16)),
            if (_corSalva != null)
              Text('Cor favorita: $_corSalva', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
