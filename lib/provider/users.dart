import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_users.dart';
import 'package:flutter_crud/models/user.dart';

class Users with ChangeNotifier {
  final Map<String, User> _items = {
    ...DUMMY_USERS
  }; /* CRIANDO CLONE dos dummy_users para itens */

  List<User> get all {
    return [
      ..._items.values
    ]; /* retornando uma lista dos valores de itens (que é uma copia dos dummy_users) */
  }

  int get count {
    return _items.length; /* faz uma contagem de quantos usuarios tem */
  }

  User byIndex(int i) {
    /* pegando o index do usuário */
    return _items.values.elementAt(i);
  }

  void put(User user) {
    /* metodo para inserir um novo usuário ou alterar um user */
    if (user == null) {
      return;
    }

    if (user.id != null &&
        user.id.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
      /* se ja tiver o user id, ele fara alteracao */
      _items.update(
          user.id,
          (_) => User(
                id: user.id,
                name: user.name,
                email: user.email,
                avatarUrl: user.avatarUrl,
              ));
    } else {
      // adicionar
      final id = Random().nextDouble().toString();

      _items.putIfAbsent(
          id,
          () => User(
              id: id,
              name: user.name,
              email: user.email,
              avatarUrl: user.avatarUrl));

      // ou alterar

    }
    notifyListeners(); /* serve para notificar a mudanca */
  }

  void remove(User user) {
    /* para remover o user, so remove se o id e o usuario forem diferentes de null */
    if (user != null && user.id != null) {
      _items.remove(user.id);
      notifyListeners();
    }
  }
}
