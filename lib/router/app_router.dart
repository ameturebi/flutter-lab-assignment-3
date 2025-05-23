import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/album_list_screen.dart';
import '../screens/album_detail_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const AlbumListScreen(),
      ),
      GoRoute(
        path: '/album/:id',
        builder: (context, state) {
          final albumId = int.parse(state.pathParameters['id'] ?? '0');
          return AlbumDetailScreen(albumId: albumId);
        },
      ),
    ],
  );
}