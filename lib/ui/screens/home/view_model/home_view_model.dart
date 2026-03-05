import 'package:flutter/material.dart';
import 'package:homework_week7/data/repositories/history/user_history_repository.dart';
import 'package:homework_week7/data/repositories/songs/song_repository.dart';
import 'package:homework_week7/model/songs/song.dart';
import '../../../states/player_state.dart';

class HomeViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;
  final UserHistoryRepository userHistoryRepository;

  List<Song> recentSongs = [];
  List<Song> recommendedSongs = [];

  HomeViewModel({
    required this.songRepository,
    required this.playerState,
    required this.userHistoryRepository,
  }) 
  {
    playerState.addListener(_onPlayerStateChanged);
  }

  void _onPlayerStateChanged() => notifyListeners();

  @override
  void dispose() {
    playerState.removeListener(_onPlayerStateChanged);
    super.dispose();
  }

  void init() {loadRecentSongs(); loadRecommendedSongs(); notifyListeners();}

  void loadRecentSongs() {
    final recentSongIds = userHistoryRepository.fetchRecentSongIds();
    recentSongs = recentSongIds.map((id) => songRepository.fetchSongById(id))
      .whereType<Song>()
      .toList();
  }

  void loadRecommendedSongs() {
    final recentSongIds = userHistoryRepository.fetchRecentSongIds();
    recommendedSongs = songRepository.fetchSongs()
      .where((song) => !recentSongIds.contains(song.id.toString()))
      .toList();
  }

  Song? get currentSong => playerState.currentSong;
  bool isPlaying(Song song) => playerState.currentSong == song;
  void play(Song song) {
    playerState.start(song);
    userHistoryRepository.addSongId(song.id.toString());
    loadRecentSongs();
    loadRecommendedSongs();
    notifyListeners();
  }

  void stop() => playerState.stop();
}
