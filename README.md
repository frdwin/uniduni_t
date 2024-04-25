# uniduni_t

*uniduni_t* is a Zig library that lets you easily use colored outputs on your code.

It uses ANSI escape codes to put color in your strings.

## Examples:

### Print with custom foreground, background color and style:
```
const std = @import("std");
const uniduni_t = @import("uniduni_t.zig");

pub fn main() !void {
    const alloc = std.heap.page_allocator;

    var cp = uniduni_t.ColorPrint.init(alloc);
    defer cp.deinit();

    try cp.set(.{ uniduni_t.FgColor.green, uniduni_t.BgColor.magenta, uniduni_t.Style.italic });
    try cp.print("This is an italic green text on a magenta background\n");
}
```
### Print with color aliases:
```
const std = @import("std");
const uniduni_t = @import("uniduni_t.zig");

pub fn main() !void {
    const alloc = std.heap.page_allocator;

    var cp = uniduni_t.ColorPrint.init(alloc);
    defer cp.deinit();

    try cp.black("This is a black foreground text\n");
    try cp.red("This is a red foreground text\n");
    try cp.green("This is a green foreground text\n");
    try cp.yellow("This is a yellow foreground text\n");
    try cp.blue("This is a blue foreground text\n");
    try cp.magenta("This is a magenta foreground text\n");
    try cp.cyan("This is a cyan foreground text\n");
    try cp.white("This is a white foreground text\n");
    try cp.default("This is your default text color\n");
}
```
### Colorize a string:
```
const std = @import("std");
const uniduni_t = @import("uniduni_t.zig");

pub fn main() !void {
    const alloc = std.heap.page_allocator;

    var cp = uniduni_t.ColorPrint.init(alloc);
    defer cp.deinit();

    try cp.set(.{ uniduni_t.FgColor.green, uniduni_t.BgColor.magenta, uniduni_t.Style.italic });

    const my_colorized_string: []const u8 = try cp.colorize("This is my colorized string\n");
}
```
