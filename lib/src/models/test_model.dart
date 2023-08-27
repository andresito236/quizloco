import 'package:quizloco/src/models/question_model.dart';

class Test {
  String name;
  String description;
  List<Question> questions;
  String creator;

  Test({ required this.name, required this.description, required this.questions, required this.creator});

  @override
  String toString() {
    return 'Test{name: $name, description: $description, questions: $questions}';
  }
}
