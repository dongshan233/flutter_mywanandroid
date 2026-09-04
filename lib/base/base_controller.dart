import 'package:get/state_manager.dart';

abstract class BaseController<D> extends GetxController with StateMixin<D> {
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  //子类必须重写
  Future<void> loadData();

  void setLoading() {
    change(null, status: RxStatus.loading());
  }

  void setSuccess(D data) {
    change(data, status: RxStatus.success());
  }

  void setError(String error) {
    change(null, status: RxStatus.error(error));
  }

  void setEmpty() {
    change(null, status: RxStatus.empty());
  }

  void retry() {
    loadData();
  }
}
