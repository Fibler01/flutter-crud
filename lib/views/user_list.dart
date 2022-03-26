import 'package:flutter/material.dart';
import 'package:flutter_crud/components/user_tile.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Lista de Usuários'), actions: <Widget>[
        IconButton(
          onPressed: () {
            /* Navigator serve para navegar entre rotas */
            Navigator.of(context).pushNamed(AppRoutes
                .USER_FORMADD); /* push serve para colocar uma tela em cima da outra, sem remover a anterior */
          },
          icon: Icon(Icons.add), /* Icone para adicionar um novo usuario */
        ),
      ]),
      body: ListView.builder(
        /* cria uma lista e carrega apenas aquilo que é mostrado na tela */
        itemCount: users.count,
        itemBuilder: (ctx, i) => UserTile(users.byIndex(i)),
      ),
    );
  }
}
