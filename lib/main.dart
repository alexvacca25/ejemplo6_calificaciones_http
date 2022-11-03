import 'package:ejemplo6_calificaciones_http/peticiones.dart';
import 'package:flutter/material.dart';
import 'modelo.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Calificaciones'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final title;
  MyHomePage({this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String id = "";
  TextEditingController controlcodigo = TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
    id = '1';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controlcodigo,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              filled: true,
              labelText: 'Identificacion',
              // suffix: Icon(Icons.access_alarm),
              suffix: GestureDetector(
                child: Icon(Icons.search),
                onTap: () {
                  setState(() {
                    id = controlcodigo.text;
                  });
                },
              )
              //probar suffix
              ),
        ),
      ),

      body: ListView(
        children: [
          getInfo(context, id),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Refrescar',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget getInfo(BuildContext context, String id) {
  return FutureBuilder(
    future: listarPost(http.Client(),
        id), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {

        //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el loader
        case ConnectionState.waiting:
          return Center(child: CircularProgressIndicator());

        case ConnectionState.done:
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          // print(snapshot.data);
          return snapshot.data != null
              ? Vistanotas(posts: snapshot.data)
              : Text('Sin Datos');

        /*
             Text(
              snapshot.data != null ?'ID: ${snapshot.data['id']}\nTitle: ${snapshot.data['title']}' : 'Vuelve a intentar', 
              style: TextStyle(color: Colors.black, fontSize: 20),);
            */

        default:
          return Text('Presiona el boton para recargar');
      }
    },
  );
}

class Vistanotas extends StatelessWidget {
  final List<Post> posts;

  Vistanotas({required this.posts});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
      height: 460,
      width: double.maxFinite,
      child: Card(
        elevation: 5,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -50,
              left: (MediaQuery.of(context).size.width / 2) - 55,
              child: Container(
                height: 100,
                width: 100,
                //color: Colors.blue,
                child: Card(
                  elevation: 2,
                  child: Image.network(
                      "http://sistemas.unicesar.edu.co/images/tlpteam/m_alex-vacca-1623230209.png"),
                  //child: Image.network(posts[posts.length - 1].foto),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        Text(
                          posts[posts.length - 1].nombre,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(posts[posts.length - 1].materia),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Informe de Notas'),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text('Nota 1'),
                                CircleAvatar(
                                    child: Text(posts[posts.length - 1].n1)),
                              ],
                            ),
                            Column(
                              children: [
                                Text('Nota 2'),
                                CircleAvatar(
                                    child: Text(posts[posts.length - 1].n2)),
                              ],
                            ),
                            Column(
                              children: [
                                Text('Nota 3'),
                                CircleAvatar(
                                    child: Text(posts[posts.length - 1].n3)),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Apuntes:'),
                        Text(posts[posts.length - 1].detalle),
                        SizedBox(height: 20),
                        Text('Definitiva:'),
                        CircleAvatar(
                          radius: 40.0,
                          child: Text(
                            posts[posts.length - 1].definitiva,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
