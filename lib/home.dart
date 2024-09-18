import 'package:flutter/material.dart';
import 'mensajes.dart';

class HomePage extends StatelessWidget {
  final String uid;

  const HomePage({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios para Chatear'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Usuario 1'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MensajesPage(uid: uid, otherUserId: 'usuario_1'),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Usuario 2'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MensajesPage(uid: uid, otherUserId: 'usuario_2'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
