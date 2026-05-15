# lutui
A minimal Lua Terminal UI Library. Handles the game loop, 
module lifecycle, and crash recovery for terminal applications.

## Dependencies
- lua-term (`luarocks install lua-term`)
  Not required but highly recommended. lutui doesn't bundle 
  terminal primitives by design. lua-term gives you cursor 
  movement, colors, and everything else.

## Files
- `lutui.lua` - the library itself
- `runner.lua` - runs a module, defaults to `main.lua`
- `wrapper.lua` - wraps runner.lua, catches crashes to `crash.txt`

## Usage
```bash
lua wrapper.lua          # runs main.lua
lua wrapper.lua mygame   # runs mygame.lua
```

## Module Structure
Every lutui module looks like this:
```lua
local M = {}
function M.init()
    -- runs once on startup
end
function M.draw()
    -- runs every frame
end
function M.update()
    -- runs every frame, return false to exit
end
return M
```

## Functions
```lua
-- Gives terminal dimensions, tries env vars, then stty size, then falls back to 80x24
lutui.getSize() -- Returns: Width, Height

-- Reads N Bytes from stdin (wrapper for io.read())
lutui.readbyte(n) -- Returns: String (n bytes from stdin)

-- Strips ANSI color codes from a string, used internally for length calculations
lutui.decolor(str) -- Returns: String

-- Pads text left or right, ANSI-aware (have no idea why i actually did this)
lutui.pad_text(txt, padding, dir, pad_char) -- Returns: String

-- Word-wraps text with ANSI-aware width calculation,
-- supports pre/suf decorators & handles words longet than the line
lutui.text_wrap(text, x, term_width, config) -- Returns: Table (Wrapped text)

-- Queues text to print after app quit
lutui.afterprint(txt) -- Returns: Nothing

-- Full SGR Mouse Sequence Parser + arrow keys, assumes \27 is already consumed before you call it
lutui.parse_mouse() -- Returns: Table (see below)
--[[

Arrow keys:
{ type = "arrowup",    x = 0, y = 0 }
{ type = "arrowdown",  x = 0, y = 0 }
{ type = "arrowright", x = 0, y = 0 }
{ type = "arrowleft",  x = 0, y = 0 }
{ type = "arrowunknown", x = 0, y = 0 } (anything else after \27[)

Mouse clicks:
{ type = "left",   x = 42, y = 12, action = "press" }
{ type = "left",   x = 42, y = 12, action = "release" }
{ type = "middle", x = 42, y = 12, action = "press" }
{ type = "right",  x = 42, y = 12, action = "press" }

Mouse movement (while holding button):
{ type = "leftmove",   x = 43, y = 12, action = "press" }
{ type = "middlemove", x = 43, y = 12, action = "press" }
{ type = "rightmove",  x = 43, y = 12, action = "press" }

Mouse movement (no button held):
{ type = "move", x = 43, y = 12, action = "press" }

Scroll wheel:
{ type = "up",   x = 43, y = 12, action = "press" }
{ type = "down", x = 43, y = 12, action = "press" }

]]
```

## Projects using lutui
- [INTUINET](https://github.com/ihaveno-username/intuinet) — a TML browser for the terminal
