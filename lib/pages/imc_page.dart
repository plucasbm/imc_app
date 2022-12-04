import 'package:flutter/material.dart';

class IMCPage extends StatefulWidget {
  const IMCPage({super.key});

  @override
  State<IMCPage> createState() => _IMCPageState();
}

class _IMCPageState extends State<IMCPage> {
  final pesoController = TextEditingController();
  final alturaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _infoText = 'Informe os seus dados';

  void _resetFields(){
    pesoController.clear();
    alturaController.clear();
    setState(() {
      _infoText = 'Informe os seus dados';
    });
  }

  _calcularIMC(){
    setState(() {
      double peso = double.parse(pesoController.text); 
      double altura = double.parse(alturaController.text)/100;
      double imc = peso/(altura*altura);

      if(imc < 18.5 ){
          _infoText = 'Abaixo do peso (${imc.toStringAsPrecision(2)})';
      }else if(imc >= 18.5 && imc <= 24.9){
        
          _infoText = 'Peso ideal (${imc.toStringAsPrecision(2)})';
        
      }else if(imc >= 25 && imc <= 29.9){
      
          _infoText = 'Sobrepeso (${imc.toStringAsPrecision(2)})';
        
      }else if(imc >= 30 && imc <=39.9){
        
          _infoText = 'Obesidade (${imc.toStringAsPrecision(2)})';
        
      }else{
        
          _infoText = 'Obesidade mórbida (${imc.toStringAsPrecision(2)})';
        
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _resetFields,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person_outline,
                color: Colors.purple,
                size: 120,
              ),
              TextFormField(
                controller: pesoController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Insira seu peso!';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Peso (kg)',
                  hintStyle: TextStyle(
                    fontSize: 22,
                    color: Colors.purple,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: alturaController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Insira seu peso!';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Altura (cm)',
                  hintStyle: TextStyle(
                    fontSize: 22,
                    color: Colors.purple,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    _calcularIMC();
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Calcular',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
