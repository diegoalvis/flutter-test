abstract class IdtError extends Error {

  IdtError(this.message, this.code);

  final String message;
  final int code;
}