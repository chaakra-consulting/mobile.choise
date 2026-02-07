class CepatTelitiAnswer {
  int? idJawabanCepat;
  int? idPelamar;
  int? idLowongan;
  int? idUjian;
  int? noSoal;
  String? jawaban;

  CepatTelitiAnswer({
    this.idJawabanCepat,
    this.idPelamar,
    this.idLowongan,
    this.idUjian,
    this.noSoal,
    this.jawaban,
  });

  CepatTelitiAnswer copyWith({
    int? idJawabanCepat,
    int? idPelamar,
    int? idLowongan,
    int? idUjian,
    int? noSoal,
    String? jawaban,
  }) => CepatTelitiAnswer(
    idJawabanCepat: idJawabanCepat ?? this.idJawabanCepat,
    idPelamar: idPelamar ?? this.idPelamar,
    idLowongan: idLowongan ?? this.idLowongan,
    idUjian: idUjian ?? this.idUjian,
    noSoal: noSoal ?? this.noSoal,
    jawaban: jawaban ?? this.jawaban,
  );
}
