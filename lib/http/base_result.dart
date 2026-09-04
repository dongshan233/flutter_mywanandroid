//响应结果基类
class BaseResult<T> {
  final int errorCode;
  final String errorMsg;
  final T? data;
  bool get isSuccess => errorCode == 0;

  //构造函数
  BaseResult({required this.errorCode, required this.errorMsg, this.data});
  //从Map创建实例
  factory BaseResult.fromMap(Map<String, dynamic> map) {
    return BaseResult(
      errorCode: map['errorCode'] ?? 0,
      errorMsg: map['errorMsg'] ?? '',
      data: map['data'],
    );
  }

  //转换为Map
  Map<String, dynamic> toMap() {
    return {'errorCode': errorCode, 'errorMsg': errorMsg, 'data': data};
  }

  @override
  String toString() {
    return 'BaseResult{errorCode:$errorCode,errorMsg:$errorMsg,data:$data}';
  }
}
