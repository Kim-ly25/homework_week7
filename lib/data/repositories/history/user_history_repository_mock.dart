import 'package:homework_week7/data/repositories/history/user_history_repository.dart';

class UserHistoryRepositoryMock implements UserHistoryRepository {
  final List<String> history = ['101', '102'];

  @override
  List<String> fetchRecentSongIds() => List.unmodifiable(history);

  @override
  void addSongId(String songId) {
    history.remove(songId);
    history.insert(0, songId);
  }
}
