import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'mensajes.dart';

class UsuariosPage extends StatelessWidget {
  final String uid;

  const UsuariosPage({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona un Usuario para Chatear'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('usuarios').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index];
              var userId = user.id; 
              var userData = user.data() as Map<String, dynamic>;

              if (userId == uid) {
                return Container();
              }

              return ListTile(
                title: Text(userData['nombre'] ?? 'Usuario sin nombre'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MensajesPage(uid: uid, otherUserId: userId),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
