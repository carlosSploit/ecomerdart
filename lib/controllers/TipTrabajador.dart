class TipTrabajador {
  int idtiptrabajador = 0;
  String nombtipo = "";

  get getidtrab => this.idtiptrabajador;
  get getnomtip => this.nombtipo;

  TipTrabajador(this.idtiptrabajador, this.nombtipo);

  TipTrabajador.fromJson(Map<String, dynamic> json) {
    idtiptrabajador =
        (json.containsKey("id_tiptrabajador")) ? json['id_tiptrabajador'] : 0;
    nombtipo = (json.containsKey("nomb_tipo"))
        ? json['nomb_tipo']
        : (json.containsKey("nametipo"))
            ? json['nametipo']
            : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id_tiptrabajador'] = idtiptrabajador;
    data['nomb_tipo'] = nombtipo;
    return data;
  }
}
