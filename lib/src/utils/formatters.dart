// lib/src/utils/formatters.dart
import 'dart:convert';
import 'package:dart_des/dart_des.dart';

String formatString(String text) {
  return text
      .replaceAll("&quot;", "'")
      .replaceAll("&amp;", "&")
      .replaceAll("&#039;", "'");
}

/// Decrypts the JioSaavn encrypted_media_url (base64 -> DES -> utf8)
/// and returns a usable media URL (switching preview bitrate suffix to _320.mp4).
String decryptUrl(String url) {
  if (url.trim().isEmpty) return url;

  // key must be 8 bytes for single DES
  final List<int> key = '38346591'.codeUnits;

  // Create DES in ECB mode (no IV for ECB)
  final des = DES(key: key, mode: DESMode.ECB);

  // Decode base64 input into bytes
  final List<int> encryptedBytes = base64.decode(url.trim());

  // Decrypt bytes -> plaintext bytes (PKCS5 padding handled by dart_des)
  final List<int> decryptedBytes = des.decrypt(encryptedBytes);

  // Convert to string and normalize the URL suffix
  final String decrypted =
      utf8.decode(decryptedBytes, allowMalformed: true).replaceAll("_96.mp4", "_320.mp4");

  return decrypted;
}
