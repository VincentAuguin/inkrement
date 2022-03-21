import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:inkrement/counter/domain/counter.dart';
import 'package:inkrement/counter/presentation/bump_text.dart';
import 'package:inkrement/counter/presentation/edit_counter_page.dart';
import 'package:inkrement/counter/presentation/navigation/edit_counter_page_argument.dart';

class CounterTile extends StatefulWidget {
  const CounterTile(
      {Key? key, required this.counter, required this.onIncrement})
      : super(key: key);

  final Counter counter;

  final Function(Counter counter, int value) onIncrement;

  @override
  State<StatefulWidget> createState() => _CounterTileState();
}

class _CounterTileState extends State<CounterTile> {
  late int _count;

  void _increment() {
    int newCount = _count + 1;
    setState(() {
      _count = newCount;
    });
    widget.onIncrement.call(widget.counter, newCount);
  }

  void _edit() {
    Navigator.pushNamed(context, EditCounterPage.route,
        arguments: EditCounterPageArgument(widget.counter));
  }

  @override
  void initState() {
    super.initState();
    _count = widget.counter.value;
  }

  @override
  void didUpdateWidget(covariant CounterTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _count = widget.counter.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Stack(alignment: Alignment.center, children: [
          Align(
              alignment: Alignment.topRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: _edit,
                      child: AutoSizeText(
                        widget.counter.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 28),
                        maxLines: 4,
                        minFontSize: 14,
                        overflow: TextOverflow.ellipsis,
                        wrapWords: false,
                      )),
                  BumpIntText(
                    value: _count,
                    textStyle: const TextStyle(fontSize: 80),
                  ),
                  ElevatedButton(
                      onPressed: _increment,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10),
                      ),
                      child: const Icon(Icons.arrow_upward))
                ],
              ))
        ]));
  }
}
