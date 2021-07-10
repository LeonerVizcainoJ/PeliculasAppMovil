import 'package:aplicacion_peliculas/busquedas/busquedas_delegadas.dart';
import 'package:aplicacion_peliculas/proveedores/peli_proveedor.dart';
import 'package:aplicacion_peliculas/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final pelisProveedor = Provider.of<PelisProveedor>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en Cines'),
        elevation: 0,
        actions: [
          IconButton(
           icon: Icon(Icons.search_outlined),
           onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [
        
        //Tarjeta principal
        PasaTarjeta(movies: pelisProveedor.enPantalla,),
       
        //El slider
        PeliSlider(
          movies: pelisProveedor.popularMovies,
          title: 'Populares',
          onNextPage: () => pelisProveedor.getPopularMovie(),
        ),

      ],
    )
   )
  );
  }
}