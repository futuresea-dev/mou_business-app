class ResourceType {
  static const int SUCCESS = 200;
  static const int DISCONNECT = -1;
  static const int NULL_DATA = 0;
  static const int ERROR_TOKEN = 401;
  static const int ERROR_VALIDATE = 422;
  static const int ERROR_SERVER = 500;

  static const int CONNECT_TIMEOUT = 1;
  static const int SEND_TIMEOUT = 2;
  static const int RECEIVE_TIMEOUT = 3;
  static const int CANCEL = 4;
}
