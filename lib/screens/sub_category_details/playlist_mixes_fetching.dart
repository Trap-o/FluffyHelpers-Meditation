import 'package:cloud_firestore/cloud_firestore.dart';

class PlaylistService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchSongsForPlaylist(
      String playlistId) async {
    final querySnapshot = await _firestore
        .collection('playlists')
        .where('id', isEqualTo: playlistId)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      throw Exception('Playlist not found');
    }

    final playlistDoc = querySnapshot.docs.first;
    final playlistData = playlistDoc.data();

    if (!playlistData.containsKey('musicList')) {
      return [];
    }

    final List<dynamic> musicList = playlistData['musicList'];

    final songs = <Map<String, dynamic>>[];

    for (String musicId in musicList.cast<String>()) {
      final songDoc = await _firestore.collection('music').doc(musicId).get();
      if (songDoc.exists) {
        final songData = songDoc.data()!;
        songData['id'] = songDoc.id;
        songs.add(songData);
      }
    }

    return songs;
  }
}
