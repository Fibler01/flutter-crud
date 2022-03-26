import 'package:flutter/material.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:flutter_crud/views/user_formalter.dart';
import 'package:flutter_crud/views/user_formadd.dart';
import 'package:flutter_crud/views/user_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      /* utilizado p criar varios providers */
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Users(),
          /* notifica quando alguma alteracao é feita nos usuarios, controla o acesso a nossos itens */
        )
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          /* home: UserList(), */
          routes: {
            AppRoutes.HOME: (_) => UserList(),
            AppRoutes.USER_FORMALTER: (_) => UserFormAlter(),
            AppRoutes.USER_FORMADD: (_) => UserFormAdd()
          }),
    );
  }
}
