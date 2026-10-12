import 'package:flutter/material.dart';
import '../../models/dog_photo.dart';
import '../../services/dog_api.dart';
import '../molecules/error_view.dart';
import '../molecules/loading_view.dart';
import '../organisms/dog_photo_card.dart';
import '../templates/screen_template.dart';

/// SCREEN 2 - The Belt (Stream + StreamBuilder)
class LiveDogPage extends StatefulWidget {
  const LiveDogPage({super.key});

  @override
  State<LiveDogPage> createState() => _LiveDogPageState();
}

class _LiveDogPageState extends State<LiveDogPage> {
  // Created ONCE, held in a field. StreamBuilder cancels the subscription for us.
  late final Stream<FeedEvent> _feed = DogApi.liveFeed();

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      title: 'Live Dog Feed',
      body: StreamBuilder<FeedEvent>(
        stream: _feed,
        builder: (context, snap) {
          if (snap.hasError) {
            return ErrorView(message: '${snap.error}');
          }
          if (!snap.hasData) {
            return const LoadingView(label: 'Waiting for the first dog...');
          }
          final event = snap.data!;
          if (event.error != null) {
            // The stream is still alive. The next tick may succeed and the
            // screen will recover by itself, with no restart.
            return ErrorView(
              message: event.error!,
              hint: 'Trying again every ${DogApi.pollInterval.inSeconds} seconds...',
            );
          }
          return SingleChildScrollView(
            child: DogPhotoCard(photo: event.photo!, number: event.number),
          );
        },
      ),
    );
  }
}
