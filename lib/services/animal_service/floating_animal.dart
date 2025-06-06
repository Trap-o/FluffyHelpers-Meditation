import 'dart:async';
import 'package:fluffyhelpers_meditation/services/animal_service/animal_manager.dart';
import 'package:flutter/material.dart';

class FloatingAnimal extends StatefulWidget {
  const FloatingAnimal({super.key});

  @override
  State<FloatingAnimal> createState() => _FloatingAnimalState();
}

class _FloatingAnimalState extends State<FloatingAnimal> {
  double _left = 0.0;
  bool _movingRight = true;
  late Timer _timer;

  final AnimalManager manager = AnimalManager();

  late VoidCallback _listener;

  @override
  void initState() {
    super.initState();

    manager.setAnimalName();

    _listener = () {
      setState(() {});
    };

    manager.selectedPet.addListener(_listener);

    _timer = Timer.periodic(const Duration(milliseconds: 25), (_) {
      setState(() {
        if (_movingRight) {
          _left += 2;
          if (_left >= MediaQuery.of(context).size.width - 80) {
            _movingRight = false;
          }
        } else {
          _left -= 2;
          if (_left <= 0) {
            _movingRight = true;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    manager.selectedPet.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String petName = manager.selectedPet.value;

    return Positioned(
      top: 600,
      left: _left,
      child: SizedBox(
        width: 150,
        height: 150,
        child: Image.asset('assets/animals/$petName.png'),
      ),
    );
  }
}


