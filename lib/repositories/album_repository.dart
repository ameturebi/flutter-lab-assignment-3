import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/album.dart';
import '../models/photo.dart';

class AlbumRepository {
  final String _baseUrl = 'https://jsonplaceholder.typicode.com';
  final http.Client _httpClient;

  AlbumRepository({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<List<Album>> getAlbums() async {
    try {
      final response = await _httpClient.get(
        Uri.parse('$_baseUrl/albums'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Album.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load albums');
      }
    } catch (e) {
      throw Exception('Failed to fetch albums: $e');
    }
  }

  Future<List<Photo>> getPhotosByAlbumId(int albumId) async {
    try {
      final response = await _httpClient.get(
        Uri.parse('$_baseUrl/photos?albumId=$albumId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Photo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load photos');
      }
    } catch (e) {
      throw Exception('Failed to fetch photos: $e');
    }
  }

  void dispose() {
    _httpClient.close();
  }
}