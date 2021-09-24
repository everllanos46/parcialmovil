import 'package:flutter/material.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _user = "";
  String _password = "";
  late TextEditingController _userController;
  late TextEditingController _passController;
  @override
  void initState() {
    _userController = TextEditingController();
    _passController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: _camposLogin(),
      ),
    );
  }

  List<Widget> _camposLogin() {
    final List<Widget> inputs = [];
    inputs..add(_cardImage())..add(Divider());
    final inputUser = TextField(
      keyboardType: TextInputType.text,
      controller: _userController,
      decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black),
          suffix: GestureDetector(
            child: Icon(Icons.close),
            onTap: () {
              _userController.clear();
            },
          ),
          hintText: 'Usuario',
          labelText: 'Ingrese su usuario',
          suffixIcon: Icon(Icons.perm_identity),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      onChanged: (value) => _user = value,
    );
    inputs..add(inputUser)..add(Divider());
    final inputPass = TextField(
        obscureText: true,
        controller: _passController,
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.black),
            suffix: GestureDetector(
            child: Icon(Icons.close),
            onTap: () {
              _passController.clear();
            },
          ),
            hintText: 'Contraseña',
            labelText: 'Ingrese su contraseña',
            suffixIcon: Icon(Icons.password),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) => _password = value);
    inputs..add(inputPass)..add(Divider());
    inputs.add(_createButton());
    return inputs;
  }

  Widget _cardImage() {
    final card = Container(
      child: Column(
        children: <Widget>[
          Image(
              image: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTu5H-Ih4ojE7KqCNSIfYw2UM0TcXeK6S8tWA&usqp=CAU'),
              height: 150,
              fit: BoxFit.cover),
          Container(padding: EdgeInsets.all(10))
        ],
      ),
    );
    return card;
  }

  Widget _createButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40))),
          onPressed: () => _validateInputs(),
          child:
              Text('Entrar', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }

  void _validateInputs() {
    if (_userController.text == "parcial" && _passController.text == "123") {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MyHomePage(title: _userController.text);
      }));
      _showAlerts(true);
    } else {
      _showAlerts(false);
    }
  }

  void _showAlerts(bool login) {
    if (login) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Bienvenido'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Usuario y contraseña correcta, bienvenido!'),
                  Image(
                    image: NetworkImage(
                        'https://definicion.de/wp-content/uploads/2017/01/Correcto.jpg'),
                    height: 100,
                  )
                ],
              ),
            );
          },
          barrierDismissible: true);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error!'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Usuario y contraseña incorrecta, vuelva a intentar!'),
                  Image(
                    image: NetworkImage(
                        'http://altaglatam.com/wp-content/uploads/2014/03/errores.png'),
                    height: 50,
                  )
                ],
              ),
              actions: <Widget>[
                TextButton(child: Text('Cancelar'), onPressed: () {})
              ],
            );
          },
          barrierDismissible: true);
    }
  }
}
