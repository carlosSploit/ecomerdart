class Usuario {
// id_usuario
// usser
// pass
// tipo_user
// estado

  int idusuario = 0;
  String usser = "";
  String pass = "";
  String tipouser = "";
  int estado = 0;
  //--------------------
  String nombre = "";
  int celular = 0;
  String foto = "";
  String correo = "";
  //--------------------

  get getidusua => this.idusuario;
  get getusser => this.usser;
  get getpass => this.pass;
  get gettipos => this.tipouser;
  get getestado => this.estado;
  //---------------------------
  get getnombre => this.nombre;
  get getcelula => this.celular;
  get getcorreo => this.correo;
  get getfoto => this.foto;
  //---------------------------

  // Usuario.fromJson(Map<String, dynamic> json) {
  //   //--------------------
  //   nombre = (json.containsKey('nombre')) ? json['nombre'] : "";
  //   celular = (json.containsKey('celular')) ? json['celular'] : 0;
  //   correo = (json.containsKey('correo')) ? json['correo'] : "";
  //   foto = (json.containsKey('foto')) ? json['foto'] : "";
  //   id_usuario = (json.containsKey('id_usuario')) ? json['id_usuario'] : 0;
  //   usser = (json.containsKey('usser')) ? json['usser'] : "";
  //   pass = (json.containsKey('pass')) ? json['pass'] : "";
  //   tipo_user = (json.containsKey('tipo_user')) ? json['tipo_user'] : "";
  //   estado = (json.containsKey('estado')) ? json['estado'] : 0;
  // }

  // Usuario(this.id_usuario, this.usser, this.pass, this.tipo_user, this.estado);

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['id_usuario'] = id_usuario;
  //   data['usser'] = usser;
  //   data['pass'] = pass;
  //   data['tipo_user'] = tipo_user;
  //   data['estado'] = estado;
  //   return data;
  // }
}

//  {
  //   "id_pedido": 4,
  //   "montoC": 220,
  //   "fecha": "2021-09-14T05:00:00.000Z",
  //   "estado_pedido": 2,
  //   "cantidadp": 1
  // }