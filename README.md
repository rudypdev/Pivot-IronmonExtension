
# Ironmon-Tracker Pivot Command Extension

### [Usage](#usage) | [Installation](#installation) | [Changelog](#changelog)

The Super Kaiso variant of IronMON requires the player to "pivot" to a new pokemon from Safari Zone. There's a ton of useful information for twitch chatters to have regarding this pivot, e.g. if the pokemon was caught in the Safari Zone or if the streamer has enough mushroom items to use the move relearner. This extension implements a number of subcommands related to this pivot. Currently only supports LeafGreen/FireRed locations.

## Usage

The Pivot Command Extension provides a `!pivot` command with several subcommands to help track pivot Pokemon and related items in Super Kaiso Ironmon runs.

### Basic Commands

- **`!pivot`** - Shows whether the first Pokemon in your party is the pivot (caught in Safari Zone)
  - Returns: "Pivot > [Pokemon Name] IS the pivot!" or "Pivot > [Pokemon Name] IS NOT the Pivot. It was caught in [Location]."

### Item Subcommands

- **`!pivot mushrooms`** - Shows all mushroom items in your bag
  - Returns: List of mushroom items with quantities (e.g., "Mushrooms > Tiny Mushroom (3), Big Mushroom (1)")

- **`!pivot candy`** or **`!pivot candies`** - Shows all Rare Candy items in your bag
  - Returns: Whether or not the player has any rare candies in their bag and the quantity.

- **`!pivot evo`** or **`!pivot stones`** - Shows all evolution stones in your bag

### Examples

```
!pivot
> Pivot > Snorlax IS NOT the Pivot. It was caught in Viridian Forest.

!pivot mushrooms
> Mushrooms > Tiny Mushroom (2), Big Mushroom (1)
```

## Installation

1. **Streamer.bot Stream Connect**  
   The extension is designed to work in conjunction with the existing Stream Connect functionality. You can find guidelines on how to set that up here in the [Stream Connect Setup Guide](https://github.com/besteon/Ironmon-Tracker/wiki/Stream-Connect-Guide).

2. **Drop in the Extension**  
   Copy or download `PivotCommandExtension.lua` and place it in your tracker's `extensions` folder.

   Alternatively, you can copy and paste the link to this github repo into the tracker's GUI.

   <img width="300" height="150" alt="image" src="https://github.com/user-attachments/assets/94f1b611-c650-41ca-a884-679130633f8d" />
 
   <img width="300" height="300" alt="image" src="https://github.com/user-attachments/assets/ee73bfcb-8bd5-406c-a8c7-d7022d9c1bce" />

   <img width="300" height="300" alt="image" src="https://github.com/user-attachments/assets/652023de-cd83-4e36-b9a2-a208a8287c69" />

   <img width="300" height="220" alt="image" src="https://github.com/user-attachments/assets/40eed051-d4c9-4e44-9eb6-441f85ff3505" />


4. Enable the Extension via `Tracker Settings > Extensions`

<img width="300" height="150" alt="image" src="https://github.com/user-attachments/assets/94f1b611-c650-41ca-a884-679130633f8d" />

<img width="300" height="300" alt="image" src="https://github.com/user-attachments/assets/ee73bfcb-8bd5-406c-a8c7-d7022d9c1bce" />

<img width="300" height="300" alt="image" src="https://github.com/user-attachments/assets/95f24f7b-fb27-4621-a5dd-b2cb2221f2eb" />

<img width="300" height="175" alt="image" src="https://github.com/user-attachments/assets/abc1116f-9efe-4c87-ae98-1f101c3a6627" />

4. Enable the new `!pivot` command in Streaming Settings / Stream Connect

<img width="300" height="150" alt="image" src="https://github.com/user-attachments/assets/94f1b611-c650-41ca-a884-679130633f8d" />

<img width="300" height="300" alt="image" src="https://github.com/user-attachments/assets/012c4051-dc10-4fba-9f6e-c0ff22bc2c64" />

<img width="300" height="300" alt="image" src="https://github.com/user-attachments/assets/d0a9c43d-4d39-43a1-bf21-4d3bfa36a095" />

<img width="300" height="200" alt="image" src="https://github.com/user-attachments/assets/255a2205-18d9-47cd-a787-aeb9b98e975b" />


## Changelog

- v1.0: Initial Release
