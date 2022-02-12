/// Custom [Exception] made to throw when the API returned a error of BAD_REQUEST
class BadRequestException implements Exception {
  BadRequestException([message]);
}

/// Custom [Exception] made to throw when the API returned a error of AUTHORIZATION
class UnauthorizedException implements Exception {
  UnauthorizedException([message]);
}

/// Custom [Exception] made to throw when the API returned a error of NOT_FOUND
class NotFoundException implements Exception {
  NotFoundException([message]);
}

/// Custom [Exception] made to throw when the API returned a error of INTERNAL_SERVER
class InternalServerErrorException implements Exception {
  InternalServerErrorException([message]);
}

/// Custom [Exception] made to throw when the system detect a error of NO_INTERNET
class NoInternetException implements Exception {
  NoInternetException([message]);
}
