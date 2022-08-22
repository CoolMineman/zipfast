const std = @import("std");
const ld = @import("./libdeflate.zig");
const j = @import("./jni.zig");
const testing = std.testing;

fn long2ptr(comptime DestType: type, long: j.jlong) DestType {
    return @intToPtr(DestType, @intCast(usize, @bitCast(u64, long)));
}

fn ptr2long(ptr: anytype) j.jlong {
    return @bitCast(isize, @ptrToInt(ptr));
}

export fn Java_zipfast_Native_libdeflate_1inflater_1alloc0(env: *j.JNIEnv, cls: j.jclass) j.jlong {
    _ = cls;
    _ = env;
    return ptr2long(ld.libdeflate_alloc_decompressor());
}

export fn Java_zipfast_Native_libdeflate_1inflater_1free(env: *j.JNIEnv, cls: j.jclass, ptr: j.jlong) void {
    _ = env;
    _ = cls;
    ld.libdeflate_free_decompressor(long2ptr(*ld.struct_libdeflate_decompressor, ptr));
}

export fn Java_zipfast_Native_libdeflate_1inflate0(env: *j.JNIEnv, cls: j.jclass, deflater: j.jlong, src: j.jobject, src_start: j.jint, src_size: j.jint, dst: j.jobject, dst_pos: j.jint, dst_size: j.jint) j.jint {
    _ = cls;
    const deflater0 = long2ptr(*ld.struct_libdeflate_decompressor, deflater);
    const src0 = env.*.GetDirectBufferAddress(env, src) orelse return -1;
    var copy: j.jboolean = undefined;
    const dst0 = env.*.GetPrimitiveArrayCritical(env, dst, copy) orelse return -2;
    var actual_out_bytes: usize = 0;
    const r = @enumToInt(ld.libdeflate_deflate_decompress(deflater0, src0 + @intCast(usize, src_start), @intCast(usize, src_size), @ptrCast([*]u8, dst0) + @intCast(usize, dst_pos), @intCast(usize, dst_size), &actual_out_bytes));
    env.*.ReleasePrimitiveArrayCritical(env, dst, dst0, 0);
    return r;
}

