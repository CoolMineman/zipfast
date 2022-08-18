pub const alloc_func = ?fn (?*anyopaque, c_uint, c_uint) callconv(.C) ?*anyopaque;
pub const free_func = ?fn (?*anyopaque, ?*anyopaque) callconv(.C) void;
pub const struct_internal_state = opaque {};
pub const struct_zng_stream_s = extern struct {
    next_in: [*]const u8,
    avail_in: u32,
    total_in: usize,
    next_out: *u8,
    avail_out: u32,
    total_out: usize,
    msg: ?[*:0]const u8,
    state: ?*struct_internal_state,
    zalloc: alloc_func,
    zfree: free_func,
    @"opaque": ?*anyopaque,
    data_type: c_int,
    adler: u32,
    reserved: c_ulong,
};
pub const zng_stream = struct_zng_stream_s;
pub const zng_streamp = *zng_stream;
pub const struct_zng_gz_header_s = extern struct {
    text: i32,
    time: c_ulong,
    xflags: i32,
    os: i32,
    extra: ?[*]u8,
    extra_len: u32,
    extra_max: u32,
    name: ?[*:0]u8,
    name_max: u32,
    comment: ?[*:0]u8,
    comm_max: u32,
    hcrc: i32,
    done: i32,
};
pub const zng_gz_header = struct_zng_gz_header_s;
pub const zng_gz_headerp = *zng_gz_header;
pub extern fn zlibng_version() [*c]const u8;
pub extern fn zng_deflateInit(strm: *zng_stream, level: i32) i32;
pub extern fn zng_deflate(strm: *zng_stream, flush: i32) i32;
pub extern fn zng_deflateEnd(strm: *zng_stream) i32;
pub extern fn zng_inflateInit(strm: *zng_stream) i32;
pub extern fn zng_inflate(strm: *zng_stream, flush: i32) i32;
pub extern fn zng_inflateEnd(strm: *zng_stream) i32;
pub extern fn zng_deflateInit2(strm: *zng_stream, level: i32, method: i32, windowBits: i32, memLevel: i32, strategy: i32) i32;
pub extern fn zng_deflateSetDictionary(strm: *zng_stream, dictionary: [*]const u8, dictLength: u32) i32;
pub extern fn zng_deflateGetDictionary(strm: *zng_stream, dictionary: [*c]u8, dictLength: [*c]u32) i32;
pub extern fn zng_deflateCopy(dest: *zng_stream, source: *zng_stream) i32;
pub extern fn zng_deflateReset(strm: *zng_stream) i32;
pub extern fn zng_deflateParams(strm: *zng_stream, level: i32, strategy: i32) i32;
pub extern fn zng_deflateTune(strm: *zng_stream, good_length: i32, max_lazy: i32, nice_length: i32, max_chain: i32) i32;
pub extern fn zng_deflateBound(strm: *zng_stream, sourceLen: c_ulong) c_ulong;
pub extern fn zng_deflatePending(strm: *zng_stream, pending: [*c]u32, bits: [*c]i32) i32;
pub extern fn zng_deflatePrime(strm: *zng_stream, bits: i32, value: i32) i32;
pub extern fn zng_deflateSetHeader(strm: *zng_stream, head: zng_gz_headerp) i32;
pub extern fn zng_inflateInit2(strm: *zng_stream, windowBits: i32) i32;
pub extern fn zng_inflateSetDictionary(strm: *zng_stream, dictionary: [*c]const u8, dictLength: u32) i32;
pub extern fn zng_inflateGetDictionary(strm: *zng_stream, dictionary: [*c]u8, dictLength: [*c]u32) i32;
pub extern fn zng_inflateSync(strm: *zng_stream) i32;
pub extern fn zng_inflateCopy(dest: *zng_stream, source: *zng_stream) i32;
pub extern fn zng_inflateReset(strm: *zng_stream) i32;
pub extern fn zng_inflateReset2(strm: *zng_stream, windowBits: i32) i32;
pub extern fn zng_inflatePrime(strm: *zng_stream, bits: i32, value: i32) i32;
pub extern fn zng_inflateMark(strm: *zng_stream) c_long;
pub extern fn zng_inflateGetHeader(strm: *zng_stream, head: zng_gz_headerp) i32;
pub extern fn zng_inflateBackInit(strm: *zng_stream, windowBits: i32, window: [*c]u8) i32;
pub const in_func = ?fn (?*anyopaque, [*c][*c]const u8) callconv(.C) u32;
pub const out_func = ?fn (?*anyopaque, [*c]u8, u32) callconv(.C) i32;
pub extern fn zng_inflateBack(strm: *zng_stream, in: in_func, in_desc: ?*anyopaque, out: out_func, out_desc: ?*anyopaque) i32;
pub extern fn zng_inflateBackEnd(strm: *zng_stream) i32;
pub extern fn zng_zlibCompileFlags() c_ulong;
pub extern fn zng_compress(dest: [*c]u8, destLen: [*c]usize, source: [*c]const u8, sourceLen: usize) i32;
pub extern fn zng_compress2(dest: [*c]u8, destLen: [*c]usize, source: [*c]const u8, sourceLen: usize, level: i32) i32;
pub extern fn zng_compressBound(sourceLen: usize) usize;
pub extern fn zng_uncompress(dest: [*c]u8, destLen: [*c]usize, source: [*c]const u8, sourceLen: usize) i32;
pub extern fn zng_uncompress2(dest: [*c]u8, destLen: [*c]usize, source: [*c]const u8, sourceLen: [*c]usize) i32;
pub extern fn zng_adler32(adler: u32, buf: [*c]const u8, len: u32) u32;
pub extern fn zng_adler32_z(adler: u32, buf: [*c]const u8, len: usize) u32;
pub extern fn zng_adler32_combine(adler1: u32, adler2: u32, len2: off_t) u32;
pub extern fn zng_crc32(crc: u32, buf: [*c]const u8, len: u32) u32;
pub extern fn zng_crc32_z(crc: u32, buf: [*c]const u8, len: usize) u32;
pub extern fn zng_crc32_combine(crc1: u32, crc2: u32, len2: off_t) u32;
pub extern fn zng_crc32_combine_gen(len2: off_t) u32;
pub extern fn zng_crc32_combine_op(crc1: u32, crc2: u32, op: u32) u32;
pub const Z_DEFLATE_LEVEL: c_int = 0;
pub const Z_DEFLATE_STRATEGY: c_int = 1;
pub const Z_DEFLATE_REPRODUCIBLE: c_int = 2;
pub const zng_deflate_param = c_uint;
pub const zng_deflate_param_value = extern struct {
    param: zng_deflate_param,
    buf: ?*anyopaque,
    size: usize,
    status: i32,
};
pub extern fn zng_deflateSetParams(strm: *zng_stream, params: [*c]zng_deflate_param_value, count: usize) i32;
pub extern fn zng_deflateGetParams(strm: *zng_stream, params: [*c]zng_deflate_param_value, count: usize) i32;
pub extern fn zng_zError(i32) [*c]const u8;
pub extern fn zng_inflateSyncPoint(*zng_stream) i32;
pub extern fn zng_get_crc_table() [*c]const u32;
pub extern fn zng_inflateUndermine(*zng_stream, i32) i32;
pub extern fn zng_inflateValidate(*zng_stream, i32) i32;
pub extern fn zng_inflateCodesUsed(*zng_stream) c_ulong;
pub extern fn zng_inflateResetKeep(*zng_stream) i32;
pub extern fn zng_deflateResetKeep(*zng_stream) i32;