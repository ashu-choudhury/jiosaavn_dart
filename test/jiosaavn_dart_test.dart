import 'package:test/test.dart';
import 'package:jiosaavn_dart/jiosaavn_dart.dart';

void main() {
  final api = JioSaavnApi();

  group('JioSaavn API Tests', () {
    
    test('Search songs', () async {
      final songs = await api.searchSong('hindi');
      expect(songs, isA<List<Song>>());
      expect(songs.isNotEmpty, true);

      final song = songs.first;
      expect(song.id, isNotEmpty);
      expect(song.song, isNotEmpty);
      expect(song.album, isNotEmpty);
      expect(song.mediaUrl, contains('.mp4'));
    });

    test('Fetch song by ID', () async {
      // Use a known song ID for consistent test
      final songId = '7CwLvXc6';
      final song = await api.getSongFromId(songId);
      expect(song, isNotNull);
      expect(song!.id, songId);
      expect(song.mediaUrl, contains('.mp4'));
    });

    test('Get lyrics', () async {
      final songId = '7CwLvXc6';
      final lyrics = await api.getLyrics(songId);
      // Lyrics can be null if not available
      expect(lyrics == null || lyrics.isNotEmpty, true);
    });

    test('Fetch album by ID', () async {
      final albumId = '2369982';
      final album = await api.getAlbumFromId(albumId);
      expect(album, isNotNull);
      expect(album!.songs.isNotEmpty, true);
    });

    test('Fetch playlist by ID', () async {
      final playlistId = '123456';
      final playlist = await api.getPlaylistFromId(playlistId);
      // Playlist might not exist, so just check for null safety
      expect(playlist == null || playlist.songs.isNotEmpty, true);
    });

  });
}
