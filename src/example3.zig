const std = @import("std");
const Uniduni_t = @import("uniduni_t.zig").Uniduni_t;

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const yellow_string = Uniduni_t.init().yellow().format("This is a yellow string");
    try stdout.print("{s}\n", .{yellow_string});
}
