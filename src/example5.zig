const std = @import("std");

const Uniduni_t = @import("uniduni_t.zig").Uniduni_t;
const attr = @import("attributes.zig");
const Color = attr.Color;

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const red = Uniduni_t.init().rgb(102, 0, 0, .foreground); // First way
    const green = Uniduni_t.init().add(.{Color.RGB.fg(0, 102, 0)}); // Second way
    const blue = Uniduni_t.init().add(.{Color.RGB.fg(0, 0, 102)});
    try stdout.print("{s}{s}{s}\n", .{ red.format("R"), green.format("G"), blue.format("B") });

    const bg_red = Uniduni_t.init().rgb(102, 0, 0, .background); // First way
    const bg_green = Uniduni_t.init().add(.{Color.RGB.bg(0, 102, 0)}); // Second way
    const bg_blue = Uniduni_t.init().add(.{Color.RGB.bg(0, 0, 102)});
    try stdout.print("{s}{s}{s}\n", .{ bg_red.format("R"), bg_green.format("G"), bg_blue.format("B") });
}
