import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            radius: MediaQuery.of(context).size.width * 0.12,
            child: Icon(
              Icons.person_sharp,
              size: MediaQuery.of(context).size.width * 0.2,
            ),
          ),
        ),
        Text('Usuario'),
        Text('Rol'),
        Divider(),
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Nombre:'),
              Text('Apellido:'),
              Text('Correo:'),
              Text('Telefono:'),
            ],
          ),
        ),
        Divider(),
        ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))),
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/edit_account");
            },
            child: Text('Editar Información')),
        OutlinedButton.icon(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0))),
          ),
          onPressed: () {
            return showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: Text(
                        'Cerrar Sesión',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      content: Text('Estas seguro?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          child: Text(
                            'CANCELAR',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            // agregar evento al bloc de cerrar sesión.
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/', (Route<dynamic> route) => false);
                          },
                          child: Text(
                            'ACEPTAR',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ));
          },
          icon: Icon(Icons.logout),
          label: Text('Cerrar Sesión'),
        ),
      ],
    );
  }
}
