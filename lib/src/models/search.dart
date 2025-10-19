
import 'package:jiosaavn_dart/src/models/song.dart';

class SearchResults {
  final List<Song> songs;

  SearchResults({required this.songs});

  factory SearchResults.fromJson(Map<String, dynamic> json) {
    return SearchResults(
      songs: (json['songs']['data'] as List)
          .map((song) => Song.fromJson(song))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'songs': songs.map((song) => song.toJson()).toList(),
    };
  }
}
