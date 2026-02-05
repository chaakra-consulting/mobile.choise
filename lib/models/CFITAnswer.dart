class CfitAnswer {
  int? idJawabanCfit;
  int? idPelamar;
  int? idLowongan;
  int? nomorSoal;
  int? idUjian;
  String? subtes;
  String? jawaban;
  String? jawaban2;
  String? jawabanKunci;
  String? jawabanKunci2;

  CfitAnswer({
    this.idJawabanCfit,
    this.idPelamar,
    this.idLowongan,
    this.nomorSoal,
    this.idUjian,
    this.subtes,
    this.jawaban,
    this.jawaban2,
    this.jawabanKunci,
    this.jawabanKunci2,
  });

  CfitAnswer copyWith({
    int? idJawabanCfit,
    int? idPelamar,
    int? idLowongan,
    int? nomorSoal,
    int? idUjian,
    String? subtes,
    String? jawaban,
    String? jawaban2,
    String? jawabanKunci,
    String? jawabanKunci2,
  }) => CfitAnswer(
    idJawabanCfit: idJawabanCfit ?? this.idJawabanCfit,
    idPelamar: idPelamar ?? this.idPelamar,
    idLowongan: idLowongan ?? this.idLowongan,
    nomorSoal: nomorSoal ?? this.nomorSoal,
    idUjian: idUjian ?? this.idUjian,
    subtes: subtes ?? this.subtes,
    jawaban: jawaban ?? this.jawaban,
    jawaban2: jawaban2 ?? this.jawaban2,
    jawabanKunci: jawabanKunci ?? this.jawabanKunci,
    jawabanKunci2: jawabanKunci2 ?? this.jawabanKunci2,
  );
}
