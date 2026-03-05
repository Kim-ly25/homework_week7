import 'package:flutter/material.dart';
import 'package:homework_week7/data/repositories/songs/song_repository.dart';
import 'package:homework_week7/model/songs/song.dart';
import '../../../states/player_state.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;
  List<Song> songs = [];

  LibraryViewModel({
    required SongRepository songRepository,
    required PlayerState playerState,
  }) : songRepository = songRepository,
       playerState = playerState {
    playerState.addListener(_onPlayerStateChanged);
  }
  void _onPlayerStateChanged() => notifyListeners();

  void init(){ songs = songRepository.fetchSongs();notifyListeners();
  }

  @override
  void dispose(){
    playerState.removeListener(_onPlayerStateChanged);
    super.dispose();
  }

  List<Song> getSongs() => songs;
  Song? get currentSong => playerState.currentSong;
  bool isPlaying(Song song) => playerState.currentSong == song;
  bool get hasCurrentSong => playerState.currentSong != null;
  void play(Song song) => playerState.start(song);
  void stop() => playerState.stop();

}
