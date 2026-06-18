# Mutagen

Mutagen is a puzzle game where the player traverses various rooms with doors. They have to mutate the character into different forms (colors) by walking into Mutagens. Based on the color, certain doors become traversable.

## Tools used

- [Godot Engine 4.6.3](https://godotengine.org)
- [Aseprite](https://aseprite.org)

## Constraints

1. hand-crafted levels with Godot tilemaps
2. low-fidelity, pixel-perfect pixelart
3. no UI or mouse dependencies
4. Mobile/Browser friendly.

# Game Loop
1. Player enters stage
2. Player sees portal but portal is inactive
3. Player must find fragments to unlock portal
4. Player gathered all fragments and portal now activates (with animation)

## Win Condition

The player traversed all levels and reached the end.

## Lose Condition

One cannot really lose but one can always reset a level if one gets stuck.

## Color Combinations

- Red Mutagen
- Blue Mutagen
- Green Mutagen
- Yellow Mutagen: combining Green and Red
- Cyan Mutagen: combining Blue and Green
- Magenta Mutagen: combining Blue and Red
- Reset (white): Combining incompatible Mutagens

## Interactibles

- Doors: only visible when door color does not match player color
- Mutagen collectibles
- Mutagen Pressure plate: rotates mutagens in the world when stepping on it
- Door Pressure plate: rotates door colors in the world when stepping on it
- (optional) Orbs: collectibles to satisfy completionists
