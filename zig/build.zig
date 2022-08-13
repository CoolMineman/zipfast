const std = @import("std");

pub fn build(b: *std.build.Builder) !void {
    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const libdeflate = b.addStaticLibrary("libdeflate", null);
    const libdeflate_dir = "../libdeflate/";
    const libdeflate_dir_lib = libdeflate_dir ++ "lib/";
    libdeflate.addIncludePath(libdeflate_dir);
    var libdeflate_sources = std.ArrayList([]const u8).init(b.allocator);
    // Search for all C/C++ files in `src` and add them
    // https://zig.news/xq/zig-build-explained-part-2-1850
    {
        var dir = try std.fs.cwd().openIterableDir(libdeflate_dir_lib, .{});

        var walker = try dir.walk(b.allocator);
        defer walker.deinit();

        const allowed_exts = [_][]const u8{ ".c", ".cpp", ".cxx", ".c++", ".cc" };
        while (try walker.next()) |entry| {
            const ext = std.fs.path.extension(entry.basename);
            const include_file = for (allowed_exts) |e| {
                if (std.mem.eql(u8, ext, e))
                    break true;
            } else false;
            if (include_file) {
                // we have to clone the path as walker.next() or walker.deinit() will override/kill it
                // std.debug.print("{s}\n", .{entry.path});
                try libdeflate_sources.append(try std.mem.join(b.allocator, "", &.{ libdeflate_dir_lib, b.dupe(entry.path) }));
            }
        }
    }
    libdeflate.addCSourceFiles(libdeflate_sources.items, &[_][]const u8{"-fvisibility=hidden"}); // "-fvisibility=hidden" hides unwanted exports
    libdeflate.linkLibC();
    libdeflate.setBuildMode(mode);
    libdeflate.install();

    const zlibng = b.addStaticLibrary("zlib-ng", null);
    const zlibng_dir = "../zlib-ng";


    const lib = b.addSharedLibrary("zipfast", "src/main.zig", std.build.LibExeObjStep.SharedLibKind.unversioned);
    lib.linkLibrary(libdeflate);
    lib.setBuildMode(mode);
    lib.addIncludePath(libdeflate_dir);
    lib.addIncludePath(zlibng_dir);
    lib.install();

    const main_tests = b.addTest("src/main.zig");
    main_tests.setBuildMode(mode);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&main_tests.step);
}
