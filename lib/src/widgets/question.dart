import 'package:flutter/material.dart';

class QuestionWidget extends StatefulWidget {
  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  String _selectedQuestionType = 'Verdadero/Falso'; // Valor por defecto
  TextEditingController _questionController = TextEditingController();
  List<String> _options = ['Opción 1', 'Opción 2', 'Opción 3'];
  List<bool> _correctAnswers = [false, false, false]; // Para respuestas correctas en selección múltiple

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          value: _selectedQuestionType,
          onChanged: (value) {
            setState(() {
              _selectedQuestionType = value!;
              // Reiniciar campos cuando se cambie el tipo de pregunta
              _questionController.clear();
              _options = ['Opción 1', 'Opción 2', 'Opción 3'];
              _correctAnswers = [false, false, false];
            });
          },
          items: [
            'Verdadero/Falso',
            'Respuesta Única',
            'Selección Múltiple',
          ].map((type) {
            return DropdownMenuItem<String>(
              value: type,
              child: Text(type),
            );
          }).toList(),
          decoration: InputDecoration(
            labelText: 'Tipo de Pregunta',
          ),
        ),
        TextFormField(
          controller: _questionController,
          decoration: InputDecoration(
            labelText: 'Pregunta',
          ),
        ),
        if (_selectedQuestionType == 'Verdadero/Falso')
          Row(
            children: [
              Radio(
                value: true,
                groupValue: _correctAnswers[0],
                onChanged: (bool? value) {
                  setState(() {
                    _correctAnswers[0] = true;
                    _correctAnswers[1] = false;
                  });
                },
              ),
              Text('Verdadero'),
              Radio(
                value: false,
                groupValue: _correctAnswers[0],
                onChanged: (bool? value) {
                  setState(() {
                    _correctAnswers[0] = false;
                    _correctAnswers[1] = true;
                  });
                },
              ),
              Text('Falso'),
            ],
          ),
        if (_selectedQuestionType == 'Respuesta Única')
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
                        _options[index] = value;
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Radio(
                      value: index,
                      groupValue: _options.indexOf(_options[index]),
                      onChanged: (int? value) {
                        setState(() {
                          _options[index] = _options[value!];
                          _options[value] = entry.value;
                        });
                      },
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        if (_selectedQuestionType == 'Selección Múltiple')
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
                        _options[index] = value;
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Checkbox(
                      value: _correctAnswers[index],
                      onChanged: (bool? value) {
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
      ],
    );
  }
}
