class MsdtAnswer {
  int? idJawabanMsdt;
  int? idPelamar;
  int? idLowongan;
  int? idUjian;
  int? noSoal;
  String? jawaban;

  MsdtAnswer({
    this.idJawabanMsdt,
    this.idPelamar,
    this.idLowongan,
    this.idUjian,
    this.noSoal,
    this.jawaban,
  });

  MsdtAnswer copyWith({
    int? idJawabanMsdt,
    int? idPelamar,
    int? idLowongan,
    int? idUjian,
    int? noSoal,
    String? jawaban,
  }) => MsdtAnswer(
    idJawabanMsdt: idJawabanMsdt ?? this.idJawabanMsdt,
    idPelamar: idPelamar ?? this.idPelamar,
    idLowongan: idLowongan ?? this.idLowongan,
    idUjian: idUjian ?? this.idUjian,
    noSoal: noSoal ?? this.noSoal,
    jawaban: jawaban ?? this.jawaban,
  );
}
