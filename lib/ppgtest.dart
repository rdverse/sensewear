import 'package:ppg/ppg.dart';
import 'package:flutter/material.dart';
import 'package:conreality_pulse/conreality_pulse.dart';

void main() => runApp(MaterialApp(
  home: ppgtest(),
));


class ppgtest extends StatefulWidget {
  @override
  _ppgtestState createState() => _ppgtestState();
}

class _ppgtestState extends State<ppgtest> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
    children: <Widget>[
      Container(
          child: FloatingActionButton(
            onPressed: () async {

              Stream<PulseEvent> stream = await Pulse.subscribe();

              stream.listen((PulseEvent event) {
                print("Your current heart rate is: ${event.value}");
              });

            },
          ),


    )
        ],

    ),
    );
  }
}

