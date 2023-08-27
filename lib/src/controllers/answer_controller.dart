import 'package:get/get.dart';
import 'package:quizloco/src/models/answer_model.dart';

class AnswerController extends GetxController {
  final RxList<Answer> _answers = <Answer>[].obs;

  //getters y setters
  List<Answer> get answers => _answers;

  set answers(List<Answer>  value) => _answers.value = value;

  @override
  void onClose() {
    _answers.value = [];
    super.onClose();
  }
}
