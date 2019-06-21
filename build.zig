const Builder = @import("std").build.Builder;
const builtin = @import("builtin");

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("firmware.elf", "startup.zig");
    exe.setTarget(builtin.Arch{ .thumb = .v7m }, builtin.Os.freestanding, builtin.Abi.none);

    const main_o = b.addObject("main", "main.zig");
    main_o.setTarget(builtin.Arch{ .thumb = .v7m }, builtin.Os.freestanding, builtin.Abi.none);
    exe.addObject(main_o);

    exe.setBuildMode(mode);
    exe.setLinkerScriptPath("arm_cm3.ld");
    exe.setOutputDir(".");

    b.default_step.dependOn(&exe.step);
    b.installArtifact(exe);
}
