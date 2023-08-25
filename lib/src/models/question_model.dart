enum QuestionType { VerdaderoFalso, RespuestaUnica, SeleccionMultiple }

class Question {
  String? question;
  List<String>? answers;
  String? type;
  List<String>? options;

  Question({this.question, this.answers, this.type, this.options});
  
  @override
  String toString() {
    return 'Question{question: $question, answers: $answers, type: $type, options: $options}';
  }
}
