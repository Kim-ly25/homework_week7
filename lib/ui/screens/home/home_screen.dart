import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/history/user_history_repository.dart';
import '../../../data/repositories/songs/song_repository.dart';
import '../../states/player_state.dart';
import 'view_model/home_view_model.dart';
import 'widgets/home_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(
        songRepository: context.read<SongRepository>(),
        playerState: context.read<PlayerState>(),
        userHistoryRepository: context.read<UserHistoryRepository>(),
      )..init(),
      child: const HomeContent(),
    );
  }
}
