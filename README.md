# **THE MAIN REPO FOR uniduni_t IS ON CODEBERG: [HERE](https://codeberg.org/fwinter/uniduni_t)**

# uniduni_t

![Static Badge](https://img.shields.io/badge/Zig-v.0.12-%23F7A41D?style=for-the-badge&logo=zig&logoColor=%23F7A41D&color=%23F7A41D)
![Static Badge](https://img.shields.io/badge/tests-passing-black?style=for-the-badge&label=Tests&color=green)

![uniduni_t image](uniduni_t.png)

`uniduni_t` is a Zig library that lets you easily colorize your strings and outputs on your code. It uses ANSI escape codes to put color and styles in your strings and outputs.

It was built on Linux, with :heart:, as part of my ongoing journey of learning Zig.

I'm so grateful for all the help I got from the [Ziggit.dev](https://ziggit.dev) community!

## Features:

- [x] Normal colors
- [x] Styles
- [x] RGB
- [x] Hexadecimal
- [ ] Detects terminal capacity
- [ ] Use colors only when the terminal supports it
- [ ] Supports major OSes
  - [x] Linux
  - [ ] FreeBSD
  - [ ] Windows
  - [ ] MacOS

## How to use Uniduni_t in your project?

1. Add Uniduni_t as a dependency in your `build.zig.zon` file, running the following command: `zig fetch --save https://codeberg.org/fwinter/uniduni_t/archive/main.tar.gz`
```
.{
    .name = "YourProject",
    .version = "0.0.0",
    .dependencies = .{
        .uniduni_t = .{
            .url = "https://codeberg.org/fwinter/uniduni_t/archive/main.tar.gz",
            .hash = "122031b19f9408c0cf9e45b6d2e96ed119778af64efd0d8d67ca5803302286107db3",
        },
    },
    .paths = .{
        "",
    },
}
```

2. Import Uniduni_t in your `build.zig` file:
```
pub fn build(b: *std.Build) void {
   const exe = b.addExecutable(.{ ... });

   const uniduni_t = b.dependency("uniduni_t", .{
      .target = target,
      .optimize = optimize,
   });
   exe.root_module.addImport("uniduni_t", uniduni_t.module("uniduni_t"));
}
```

3. See the examples below for usage.

## Examples:

<details>
<summary>Print with custom foreground, background color and style</summary>

```
const std = @import("std");
const Uniduni_t = @import("uniduni_t");
const Color = Uniduni_t.Color;
const Style = Uniduni_t.Style;

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const warn = Uniduni_t.init().add(.{ Color.Foreground.red, Color.Background.black, Style.bold });
    try stdout.print("{s}: This is a warning!\n", .{ warn.format("WARNING") });
}
```

</details>

<details>
<summary>Print with main color aliases</summary>

```
const std = @import("std");
const Uniduni_t = @import("uniduni_t");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const green = Uniduni_t.init().green(.foreground).bold();
    try stdout.print("{s}: success!\n", .{green.format("GREAT")});

    const bg_green = Uniduni_t.init().green(.background).bold();
    try stdout.print("{s}: success!\n", .{bg_green.format("GREAT")});
}
```

</details>

<details>
<summary>Colorize a string</summary>

```
const std = @import("std");
const Uniduni_t = @import("uniduni_t");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const bright_yellow_string = Uniduni_t.init().brightYellow(.foreground).format("This is a bright yellow string");
    try stdout.print("{s}\n", .{bright_yellow_string});
}
```

</details>

<details>
<summary>Reuse your setted colors</summary>

```
const std = @import("std");
const Uniduni_t = @import("uniduni_t");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const magenta = Uniduni_t.init().magenta(.foreground);
    try stdout.print("This is {s}. This is also a magenta word: {s}.\n", .{ magenta.format("magenta"), magenta.format("Uniduni_t") });
}
```

</details>

<details>
<summary>Print with RGB color</summary>

```
const std = @import("std");
const Uniduni_t = @import("uniduni_t");
const Color = Uniduni_t.Color;

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
```

</details>

<details>
<summary>Use uniduni_t on your existing code</summary>

```
const std = @import("std");
const Uniduni_t = @import("uniduni_t");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const uni = Uniduni_t.init().cyan(.foreground);

    try uni.on();
    try stdout.print("This is a cyan string\n", .{});

    try uni.off();
    try stdout.print("This is a default colored string\n", .{});
}
```

</details>

<details>
<summary>Print with Hexadecimal code</summary>

```
const std = @import("std");

const Uniduni_t = @import("uniduni_t");
const Color = Uniduni_t.Color;

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const first = Uniduni_t.init().add(.{ Color.Hex.fg("#a7c080"), Color.Hex.bg("2d353b") }); // First way
    const second = Uniduni_t.init().hex("A7C080", .foreground).hex("#2D353B", .background); // Second way
    try stdout.print("{s}\n", .{first.format("We accept hexadecimal too! Yay!")});
    try stdout.print("{s}\n", .{second.format("Everforest theme is great!")});
}
```

</details>
