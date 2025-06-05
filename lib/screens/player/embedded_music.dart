import 'package:cloud_firestore/cloud_firestore.dart';

class EmbeddedMusic {
  Future<List<Map<String, dynamic>>> fetchEmbeddedMixes() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('music')
        .where('creatorId', isEqualTo: "1")
        .get();

    final mixes = querySnapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();

    return mixes;
  }
}