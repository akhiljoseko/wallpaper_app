class BadRequestException implements Exception {
  BadRequestException([message]);
}

class UnauthorizedException implements Exception {
  UnauthorizedException([message]);
}

class NotFoundException implements Exception {
  NotFoundException([message]);
}

class InternalServerErrorException implements Exception {
  InternalServerErrorException([message]);
}

class NoInternetException implements Exception {
  NoInternetException([message]);
}
