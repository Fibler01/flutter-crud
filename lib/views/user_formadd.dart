import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';
import 'package:flutter_crud/components/user_tile.dart';

class UserFormAdd extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    _formData['id'] = user.id;
    _formData['name'] = user.name;
    _formData['email'] = user.email;
    _formData['avatarUrl'] = user.avatarUrl;
  }

  @override
  Widget build(BuildContext context) {
    /* final user = ModalRoute.of(context)!.settings.arguments
        as User; /* problema causado nessa linha */

    _loadFormData(user); */
    /* print(user.name); */

    return Scaffold(
        appBar: AppBar(
          title: Text('Formulário de Usuário'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  final isValid = _form.currentState!.validate();

                  if (isValid) {
                    _form.currentState!
                        .save(); /* salvando cada um dos fields, OBS */
                    Provider.of<Users>(context, listen: false).put(
                      User(
                        /* pegando os dados do formulario salvo e colocando em user */

                        id: _formData['id'] ?? ' ',
                        name: _formData['name'] ?? ' ',
                        email: _formData['email'] ?? ' ',
                        avatarUrl: _formData['avatarUrl'] ??
                            ' ', /* colocado isso pcausa do problema com String nao poder receber String? */
                      ),
                    );
                    Navigator.of(context)
                        .pop(); /* icone de salvar, pop pois desempilha a tela, voltando a anterior */
                  }
                },
                icon: Icon(Icons.save))
          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Form(
              key: _form,
              /* criando formulario para usuario */
              child: Column(children: <Widget>[
                TextFormField(
                  initialValue: _formData['name'],
                  /* pegando o valor inicial do usuario selecionado */
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nome inválido';
                    }

                    if (value.trim().length <= 3) {
                      return 'Nome muito pequeno. No mínimo 3 letras';
                    }

                    return null;
                  },
                  onSaved: (value) => _formData['name'] = value!,
                ),
                TextFormField(
                  initialValue: _formData['email'],
                  decoration: InputDecoration(labelText: 'E-mail'),
                  onSaved: (value) => _formData['email'] = value!,
                ),
                TextFormField(
                  initialValue: _formData['avatarUrl'],
                  decoration: InputDecoration(labelText: 'URL do Avatar'),
                  onSaved: (value) => _formData['avatarUrl'] = value!,
                )
              ]),
            )));
  }
}
