import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:ludic/shared/models/user_model.dart';
import 'package:ludic/shared/widgets/button.dart';
import 'package:ludic/shared/widgets/inputField.dart';

class UpdateUsuarioView extends StatelessWidget {
  UpdateUsuarioView({Key? key, required this.user}) : super(key: key);
  UserModel user;

  @override
  final _formKey = GlobalKey<FormState>();
  final db = FirebaseFirestore.instance;
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            InputField(
              label: 'Nome',
              icon: Icons.person,
              controller: _nameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Insira um Nome';
                } else if (value.length < 3) {
                  return 'O nome deve ter mais de 3 caracteres';
                }
                return null;
              },
            ),
            Button(
                label: 'Atualizar',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    db.collection('usuarios').doc(user.email).update(
                        {'nome': _nameController.text.toUpperCase().trim()});
                    user = UserModel(
                        email: user.email,
                        id: user.id,
                        name: _nameController.text.toUpperCase().trim());
                    Navigator.of(context).pushNamed('/home', arguments: user);
                  }
                })
          ],
        ),
      )),
    );
  }
}
