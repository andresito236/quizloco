import 'package:flutter/material.dart';
import 'package:quizloco/src/controllers/test_controller.dart';

class TestGeneralInfoForm extends StatelessWidget {
  final TestController testController;

  TestGeneralInfoForm({
    required this.testController
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16.0),
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
            color: Color.fromARGB(54, 75, 93, 200),
          ),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Nombre de la Prueba'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Por favor, ingresa un nombre para la prueba';
                    }
                    return null;
                  },
                  onChanged:(value) {
                    testController.name = value;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Descripcion'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Descripcion del test';
                    }
                    return null;
                  },
                  onChanged:(value) {
                    testController.description = value;
                  },
                ),
                const SizedBox(height: 16.0),
                // TextFormField(
                //   keyboardType: TextInputType.number,
                //   initialValue: '70', // Valor por defecto
                //   decoration: const InputDecoration(
                //       labelText: 'Nota de Aprobación'),
                //   onChanged: (value) {
                //     // Actualiza la nota de aprobación cuando cambia el valor del campo.
                //     _passingScore = int.tryParse(value) ?? 0;
                //   },
                //   validator: (value) {
                //     if (value?.isEmpty ?? true) {
                //       return 'Por favor, ingresa la nota de aprobación';
                //     }
                //     if (_passingScore < 0 || _passingScore > 100) {
                //       return 'La nota de aprobación debe estar entre 0 y 100';
                //     }
                //     return null;
                //   },
                // ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
