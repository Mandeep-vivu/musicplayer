
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/common.dart';
import 'package:musicplayer/main.dart';
import 'package:provider/provider.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
class MusicScreen extends StatefulWidget {
  MusicScreen({super.key});


  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> with WidgetsBindingObserver {
  final _player = AudioPlayer();
  late List<String> sourceLinks;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        });
    // Try to load audio from a source and catch any errors.
    try {
      final musicProvider = Provider.of<MusicProvider>(context, listen: false);
      final currentSongDetails = musicProvider.getSongDetails;
      if (currentSongDetails != null) {
        final sourceLink = currentSongDetails.sourceLink;
        await _player.setAudioSource(AudioSource.uri(Uri.parse(sourceLink)));
      }
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _player.stop();
    }
  }
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
              (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));




  @override
  Widget build(BuildContext context) {
      final musicProvider = Provider.of<MusicProvider>(context);
      final currentSong = musicProvider.currentSong;
      final currentSongDetails =
     musicProvider.getSongDetails;
      sourceLinks = musicProvider.trendingSongs
          .map((song) => song.sourceLink)
          .toList();
      final List<Song> playingSongs = musicProvider.trendingSongs
          .where((song) => song.title == currentSong)
          .toList();

      return Scaffold(
      body: Stack(

        children: [

          GestureDetector(
            onVerticalDragUpdate: (details) {
              if (details.delta.dy > 0) {
              } else if (details.delta.dy < 0) {
              }
            },
            child: DraggableScrollableSheet(
              initialChildSize: 0.5,
              minChildSize: 0.2,
              maxChildSize: 0.95,
              builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                  color: Colors.black38,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 5,),
                        Container(
                          color: Colors.grey[800],
                          height: 20,
                          child: Center(
                            child: Container(
                              color: Colors.white,
                              width: 45,
                              height: 3,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        const Text(
                          'Now Playing',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            currentSongDetails?.albumImageUrl ?? 'https://www.techprevue.com/wp-content/uploads/2017/09/best-music-player-1024x683.jpg',
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),

                        ),
                        const SizedBox(height: 16),
                        Text(
                          currentSongDetails?.title ?? 'Select a song',
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          currentSongDetails?.category ?? 'XXXX',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 32),
                        StreamBuilder<PositionData>(
                          stream: _positionDataStream,
                          builder: (context, snapshot) {
                            final positionData = snapshot.data;
                            return SeekBar(
                              duration: positionData?.duration ?? Duration.zero,
                              position: positionData?.position ?? Duration.zero,
                              bufferedPosition:
                              positionData?.bufferedPosition ?? Duration.zero,
                              onChangeEnd: _player.seek,
                            );
                          },
                        ),

                        ControlButtons(_player, isPlaying: musicProvider.isPlaying),


                        const SizedBox(height: 30,),

                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );

  }

}
class ControlButtons extends StatelessWidget {
  final AudioPlayer player;
  final bool isPlaying;

  const ControlButtons(this.player, {Key? key, required this.isPlaying}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Opens volume slider dialog
        IconButton(
          icon: const Icon(Icons.volume_up_outlined,color: Colors.white,),
          onPressed: () {
            showSliderDialog(
              context: context,
              title: "Adjust volume",
              divisions: 10,
              min: 0.0,
              max: 1.0,
              value: player.volume,
              stream: player.volumeStream,
              onChanged: player.setVolume,
            );
          },
        ),
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: const Icon(Icons.play_circle,color: Colors.white,),
                iconSize: 64.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Icons.pause_circle,color: Colors.white,),
                iconSize: 64.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.replay_10_outlined,color: Colors.white,),
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
        // Opens speed slider dialog
        StreamBuilder<double>(
          stream: player.speedStream,
          builder: (context, snapshot) => IconButton(

            icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
            onPressed: () {
              showSliderDialog(
                context: context,
                title: "Adjust speed",
                divisions: 10,
                min: 0.5,
                max: 1.5,
                value: player.speed,
                stream: player.speedStream,
                onChanged: player.setSpeed,
              );
            },
          ),
        ),
      ],
    );
  }
}