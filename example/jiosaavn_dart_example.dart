import 'package:jiosaavn_dart/jiosaavn_dart.dart';

void main() async {
  final JioSaavnApi api = JioSaavnApi();
  final List<Song> songs = await api.searchSong("hindi");

  // Convert each Song object to JSON
  final List<Map<String, dynamic>> jsonList = songs.map((song) => song.toJson()).toList();

  print(jsonList);
}
