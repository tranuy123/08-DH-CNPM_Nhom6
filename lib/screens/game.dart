// ignore_for_file: avoid_print, overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import '../utils/utils.dart';

class Game extends StatefulWidget {
  final bool isLoading;
  final int counter;
  final Widget child;

  const Game({super.key,
    required this.isLoading,
    required this.counter,
    required this.child,
  });

  @override
  State<Game> createState() {
    return GamePageState();
  }
}

class GamePageState extends State<Game> {
  late bool _isLoading;
  late int _counter;

  @override
  void initState() {
    super.initState();
    _isLoading = widget.isLoading;
    _counter = widget.counter;
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild Game');
    return Scaffold(
      body: MyInheritedWidget(
        isLoading: _isLoading,
        counter: _counter,
        child: widget.child,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onFloatingButtonClicked,
        tooltip: "Nhấn",
        backgroundColor: redColor,
        child: const Center(
          child: Icon(
            Icons.plus_one_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void onFloatingButtonClicked() {
    print('Nút đã được nhấn. Gọi phương thức setState');
    setState(() {
      _counter++;
      if (_counter % 2 == 0) {
        _isLoading = false;
      } else {
        _isLoading = true;
      }
    });
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print('rebuild CounterWidget');
    final myInheritedWidget = MyInheritedWidget.of(context);

    if (myInheritedWidget == null) {
      return const Text('MyInheritedWidget không tìm thấy');
    }

    return myInheritedWidget.isLoading
        ? const CircularProgressIndicator(color: Colors.greenAccent,)
        : Text('${myInheritedWidget.counter}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 40),);
  }
}

class MyCenterWidget extends StatelessWidget {
  const MyCenterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print('rebuild MyCenterWidget');
    return const Center(
      child: CounterWidget(),
    );
  }
}

class MyInheritedWidget extends InheritedWidget {
  final int counter;
  final bool isLoading;
  final Widget child;

  const MyInheritedWidget({super.key,
    required this.isLoading,
    required this.counter,
    required this.child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return isLoading != oldWidget.isLoading || counter != oldWidget.counter;
  }

  static MyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  }
}
