import 'package:cloud_firestore/cloud_firestore.dart';

class MixesFetching {
  Future<List<Map<String, dynamic>>> fetchMixesByUser(String userId) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('music')
        .where('creatorId', isEqualTo: userId)
        .get();

    final mixes = querySnapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();

    return mixes;
  }
}
