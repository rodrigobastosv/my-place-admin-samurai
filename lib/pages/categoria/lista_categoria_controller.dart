import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_place_admin/core/model/categoria_model.dart';
import 'package:my_place_admin/core/model/produto_model.dart';

class ListaCategoriaController {
  CollectionReference categoriasRef =
      FirebaseFirestore.instance.collection('categorias');
  CollectionReference produtosRef =
      FirebaseFirestore.instance.collection('produtos');
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

  Future<List<ProdutoModel>> getProdutosCategoria(
      CategoriaModel categoria) async {
    final querySnapshot =
        await produtosRef.where('categoria', isEqualTo: categoria.nome).get();
    final docs = querySnapshot.docs;
    return List.generate(
        docs.length, (i) => ProdutoModel.fromJson(docs[i].id, docs[i].data()));
  }

  Future<void> removeCategoria(CategoriaModel categoria) async {
    await categoriasRef.doc(categoria.id).delete();
    final produtosCategoria = await getProdutosCategoria(categoria);
    produtosCategoria.forEach((produto) async {
      await produtosRef.doc(produto.id).delete();
    });
  }
}
