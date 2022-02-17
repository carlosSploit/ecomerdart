import '../config/validador.dart';

import 'Categoria.dart';

class Producto {
  // {
  //   "id_producto": 2,
  //   "nombre": "chifles de tocino",
  //   "descripccion": "chifles que saben a tocino",
  //   "stock": 10,
  //   "precC": 17,
  //   "precV": 20,
  //   "codigo": 2147483647,
  //   "calificacion": 1,
  //   "foto": "http://localhost:9000/img/sticker.webp",
  //   "id_categoria": 1,
  //   "nom_categ": "default",
  //   "lover": 1
  // }

  int idproducto = 0;
  String nombre = "";
  String descripccion = "";
  int stock = 0;
  double precC = 0.0;
  double precV = 0.0;
  int codigo = 0;
  int calificacion = 0;
  String foto = "";
  int love = 0;
  Categoria categ = Categoria(0, "");

  //getters
  get getidpro => this.idproducto;
  get getname => this.nombre;
  get getdesc => this.descripccion;
  get getstock => this.stock;
  get getprecV => this.precV;
  get getprecC => this.precC;
  get getcodig => this.codigo;
  get getlcalif => this.calificacion;
  String get getfoto => this.foto;
  get getlove => this.love;
  Categoria get getcatego => this.categ;

  // setters
  set setidpro(int id) {
    idproducto = id;
  }

  set setname(String name) {
    nombre = name;
  }

  set setdesc(String desc) {
    descripccion = desc;
  }

  set setstock(int stock) {
    this.stock = stock;
  }

  set setprecV(double precv) {
    this.precV = precv;
  }

  set setprecC(double precC) {
    this.precC = precC;
  }

  set setcodig(int codig) {
    this.codigo = codig;
  }

  set setlcalif(int calif) {
    this.calificacion = calif;
  }

  set setfoto(String foto) {
    this.foto = foto;
  }

  set setlove(int love) {
    this.love = love;
  }

  set setcatego(Categoria catego) {
    this.categ = catego;
  }

  Producto(this.idproducto, this.nombre);

  Producto.fromJson(Map<String, dynamic> json) {
    idproducto = (json.containsKey("id_produc"))
        ? json['id_produc']
        : (json.containsKey("id_producto"))
            ? json['id_producto']
            : 0;
    nombre = (json.containsKey("nombre")) ? json['nombre'] : "";
    descripccion =
        (json.containsKey("descripccion")) ? json['descripccion'] : "";
    stock = (json.containsKey("stock")) ? json['stock'] : 0;
    precV = (json.containsKey("precV")) ? json['precV'] * 1.0 : 0.0;
    precC = (json.containsKey("precC")) ? json['precC'] * 1.0 : 0.0;
    codigo = (json.containsKey("codigo")) ? json['codigo'] : 0;
    calificacion =
        (json.containsKey("calificacion")) ? json['calificacion'] : 0;
    foto =
        (json.containsKey("foto")) ? validador().geturlimage(json['foto']) : "";
    love = (json.containsKey("lover")) ? json['lover'] : 0;

    // ingresar datos de la categoria
    categ = Categoria.fromJson({
      "id_categ": (json.containsKey("id_categoria")) ? json['id_categoria'] : 0,
      "nom_categ": (json.containsKey("nom_categ")) ? json['nom_categ'] : ""
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id_producto'] = idproducto;
    data['nombre'] = nombre;
    return data;
  }
}

//  {
//     "id_producto": 2,
//     "nombre": "chifles de tocino",
//     "descripccion": "chifles que saben a tocino",
//     "foto": "http://localhost:9000/img/sticker.webp",
//     "lover": 1,
//     "precV": 20
//   },