
import 'package:aplicacion_peliculas/pantallas/pantalla.dart';
import 'package:aplicacion_peliculas/proveedores/peli_proveedor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(EstadoApp());


class EstadoApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: ( _ ) => PelisProveedor(), lazy: false,),
    ],
    child: MyApp(),
      
    );
  }
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: 'home',
      routes: {
        'home': ( _ ) => HomeScreen(),
        'detalle': ( _ ) => DetallePantalla(),
      },
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.deepPurple
        )
      ),
    );
  }
}