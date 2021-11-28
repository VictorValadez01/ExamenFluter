import 'dart:math';

import 'package:examen_u3/models/usuario.dart';
import 'package:examen_u3/services/auth_services.dart';
import 'package:examen_u3/widgets/custom_button.dart';
import 'package:examen_u3/widgets/custom_input.dart';
import 'package:examen_u3/widgets/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Usuario_page extends StatelessWidget {
  const Usuario_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(40, 40, 40, 1),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Container(
            //Toda la pantalla
            //height: MediaQuery.of(context).size.height * .9,
            child: Column(
              children: [_Form(), Showall()],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  _Form({Key? key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: true);
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          CustomInput(
            icono: Icons.person,
            placeHolder: 'Nombre',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icono: Icons.person,
            placeHolder: 'Apellido',
            keyboardType: TextInputType.text,
            textController: passCtrl,
          ),
          CustomButton(
            texto: 'Añadir',
            onPressed: authService.autenticando
                ? () => {}
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginRes = await authService.registrar(
                        emailCtrl.text, passCtrl.text);
                    if (loginRes) {
                      //Navigator.pushNamed(context, 'usuarios');
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    }
                  },
          )
        ],
      ),
    );
  }
}

class Showall extends StatefulWidget {
  Showall({Key? key}) : super(key: key);

  @override
  _ShowallState createState() => _ShowallState();
}

class _ShowallState extends State<Showall> {
  List<Usuario> response = [];
  _ShowallState() {
    final authService = AuthService();
    authService.getUser().then((Value) {
      response = Value;
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: response
            .map((e) => Text(
                  '${e.nombre} ${e.apellido}',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ))
            .toList(),
      ),
    );
  }
}
