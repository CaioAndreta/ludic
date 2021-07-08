import 'package:flutter/material.dart';

class EscolherRegistroView extends StatelessWidget {
  const EscolherRegistroView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.purple.shade900,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Escolha o tipo de cadastro',
            style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/register-professor');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Sou um professor',
                          style: Theme.of(context).textTheme.headline2),
                      SizedBox(height: 15),
                      Text(
                        '👨‍🏫',
                        style: TextStyle(fontSize: 36),
                      ),
                    ],
                  ),
                ),
                width: size.width,
                height: size.height / 2,
                decoration: BoxDecoration(color: Colors.purple.shade900)),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 1,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Container(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/register-aluno');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Sou um aluno',
                          style: Theme.of(context).textTheme.headline2),
                      SizedBox(height: 15),
                      Text(
                        '👨‍🎓',
                        style: TextStyle(fontSize: 36),
                      ),
                    ],
                  ),
                ),
                width: size.width,
                height: size.height / 2,
                decoration: BoxDecoration(color: Colors.purple.shade900)),
          ),
        ],
      ),
    );
  }
}
