import 'package:get_it/get_it.dart';
import 'package:spotify/data/repository/auth/auth_repository_impl.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/domain/usecases/auth/get_user.dart';
import 'package:spotify/domain/usecases/auth/signup.dart';
import 'package:spotify/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:spotify/domain/usecases/song/get_favorite_songs.dart';
import 'package:spotify/domain/usecases/song/get_news_songs.dart';
import 'package:spotify/domain/usecases/song/get_play_list.dart';
import 'package:spotify/domain/usecases/song/is_favorite_song.dart';

import 'data/repository/song/song_repository_impl.dart';
import 'data/sources/song/song_firebase_service.dart';
import 'domain/repository/song/song.dart';
import 'domain/usecases/auth/sigin.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
 
 
 sl.registerSingleton<AuthFirebaseService>(
  AuthFirebaseServiceImpl()
 );

 sl.registerSingleton<SongFirebaseService>(
  SongFirebaseServiceImpl()
 );
 

 sl.registerSingleton<AuthRepository>(
  AuthRepositoryImpl()
 );

 sl.registerSingleton<SongsRepository>(
  SongRepositoryImpl()
 );



 sl.registerSingleton<SignupUseCase>(
  SignupUseCase()
 );

 sl.registerSingleton<SigninUseCase>(
  SigninUseCase()
 );

 sl.registerSingleton<GetNewsSongsUseCase>(
  GetNewsSongsUseCase()
 );

 sl.registerSingleton<GetPlayListUseCase>(
  GetPlayListUseCase()
 );

 sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(
  AddOrRemoveFavoriteSongUseCase()
 );

 sl.registerSingleton<IsFavoriteSongUseCase>(
  IsFavoriteSongUseCase()
 );

 sl.registerSingleton<GetUserUseCase>(
  GetUserUseCase()
 );

 sl.registerSingleton<GetFavoriteSongsUseCase>(
  GetFavoriteSongsUseCase()
 );
 
}








// class Song {
//   String name;
//   int clickCount;

//   Song(this.name, this.clickCount);
// }

// void sortSongsByClicks(List<Song> songs) {
//   int n = songs.length;

//   for (int i = 0; i < n - 1; i++) {
//     // Giả định bài hát đầu tiên có nhiều lượt click nhất
//     int maxIndex = i;

//     // Tìm bài hát có số lượt click nhiều nhất trong phần còn lại của danh sách
//     for (int j = i + 1; j < n; j++) {
//       if (songs[j].clickCount > songs[maxIndex].clickCount) {
//         maxIndex = j;
//       }
//     }

//     // Đổi chỗ bài hát có nhiều lượt click nhất với bài hát đầu tiên trong danh sách chưa sắp xếp
//     if (maxIndex != i) {
//       Song temp = songs[i];
//       songs[i] = songs[maxIndex];
//       songs[maxIndex] = temp;
//     }
//   }
// }

// void main() {
//   List<Song> songs = [
//     Song('Bài hát A', 120),
//     Song('Bài hát B', 450),
//     Song('Bài hát C', 320),
//     Song('Bài hát D', 200),
//     Song('Bài hát E', 600),
//   ];

//   print('Danh sách bài hát trước khi sắp xếp:');
//   for (var song in songs) {
//     print('${song.name} - ${song.clickCount} lượt click');
//   }

//   sortSongsByClicks(songs);

//   print('\nDanh sách bài hát sau khi sắp xếp theo lượt click:');
//   for (var song in songs) {
//     print('${song.name} - ${song.clickCount} lượt click');
//   }
// }
