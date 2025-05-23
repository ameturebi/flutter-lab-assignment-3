import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/album_repository.dart';
import 'album_event.dart';
import 'album_state.dart';
import '../../models/photo.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository _albumRepository;

  AlbumBloc({required AlbumRepository albumRepository})
      : _albumRepository = albumRepository,
        super(const AlbumState()) {
    on<LoadAlbums>(_onLoadAlbums);
    on<LoadAlbumPhotos>(_onLoadAlbumPhotos);
    on<RetryLoadAlbums>(_onRetryLoadAlbums);
  }

  Future<void> _onLoadAlbums(LoadAlbums event, Emitter<AlbumState> emit) async {
    emit(state.copyWith(status: AlbumStatus.loading));
    try {
      final albums = await _albumRepository.getAlbums();
      emit(state.copyWith(
        status: AlbumStatus.success,
        albums: albums,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AlbumStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadAlbumPhotos(LoadAlbumPhotos event, Emitter<AlbumState> emit) async {
    try {
      final photos = await _albumRepository.getPhotosByAlbumId(event.albumId);
      final updatedAlbumPhotos = Map<int, List<Photo>>.from(state.albumPhotos);
      updatedAlbumPhotos[event.albumId] = photos;
      
      emit(state.copyWith(
        albumPhotos: updatedAlbumPhotos,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRetryLoadAlbums(RetryLoadAlbums event, Emitter<AlbumState> emit) async {
    if (state.status == AlbumStatus.failure) {
      add(LoadAlbums());
    }
  }

  @override
  Future<void> close() {
    _albumRepository.dispose();
    return super.close();
  }
}