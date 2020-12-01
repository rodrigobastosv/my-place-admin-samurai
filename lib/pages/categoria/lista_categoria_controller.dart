import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_place_admin/core/model/categoria_model.dart';

class ListaCategoriaController {
  CollectionReference categoriasRef =
      FirebaseFirestore.instance.collection('categorias');
  final Stream<QuerySnapshot> _categoriasStream =
      FirebaseFirestore.instance.collection('categorias').snapshots();

  Stream<QuerySnapshot> categoriasStream() => _categoriasStream;

  List<CategoriaModel> getCategoriasFromDocs(List<QueryDocumentSnapshot> docs) {
    return List.generate(docs.length, (i) {
      final categoriaDoc = docs[i];
      return CategoriaModel.fromJson(
        categoriaDoc.id,
        categoriaDoc.data(),
      );
    });
  }
}
