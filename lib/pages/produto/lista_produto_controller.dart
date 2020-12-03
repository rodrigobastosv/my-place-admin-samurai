import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_place_admin/core/model/produto_model.dart';

class ListaProdutoController {
  CollectionReference produtosRef =
      FirebaseFirestore.instance.collection('produtos');
  final Stream<QuerySnapshot> _produtosStream =
      FirebaseFirestore.instance.collection('produtos').snapshots();

  Stream<QuerySnapshot> get produtosStream => _produtosStream;

  List<ProdutoModel> getProdutosFromData(List<QueryDocumentSnapshot> docs) {
    return List.generate(docs.length, (i) {
      final produtoDoc = docs[i];
      return ProdutoModel.fromJson(
        produtoDoc.id,
        produtoDoc.data(),
      );
    });
  }

  Future<void> removeProduto(ProdutoModel produto) async {
    await produtosRef.doc(produto.id).delete();
  }
}
