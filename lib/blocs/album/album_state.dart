import 'package:equatable/equatable.dart';
import '../../models/album.dart';
import '../../models/photo.dart';

enum AlbumStatus { initial, loading, success, failure }

class AlbumState extends Equatable {
  final AlbumStatus status;
  final List<Album> albums;
  final Map<int, List<Photo>> albumPhotos;
  final String? errorMessage;

  const AlbumState({
    this.status = AlbumStatus.initial,
    this.albums = const [],
    this.albumPhotos = const {},
    this.errorMessage,
  });

  AlbumState copyWith({
    AlbumStatus? status,
    List<Album>? albums,
    Map<int, List<Photo>>? albumPhotos,
    String? errorMessage,
  }) {
    return AlbumState(
      status: status ?? this.status,
      albums: albums ?? this.albums,
      albumPhotos: albumPhotos ?? this.albumPhotos,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, albums, albumPhotos, errorMessage];
}