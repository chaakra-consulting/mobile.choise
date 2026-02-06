class HollandQuestion {
  int? id;
  String? questionText;
  String? type;
  String? identifier;
  bool? isChecked;
  int? value;

  HollandQuestion({
    this.id,
    this.questionText,
    this.type,
    this.identifier,
    this.isChecked,
    this.value,
  });

  HollandQuestion copyWith({
    int? id,
    String? questionText,
    String? type,
    String? identifier,
    bool? isChecked,
    int? value,
  }) => HollandQuestion(
    id: id ?? this.id,
    questionText: questionText ?? this.questionText,
    type: type ?? this.type,
    identifier: identifier ?? this.identifier,
    isChecked: isChecked ?? this.isChecked,
    value: value ?? this.value,
  );
}
