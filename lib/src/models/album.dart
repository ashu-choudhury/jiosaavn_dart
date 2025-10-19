
import 'package:jiosaavn_dart/src/models/song.dart';
import 'package:jiosaavn_dart/src/utils/formatters.dart';

class Album {
  final String id;
  final String title;
  final String name;
  final String year;
  final String primaryArtists;
  final String image;
  final List<Song> songs;

  Album({
    required this.id,
    required this.title,
    required this.name,
    required this.year,
    required this.primaryArtists,
    required this.image,
    required this.songs,
  });

  factory Album.fromJson(Map<String, dynamic> json, {bool fetchLyrics = false, String? lyrics}) {
    return Album(
      id: json['id'],
      title: formatString(json['title']),
      name: formatString(json['name']),
      year: json['year'],
      primaryArtists: formatString(json['primary_artists']),
      image: json['image'].toString().replaceAll('150x150', '500x500'),
      songs: (json['songs'] as List)
          .map((song) => Song.fromJson(song, lyrics: fetchLyrics ? lyrics : null))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'name': name,
      'year': year,
      'primary_artists': primaryArtists,
      'image': image,
      'songs': songs.map((song) => song.toJson()).toList(),
    };
  }
}
