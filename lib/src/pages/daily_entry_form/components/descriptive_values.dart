class DescriptiveValue {
  final int value;
  final String? description;

  DescriptiveValue(this.value, [this.description]);
}

final functionalImpairment = [
  DescriptiveValue(-4, 'Totalmente incapacitado'),
  DescriptiveValue(-3, 'Funcionando com muito esforço'),
  DescriptiveValue(-2, 'Funcionando com um pouco de esforço'),
  DescriptiveValue(-1, 'Consigo realizar qualquer atividade normalmente'),
  DescriptiveValue(0, 'Totalmente normal'),
  DescriptiveValue(
    1,
    'Mais energizado e mais produtivo\nConsigo realizar qualquer atividade normalmente',
  ),
  DescriptiveValue(
    2,
    'Com um pouco de dificuldade em realizar certas atividades',
  ),
  DescriptiveValue(3, 'Com muita dificuldade em realizar certas atividades'),
  DescriptiveValue(4, 'Totalmente incapacitado'),
];

final mood = [
  DescriptiveValue(-1, 'Mais depressivo que nunca'),
  DescriptiveValue(0, 'Equilibrado'),
  DescriptiveValue(1, 'Mais ativo que nunca'),
];
