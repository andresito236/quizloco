import 'package:get/get.dart';
import 'package:quizloco/src/models/question_model.dart';

class TestController extends GetxController {
  final RxString _name = ''.obs;
  final RxString _description = ''.obs;
  final RxString _creator = ''.obs;
  final RxList<Question> _questions = <Question>[].obs;

  String get name => _name.value;
  String get description => _description.value;
  String get creator => _creator.value;
  List<Question> get questions => _questions;

  set name(String value) => _name.value = value;
  set description(String value) => _description.value = value;
  set creator(String value) => _creator.value = value;
  set questions(List<Question> value) => _questions.value = value;

  @override
  void onClose() {
    _name.value = '';
    _description.value = '';
    _creator.value = '';
    _questions.value = [];
    super.onClose();
  }
}
