import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/breed.dart';
import '../models/dog_photo.dart';

/// A friendly error we show to the user.
class ApiException implements Exception {
  const ApiException(this.message);
  final String message;
  @override
  String toString() => message;
}

class DogApi {
  static const _base = 'https://dog.ceo/api';
  static const _timeout = Duration(seconds: 10);
  static const pollInterval = Duration(seconds: 5);

  /// Shared request helper: timeout + status check + JSON decode.
  /// http.get does NOT throw on 404/500, so we check statusCode ourselves.
  static Future<Map<String, dynamic>> _getJson(String path) async {
    try {
      final res = await http.get(Uri.parse('$_base$path')).timeout(_timeout);
      if (res.statusCode != 200) {
        throw ApiException('Server said ${res.statusCode}');
      }
      return jsonDecode(res.body) as Map<String, dynamic>;
    } on TimeoutException {
      throw const ApiException('The request took too long.');
    } on SocketException {
      throw const ApiException('No internet connection.');
    } on http.ClientException {
      throw const ApiException('No internet connection.');
    } on FormatException {
      throw const ApiException('The server sent data we could not read.');
    }
  }

  /// SCREEN 1 (Future): all breeds, fetched once.
  /// API shape: {"message": {"bulldog": ["boston", ...], "akita": []}, "status": "success"}
  static Future<List<Breed>> fetchBreeds() async {
    final json = await _getJson('/breeds/list/all');
    final message = json['message'] as Map<String, dynamic>;
    return message.entries
        .map((e) => Breed.fromJson({'name': e.key, 'subBreeds': e.value}))
        .toList();
  }

  /// One random photo. Different every call, so the stream visibly changes.
  static Future<DogPhoto> fetchRandomDog() async {
    final json = await _getJson('/breeds/image/random');
    return DogPhoto.fromJson(json);
  }

  /// SCREEN 2 (Stream): a polling loop. fetch -> yield -> wait -> repeat.
  /// try/catch is INSIDE the loop so one bad fetch does not end the stream.
  static Stream<FeedEvent> liveFeed() async* {
    var count = 0;
    while (true) {
      try {
        final photo = await fetchRandomDog();
        yield FeedEvent.success(photo, ++count);
      } catch (e) {
        debugPrint('liveFeed tick failed: $e');
        yield FeedEvent.failure(e.toString());
      }
      await Future.delayed(pollInterval);
    }
  }
}
