abstract class Failure {
  final String message;
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Error de red']);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Error del servidor']);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'No encontrado']);
}

class InconsistentDataFailure extends Failure {
  const InconsistentDataFailure([super.message = 'Datos inconsistentes']);
}