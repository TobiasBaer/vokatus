class IrregularVerb {
  final String german;
  final String infinitive;
  final String simplePast;
  final String pastParticiple;

  IrregularVerb(
      {required this.german,
      required this.infinitive,
      required this.simplePast,
      required this.pastParticiple});
}

List<IrregularVerb> irregularVerbs = [
  IrregularVerb(
      german: "kaufen",
      infinitive: "to buy",
      simplePast: "bought",
      pastParticiple: "bought"),
  IrregularVerb(
      german: "bringen",
      infinitive: "to bring",
      simplePast: "brought",
      pastParticiple: "brought"),
  IrregularVerb(
      german: "bauen",
      infinitive: "to build",
      simplePast: "built",
      pastParticiple: "built"),
  IrregularVerb(
      german: "lehren",
      infinitive: "to teach",
      simplePast: "taught",
      pastParticiple: "taught"),
  IrregularVerb(
      german: "aufstellen",
      infinitive: "to put",
      simplePast: "put",
      pastParticiple: "put"),
  IrregularVerb(
      german: "essen",
      infinitive: "to eat",
      simplePast: "ate",
      pastParticiple: "eaten"),
];
