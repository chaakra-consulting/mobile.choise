class ExamList {
  String namaUjian;
  String status;
  DateTime waktuAkhir;
  DateTime waktuMulai;

  ExamList({
    required this.namaUjian,
    required this.status,
    required this.waktuAkhir,
    required this.waktuMulai,
  });

  ExamList copyWith({
    String? namaUjian,
    String? status,
    DateTime? waktuAkhir,
    DateTime? waktuMulai,
  }) => ExamList(
    namaUjian: namaUjian ?? this.namaUjian,
    status: status ?? this.status,
    waktuAkhir: waktuAkhir ?? this.waktuAkhir,
    waktuMulai: waktuMulai ?? this.waktuMulai,
  );
}
