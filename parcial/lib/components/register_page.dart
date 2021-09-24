import 'dart:developer';
import 'dart:math';
import 'package:parcial/models/personas.dart';

import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final titulo;
  const RegisterPage({this.titulo});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  List<Persona> _newPersonas = [];

  late TextEditingController _idController;
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _profesionController;
  late TextEditingController _photoController;
  late TextEditingController _dateController;

  @override
  void initState() {
    _idController = TextEditingController();
    _nameController = TextEditingController();
    _lastNameController = TextEditingController();
    _profesionController = TextEditingController();
    _photoController = TextEditingController();
    _dateController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registrar Persona")),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        children: _crearInputs(context),
      ),
    );
  }

  List<Widget> _crearInputs(BuildContext context) {
    final List<Widget> inputs = [];
    final inputIdentification = TextField(
      keyboardType: TextInputType.number,
      controller: _idController,
      decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black),
          //counter: Text('Letras 0'),
          hintText: 'Identificación',
          suffix: GestureDetector(
            child: Icon(Icons.close),
            onTap: () {
              _idController.clear();
            },
          ),
          labelText: 'Ingrese su identificación',
          suffixIcon: Icon(Icons.perm_identity),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    inputs..add(inputIdentification)..add(Divider());
    final inputName = TextField(
      textCapitalization: TextCapitalization.sentences,
      controller: _nameController,
      decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black),
          suffix: GestureDetector(
            child: Icon(Icons.close),
            onTap: () {
              _nameController.clear();
            },
          ),
          hintText: 'Nombre',
          labelText: 'Ingrese su nombre',
          suffixIcon: Icon(Icons.person),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    inputs..add(inputName)..add(Divider());
    final inputLastName = TextField(
      textCapitalization: TextCapitalization.sentences,
      controller: _lastNameController,
      decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black),
          suffix: GestureDetector(
            child: Icon(Icons.close),
            onTap: () {
              _lastNameController.clear();
            },
          ),
          hintText: 'Apellido',
          labelText: 'Ingrese su apellido',
          suffixIcon: Icon(Icons.person),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    inputs..add(inputLastName)..add(Divider());
    final inputProfesion = TextField(
      textCapitalization: TextCapitalization.sentences,
      controller: _profesionController,
      decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black),
          suffix: GestureDetector(
            child: Icon(Icons.close),
            onTap: () {
              _profesionController.clear();
            },
          ),
          hintText: 'Profesión',
          labelText: 'Ingrese su profesión',
          suffixIcon: Icon(Icons.person),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    inputs..add(inputProfesion)..add(Divider());
    final inputPhoto = TextField(
      textCapitalization: TextCapitalization.sentences,
      controller: _photoController,
      decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black),
          suffix: GestureDetector(
            child: Icon(Icons.close),
            onTap: () {
              _photoController.clear();
            },
          ),
          hintText: 'Foto',
          labelText: 'Ingrese su foto de perfil',
          suffixIcon: Icon(Icons.photo),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    inputs..add(inputPhoto)..add(Divider());
    inputs..add(_createDate())..add(Divider());
    inputs..add(_createButton(context))..add(Divider());
    return inputs;
  }

  Widget _createButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40))),
          onPressed: () {
            if (_idController.text.isNotEmpty &&
                _nameController.text.isNotEmpty &&
                _lastNameController.text.isNotEmpty &&
                _profesionController.text.isNotEmpty &&
                _photoController.text.isNotEmpty &&
                _dateController.text.isNotEmpty) {
              _newPersonas.add(Persona(
                  identificacion: _idController.text,
                  nombre: _nameController.text,
                  apellido: _lastNameController.text,
                  profesion: _profesionController.text,
                  fotoPerfil: _photoController.text,
                  fechaNacimiento: _dateController.text));
              Navigator.pop(context, _newPersonas);
              _showAlerts(true);
            } else {
              _showAlerts(false);
            }
          },
          child:
              Text('Registrar Persona', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }

  Widget _createDate() {
    return TextField(
      enableInteractiveSelection: false,
      controller: _dateController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintText: 'Fecha de Nacimiento',
          labelText: 'Fecha',
          suffixIcon: Icon(Icons.calendar_today)),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  void _createPerson(BuildContext context) {
    if (_idController.text.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _profesionController.text.isNotEmpty &&
        _photoController.text.isNotEmpty &&
        _dateController.text.isNotEmpty) {
      _newPersonas.add(Persona(
          identificacion: _idController.text,
          nombre: _nameController.text,
          apellido: _lastNameController.text,
          profesion: _profesionController.text,
          fotoPerfil: _photoController.text,
          fechaNacimiento: _dateController.text));
      Navigator.pop(context, _newPersonas);
      _showAlerts(true);
    } else {
      _showAlerts(false);
    }
  }

  void _showAlerts(bool cond) {
    if (cond) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Creado!!'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Persona creada correctamente!'),
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
                  Text('Hubo un error al momento de crear la persona DDD::'),
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

  void _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: new DateTime(1980),
      firstDate: new DateTime(1980),
      lastDate: new DateTime(2021),
    );
    if (picked != null) {
      _dateController.text = picked.toString();
    }
  }
}
