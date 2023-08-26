class Attempt {
  DateTime? attemptedAt;
  double? score;
  String? testId;
  String? userId;

  Attempt({this.attemptedAt, this.score, this.testId, this.userId});

  @override
  String toString() {
    return 'Attempt{attemptedAt: $attemptedAt, score: $score, testId: $testId, userId: $userId}';
  }
}