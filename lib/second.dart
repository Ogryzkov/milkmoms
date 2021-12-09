import 'package:flutter/material.dart';

class Second extends StatefulWidget {
  const Second({Key? key}) : super(key: key);

  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Center(child: Text('second Screen')),
        Placeholder(),
        ElevatedButton(onPressed: (){
          Navigator.of(context).pushNamed('/frst');
        },
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(10)),
              backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(
                  238, 114, 114, 0.9490196078431372)),
              // backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(
              //          114, 120, 238, 0.85)),
              //shadowColor: MaterialStateProperty.all(Colors.black),
              elevation: MaterialStateProperty.all(2.0),
              overlayColor: MaterialStateProperty.all(const Color.fromRGBO(
                  227, 229, 255, 0.5411764705882353)),
              shadowColor: MaterialStateProperty.all(const Color.fromRGBO(
                  114, 120, 238, 0.0)),
              shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(200),
                    //side: BorderSide(color: Colors.blue),
                  )
              ),
              minimumSize: MaterialStateProperty.all(Size.fromRadius(50)),
            ),
            child: Text('text')),
        Center(child: Text('tap to go back')),

      ],),
    );
  }
}
