/// One random dog photo returned by the API.
class DogPhoto {
  const DogPhoto({required this.url, required this.breed});

  final String url;
  final String breed; // taken from the URL, e.g. ".../breeds/hound-afghan/n02088094.jpg"

  /// Expects: {"message": "https://images.dog.ceo/breeds/hound-afghan/x.jpg", "status": "success"}
  factory DogPhoto.fromJson(Map<String, dynamic> json) {
    final url = json['message'] as String;
    final status = json['status'] as String;
    if (status != 'success') {
      throw FormatException('API status was "$status"');
    }
    // URL parts: [..., "breeds", "<breed-folder>", "<file>.jpg"]
    final parts = Uri.parse(url).pathSegments;
    final folder = parts.length >= 2 ? parts[parts.length - 2] : 'unknown';
    return DogPhoto(url: url, breed: folder.replaceAll('-', ' '));
  }
}

/// What the live feed emits every tick: either a photo or an error message.
/// Why not just throw? An exception inside async* ENDS the stream. Wrapping
/// the result keeps the stream alive and still lets the screen show an error.
class FeedEvent {
  const FeedEvent.success(this.photo, this.number) : error = null;
  const FeedEvent.failure(this.error)
      : photo = null,
        number = 0;

  final DogPhoto? photo;
  final String? error;
  final int number; // 1, 2, 3... so the demo can show visible updates
}
