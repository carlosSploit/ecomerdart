class Categoria {
  int id = 0;
  String nameCat = "";

  get getidcar => this.id;
  get getname => this.nameCat;

  Categoria(this.id, this.nameCat);

  Categoria.fromJson(Map<String, dynamic> json) {
    id = (json.containsKey('id_categ')) ? json['id_categ'] : 0;
    nameCat = (json.containsKey('nom_categ')) ? json['nom_categ'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id_categ'] = id;
    data['id_categ'] = nameCat;
    return data;
  }
}
