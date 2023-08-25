import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/modules/charge_screen/provider/upload.reciept.provider.dart';

final uploadRecieptProvider = StateNotifierProvider<UploadRecieptNotifier, String>((ref) {
  return UploadRecieptNotifier();
});
