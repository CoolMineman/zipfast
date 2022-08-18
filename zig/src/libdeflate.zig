pub const struct_libdeflate_compressor = opaque {};
pub extern fn libdeflate_alloc_compressor(compression_level: c_int) ?*struct_libdeflate_compressor;
pub extern fn libdeflate_deflate_compress(compressor: *struct_libdeflate_compressor, in: [*]const u8, in_nbytes: usize, out: [*]u8, out_nbytes_avail: usize) usize;
pub extern fn libdeflate_deflate_compress_bound(compressor: *struct_libdeflate_compressor, in_nbytes: usize) usize;
pub extern fn libdeflate_zlib_compress(compressor: *struct_libdeflate_compressor, in: [*]const u8, in_nbytes: usize, out: [*]u8, out_nbytes_avail: usize) usize;
pub extern fn libdeflate_zlib_compress_bound(compressor: *struct_libdeflate_compressor, in_nbytes: usize) usize;
pub extern fn libdeflate_gzip_compress(compressor: *struct_libdeflate_compressor, in: [*]const u8, in_nbytes: usize, out: [*]u8, out_nbytes_avail: usize) usize;
pub extern fn libdeflate_gzip_compress_bound(compressor: *struct_libdeflate_compressor, in_nbytes: usize) usize;
pub extern fn libdeflate_free_compressor(compressor: *struct_libdeflate_compressor) void;
pub const struct_libdeflate_decompressor = opaque {};
pub extern fn libdeflate_alloc_decompressor() ?*struct_libdeflate_decompressor;
pub const enum_libdeflate_result = enum(c_int)  {
    LIBDEFLATE_SUCCESS,
    LIBDEFLATE_BAD_DATA,
    LIBDEFLATE_SHORT_OUTPUT,
    LIBDEFLATE_INSUFFICIENT_SPACE
};
pub extern fn libdeflate_deflate_decompress(decompressor: *struct_libdeflate_decompressor, in: [*]const u8, in_nbytes: usize, out: [*]u8, out_nbytes_avail: usize, actual_out_nbytes_ret: *usize) enum_libdeflate_result;
pub extern fn libdeflate_deflate_decompress_ex(decompressor: *struct_libdeflate_decompressor, in: [*]const u8, in_nbytes: usize, out: [*]u8, out_nbytes_avail: usize, actual_in_nbytes_ret: *usize, actual_out_nbytes_ret: *usize) enum_libdeflate_result;
pub extern fn libdeflate_zlib_decompress(decompressor: *struct_libdeflate_decompressor, in: [*]const u8, in_nbytes: usize, out: [*]u8, out_nbytes_avail: usize, actual_out_nbytes_ret: *usize) enum_libdeflate_result;
pub extern fn libdeflate_zlib_decompress_ex(decompressor: *struct_libdeflate_decompressor, in: [*]const u8, in_nbytes: usize, out: [*]u8, out_nbytes_avail: usize, actual_in_nbytes_ret: *usize, actual_out_nbytes_ret: *usize) enum_libdeflate_result;
pub extern fn libdeflate_gzip_decompress(decompressor: *struct_libdeflate_decompressor, in: [*]const u8, in_nbytes: usize, out: [*]u8, out_nbytes_avail: usize, actual_out_nbytes_ret: *usize) enum_libdeflate_result;
pub extern fn libdeflate_gzip_decompress_ex(decompressor: *struct_libdeflate_decompressor, in: [*]const u8, in_nbytes: usize, out: [*]u8, out_nbytes_avail: usize, actual_in_nbytes_ret: *usize, actual_out_nbytes_ret: *usize) enum_libdeflate_result;
pub extern fn libdeflate_free_decompressor(decompressor: *struct_libdeflate_decompressor) void;
pub extern fn libdeflate_adler32(adler: u32, buffer: [*]const u8, len: usize) u32;
pub extern fn libdeflate_crc32(crc: u32, buffer: [*]const u8, len: usize) u32;
pub extern fn libdeflate_set_memory_allocator(malloc_func: ?fn (usize) callconv(.C) ?*anyopaque, free_func: ?fn (?*anyopaque) callconv(.C) void) void;

test "decompress" {
    const std = @import("std");
    const assert = std.debug.assert;
    var decomp = libdeflate_alloc_decompressor() orelse unreachable;
    const expected_result =
        \\We're no strangers to love
        \\You know the rules and so do I
        \\A full commitment's what I'm thinking of
        \\You wouldn't get this from any other guy
    ;
    var actual_result: [expected_result.len]u8 = undefined;
    var compressed: [109]u8 = undefined;
    try std.base64.standard.Decoder.decode(compressed[0..compressed.len], "HcwxDsMgEETR3qeYjnOk9AmilCgsGBl2pGUJ8u3jpP767ynBBEoMt6hFbMCJxo9sL06cygU/BDabDERNGEQi9u2BPFvDm71X76IeBtYRHXvo91L1rFrA/HcWZ0saHEX8Fweysd/eBd68oczrCw==");
    var outbytes: usize = undefined;
    const result = libdeflate_deflate_decompress(decomp, &compressed, compressed.len, &actual_result, actual_result.len, &outbytes);
    assert(result == enum_libdeflate_result.LIBDEFLATE_SUCCESS);
    assert(std.mem.eql(u8, expected_result[0..expected_result.len], actual_result[0..actual_result.len]));
}