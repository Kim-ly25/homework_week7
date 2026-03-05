import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/library_view_model.dart';
import '../../../../model/songs/song.dart';
import '../../../states/settings_state.dart';
import '../../../theme/theme.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LibraryViewModel>();
    final settingsState = context.watch<AppSettingsState>();

    return Container(
      color: settingsState.theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Library", style: AppTextStyles.heading),

          Expanded(
            child: ListView.builder(
              itemCount: viewModel.songs.length,
              itemBuilder: (context, index) {
                final song = viewModel.songs[index];
                final isPlaying = viewModel.isPlaying(song);

                return SongTile(
                  song: song,
                  isPlaying: isPlaying,
                  onTap: () => viewModel.play(song),
                  onStop: () => viewModel.stop(),
                );
              },
            ),
          ),
        ],
      ),
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
            Text("Playing", style: const TextStyle(color: Colors.amber)),
            SizedBox(width: 6),
            OutlinedButton(onPressed: onStop, child: Text("STOP")),
          ],
        )
      : null,
    );
  }
}
