# Centered UI

**Keeps your whole UI in a centered 16:9 area on ultrawide monitors, while the game world still fills the screen.**

On a 21:9 or 32:9 monitor, WoW spreads its interface across the full width. Your unit frames end up in one corner, the minimap is far off in the other, and quest, vendor and bag windows open at the edges of your vision.

Centered UI fixes that by fitting the interface into a centered 16:9 area, so everything sits where it would on a normal widescreen. The 3D world is not cropped: you still see the full ultrawide view, with only the interface pulled in.

## Features

- Every Blizzard window (quest, gossip, merchant, bags, action bars, unit frames) behaves as if the screen were 16:9. Nothing needs to be moved by hand.
- The game world keeps rendering at your monitor's full width.
- Choose any aspect ratio, such as 16:9, 21:9 or 4:3.
- Updates automatically when you change resolution or UI scale.
- Safe in combat: if a change happens mid-fight, it is applied as soon as combat ends.

## Commands

| Command | What it does |
|---|---|
| `/cui` | Turn the centering on or off |
| `/cui on` / `/cui off` | Turn it on or off explicitly |
| `/cui 16:9` | Set the aspect ratio of the UI area (any ratio of at least 1:1, e.g. `21:9`, `4:3`) |
| `/cui debug` | Print screen and UI sizes, for bug reports |

`/centeredui` works in place of `/cui`. Your settings are saved per account.