import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parcial/components/modify_page.dart';
import 'package:parcial/components/register_page.dart';
import 'package:parcial/models/personas.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _personas = personas;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Principal         -          ${widget.title}"),
      ),
      body: RefreshIndicator(
        onRefresh: updateList,
        child: ListView.builder(
          itemCount: _personas.length,
          itemBuilder: (context, index) {
            return ListTile(
              onLongPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ModifyPage(personaModificar: _personas[index], personas: _personas,),
                    )).then((value) {
                  _personas.addAll(value);
                  setState(() {});
                });
              },
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Eliminar'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                                '¿Seguro que quiere eliminar a esta persona?'),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(child: Text('Sí'), onPressed: () {
                            _personas.removeAt(index);
                            setState(() {});
                          })
                        ],
                      );
                    },
                    barrierDismissible: true);
              },
              title: Text(
                  _personas[index].nombre + ' ' + _personas[index].apellido),
              subtitle: Text(_personas[index].profesion),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(_personas[index].fotoPerfil),
              ),
              trailing: Text(_ageCalculated(personas[index].fechaNacimiento)),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RegisterPage(),
              )).then((value) {
            _personas.addAll(value);
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  String _ageCalculated(String fecha) {
    DateTime fechaNacimiento = DateTime.parse(fecha);
    DateTime fechaActual = DateTime.now();
    return (fechaActual.year-fechaNacimiento.year).toString();

  }

  Future<Null> updateList() async {
    final duration = new Duration(seconds: 3);
    new Timer(duration, () {});
  }
}
