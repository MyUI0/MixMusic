import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:mix_music/entity/mix_song.dart';

import 'mix_quality.dart';

@jsonSerializable
class MixDownload {
  String package;
  dynamic id;
  String? title;
  String? pic;
  dynamic subTitle;
  String? url;
  MixQuality? quality;
  String? filePath;
  int? status;

  MixDownload({
    required this.package,
    required this.id,
    this.title,
    this.pic,
    this.quality,
    this.subTitle,
    this.url,
  });

  static MixDownload fromSong(MixSong song, MixQuality? quality) {
    return MixDownload(
      package: song.package,
      id: song.id,
      title: song.title,
      pic: song.pic,
      subTitle: song.subTitle,
      quality: quality,
    );
  }
}
