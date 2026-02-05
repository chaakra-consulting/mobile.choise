class CfitQuestion {
  int? idSoal;
  int? nomorSoal;
  String? soal;
  String? opsiA;
  String? opsiB;
  String? opsiC;
  String? opsiD;
  String? opsiE;
  String? opsiF;
  String? jawaban;
  String? jawaban2;
  String? typeSoal;
  int? subtes;

  CfitQuestion({
    this.idSoal,
    this.nomorSoal,
    this.soal,
    this.opsiA,
    this.opsiB,
    this.opsiC,
    this.opsiD,
    this.opsiE,
    this.opsiF,
    this.jawaban,
    this.jawaban2,
    this.typeSoal,
    this.subtes,
  });

  CfitQuestion copyWith({
    int? idSoal,
    int? nomorSoal,
    String? soal,
    String? opsiA,
    String? opsiB,
    String? opsiC,
    String? opsiD,
    String? opsiE,
    String? opsiF,
    String? jawaban,
    String? jawaban2,
    String? typeSoal,
    int? subtes,
  }) => CfitQuestion(
    idSoal: idSoal ?? this.idSoal,
    nomorSoal: nomorSoal ?? this.nomorSoal,
    soal: soal ?? this.soal,
    opsiA: opsiA ?? this.opsiA,
    opsiB: opsiB ?? this.opsiB,
    opsiC: opsiC ?? this.opsiC,
    opsiD: opsiD ?? this.opsiD,
    opsiE: opsiE ?? this.opsiE,
    opsiF: opsiF ?? this.opsiF,
    jawaban: jawaban ?? this.jawaban,
    jawaban2: jawaban2 ?? this.jawaban2,
    typeSoal: typeSoal ?? this.typeSoal,
    subtes: subtes ?? this.subtes,
  );
}
