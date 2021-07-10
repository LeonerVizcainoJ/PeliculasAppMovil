import 'package:aplicacion_peliculas/modelos/creditos.dart';
import 'package:aplicacion_peliculas/proveedores/peli_proveedor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarruselActor extends StatelessWidget {

  final int movieId;
  const CarruselActor(this.movieId);

  @override
  Widget build(BuildContext context) {
    
    final pelisProvider = Provider.of<PelisProveedor>(context, listen: false);
    
    return FutureBuilder(
      future: pelisProvider.getMovieCaste(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        
      if (!snapshot.hasData){
        return Container(
          constraints: BoxConstraints(maxWidth: 150),
          height: 180,
          child: CupertinoActivityIndicator(),
        );
      }
      final List<Cast> cast =snapshot.data!;

    return Container(
      width: double.infinity,
      height: 180,
      margin: EdgeInsets.only(bottom: 30),
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, int index) => _Cartas( cast[index]),
      ),
    );  
      },
  );

  }
}

class _Cartas extends StatelessWidget {

  final Cast actor;

  const _Cartas(this.actor);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FadeInImage(

          placeholder: AssetImage('assets/no-image.jpg'),
          image: NetworkImage(actor.fullProfilePath),
          height: 140,
          width: 100,
          fit: BoxFit.cover,
        ),
      ),
      
      SizedBox(height: 5),
      Text(
        actor.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      )

      ],
      ),
    );
  }
}