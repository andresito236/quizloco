import 'package:flutter/material.dart';
import 'package:quizloco/src/controllers/answer_controller.dart';
import 'package:quizloco/src/models/answer_model.dart';
import 'package:quizloco/src/models/question_model.dart';

class QuestionWidget extends StatefulWidget {
  Question question;
  final AnswerController answerController;

  QuestionWidget(
      {super.key, required this.question, required this.answerController});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  bool _isQuestionEnabled = true;
  int _selectedOptionIndex = 1;
  List<bool> _multipleAnswers = [false, false, false];

  void verifyAnswer() {
    Answer newAnswer = Answer();
    List<String> _userAnswer = [];

    newAnswer.question = widget.question.question;

    if (widget.question.type == 'Verdadero/Falso') {
      _userAnswer = _selectedOptionIndex == 0 ? ['falso'] : ['verdadero'];
    } else if (widget.question.type == 'Respuesta Unica') {
      _userAnswer = _selectedOptionIndex >= 0
          ? [widget.question.options![_selectedOptionIndex]]
          : [];
    } else if (widget.question.type == 'Seleccion Multiple') {
      for (int i = 0; i < _multipleAnswers.length; i++) {
        if (_multipleAnswers[i]) {
          _userAnswer.add(widget.question.options![i]);
        }
      }
    }

    bool areAnswersCorrect(
        List<String> userAnswers, List<String>? correctAnswers) {
      return userAnswers.toSet().containsAll(correctAnswers!.toSet()) &&
          userAnswers.length == correctAnswers.length;
    }

    if (areAnswersCorrect(_userAnswer, widget.question.answers)) {
      newAnswer.score = 1;
    } else {
      newAnswer.score = 0;
    }

    widget.answerController.answers.add(newAnswer);
    setState(() {
      _isQuestionEnabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: _isQuestionEnabled ? null : Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.question.question ?? '',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                if (widget.question.type == 'Verdadero/Falso')
                  Column(
                    children: [
                      Column(
                        children: [
                          RadioListTile(
                            title: const Text('Verdadero'),
                            value: 1,
                            groupValue: _selectedOptionIndex,
                            onChanged: (value) {
                              setState(() {
                                _selectedOptionIndex = value as int;
                              });
                            },
                          ),
                          RadioListTile(
                            title: const Text('Falso'),
                            value: 0,
                            groupValue: _selectedOptionIndex,
                            onChanged: (value) {
                              _isQuestionEnabled ?
                              setState(() {
                                _selectedOptionIndex = value as int;
                              }) : null;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                if (widget.question.type == 'Respuesta Unica')
                  Column(
                    children:
                        widget.question.options!.asMap().entries.map((entry) {
                      final int index = entry.key;
                      return Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(widget.question.options![index])),
                          Expanded(
                            flex: 1,
                            child: Radio(
                              value: index,
                              groupValue: _selectedOptionIndex,
                              onChanged: (int? value) {
                                _isQuestionEnabled
                                    ? setState(() {
                                        _selectedOptionIndex = value!;
                                      })
                                    : null;
                              },
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                if (widget.question.type == 'Seleccion Multiple')
                  Column(
                    children:
                        widget.question.options!.asMap().entries.map((entry) {
                      final int index = entry.key;
                      return Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(widget.question.options![index]),
                          ),
                          Expanded(
                            flex: 1,
                            child: Checkbox(
                              value: _multipleAnswers[index],
                              onChanged: (value) {
                                _isQuestionEnabled
                                    ? setState(() {
                                        _multipleAnswers[index] = value!;
                                      })
                                    : null;
                              },
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  _isQuestionEnabled ? 
                OutlinedButton(
                    onPressed: () {
                      _isQuestionEnabled ? verifyAnswer() : null;
                    },
                    child: const Text("Enviar Respuesta")) : TextButton(onPressed: null, child: const Text("Respuesta Enviada")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
