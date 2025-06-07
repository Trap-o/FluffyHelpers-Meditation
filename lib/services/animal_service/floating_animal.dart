import 'dart:async';
import 'dart:math'; // Для pi
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

  final double _animalWidth = 150;

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
        double screenWidth = MediaQuery.of(context).size.width;

        if (_movingRight) {
          _left += 2;
          if (_left + _animalWidth >= screenWidth) {
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
      top: MediaQuery.of(context).size.height * 0.65,
      left: _left,
      child: SizedBox(
        width: _animalWidth,
        height: 150,
        child: _movingRight
            ? Image.asset('assets/animals/$petName.png')
            : Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi),
          child: Image.asset('assets/animals/$petName.png'),
        ),
      ),
    );
  }
}



