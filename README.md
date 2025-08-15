
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


<img width="300" height="150" alt="image" src="https://github.com/user-attachments/assets/8cf50d90-6723-42c5-9eaf-d4cfbc78e387" />

<img width="300" height="300" alt="image" src="https://github.com/user-attachments/assets/de2e9238-1264-414e-8a7d-9fda43a9e0f8" />

<img width="300" height="300" alt="image" src="https://github.com/user-attachments/assets/4d96138d-8b0d-4d73-9dac-0b1f881ce3fd" />



3. Enable the Extension via `Tracker Settings > Extensions`

<img width="300" height="150" alt="image" src="https://github.com/user-attachments/assets/8cf50d90-6723-42c5-9eaf-d4cfbc78e387" />

<img width="300" height="300" alt="image" src="https://github.com/user-attachments/assets/de2e9238-1264-414e-8a7d-9fda43a9e0f8" />

<img width="300" height="300" alt="image" src="https://github.com/user-attachments/assets/031d752f-b153-409c-bf5f-2d695cd21c09" />

<img width="300" height="175" alt="image" src="https://github.com/user-attachments/assets/1da79f7d-ef28-467a-a90b-61b37c90f27e" />


4. Enable the new `!pivot` command in Streaming Settings / Stream Connect

<img width="300" height="150" alt="image" src="https://github.com/user-attachments/assets/8cf50d90-6723-42c5-9eaf-d4cfbc78e387" />

<img width="300" height="300" alt="image" src="https://github.com/user-attachments/assets/22ea3e85-e7fb-4468-88e3-8452ee48dc9a" />

<img width="300" height="300" alt="image" src="https://github.com/user-attachments/assets/a8cf585a-a79d-419c-b87d-6e18d884f977" />

<img width="300" height="225" alt="image" src="https://github.com/user-attachments/assets/d14bc0f4-e7e2-4971-8dfd-c065372c2828" />



## Changelog

- v1.0: Initial Release
