import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_place_admin/widgets/mp_app_bar.dart';
import 'package:my_place_admin/widgets/mp_button_icon.dart';
import 'package:my_place_admin/widgets/mp_empty.dart';
import 'package:my_place_admin/widgets/mp_loading.dart';

import 'lista_categoria_controller.dart';

class ListaCategoriaPage extends StatelessWidget {
  final _controller = ListaCategoriaController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MPAppBar(
        title: Text('Lista de Categorias'),
        actions: [
          MPButtonIcon(
            iconData: Icons.add,
            onTap: () {},
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _controller.categoriasStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final categorias =
                _controller.getCategoriasFromDocs(snapshot.data.docs);
            if (categorias.isEmpty || categorias == null) {
              return MPEmpty();
            } else {
              return Text('Categorias');
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: MPLoading(),
            );
          }
          return MPEmpty();
        },
      ),
    );
  }
}
