import 'package:flutter/material.dart';
import 'package:my_place_admin/widgets/mp_logo.dart';

import 'sign_up/sign_up_page.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _senha;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MPLogo(),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: Icon(
                      Icons.mail,
                      size: 24,
                    ),
                  ),
                  validator: (email) =>
                      email.isEmpty ? 'Campo Obrigatório' : null,
                  onSaved: (email) => _email = email,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: Icon(
                      Icons.mail,
                      size: 24,
                    ),
                  ),
                  obscureText: true,
                  validator: (senha) =>
                      senha.isEmpty ? 'Campo Obrigatório' : null,
                  onSaved: (senha) => _senha = senha,
                ),
                SizedBox(height: 16),
                Container(
                  width: 120,
                  child: OutlineButton(
                    onPressed: () {
                      final form = _formKey.currentState;
                      if (form.validate()) {
                        form.save();
                        print(_email);
                        print(_senha);
                      }
                    },
                    child: Text('Entrar'),
                  ),
                ),
                Container(
                  width: 120,
                  child: OutlineButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SignUpPage(),
                        ),
                      );
                    },
                    child: Text('Cadastrar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
