import 'package:cloud_firestore/cloud_firestore.dart';

class PlaylistService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchSongsForPlaylist(String playlistId) async {
    final playlistDoc = await _firestore.collection('playlists').doc(playlistId).get();

    if (!playlistDoc.exists) {
      throw Exception('Playlist not found');
    }

    final playlistData = playlistDoc.data();
    if (playlistData == null || !playlistData.containsKey('musicList')) {
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

