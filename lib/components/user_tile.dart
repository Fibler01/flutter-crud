import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User user;

  UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null ||
            user.avatarUrl.isEmpty /* nao tenho a imagem da url */
        ? CircleAvatar(
            child: Icon(Icons
                .person)) /* se for verdade vai mostrar a imagem padrao de pessoa */
        : CircleAvatar(
            backgroundImage:
                NetworkImage(user.avatarUrl)); /* se nao usa a imagem da rede */
    return ListTile(
      /* tem as posicoes pre-definidas, mostra avatar, o nome do usuario, o email */
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORMALTER,
                  arguments: user, /* argumentos = usuario */
                );
              },
              icon: Icon(Icons.edit),
              /* colocando botao com icone de editar */
              color: Colors.orange,
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                            title: Text('Excluir Usuário'),
                            content: Text('Tem certeza?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Não'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Provider.of<Users>(context, listen: false)
                                      .remove(user);
                                  Navigator.of(context).pop();
                                },
                                child: Text('Sim'),
                              ),
                            ]));
              },
              icon: Icon(Icons.delete),
              /* colocando botao com icone de deletar */
              color: Colors.red, /* deixando a cor de apagar em vermelho */
            ),
          ],
        ),
      ),
    );
  }
}
