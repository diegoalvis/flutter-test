import 'package:bogota_app/view_model.dart';

class RecoverPassStatus extends ViewStatus {
  final bool isLoading;

  RecoverPassStatus({
    required this.isLoading,
  });

  RecoverPassStatus copyWith({
    bool? isLoading,
  }) {
    return RecoverPassStatus(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
