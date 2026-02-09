class DiscAnswer {
  int? idJawabanDisc;
  int? idPelamar;
  int? idLowongan;
  int? idUjian;
  int? noSoal;
  String? jawaban;
  String? jawaban2;

  DiscAnswer({
    this.idJawabanDisc,
    this.idPelamar,
    this.idLowongan,
    this.idUjian,
    this.noSoal,
    this.jawaban,
    this.jawaban2,
  });

  DiscAnswer copyWith({
    int? idJawabanDisc,
    int? idPelamar,
    int? idLowongan,
    int? idUjian,
    int? noSoal,
    String? jawaban,
    String? jawaban2,
  }) => DiscAnswer(
    idJawabanDisc: idJawabanDisc ?? this.idJawabanDisc,
    idPelamar: idPelamar ?? this.idPelamar,
    idLowongan: idLowongan ?? this.idLowongan,
    idUjian: idUjian ?? this.idUjian,
    noSoal: noSoal ?? this.noSoal,
    jawaban: jawaban ?? this.jawaban,
    jawaban2: jawaban2 ?? this.jawaban2,
  );
}
