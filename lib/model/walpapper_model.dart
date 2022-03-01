class WalpapperModel {
  String? photographer;
  String? photographer_uri;
  String? photographer_id;
  SrcModel? src;

  WalpapperModel(
      {this.src,
      this.photographer,
      this.photographer_uri,
      this.photographer_id});
}

class SrcModel {
  String? original;
  String? small;
  String? potraits;
}
