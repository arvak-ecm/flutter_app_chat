import 'dart:io';

class Enviroment {
  static String apiPath = Platform.isAndroid
      ? 'https://localhost:3000/api'
      : 'https://localhost:3000/api';

  static String socketPath =
      Platform.isAndroid ? 'https://localhost:3000' : 'https://localhost:3000';


}
