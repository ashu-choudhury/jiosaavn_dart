import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:jiosaavn_dart/src/models/album.dart';
import 'package:jiosaavn_dart/src/models/playlist.dart';
import 'package:jiosaavn_dart/src/models/song.dart';
import 'package:jiosaavn_dart/src/utils/constants.dart';

class JioSaavnApi {
  final Dio _dio = Dio();

  Future<List<Song>> searchSong(String query, {bool lyrics = false}) async {
    if (query.startsWith('http') && query.contains('saavn.com')) {
      final id = await getSongId(query);
      if (id != null) {
        final song = await getSongFromId(id, fetchLyrics: lyrics);
        return song != null ? [song] : [];
      }
      return [];
    }

    final response = await _dio.get(searchBaseUrl + query);
    final responseBody =
        response.data.toString().replaceAll(RegExp(r'\(From "([^"]+)"\)'), r"(From '\1')");
    final json = jsonDecode(responseBody);
    final songResponse = json['songs']['data'] as List;

    final songs = <Song>[];
    for (var songData in songResponse) {
      final song = await getSongFromId(songData['id'], fetchLyrics: lyrics);
      if (song != null) {
        songs.add(song);
      }
    }
    return songs;
  }

  Future<Song?> getSongFromId(String id, {bool fetchLyrics = false}) async {
    try {
      final response = await _dio.get(songDetailsBaseUrl + id);
      final json = jsonDecode(response.data.toString());
      final songData = json[id];
      String? lyrics;
      if (fetchLyrics && songData['has_lyrics'] == 'true') {
        lyrics = await getLyrics(id);
      }
      return Song.fromJson(songData, lyrics: lyrics);
    } catch (e) {
      return null;
    }
  }

  Future<String?> getSongId(String url) async {
    try {
      final response = await _dio.get(url, queryParameters: {'bitrate': '320'});
      final responseText = response.data.toString();
      return responseText.split('"pid":"')[1].split('","')[0];
    } catch (e) {
      try {
        final response = await _dio.get(url);
        final responseText = response.data.toString();
        return responseText.split('"song":{"type":"')[1].split('","image":')[0].split('"id":"')[1];
      } catch (e) {
        return null;
      }
    }
  }

  Future<Album?> getAlbumFromId(String albumId, {bool fetchLyrics = false}) async {
    try {
      final response = await _dio.get(albumDetailsBaseUrl + albumId);
      final json = jsonDecode(response.data.toString());
      return Album.fromJson(json, fetchLyrics: fetchLyrics);
    } catch (e) {
      return null;
    }
  }

  Future<String?> getAlbumId(String url) async {
    try {
      final response = await _dio.get(url);
      final responseText = response.data.toString();
      return responseText.split('"album_id":"')[1].split('"')[0];
    } catch (e) {
      try {
        final response = await _dio.get(url);
        final responseText = response.data.toString();
        return responseText.split('"page_id","')[1].split('","')[0];
      } catch (e) {
        return null;
      }
    }
  }

  Future<Playlist?> getPlaylistFromId(String listId, {bool fetchLyrics = false}) async {
    try {
      final response = await _dio.get(playlistDetailsBaseUrl + listId);
      final json = jsonDecode(response.data.toString());
      return Playlist.fromJson(json, fetchLyrics: fetchLyrics);
    } catch (e) {
      return null;
    }
  }

  Future<String?> getPlaylistId(String url) async {
    try {
      final response = await _dio.get(url);
      final responseText = response.data.toString();
      return responseText.split('"type":"playlist","id":"')[1].split('"')[0];
    } catch (e) {
      try {
        final response = await _dio.get(url);
        final responseText = response.data.toString();
        return responseText.split('"page_id","')[1].split('","')[0];
      } catch (e) {
        return null;
      }
    }
  }

  Future<String?> getLyrics(String id) async {
    try {
      final response = await _dio.get(lyricsBaseUrl + id);
      final json = jsonDecode(response.data.toString());
      return json['lyrics'];
    } catch (e) {
      return null;
    }
  }
}
