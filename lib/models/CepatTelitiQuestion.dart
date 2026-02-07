class CepatTelitiQuestion {
  int? idSoal;
  int? noSoal;
  String? soal;
  String? opsiA;
  String? opsiB;
  String? opsiC;
  String? opsiD;
  String? opsiE;
  String? jawaban;

  CepatTelitiQuestion({
    this.idSoal,
    this.noSoal,
    this.soal,
    this.opsiA,
    this.opsiB,
    this.opsiC,
    this.opsiD,
    this.opsiE,
    this.jawaban,
  });

  CepatTelitiQuestion copyWith({
    int? idSoal,
    int? noSoal,
    String? soal,
    String? opsiA,
    String? opsiB,
    String? opsiC,
    String? opsiD,
    String? opsiE,
    String? jawaban,
  }) => CepatTelitiQuestion(
    idSoal: idSoal ?? this.idSoal,
    noSoal: noSoal ?? this.noSoal,
    soal: soal ?? this.soal,
    opsiA: opsiA ?? this.opsiA,
    opsiB: opsiB ?? this.opsiB,
    opsiC: opsiC ?? this.opsiC,
    opsiD: opsiD ?? this.opsiD,
    opsiE: opsiE ?? this.opsiE,
    jawaban: jawaban ?? this.jawaban,
  );
}
