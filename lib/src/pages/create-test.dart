import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizloco/src/widgets/question.dart';

class CreateTestPage extends StatefulWidget {
  @override
  _CreateTestPageState createState() => _CreateTestPageState();
}

class _CreateTestPageState extends State<CreateTestPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _testNameController = TextEditingController();
  final TextEditingController _testDescriptionController =
      TextEditingController();
  String _selectedQuestionType = 'Verdadero/Falso'; // Valor por defecto
  int _passingScore = 70; // Valor por defecto
  List<Widget> _questionWidgets = [];

  @override
  void initState() {
    super.initState();
    // Inicializa la lista de widgets de preguntas con un widget vacío.
    _questionWidgets.add(QuestionWidget()); // Debes tener tu propio widget Question
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Prueba'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Informacion General del Test',
                style: TextStyle(fontSize: 20.0, color: Colors.blueGrey),
              ),
              const SizedBox(height: 16.0),
              Container(
                margin: const EdgeInsetsDirectional.symmetric(horizontal: 16.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: const Color.fromARGB(47, 82, 154, 190),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: _testNameController,
                        decoration: const InputDecoration(
                            labelText: 'Nombre de la Prueba'),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Por favor, ingresa un nombre para la prueba';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _testDescriptionController,
                        decoration:
                            const InputDecoration(labelText: 'Descripcion'),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Descripcion del test';
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
                          'Selección Múltiple',
                          'Selección Única'
                        ]
                            .map((type) => DropdownMenuItem<String>(
                                  value: type,
                                  child: Text(type),
                                ))
                            .toList(),
                        decoration: const InputDecoration(
                            labelText: 'Tipo de Pregunta'),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: '70', // Valor por defecto
                        decoration: const InputDecoration(
                            labelText: 'Nota de Aprobación'),
                        onChanged: (value) {
                          // Actualiza la nota de aprobación cuando cambia el valor del campo.
                          _passingScore = int.tryParse(value) ?? 0;
                        },
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Por favor, ingresa la nota de aprobación';
                          }
                          if (_passingScore < 0 || _passingScore > 100) {
                            return 'La nota de aprobación debe estar entre 0 y 100';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Preguntas',
                style: TextStyle(fontSize: 20.0, color: Colors.blueGrey),
              ),
              Column(children: _questionWidgets),
              ElevatedButton(
                  onPressed: _addQuestion, child: Text('Add question')),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  void _addQuestion() {
    // Agrega un nuevo widget de pregunta a la lista
    setState(() {
      _questionWidgets.add(const SizedBox(height: 16.0)); // Debes tener tu propio widget Question
      _questionWidgets.add(QuestionWidget()); // Debes tener tu propio widget Question
    });
  }

  void _createTest() async {
    // Aquí puedes agregar la lógica para crear la prueba en Firestore
    // Utiliza FirebaseFirestore.instance.collection('pruebas').add()
    // para agregar la prueba a tu colección en Firestore.
    // Asegúrate de incluir los campos y datos necesarios de acuerdo a tus requerimientos.

    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     content: Text('Prueba creada con éxito'),
    //   ),
    // );
  }

  @override
  void dispose() {
    _testNameController.dispose();
    super.dispose();
  }
}
