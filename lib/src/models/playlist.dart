
import 'package:jiosaavn_dart/src/models/song.dart';
import 'package:jiosaavn_dart/src/utils/formatters.dart';

class Playlist {
  final String id;
  final String listname;
  final String firstname;
  final List<Song> songs;

  Playlist({
    required this.id,
    required this.listname,
    required this.firstname,
    required this.songs,
  });

  factory Playlist.fromJson(Map<String, dynamic> json, {bool fetchLyrics = false, String? lyrics}) {
    return Playlist(
      id: json['id'],
      listname: formatString(json['listname']),
      firstname: formatString(json['firstname']),
      songs: (json['songs'] as List)
          .map((song) => Song.fromJson(song, lyrics: fetchLyrics ? lyrics : null))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'listname': listname,
      'firstname': firstname,
      'songs': songs.map((song) => song.toJson()).toList(),
    };
  }
}
