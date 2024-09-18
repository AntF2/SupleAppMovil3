import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MensajesPage extends StatefulWidget {
  final String uid;
  final String otherUserId;

  const MensajesPage({super.key, required this.uid, required this.otherUserId});

  @override
  MensajesPageState createState() => MensajesPageState();
}

class MensajesPageState extends State<MensajesPage> {
  final TextEditingController _mensajeController = TextEditingController();

  Future<void> _enviarMensaje() async {
    if (_mensajeController.text.isEmpty) return;

    await FirebaseFirestore.instance.collection('mensajes').add({
      'remitente': widget.uid,
      'destinatario': widget.otherUserId,
      'mensaje': _mensajeController.text,
      'fecha': DateTime.now(),
      'visto': false,
    });

    _mensajeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat con ${widget.otherUserId}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('mensajes')
                  .where('remitente', isEqualTo: widget.uid)
                  .where('destinatario', isEqualTo: widget.otherUserId)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['mensaje']),
                      subtitle: Text(
                          'Enviado el: ${data['fecha'].toDate()} - Visto: ${data['visto']}'),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _mensajeController,
                    decoration: const InputDecoration(
                      labelText: 'Escribe un mensaje...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _enviarMensaje,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
