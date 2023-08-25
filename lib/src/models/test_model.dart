import 'package:quizloco/src/models/question_model.dart';

class Test {
  String name;
  String description;
  List<Question> questions;

  Test({ required this.name, required this.description, required this.questions});

  @override
  String toString() {
    return 'Test{name: $name, description: $description, questions: $questions}';
  }
}
