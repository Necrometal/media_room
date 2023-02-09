import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'playlist_state.dart';

class PlaylistCubit extends Cubit<PlaylistState> {
  PlaylistCubit() : super(PlaylistInitial());
}
