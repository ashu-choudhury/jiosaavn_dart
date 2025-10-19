import 'package:jiosaavn_dart/src/utils/formatters.dart';

class Song {
  final String id;
  final String song;
  final String album;
  final String year;
  final String music;
  final String musicId;
  final String primaryArtists;
  final String primaryArtistsId;
  final String featuredArtists;
  final String featuredArtistsId;
  final String singers;
  final String starring;
  final String image;
  final String label;
  final String albumid;
  final String language;
  final String origin;
  final bool is320kbps;
  final String encryptedMediaUrl;
  final String encryptedMediaPreviewUrl;
  final String mediaUrl;
  final String mediaPreviewUrl;
  final bool hasLyrics;
  final String? lyrics;
  final String permaUrl;
  final String releaseDate;
  final String repo;

  Song({
    required this.id,
    required this.song,
    required this.album,
    required this.year,
    required this.music,
    required this.musicId,
    required this.primaryArtists,
    required this.primaryArtistsId,
    required this.featuredArtists,
    required this.featuredArtistsId,
    required this.singers,
    required this.starring,
    required this.image,
    required this.label,
    required this.albumid,
    required this.language,
    required this.origin,
    required this.is320kbps,
    required this.encryptedMediaUrl,
    required this.encryptedMediaPreviewUrl,
    required this.mediaUrl,
    required this.mediaPreviewUrl,
    required this.hasLyrics,
    this.lyrics,
    required this.permaUrl,
    required this.releaseDate,
    required this.repo,
  });

  factory Song.fromJson(Map<String, dynamic> json, {String? lyrics}) {
    // Safely handle nulls
    final encryptedMediaUrl = json['encrypted_media_url'] ?? '';
    String mediaUrl = '';
    try {
      mediaUrl = decryptUrl(encryptedMediaUrl);
      if (json['320kbps'] != 'true') {
        mediaUrl = mediaUrl.replaceAll('_320.mp4', '_160.mp4');
      }
    } catch (e) {
      mediaUrl = json['media_preview_url'] ?? '';
      mediaUrl = mediaUrl.replaceAll("preview", "aac");
      if (json['320kbps'] == "true") {
        mediaUrl = mediaUrl.replaceAll("_96_p.mp4", "_320.mp4");
      } else {
        mediaUrl = mediaUrl.replaceAll("_96_p.mp4", "_160.mp4");
      }
    }

    return Song(
      id: json['id'] ?? '',
      song: formatString(json['song'] ?? ''),
      album: formatString(json['album'] ?? ''),
      year: json['year'] ?? '',
      music: formatString(json['music'] ?? ''),
      musicId: json['music_id'] ?? '',
      primaryArtists: formatString(json['primary_artists'] ?? ''),
      primaryArtistsId: json['primary_artists_id'] ?? '',
      featuredArtists: json['featured_artists'] ?? '',
      featuredArtistsId: json['featured_artists_id'] ?? '',
      singers: formatString(json['singers'] ?? ''),
      starring: formatString(json['starring'] ?? ''),
      image: (json['image'] ?? '').toString().replaceAll('150x150', '500x500'),
      label: json['label'] ?? '',
      albumid: json['albumid'] ?? '',
      language: json['language'] ?? '',
      origin: json['origin'] ?? '',
      is320kbps: json['320kbps'] == 'true',
      encryptedMediaUrl: encryptedMediaUrl,
      encryptedMediaPreviewUrl: json['encrypted_media_preview_url'] ?? '',
      mediaUrl: mediaUrl,
      mediaPreviewUrl: mediaUrl
          .replaceAll("_320.mp4", "_96_p.mp4")
          .replaceAll("_160.mp4", "_96_p.mp4")
          .replaceAll("//aac.", "//preview."),
      hasLyrics: json['has_lyrics'] == 'true',
      lyrics: lyrics,
      permaUrl: json['perma_url'] ?? '',
      releaseDate: json['release_date'] ?? '',
      repo: json['repo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'song': song,
      'album': album,
      'year': year,
      'music': music,
      'music_id': musicId,
      'primary_artists': primaryArtists,
      'primary_artists_id': primaryArtistsId,
      'featured_artists': featuredArtists,
      'featured_artists_id': featuredArtistsId,
      'singers': singers,
      'starring': starring,
      'image': image,
      'label': label,
      'albumid': albumid,
      'language': language,
      'origin': origin,
      '320kbps': is320kbps.toString(),
      'encrypted_media_url': encryptedMediaUrl,
      'encrypted_media_preview_url': encryptedMediaPreviewUrl,
      'media_url': mediaUrl,
      'media_preview_url': mediaPreviewUrl,
      'has_lyrics': hasLyrics.toString(),
      'lyrics': lyrics,
      'perma_url': permaUrl,
      'release_date': releaseDate,
      'repo': repo,
    };
  }
}
