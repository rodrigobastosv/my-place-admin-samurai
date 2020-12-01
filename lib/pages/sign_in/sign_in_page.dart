import 'package:flutter/material.dart';
import 'package:my_place_admin/core/exceptions/admin_invalido_exception.dart';
import 'package:my_place_admin/core/exceptions/email_invalido_exception.dart';
import 'package:my_place_admin/core/exceptions/senha_errada_exception.dart';
import 'package:my_place_admin/core/exceptions/usuario_nao_encontrado_exception.dart';
import 'package:my_place_admin/pages/home/home_page.dart';
import 'package:my_place_admin/widgets/mp_loading.dart';
import 'package:my_place_admin/widgets/mp_logo.dart';
import 'package:my_place_admin/widgets/toasts/toast_utils.dart';

import '../sign_up/sign_up_page.dart';
import 'sign_in_controller.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = SignInController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          child: _controller.isLoading
              ? Center(
                  child: MPLoading(),
                )
              : Padding(
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
                        onSaved: _controller.setEmail,
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
                        onSaved: _controller.setSenha,
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: 120,
                        child: OutlineButton(
                          onPressed: () async {
                            final form = _formKey.currentState;
                            if (form.validate()) {
                              form.save();

                              setState(() {
                                _controller.setIsLoading(true);
                              });
                              try {
                                final usuario = await _controller.fazLogin();
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) => HomePage(usuario))
                                );
                              } on UsuarioNaoEncontradoException {
                                showWarningToast('Usuário não encontrado.');
                              } on SenhaErradaException {
                                showWarningToast('Senha inválida.');
                              } on EmailInvalidoException {
                                showWarningToast('Email inválido');
                              } on AdminInvalidoException {
                                showWarningToast(
                                    'Este usuário não é administrador');
                              } on Exception {
                                showErrorToast('Ocorreu um erro inesperado.');
                              } finally {
                                setState(() {
                                  _controller.setIsLoading(false);
                                });
                              }
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
