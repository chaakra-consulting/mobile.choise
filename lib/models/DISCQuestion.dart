class DiscQuestion {
  int? idSoal;
  int? noSoal;
  String? pernyataan1;
  String? pernyataan2;
  String? pernyataan3;
  String? pernyataan4;
  String? aspekM1;
  String? aspekM2;
  String? aspekM3;
  String? aspekM4;
  String? aspekL1;
  String? aspekL2;
  String? aspekL3;
  String? aspekL4;

  DiscQuestion({
    this.idSoal,
    this.noSoal,
    this.pernyataan1,
    this.pernyataan2,
    this.pernyataan3,
    this.pernyataan4,
    this.aspekM1,
    this.aspekM2,
    this.aspekM3,
    this.aspekM4,
    this.aspekL1,
    this.aspekL2,
    this.aspekL3,
    this.aspekL4,
  });

  DiscQuestion copyWith({
    int? idSoal,
    int? noSoal,
    String? pernyataan1,
    String? pernyataan2,
    String? pernyataan3,
    String? pernyataan4,
    String? aspekM1,
    String? aspekM2,
    String? aspekM3,
    String? aspekM4,
    String? aspekL1,
    String? aspekL2,
    String? aspekL3,
    String? aspekL4,
  }) => DiscQuestion(
    idSoal: idSoal ?? this.idSoal,
    noSoal: noSoal ?? this.noSoal,
    pernyataan1: pernyataan1 ?? this.pernyataan1,
    pernyataan2: pernyataan2 ?? this.pernyataan2,
    pernyataan3: pernyataan3 ?? this.pernyataan3,
    pernyataan4: pernyataan4 ?? this.pernyataan4,
    aspekM1: aspekM1 ?? this.aspekM1,
    aspekM2: aspekM2 ?? this.aspekM2,
    aspekM3: aspekM3 ?? this.aspekM3,
    aspekM4: aspekM4 ?? this.aspekM4,
    aspekL1: aspekL1 ?? this.aspekL1,
    aspekL2: aspekL2 ?? this.aspekL2,
    aspekL3: aspekL3 ?? this.aspekL3,
    aspekL4: aspekL4 ?? this.aspekL4,
  );
}
