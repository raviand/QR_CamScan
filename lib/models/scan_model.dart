import 'package:latlong/latlong.dart';

class ScanResponse {
    int id;
    String tipo;
    String valor;

    ScanResponse({
        this.id,
        this.tipo,
        this.valor,
    }){
      if(this.valor.contains('http')){
        this.tipo = 'http';
      }else if(this.valor.contains('geo')){
        this.tipo = 'geo';
      }else{
        this.tipo = 'ERROR';
      }
    }
    factory ScanResponse.fromJson(Map<String, dynamic> json) => new ScanResponse(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
    };

    LatLng getLatLng(){
      final lalo = valor.substring(4).split(',');
      final lat = double.parse(lalo[0]);
      final lng = double.parse(lalo[1]);

      return LatLng(lat, lng);
    }
}