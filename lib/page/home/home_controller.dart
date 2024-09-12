import 'package:get/get.dart';
import 'package:mix_music/api/api_factory.dart';
import 'package:mix_music/constant.dart';
import 'package:mix_music/entity/mix_album.dart';
import 'package:mix_music/entity/mix_play_list.dart';
import 'package:mix_music/entity/mix_song.dart';
import 'package:mix_music/page/api_controller.dart';
import 'package:mix_music/player/music_controller.dart';
import 'package:mix_music/utils/sp.dart';
import 'package:mix_music/widgets/message.dart';

class HomeController extends GetxController {
  MusicController music = Get.put(MusicController());
  ApiController api = Get.put(ApiController());
  RxList<MixPlaylist> playlist = RxList();
  RxList<MixAlbum> albumList = RxList();
  RxList<MixSong> songList = RxList();

  RxnString homeSite = RxnString();

  @override
  Future<void> onInit() async {
    super.onInit();
    getData();
  }

  void getData() {
    homeSite.value = Sp.getString(Constant.KEY_HOME_SITE) ?? ApiFactory.getRecPlugins().firstOrNull?.package;

    getSongRec();
    getPlayListRec();
    getAlbumRec();
  }

  ///获取歌单
  void getPlayListRec() {
    api.playListRec(site: homeSite.value ?? "").then((value) {
      playlist.clear();
      playlist.addAll(value?.data ?? []);

      // showComplete("操作成功");
    }).catchError((e) {
      showError(e);
    });
  }

  ///获取专辑
  Future<void> getAlbumRec() {
    return api.albumRec(site: homeSite.value ?? "").then((value) {
      albumList.clear();
      albumList.addAll(value?.data ?? []);

      // showComplete("操作成功");
    }).catchError((e) {
      showError(e);
    });
  }

  ///获取新歌
  Future<void> getSongRec() {
    return api.songRec(site: homeSite.value ?? "").then((value) {
      songList.clear();
      songList.addAll(value?.data ?? []);

      // showComplete("操作成功");
    }).catchError((e) {
      showError(e);
    });
  }
}
