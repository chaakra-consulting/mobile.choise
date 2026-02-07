class MsdtQuestion {
  int? idSoal;
  int? noSoal;
  String? pernyataan1;
  String? pernyataan2;
  String? aspek1;
  String? aspek2;

  MsdtQuestion({
    this.idSoal,
    this.noSoal,
    this.pernyataan1,
    this.pernyataan2,
    this.aspek1,
    this.aspek2,
  });

  MsdtQuestion copyWith({
    int? idSoal,
    int? noSoal,
    String? pernyataan1,
    String? pernyataan2,
    String? aspek1,
    String? aspek2,
  }) => MsdtQuestion(
    idSoal: idSoal ?? this.idSoal,
    noSoal: noSoal ?? this.noSoal,
    pernyataan1: pernyataan1 ?? this.pernyataan1,
    pernyataan2: pernyataan2 ?? this.pernyataan2,
    aspek1: aspek1 ?? this.aspek1,
    aspek2: aspek2 ?? this.aspek2,
  );
}
