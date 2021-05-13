import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/menu_provider.dart';
import 'package:flutter_application_1/utils/icono_string_util.dart';

import 'alert_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proyecto Departamental'),
      ),
      body: _lista(),
    );
  }

  Widget _lista() {
    return FutureBuilder(
      future: menuProvider.cargarData(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        return ListView(
          children: _listaItems(snapshot.data, context),
        );
      },
    );
  }

  List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];

    data.forEach((opt) {
      final widgetTemp = ListTile(
        title: Text(opt['texto']),
        leading: getIcon(opt['icon']),
        trailing: Icon(
          Icons.keyboard_arrow_right_sharp,
          color: Colors.lightBlueAccent,
        ),
        onTap: () {
          //showDialog(
            //context: context,
            //builder: (BuildContext context) =>
              //  _builPopUpDialog(context, opt['texto']),
          //);

          print(opt['ruta']);
          Navigator.of(context).pushNamed(opt['ruta']); 
        },
      );
      opciones..add(widgetTemp)..add(Divider());
    });
    return opciones;
  }

  Widget _builPopUpDialog(BuildContext context, String opt) {
    return new AlertDialog(
      title: const Text('Opcion Seleccionada'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Opcion ' + opt),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}