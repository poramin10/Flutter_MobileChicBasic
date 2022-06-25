//! 1. success => api ที่ยิงไปทำงานสำเร็จหรือไม่
//! 2. message => ข้อความการทำงานของ api
//! 3. traceId => traceId ของการรัน api
//! 4. data => ข้อมูลที่ได้จากการยิง api

class Result<T> {
  bool? success = false;
  String? message;
  String? traceId;
  T data;

  Result(
    this.success,
    this.message,
    this.traceId,
    this.data
  );
}