import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/songs/song.dart';
import '../../../states/settings_state.dart';
import '../../../theme/theme.dart';
import '../view_model/home_view_model.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsState = context.watch<AppSettingsState>();
    final viewModel = context.watch<HomeViewModel>();

    return Container(
      color: settingsState.theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text("Home", style: AppTextStyles.heading)),
          if (viewModel.recentSongs.isNotEmpty) ...  [
            const SectionHeader(label: "Your recent songs"),
            ...viewModel.recentSongs.map(
              (song) => SongTile(
                song: song,
                isPlaying: viewModel.isPlaying(song),
                onTap: () => viewModel.play(song),
                onStop: viewModel.stop,
              ),
            ),
          ],

          if (viewModel.recommendedSongs.isNotEmpty) ...[
            const SectionHeader(label: "You might also like"),
            ...viewModel.recommendedSongs.map(
              (song) => SongTile(
                song: song,
                isPlaying: viewModel.isPlaying(song),
                onTap: () => viewModel.play(song),
                onStop: viewModel.stop,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(label),
    );
  }
}

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
    required this.onStop,
  });

  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(song.title),
      trailing: isPlaying
      ? Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Playing", style: TextStyle(color: Colors.amber)),
            const SizedBox(width: 6),
            OutlinedButton(onPressed: onStop, child: const Text("STOP")),
          ],
        )
      : null,
    );
  }
}
