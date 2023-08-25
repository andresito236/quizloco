import 'package:get/get.dart';

class QuestionController extends GetxController {
  final RxString _id = ''.obs;
  final RxString _question = ''.obs;
  final RxList<String> _answers = [''].obs;
  final RxString _type = ''.obs;
  RxList<String> _options = [''].obs;

  //getters y setters
  String get id => _id.value;
  String get question => _question.value;
  List<String> get answers => _answers;
  String get type => _type.value;
  List<String> get options => _options;

  set id(String value) => _id.value = value;
  set question(String value) => _question.value = value;
  set answers(List<String> value) => _answers.value = value;
  set type(String value) => _type.value = value;
  set options(List<String> value) => _options.value = value;
}
