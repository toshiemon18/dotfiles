hs.loadSpoon("ShiftIt")

local shiftitHotkeys = {
    left = { { 'ctrl', 'cmd' }, 'left' },
    right = { { 'ctrl', 'cmd' }, 'right' },
    up = { { 'ctrl', 'cmd' }, 'up' },
    down = { { 'ctrl', 'cmd' }, 'down' },
    upleft = { { 'ctrl', 'cmd' }, '1' },
    upright = { { 'ctrl', 'cmd' }, '2' },
    botleft = { { 'ctrl', 'cmd' }, '3' },
    botright = { { 'ctrl', 'alt', 'cmd' }, '4' },
    maximum = { { 'ctrl', 'cmd' }, 'f' },
    toggleFullScreen = { { 'ctrl', 'alt', 'cmd' }, 'f' },
    toggleZoom = { { 'ctrl', 'alt', 'cmd' }, 'z' },
    center = { { 'ctrl', 'cmd' }, 'c' },
    nextScreen = { { 'ctrl', 'alt', 'cmd' }, 'n' },
    previousScreen = { { 'ctrl', 'alt', 'cmd' }, 'p' },
    resizeOut = { { 'ctrl', 'alt', 'cmd' }, '=' },
    resizeIn = { { 'ctrl', 'alt', 'cmd' }, '-' }
}
spoon.ShiftIt:bindHotkeys(shiftitHotkeys)


