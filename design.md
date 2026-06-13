# Game Design Document

Mutagen is a puzzle game where the player traverses various rooms with doors. They have to mutate the character into different forms (colors) by walking into Mutagens. Based on the color, certain doors become traversable.

# Constraints

1. hand-crafted levels with Godot tilemaps
2. low-fidelity, pixel-perfect pixelart
3. no UI or mouse dependencies. Mobile/Browser friendly.

# Win Condition

The player traversed all levels and reached the end.

# Lose Condition

One cannot really lose but one can always reset a level if one gets stuck.

# Color Combinations

- Red Mutagen
- Blue Mutagen
- Green Mutagen
- Yellow Mutagen: combining Green and Red
- Cyan Mutagen: combining Blue and Green
- Magenta Mutagen: combining Blue and Red
- Reset (white): Combining incompatible Mutagens

# Interactibles

- Doors: only visible when door color does not match player color
- Mutagen Pressure plate: rotates mutagens in the world when stepping on it
- Door Pressure plate: rotates door colors in the world when stepping on it
- Orbs: collectibles to satisfy completionists