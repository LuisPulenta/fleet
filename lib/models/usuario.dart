class Usuario {
  int? idUser = 0;
  String? codigo = '';
  String? apellidonombre = '';
  String? usrlogin = '';
  String? usrcontrasena = '';
  int? habilitadoWeb = 0;
  String? causanteC = '';

  Usuario(
      {required this.idUser,
      required this.codigo,
      required this.apellidonombre,
      required this.usrlogin,
      required this.usrcontrasena,
      required this.habilitadoWeb,
      required this.causanteC});

  Usuario.fromJson(Map<String, dynamic> json) {
    idUser = json['idUser'];
    codigo = json['codigo'];
    apellidonombre = json['apellidonombre'];
    usrlogin = json['usrlogin'];
    usrcontrasena = json['usrcontrasena'];
    habilitadoWeb = json['habilitadoWeb'];
    causanteC = json['causanteC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idUser'] = this.idUser;
    data['codigo'] = this.codigo;
    data['apellidonombre'] = this.apellidonombre;
    data['usrlogin'] = this.usrlogin;
    data['usrcontrasena'] = this.usrcontrasena;
    data['habilitadoWeb'] = this.habilitadoWeb;
    data['causanteC'] = this.causanteC;
    return data;
  }
}
