import 'package:flutter/material.dart';
import 'package:quizloco/src/controllers/question_controller.dart';
import 'package:quizloco/src/controllers/test_controller.dart';
import 'package:quizloco/src/models/question_model.dart';

class QuestionForm extends StatefulWidget {
  final QuestionController questionController;
  final TestController testController;

  QuestionForm(
      {required this.questionController, required this.testController});

  @override
  _QuestionFormState createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _questionController = TextEditingController();
  String _selectedQuestionType = 'Verdadero/Falso';
  int _selectedOptionIndex = 1;
  List<String> _options = ['Opcion 1', 'Opcion 2', 'Opcion 3'];
  List<bool> _correctAnswers = [false, false, false];

  void setQuestion() {
    Question newQuestion = Question();
    newQuestion.question = _questionController.text;
    newQuestion.type = _selectedQuestionType;

    if (_selectedQuestionType == 'Verdadero/Falso') {
      newQuestion.options = ['Verdadero', 'Falso'];
      newQuestion.answers =
          _selectedOptionIndex == 0 ? ['falso'] : ['verdadero'];
    } else if (_selectedQuestionType == 'Respuesta Unica') {
      newQuestion.answers =
          _selectedOptionIndex >= 0 ? [_options[_selectedOptionIndex]] : [];
      newQuestion.options = [];
      for (int i = 0; i < _options.length; i++) {
        newQuestion.options?.add(_options[i]);
      }
    } else if (_selectedQuestionType == 'Seleccion Multiple') {
      newQuestion.answers = [];

      newQuestion.options = [];
      for (int i = 0; i < _options.length; i++) {
        newQuestion.options?.add(_options[i]);
      }
      for (int i = 0; i < _correctAnswers.length; i++) {
        if (_correctAnswers[i]) {
          newQuestion.answers?.add(_options[i]);
        }
      }
    }

    widget.testController.questions.add(newQuestion);

    newQuestion = Question();
    _questionController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _questionController,
                decoration: const InputDecoration(labelText: 'Pregunta'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, ingresa una pregunta';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _selectedQuestionType,
                onChanged: (value) {
                  setState(() {
                    _selectedQuestionType = value!;
                  });
                },
                items: [
                  'Verdadero/Falso',
                  'Respuesta Unica',
                  'Seleccion Multiple',
                ]
                    .map((type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                decoration:
                    const InputDecoration(labelText: 'Tipo de Pregunta'),
              ),
              const SizedBox(height: 14.0),
              Text(
                'Respuesta Correcta:',
                style: const TextStyle(fontSize: 14.0),
              ),
              if (_selectedQuestionType == 'Verdadero/Falso')
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
                        setState(() {
                          _selectedOptionIndex = value as int;
                        });
                      },
                    ),
                  ],
                ),
              if (_selectedQuestionType == 'Respuesta Unica')
                Column(
                  children: _options.asMap().entries.map((entry) {
                    final int index = entry.key;
                    return Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Opcion ${index + 1}'),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Por favor, ingresa una opcion';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _options[index] = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Radio(
                            value: index,
                            groupValue: _selectedOptionIndex,
                            onChanged: (int? value) {
                              setState(() {
                                _selectedOptionIndex = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              if (_selectedQuestionType == 'Seleccion Multiple')
                Column(
                  children: _options.asMap().entries.map((entry) {
                    final int index = entry.key;
                    return Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            initialValue: _options[index],
                            onChanged: (value) {
                              setState(() {
                                _options[index] = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Checkbox(
                            value: _correctAnswers[index],
                            onChanged: (value) {
                              setState(() {
                                _correctAnswers[index] = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ElevatedButton(
                  onPressed: () {
                    setQuestion();
                  },
                  child: Text('Submit Pregunta'))
            ],
          ),
        ),
      ),
    );
  }
}
