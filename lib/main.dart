import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Container(),
        floatingActionButton: FloatingActionButton(
          onPressed: _refresh,
          tooltip: 'Exemplo Firebase',
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Future<void> _adiciona() {
    Firestore.instance.collection('vinhos').add(
      {'marca': 'Vinhos Garibaldi', 'valor': 21.90},
    );
    print('Ok! Registro inserido');
  }

  Future<void> _lista() {
    print('------------------------------');

    Firestore.instance.collection('vinhos').getDocuments().then((vinhos) {
      vinhos.documents.forEach((vinho) {
        print(vinho.documentID);
        print(vinho.data);
        print(vinho.data['marca']);
        print(vinho.data['valor']);
        print('........................');
      });
    });

    print('==============================');
  }

  Future<void> _lista2() async {
    print('------------------------------');

    QuerySnapshot vinhos =
        await Firestore.instance.collection('vinhos').getDocuments();

    vinhos.documents.forEach((vinho) {
      print(vinho.documentID);
      print(vinho.data);
      print(vinho.data['marca']);
      print(vinho.data['valor']);
      print('........................');
    });

    print('==============================');
  }

  // setData: deve ser utilizado com todos os campos do documento
  // se o documento (id) não existir, será incluído um novo
  Future<void> _atualiza() {
    Firestore.instance.collection('vinhos').document('vinho1').setData(
      {'marca': 'Mollon', 'valor': 19.90},
    );
    print('Ok! Registro alterado');
  }

  // updateData: permite atualizar apenas alguns campos do documento
  Future<void> _atualiza2() {
    Firestore.instance.collection('vinhos').document('vinho1').updateData(
      {'valor': 14.5},
    );
    print('Ok! Registro alterado');
  }

  // A cada mudança no dataset lista novamente os dados
  Future<void> _refresh() async {
    print('------------------------------');

    await Firestore.instance.collection('vinhos').snapshots().listen((vinhos) {
      vinhos.documents.forEach((vinho) {
        print(vinho.documentID);
        print(vinho.data);
        print(vinho.data['marca']);
        print(vinho.data['valor']);
        print('........................');
      });
    });

    print('==============================');
  }

  // obtém um único documento
  Future<void> _obtem() async {
    DocumentSnapshot vinho =
        await Firestore.instance.collection('vinhos').document('vinho1').get();

    print(vinho.documentID);
    print(vinho.data);
  }

  // acrescenta um novo campo em todos os documentos
  Future<void> _novoCampo() async {
    QuerySnapshot vinhos =
        await Firestore.instance.collection('vinhos').getDocuments();

    vinhos.documents.forEach((vinho) {
      vinho.reference.updateData({'ano': 2020});
    });
  }

  // exclui um documento
  Future<void> _exclui() async {
    await Firestore.instance.collection('vinhos').document('vinho1').delete();

    print('Ok! Removido');
  }
}
