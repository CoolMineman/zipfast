const c = @cImport(@cInclude("stdarg.h"));
const va_list = c.va_list;

pub const jint = i32;
pub const jlong = i64;
pub const jbyte = i8;
pub const jboolean = u8;
pub const jchar = u16;
pub const jshort = i16;
pub const jfloat = f32;
pub const jdouble = f64;
pub const jsize = jint;
pub const struct__jobject = opaque {};
pub const jobject = ?*struct__jobject;
pub const jclass = jobject;
pub const jthrowable = jobject;
pub const jstring = jobject;
pub const jarray = jobject;
pub const jbooleanArray = jarray;
pub const jbyteArray = jarray;
pub const jcharArray = jarray;
pub const jshortArray = jarray;
pub const jintArray = jarray;
pub const jlongArray = jarray;
pub const jfloatArray = jarray;
pub const jdoubleArray = jarray;
pub const jobjectArray = jarray;
pub const jweak = jobject;
pub const union_jvalue = extern union {
    z: jboolean,
    b: jbyte,
    c: jchar,
    s: jshort,
    i: jint,
    j: jlong,
    f: jfloat,
    d: jdouble,
    l: jobject,
};
pub const jvalue = union_jvalue;
pub const struct__jfieldID = opaque {};
pub const jfieldID = ?*struct__jfieldID;
pub const struct__jmethodID = opaque {};
pub const jmethodID = ?*struct__jmethodID;
pub const JNIInvalidRefType: c_int = 0;
pub const JNILocalRefType: c_int = 1;
pub const JNIGlobalRefType: c_int = 2;
pub const JNIWeakGlobalRefType: c_int = 3;
pub const enum__jobjectType = c_uint;
pub const jobjectRefType = enum__jobjectType;
pub const JNINativeMethod = extern struct {
    name: [*c]u8,
    signature: [*c]u8,
    fnPtr: ?*anyopaque,
};
pub const JNIEnv = *const struct_JNINativeInterface_;
pub const struct_JNIInvokeInterface_ = extern struct {
    reserved0: ?*anyopaque,
    reserved1: ?*anyopaque,
    reserved2: ?*anyopaque,
    DestroyJavaVM: ?fn ([*c]JavaVM) callconv(.C) jint,
    AttachCurrentThread: ?fn ([*c]JavaVM, [*c]?*anyopaque, ?*anyopaque) callconv(.C) jint,
    DetachCurrentThread: ?fn ([*c]JavaVM) callconv(.C) jint,
    GetEnv: ?fn ([*c]JavaVM, [*c]?*anyopaque, jint) callconv(.C) jint,
    AttachCurrentThreadAsDaemon: ?fn ([*c]JavaVM, [*c]?*anyopaque, ?*anyopaque) callconv(.C) jint,
};
pub const JavaVM = [*c]const struct_JNIInvokeInterface_;
pub const struct_JNINativeInterface_ = extern struct {
    reserved0: ?*anyopaque,
    reserved1: ?*anyopaque,
    reserved2: ?*anyopaque,
    reserved3: ?*anyopaque,
    GetVersion: ?fn ([*c]JNIEnv) callconv(.C) jint,
    DefineClass: ?fn ([*c]JNIEnv, [*c]const u8, jobject, [*c]const jbyte, jsize) callconv(.C) jclass,
    FindClass: ?fn ([*c]JNIEnv, [*c]const u8) callconv(.C) jclass,
    FromReflectedMethod: ?fn ([*c]JNIEnv, jobject) callconv(.C) jmethodID,
    FromReflectedField: ?fn ([*c]JNIEnv, jobject) callconv(.C) jfieldID,
    ToReflectedMethod: ?fn ([*c]JNIEnv, jclass, jmethodID, jboolean) callconv(.C) jobject,
    GetSuperclass: ?fn ([*c]JNIEnv, jclass) callconv(.C) jclass,
    IsAssignableFrom: ?fn ([*c]JNIEnv, jclass, jclass) callconv(.C) jboolean,
    ToReflectedField: ?fn ([*c]JNIEnv, jclass, jfieldID, jboolean) callconv(.C) jobject,
    Throw: ?fn ([*c]JNIEnv, jthrowable) callconv(.C) jint,
    ThrowNew: ?fn ([*c]JNIEnv, jclass, [*c]const u8) callconv(.C) jint,
    ExceptionOccurred: ?fn ([*c]JNIEnv) callconv(.C) jthrowable,
    ExceptionDescribe: ?fn ([*c]JNIEnv) callconv(.C) void,
    ExceptionClear: ?fn ([*c]JNIEnv) callconv(.C) void,
    FatalError: ?fn ([*c]JNIEnv, [*c]const u8) callconv(.C) void,
    PushLocalFrame: ?fn ([*c]JNIEnv, jint) callconv(.C) jint,
    PopLocalFrame: ?fn ([*c]JNIEnv, jobject) callconv(.C) jobject,
    NewGlobalRef: ?fn ([*c]JNIEnv, jobject) callconv(.C) jobject,
    DeleteGlobalRef: ?fn ([*c]JNIEnv, jobject) callconv(.C) void,
    DeleteLocalRef: ?fn ([*c]JNIEnv, jobject) callconv(.C) void,
    IsSameObject: ?fn ([*c]JNIEnv, jobject, jobject) callconv(.C) jboolean,
    NewLocalRef: ?fn ([*c]JNIEnv, jobject) callconv(.C) jobject,
    EnsureLocalCapacity: ?fn ([*c]JNIEnv, jint) callconv(.C) jint,
    AllocObject: ?fn ([*c]JNIEnv, jclass) callconv(.C) jobject,
    NewObject: ?fn ([*c]JNIEnv, jclass, jmethodID, ...) callconv(.C) jobject,
    NewObjectV: ?fn ([*c]JNIEnv, jclass, jmethodID, va_list) callconv(.C) jobject,
    NewObjectA: ?fn ([*c]JNIEnv, jclass, jmethodID, [*c]const jvalue) callconv(.C) jobject,
    GetObjectClass: ?fn ([*c]JNIEnv, jobject) callconv(.C) jclass,
    IsInstanceOf: ?fn ([*c]JNIEnv, jobject, jclass) callconv(.C) jboolean,
    GetMethodID: ?fn ([*c]JNIEnv, jclass, [*c]const u8, [*c]const u8) callconv(.C) jmethodID,
    CallObjectMethod: ?fn ([*c]JNIEnv, jobject, jmethodID, ...) callconv(.C) jobject,
    CallObjectMethodV: ?fn ([*c]JNIEnv, jobject, jmethodID, va_list) callconv(.C) jobject,
    CallObjectMethodA: ?fn ([*c]JNIEnv, jobject, jmethodID, [*c]const jvalue) callconv(.C) jobject,
    CallBooleanMethod: ?fn ([*c]JNIEnv, jobject, jmethodID, ...) callconv(.C) jboolean,
    CallBooleanMethodV: ?fn ([*c]JNIEnv, jobject, jmethodID, va_list) callconv(.C) jboolean,
    CallBooleanMethodA: ?fn ([*c]JNIEnv, jobject, jmethodID, [*c]const jvalue) callconv(.C) jboolean,
    CallByteMethod: ?fn ([*c]JNIEnv, jobject, jmethodID, ...) callconv(.C) jbyte,
    CallByteMethodV: ?fn ([*c]JNIEnv, jobject, jmethodID, va_list) callconv(.C) jbyte,
    CallByteMethodA: ?fn ([*c]JNIEnv, jobject, jmethodID, [*c]const jvalue) callconv(.C) jbyte,
    CallCharMethod: ?fn ([*c]JNIEnv, jobject, jmethodID, ...) callconv(.C) jchar,
    CallCharMethodV: ?fn ([*c]JNIEnv, jobject, jmethodID, va_list) callconv(.C) jchar,
    CallCharMethodA: ?fn ([*c]JNIEnv, jobject, jmethodID, [*c]const jvalue) callconv(.C) jchar,
    CallShortMethod: ?fn ([*c]JNIEnv, jobject, jmethodID, ...) callconv(.C) jshort,
    CallShortMethodV: ?fn ([*c]JNIEnv, jobject, jmethodID, va_list) callconv(.C) jshort,
    CallShortMethodA: ?fn ([*c]JNIEnv, jobject, jmethodID, [*c]const jvalue) callconv(.C) jshort,
    CallIntMethod: ?fn ([*c]JNIEnv, jobject, jmethodID, ...) callconv(.C) jint,
    CallIntMethodV: ?fn ([*c]JNIEnv, jobject, jmethodID, va_list) callconv(.C) jint,
    CallIntMethodA: ?fn ([*c]JNIEnv, jobject, jmethodID, [*c]const jvalue) callconv(.C) jint,
    CallLongMethod: ?fn ([*c]JNIEnv, jobject, jmethodID, ...) callconv(.C) jlong,
    CallLongMethodV: ?fn ([*c]JNIEnv, jobject, jmethodID, va_list) callconv(.C) jlong,
    CallLongMethodA: ?fn ([*c]JNIEnv, jobject, jmethodID, [*c]const jvalue) callconv(.C) jlong,
    CallFloatMethod: ?fn ([*c]JNIEnv, jobject, jmethodID, ...) callconv(.C) jfloat,
    CallFloatMethodV: ?fn ([*c]JNIEnv, jobject, jmethodID, va_list) callconv(.C) jfloat,
    CallFloatMethodA: ?fn ([*c]JNIEnv, jobject, jmethodID, [*c]const jvalue) callconv(.C) jfloat,
    CallDoubleMethod: ?fn ([*c]JNIEnv, jobject, jmethodID, ...) callconv(.C) jdouble,
    CallDoubleMethodV: ?fn ([*c]JNIEnv, jobject, jmethodID, va_list) callconv(.C) jdouble,
    CallDoubleMethodA: ?fn ([*c]JNIEnv, jobject, jmethodID, [*c]const jvalue) callconv(.C) jdouble,
    CallVoidMethod: ?fn ([*c]JNIEnv, jobject, jmethodID, ...) callconv(.C) void,
    CallVoidMethodV: ?fn ([*c]JNIEnv, jobject, jmethodID, va_list) callconv(.C) void,
    CallVoidMethodA: ?fn ([*c]JNIEnv, jobject, jmethodID, [*c]const jvalue) callconv(.C) void,
    CallNonvirtualObjectMethod: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, ...) callconv(.C) jobject,
    CallNonvirtualObjectMethodV: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, va_list) callconv(.C) jobject,
    CallNonvirtualObjectMethodA: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, [*c]const jvalue) callconv(.C) jobject,
    CallNonvirtualBooleanMethod: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, ...) callconv(.C) jboolean,
    CallNonvirtualBooleanMethodV: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, va_list) callconv(.C) jboolean,
    CallNonvirtualBooleanMethodA: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, [*c]const jvalue) callconv(.C) jboolean,
    CallNonvirtualByteMethod: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, ...) callconv(.C) jbyte,
    CallNonvirtualByteMethodV: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, va_list) callconv(.C) jbyte,
    CallNonvirtualByteMethodA: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, [*c]const jvalue) callconv(.C) jbyte,
    CallNonvirtualCharMethod: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, ...) callconv(.C) jchar,
    CallNonvirtualCharMethodV: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, va_list) callconv(.C) jchar,
    CallNonvirtualCharMethodA: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, [*c]const jvalue) callconv(.C) jchar,
    CallNonvirtualShortMethod: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, ...) callconv(.C) jshort,
    CallNonvirtualShortMethodV: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, va_list) callconv(.C) jshort,
    CallNonvirtualShortMethodA: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, [*c]const jvalue) callconv(.C) jshort,
    CallNonvirtualIntMethod: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, ...) callconv(.C) jint,
    CallNonvirtualIntMethodV: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, va_list) callconv(.C) jint,
    CallNonvirtualIntMethodA: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, [*c]const jvalue) callconv(.C) jint,
    CallNonvirtualLongMethod: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, ...) callconv(.C) jlong,
    CallNonvirtualLongMethodV: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, va_list) callconv(.C) jlong,
    CallNonvirtualLongMethodA: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, [*c]const jvalue) callconv(.C) jlong,
    CallNonvirtualFloatMethod: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, ...) callconv(.C) jfloat,
    CallNonvirtualFloatMethodV: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, va_list) callconv(.C) jfloat,
    CallNonvirtualFloatMethodA: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, [*c]const jvalue) callconv(.C) jfloat,
    CallNonvirtualDoubleMethod: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, ...) callconv(.C) jdouble,
    CallNonvirtualDoubleMethodV: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, va_list) callconv(.C) jdouble,
    CallNonvirtualDoubleMethodA: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, [*c]const jvalue) callconv(.C) jdouble,
    CallNonvirtualVoidMethod: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, ...) callconv(.C) void,
    CallNonvirtualVoidMethodV: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, va_list) callconv(.C) void,
    CallNonvirtualVoidMethodA: ?fn ([*c]JNIEnv, jobject, jclass, jmethodID, [*c]const jvalue) callconv(.C) void,
    GetFieldID: ?fn ([*c]JNIEnv, jclass, [*c]const u8, [*c]const u8) callconv(.C) jfieldID,
    GetObjectField: ?fn ([*c]JNIEnv, jobject, jfieldID) callconv(.C) jobject,
    GetBooleanField: ?fn ([*c]JNIEnv, jobject, jfieldID) callconv(.C) jboolean,
    GetByteField: ?fn ([*c]JNIEnv, jobject, jfieldID) callconv(.C) jbyte,
    GetCharField: ?fn ([*c]JNIEnv, jobject, jfieldID) callconv(.C) jchar,
    GetShortField: ?fn ([*c]JNIEnv, jobject, jfieldID) callconv(.C) jshort,
    GetIntField: ?fn ([*c]JNIEnv, jobject, jfieldID) callconv(.C) jint,
    GetLongField: ?fn ([*c]JNIEnv, jobject, jfieldID) callconv(.C) jlong,
    GetFloatField: ?fn ([*c]JNIEnv, jobject, jfieldID) callconv(.C) jfloat,
    GetDoubleField: ?fn ([*c]JNIEnv, jobject, jfieldID) callconv(.C) jdouble,
    SetObjectField: ?fn ([*c]JNIEnv, jobject, jfieldID, jobject) callconv(.C) void,
    SetBooleanField: ?fn ([*c]JNIEnv, jobject, jfieldID, jboolean) callconv(.C) void,
    SetByteField: ?fn ([*c]JNIEnv, jobject, jfieldID, jbyte) callconv(.C) void,
    SetCharField: ?fn ([*c]JNIEnv, jobject, jfieldID, jchar) callconv(.C) void,
    SetShortField: ?fn ([*c]JNIEnv, jobject, jfieldID, jshort) callconv(.C) void,
    SetIntField: ?fn ([*c]JNIEnv, jobject, jfieldID, jint) callconv(.C) void,
    SetLongField: ?fn ([*c]JNIEnv, jobject, jfieldID, jlong) callconv(.C) void,
    SetFloatField: ?fn ([*c]JNIEnv, jobject, jfieldID, jfloat) callconv(.C) void,
    SetDoubleField: ?fn ([*c]JNIEnv, jobject, jfieldID, jdouble) callconv(.C) void,
    GetStaticMethodID: ?fn ([*c]JNIEnv, jclass, [*c]const u8, [*c]const u8) callconv(.C) jmethodID,
    CallStaticObjectMethod: ?fn ([*c]JNIEnv, jclass, jmethodID, ...) callconv(.C) jobject,
    CallStaticObjectMethodV: ?fn ([*c]JNIEnv, jclass, jmethodID, va_list) callconv(.C) jobject,
    CallStaticObjectMethodA: ?fn ([*c]JNIEnv, jclass, jmethodID, [*c]const jvalue) callconv(.C) jobject,
    CallStaticBooleanMethod: ?fn ([*c]JNIEnv, jclass, jmethodID, ...) callconv(.C) jboolean,
    CallStaticBooleanMethodV: ?fn ([*c]JNIEnv, jclass, jmethodID, va_list) callconv(.C) jboolean,
    CallStaticBooleanMethodA: ?fn ([*c]JNIEnv, jclass, jmethodID, [*c]const jvalue) callconv(.C) jboolean,
    CallStaticByteMethod: ?fn ([*c]JNIEnv, jclass, jmethodID, ...) callconv(.C) jbyte,
    CallStaticByteMethodV: ?fn ([*c]JNIEnv, jclass, jmethodID, va_list) callconv(.C) jbyte,
    CallStaticByteMethodA: ?fn ([*c]JNIEnv, jclass, jmethodID, [*c]const jvalue) callconv(.C) jbyte,
    CallStaticCharMethod: ?fn ([*c]JNIEnv, jclass, jmethodID, ...) callconv(.C) jchar,
    CallStaticCharMethodV: ?fn ([*c]JNIEnv, jclass, jmethodID, va_list) callconv(.C) jchar,
    CallStaticCharMethodA: ?fn ([*c]JNIEnv, jclass, jmethodID, [*c]const jvalue) callconv(.C) jchar,
    CallStaticShortMethod: ?fn ([*c]JNIEnv, jclass, jmethodID, ...) callconv(.C) jshort,
    CallStaticShortMethodV: ?fn ([*c]JNIEnv, jclass, jmethodID, va_list) callconv(.C) jshort,
    CallStaticShortMethodA: ?fn ([*c]JNIEnv, jclass, jmethodID, [*c]const jvalue) callconv(.C) jshort,
    CallStaticIntMethod: ?fn ([*c]JNIEnv, jclass, jmethodID, ...) callconv(.C) jint,
    CallStaticIntMethodV: ?fn ([*c]JNIEnv, jclass, jmethodID, va_list) callconv(.C) jint,
    CallStaticIntMethodA: ?fn ([*c]JNIEnv, jclass, jmethodID, [*c]const jvalue) callconv(.C) jint,
    CallStaticLongMethod: ?fn ([*c]JNIEnv, jclass, jmethodID, ...) callconv(.C) jlong,
    CallStaticLongMethodV: ?fn ([*c]JNIEnv, jclass, jmethodID, va_list) callconv(.C) jlong,
    CallStaticLongMethodA: ?fn ([*c]JNIEnv, jclass, jmethodID, [*c]const jvalue) callconv(.C) jlong,
    CallStaticFloatMethod: ?fn ([*c]JNIEnv, jclass, jmethodID, ...) callconv(.C) jfloat,
    CallStaticFloatMethodV: ?fn ([*c]JNIEnv, jclass, jmethodID, va_list) callconv(.C) jfloat,
    CallStaticFloatMethodA: ?fn ([*c]JNIEnv, jclass, jmethodID, [*c]const jvalue) callconv(.C) jfloat,
    CallStaticDoubleMethod: ?fn ([*c]JNIEnv, jclass, jmethodID, ...) callconv(.C) jdouble,
    CallStaticDoubleMethodV: ?fn ([*c]JNIEnv, jclass, jmethodID, va_list) callconv(.C) jdouble,
    CallStaticDoubleMethodA: ?fn ([*c]JNIEnv, jclass, jmethodID, [*c]const jvalue) callconv(.C) jdouble,
    CallStaticVoidMethod: ?fn ([*c]JNIEnv, jclass, jmethodID, ...) callconv(.C) void,
    CallStaticVoidMethodV: ?fn ([*c]JNIEnv, jclass, jmethodID, va_list) callconv(.C) void,
    CallStaticVoidMethodA: ?fn ([*c]JNIEnv, jclass, jmethodID, [*c]const jvalue) callconv(.C) void,
    GetStaticFieldID: ?fn ([*c]JNIEnv, jclass, [*c]const u8, [*c]const u8) callconv(.C) jfieldID,
    GetStaticObjectField: ?fn ([*c]JNIEnv, jclass, jfieldID) callconv(.C) jobject,
    GetStaticBooleanField: ?fn ([*c]JNIEnv, jclass, jfieldID) callconv(.C) jboolean,
    GetStaticByteField: ?fn ([*c]JNIEnv, jclass, jfieldID) callconv(.C) jbyte,
    GetStaticCharField: ?fn ([*c]JNIEnv, jclass, jfieldID) callconv(.C) jchar,
    GetStaticShortField: ?fn ([*c]JNIEnv, jclass, jfieldID) callconv(.C) jshort,
    GetStaticIntField: ?fn ([*c]JNIEnv, jclass, jfieldID) callconv(.C) jint,
    GetStaticLongField: ?fn ([*c]JNIEnv, jclass, jfieldID) callconv(.C) jlong,
    GetStaticFloatField: ?fn ([*c]JNIEnv, jclass, jfieldID) callconv(.C) jfloat,
    GetStaticDoubleField: ?fn ([*c]JNIEnv, jclass, jfieldID) callconv(.C) jdouble,
    SetStaticObjectField: ?fn ([*c]JNIEnv, jclass, jfieldID, jobject) callconv(.C) void,
    SetStaticBooleanField: ?fn ([*c]JNIEnv, jclass, jfieldID, jboolean) callconv(.C) void,
    SetStaticByteField: ?fn ([*c]JNIEnv, jclass, jfieldID, jbyte) callconv(.C) void,
    SetStaticCharField: ?fn ([*c]JNIEnv, jclass, jfieldID, jchar) callconv(.C) void,
    SetStaticShortField: ?fn ([*c]JNIEnv, jclass, jfieldID, jshort) callconv(.C) void,
    SetStaticIntField: ?fn ([*c]JNIEnv, jclass, jfieldID, jint) callconv(.C) void,
    SetStaticLongField: ?fn ([*c]JNIEnv, jclass, jfieldID, jlong) callconv(.C) void,
    SetStaticFloatField: ?fn ([*c]JNIEnv, jclass, jfieldID, jfloat) callconv(.C) void,
    SetStaticDoubleField: ?fn ([*c]JNIEnv, jclass, jfieldID, jdouble) callconv(.C) void,
    NewString: ?fn ([*c]JNIEnv, [*c]const jchar, jsize) callconv(.C) jstring,
    GetStringLength: ?fn ([*c]JNIEnv, jstring) callconv(.C) jsize,
    GetStringChars: ?fn ([*c]JNIEnv, jstring, [*c]jboolean) callconv(.C) [*c]const jchar,
    ReleaseStringChars: ?fn ([*c]JNIEnv, jstring, [*c]const jchar) callconv(.C) void,
    NewStringUTF: ?fn ([*c]JNIEnv, [*c]const u8) callconv(.C) jstring,
    GetStringUTFLength: ?fn ([*c]JNIEnv, jstring) callconv(.C) jsize,
    GetStringUTFChars: ?fn ([*c]JNIEnv, jstring, [*c]jboolean) callconv(.C) [*c]const u8,
    ReleaseStringUTFChars: ?fn ([*c]JNIEnv, jstring, [*c]const u8) callconv(.C) void,
    GetArrayLength: ?fn ([*c]JNIEnv, jarray) callconv(.C) jsize,
    NewObjectArray: ?fn ([*c]JNIEnv, jsize, jclass, jobject) callconv(.C) jobjectArray,
    GetObjectArrayElement: ?fn ([*c]JNIEnv, jobjectArray, jsize) callconv(.C) jobject,
    SetObjectArrayElement: ?fn ([*c]JNIEnv, jobjectArray, jsize, jobject) callconv(.C) void,
    NewBooleanArray: ?fn ([*c]JNIEnv, jsize) callconv(.C) jbooleanArray,
    NewByteArray: ?fn ([*c]JNIEnv, jsize) callconv(.C) jbyteArray,
    NewCharArray: ?fn ([*c]JNIEnv, jsize) callconv(.C) jcharArray,
    NewShortArray: ?fn ([*c]JNIEnv, jsize) callconv(.C) jshortArray,
    NewIntArray: ?fn ([*c]JNIEnv, jsize) callconv(.C) jintArray,
    NewLongArray: ?fn ([*c]JNIEnv, jsize) callconv(.C) jlongArray,
    NewFloatArray: ?fn ([*c]JNIEnv, jsize) callconv(.C) jfloatArray,
    NewDoubleArray: ?fn ([*c]JNIEnv, jsize) callconv(.C) jdoubleArray,
    GetBooleanArrayElements: ?fn ([*c]JNIEnv, jbooleanArray, [*c]jboolean) callconv(.C) [*c]jboolean,
    GetByteArrayElements: ?fn ([*c]JNIEnv, jbyteArray, [*c]jboolean) callconv(.C) [*c]jbyte,
    GetCharArrayElements: ?fn ([*c]JNIEnv, jcharArray, [*c]jboolean) callconv(.C) [*c]jchar,
    GetShortArrayElements: ?fn ([*c]JNIEnv, jshortArray, [*c]jboolean) callconv(.C) [*c]jshort,
    GetIntArrayElements: ?fn ([*c]JNIEnv, jintArray, [*c]jboolean) callconv(.C) [*c]jint,
    GetLongArrayElements: ?fn ([*c]JNIEnv, jlongArray, [*c]jboolean) callconv(.C) [*c]jlong,
    GetFloatArrayElements: ?fn ([*c]JNIEnv, jfloatArray, [*c]jboolean) callconv(.C) [*c]jfloat,
    GetDoubleArrayElements: ?fn ([*c]JNIEnv, jdoubleArray, [*c]jboolean) callconv(.C) [*c]jdouble,
    ReleaseBooleanArrayElements: ?fn ([*c]JNIEnv, jbooleanArray, [*c]jboolean, jint) callconv(.C) void,
    ReleaseByteArrayElements: ?fn ([*c]JNIEnv, jbyteArray, [*c]jbyte, jint) callconv(.C) void,
    ReleaseCharArrayElements: ?fn ([*c]JNIEnv, jcharArray, [*c]jchar, jint) callconv(.C) void,
    ReleaseShortArrayElements: ?fn ([*c]JNIEnv, jshortArray, [*c]jshort, jint) callconv(.C) void,
    ReleaseIntArrayElements: ?fn ([*c]JNIEnv, jintArray, [*c]jint, jint) callconv(.C) void,
    ReleaseLongArrayElements: ?fn ([*c]JNIEnv, jlongArray, [*c]jlong, jint) callconv(.C) void,
    ReleaseFloatArrayElements: ?fn ([*c]JNIEnv, jfloatArray, [*c]jfloat, jint) callconv(.C) void,
    ReleaseDoubleArrayElements: ?fn ([*c]JNIEnv, jdoubleArray, [*c]jdouble, jint) callconv(.C) void,
    GetBooleanArrayRegion: ?fn ([*c]JNIEnv, jbooleanArray, jsize, jsize, [*c]jboolean) callconv(.C) void,
    GetByteArrayRegion: ?fn ([*c]JNIEnv, jbyteArray, jsize, jsize, [*c]jbyte) callconv(.C) void,
    GetCharArrayRegion: ?fn ([*c]JNIEnv, jcharArray, jsize, jsize, [*c]jchar) callconv(.C) void,
    GetShortArrayRegion: ?fn ([*c]JNIEnv, jshortArray, jsize, jsize, [*c]jshort) callconv(.C) void,
    GetIntArrayRegion: ?fn ([*c]JNIEnv, jintArray, jsize, jsize, [*c]jint) callconv(.C) void,
    GetLongArrayRegion: ?fn ([*c]JNIEnv, jlongArray, jsize, jsize, [*c]jlong) callconv(.C) void,
    GetFloatArrayRegion: ?fn ([*c]JNIEnv, jfloatArray, jsize, jsize, [*c]jfloat) callconv(.C) void,
    GetDoubleArrayRegion: ?fn ([*c]JNIEnv, jdoubleArray, jsize, jsize, [*c]jdouble) callconv(.C) void,
    SetBooleanArrayRegion: ?fn ([*c]JNIEnv, jbooleanArray, jsize, jsize, [*c]const jboolean) callconv(.C) void,
    SetByteArrayRegion: ?fn ([*c]JNIEnv, jbyteArray, jsize, jsize, [*c]const jbyte) callconv(.C) void,
    SetCharArrayRegion: ?fn ([*c]JNIEnv, jcharArray, jsize, jsize, [*c]const jchar) callconv(.C) void,
    SetShortArrayRegion: ?fn ([*c]JNIEnv, jshortArray, jsize, jsize, [*c]const jshort) callconv(.C) void,
    SetIntArrayRegion: ?fn ([*c]JNIEnv, jintArray, jsize, jsize, [*c]const jint) callconv(.C) void,
    SetLongArrayRegion: ?fn ([*c]JNIEnv, jlongArray, jsize, jsize, [*c]const jlong) callconv(.C) void,
    SetFloatArrayRegion: ?fn ([*c]JNIEnv, jfloatArray, jsize, jsize, [*c]const jfloat) callconv(.C) void,
    SetDoubleArrayRegion: ?fn ([*c]JNIEnv, jdoubleArray, jsize, jsize, [*c]const jdouble) callconv(.C) void,
    RegisterNatives: ?fn ([*c]JNIEnv, jclass, [*c]const JNINativeMethod, jint) callconv(.C) jint,
    UnregisterNatives: ?fn ([*c]JNIEnv, jclass) callconv(.C) jint,
    MonitorEnter: ?fn ([*c]JNIEnv, jobject) callconv(.C) jint,
    MonitorExit: ?fn ([*c]JNIEnv, jobject) callconv(.C) jint,
    GetJavaVM: ?fn ([*c]JNIEnv, [*c][*c]JavaVM) callconv(.C) jint,
    GetStringRegion: ?fn ([*c]JNIEnv, jstring, jsize, jsize, [*c]jchar) callconv(.C) void,
    GetStringUTFRegion: ?fn ([*c]JNIEnv, jstring, jsize, jsize, [*c]u8) callconv(.C) void,
    GetPrimitiveArrayCritical: fn ([*c]JNIEnv, jarray, [*c]jboolean) callconv(.C) ?*anyopaque,
    ReleasePrimitiveArrayCritical: fn ([*c]JNIEnv, jarray, ?*anyopaque, jint) callconv(.C) void,
    GetStringCritical: ?fn ([*c]JNIEnv, jstring, [*c]jboolean) callconv(.C) [*c]const jchar,
    ReleaseStringCritical: ?fn ([*c]JNIEnv, jstring, [*c]const jchar) callconv(.C) void,
    NewWeakGlobalRef: ?fn ([*c]JNIEnv, jobject) callconv(.C) jweak,
    DeleteWeakGlobalRef: ?fn ([*c]JNIEnv, jweak) callconv(.C) void,
    ExceptionCheck: ?fn ([*c]JNIEnv) callconv(.C) jboolean,
    NewDirectByteBuffer: ?fn ([*c]JNIEnv, ?*anyopaque, jlong) callconv(.C) jobject,
    GetDirectBufferAddress: fn ([*c]JNIEnv, jobject) callconv(.C) ?[*]u8,
    GetDirectBufferCapacity: ?fn ([*c]JNIEnv, jobject) callconv(.C) jlong,
    GetObjectRefType: ?fn ([*c]JNIEnv, jobject) callconv(.C) jobjectRefType,
    GetModule: ?fn ([*c]JNIEnv, jclass) callconv(.C) jobject,
};
pub const struct_JNIEnv_ = extern struct {
    functions: [*c]const struct_JNINativeInterface_,
};
pub const struct_JavaVM_ = extern struct {
    functions: [*c]const struct_JNIInvokeInterface_,
};
pub const struct_JavaVMOption = extern struct {
    optionString: [*c]u8,
    extraInfo: ?*anyopaque,
};
pub const JavaVMOption = struct_JavaVMOption;
pub const struct_JavaVMInitArgs = extern struct {
    version: jint,
    nOptions: jint,
    options: [*c]JavaVMOption,
    ignoreUnrecognized: jboolean,
};
pub const JavaVMInitArgs = struct_JavaVMInitArgs;
pub const struct_JavaVMAttachArgs = extern struct {
    version: jint,
    name: [*c]u8,
    group: jobject,
};
pub const JavaVMAttachArgs = struct_JavaVMAttachArgs;
pub extern fn JNI_GetDefaultJavaVMInitArgs(args: ?*anyopaque) jint;
pub extern fn JNI_CreateJavaVM(pvm: [*c][*c]JavaVM, penv: [*c]?*anyopaque, args: ?*anyopaque) jint;
pub extern fn JNI_GetCreatedJavaVMs([*c][*c]JavaVM, jsize, [*c]jsize) jint;
pub extern fn JNI_OnLoad(vm: [*c]JavaVM, reserved: ?*anyopaque) jint;
pub extern fn JNI_OnUnload(vm: [*c]JavaVM, reserved: ?*anyopaque) void;
