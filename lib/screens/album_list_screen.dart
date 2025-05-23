import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/album/album_bloc.dart';
import '../blocs/album/album_event.dart';
import '../blocs/album/album_state.dart';
import '../models/album.dart';
import '../models/photo.dart';
import 'package:go_router/go_router.dart';

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
      ),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          switch (state.status) {
            case AlbumStatus.initial:
              return const SizedBox.shrink();
            case AlbumStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case AlbumStatus.failure:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${state.errorMessage}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AlbumBloc>().add(RetryLoadAlbums());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            case AlbumStatus.success:
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<AlbumBloc>().add(LoadAlbums());
                },
                child: ListView.builder(
                  itemCount: state.albums.length,
                  itemBuilder: (context, index) {
                    final album = state.albums[index];
                    final photos = state.albumPhotos[album.id] ?? [];
                    return AlbumListTile(
                      album: album,
                      photos: photos,
                      onTap: () {
                        context.read<AlbumBloc>().add(LoadAlbumPhotos(album.id));
                        context.go('/album/${album.id}');
                      },
                    );
                  },
                ),
              );
          }
        },
      ),
    );
  }
}

class AlbumListTile extends StatelessWidget {
  final Album album;
  final List<Photo> photos;
  final VoidCallback onTap;

  const AlbumListTile({
    super.key,
    required this.album,
    required this.photos,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: photos.isNotEmpty
          ? Image.network(
              photos.first.thumbnailUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);
              },
            )
          : const Icon(Icons.photo_album),
      title: Text(album.title),
      subtitle: Text('Album ID: ${album.id}'),
      onTap: onTap,
    );
  }
}