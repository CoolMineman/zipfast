const std = @import("std");

pub fn build(b: *std.build.Builder) !void {
    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();
    const target = b.standardTargetOptions(.{});

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
    const libdeflate_args = &[_][]const u8{"-fvisibility=hidden"};
    libdeflate.addCSourceFiles(libdeflate_sources.items, libdeflate_args); // "-fvisibility=hidden" hides unwanted exports
    libdeflate.linkLibC();
    libdeflate.setBuildMode(mode);
    libdeflate.setTarget(target);
    libdeflate.install();

    // const zlibng = b.addStaticLibrary("zlib-ng", null);
    // const zlibng_dir = "../zlib-ng/";
    // const os_str = if (target.isWindows()) 
    //     "Windows"
    // else if (target.isLinux())
    //     "Linux"
    // else if (target.isDarwin())
    //     "Darwin"
    // else 
    //     unreachable;
    
    // const zlibng_build = b.addSystemCommand(&.{
    //     "bash",
    //     "zlib-ng-build/build.sh",
    //     try target.linuxTriple(b.allocator),
    //     os_str
    // });


    const lib = b.addSharedLibrary("zipfast", "src/main.zig", std.build.LibExeObjStep.SharedLibKind.unversioned);
    lib.linkLibrary(libdeflate);
    // lib.step.dependOn(&zlibng_build.step);
    // todo broken on mac
    // lib.addObjectFile(zlibng_dir ++ "libz-ng.a");
    lib.setBuildMode(mode);
    // lib.addIncludePath(libdeflate_dir);
    lib.setTarget(target);
    lib.linkLibC();
    lib.install();

    const main_tests = b.addTest("src/main.zig");
    main_tests.setBuildMode(mode);
    main_tests.linkLibrary(libdeflate);
    // main_tests.step.dependOn(&zlibng_build.step);
    // main_tests.addObjectFile(zlibng_dir ++ "libz-ng.a");

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&main_tests.step);
}
