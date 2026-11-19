import 'package:flutter/material.dart';

void main() {
  runApp(const ContainerConfiguratorApp());
}

/// Кореневий StatelessWidget додатку
class ContainerConfiguratorApp extends StatelessWidget {
  const ContainerConfiguratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Конфігуратор контейнера (Варіант 10)',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const ConfiguratorScreen(),
    );
  }
}

/// Основний StatefulWidget, який зберігає стан параметрів контейнера
class ConfiguratorScreen extends StatefulWidget {
  const ConfiguratorScreen({super.key});

  @override
  State<ConfiguratorScreen> createState() => _ConfiguratorScreenState();
}

class _ConfiguratorScreenState extends State<ConfiguratorScreen> {
  // Початкові значення параметрів
  double _width = 150.0;
  double _height = 150.0;
  double _topRightRadius = 20.0;

  void _resetParameters() {
    setState(() {
      _width = 150.0;
      _height = 150.0;
      _topRightRadius = 20.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Конфігуратор контейнера'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: _resetParameters,
            tooltip: 'Скинути параметри',
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Панель введення даних (повзунки)
            ParameterSlider(
              label: 'Ширина',
              value: _width,
              min: 50.0,
              max: 300.0,
              onChanged: (newValue) {
                setState(() {
                  _width = newValue;
                });
              },
            ),
            const SizedBox(height: 12),
            ParameterSlider(
              label: 'Висота',
              value: _height,
              min: 50.0,
              max: 300.0,
              onChanged: (newValue) {
                setState(() {
                  _height = newValue;
                });
              },
            ),
            const SizedBox(height: 12),
            ParameterSlider(
              label: 'Радіус верхнього правого кутка',
              value: _topRightRadius,
              min: 0.0,
              max: 150.0,
              onChanged: (newValue) {
                setState(() {
                  _topRightRadius = newValue;
                });
              },
            ),
            const Divider(height: 40),

            // Область відображення контейнера
            SizedBox(
              height: 320,
              child: Center(
                child: RedContainerPreview(
                  width: _width,
                  height: _height,
                  topRightRadius: _topRightRadius,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// StatelessWidget для відображення одного елемента введення (слайдера)
class ParameterSlider extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  const ParameterSlider({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              value.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          activeColor: Colors.red,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

/// StatelessWidget для рендерингу самого червоного контейнера
class RedContainerPreview extends StatelessWidget {
  final double width;
  final double height;
  final double topRightRadius;

  const RedContainerPreview({
    super.key,
    required this.width,
    required this.height,
    required this.topRightRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(topRightRadius),
        ),
      ),
    );
  }
}