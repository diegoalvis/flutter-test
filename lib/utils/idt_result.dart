import 'package:bogota_app/utils/idt_error.dart';

abstract class IdtResult <T>{

  factory IdtResult.success(T body){
    return IdtSuccess(body);
  }

  factory IdtResult.failure(IdtError error){
    return IdtFailure(cause: error);
  }

  IdtResult();
}

class IdtSuccess <T> extends IdtResult<T> {

  IdtSuccess(this.body);

  final T body;
}

class IdtFailure<T> extends IdtResult<T> {

  IdtFailure({required this.cause});

  final IdtError cause;

  String get message {
    return cause.message;
  }

  int get code {
    return cause.code;
  }
}