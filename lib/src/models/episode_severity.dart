enum EpisodeSeverity {
  maniaSevere(4),
  maniaModerateHigh(3),
  maniaModerateLow(2),
  maniaMild(1),
  balanced(0),
  depressionMild(1),
  depressionModerateLow(2),
  depressionModerateHigh(3),
  depressionSevere(4);

  final int levelValue;

  const EpisodeSeverity(this.levelValue);

  bool get isMania =>
      this == EpisodeSeverity.maniaMild ||
      this == EpisodeSeverity.maniaModerateLow ||
      this == EpisodeSeverity.maniaModerateHigh ||
      this == EpisodeSeverity.maniaSevere;

  bool get isDepression =>
      this == EpisodeSeverity.depressionMild ||
      this == EpisodeSeverity.depressionModerateLow ||
      this == EpisodeSeverity.depressionModerateHigh ||
      this == EpisodeSeverity.depressionSevere;
}
