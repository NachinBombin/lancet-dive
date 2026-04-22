# lancet-dive

Garry's Mod addon — **Lancet-3** loiter munition.

Part of the **Bombin Support** family. The smallest and most precise warhead of the three.

| Addon | Model | Damage | Radius |
|---|---|---|---|
| [learn-dive](https://github.com/NachinBombin/learn-dive) | TB-2 | 350 | 600 HU |
| [shahed-dive](https://github.com/NachinBombin/shahed-dive) | Shahed-136 | 700 | 900 HU |
| **lancet-dive** | **Lancet-3** | **150** | **300 HU** |

## Behaviour

- Combine soldiers throw a blue flare call when they have a player enemy in range.
- The Lancet-3 spawns, climbs to altitude and orbits the call position.
- After a random window it pitches nose-down and dives at the nearest player.
- Small warhead — **150 damage / 300 HU radius** — best used in tight spaces or as a precision tool.
- Can be shot down (200 HP).

## Required model

```
models/sw/avia/lancet3/lancet3.mdl
```

## ConVars

| ConVar | Default | Description |
|---|---|---|
| `npc_bombinlancet_enabled` | 1 | Enable NPC calls |
| `npc_bombinlancet_chance` | 0.12 | Probability per check |
| `npc_bombinlancet_interval` | 12 | Seconds between checks |
| `npc_bombinlancet_cooldown` | 50 | Per-NPC cooldown |
| `npc_bombinlancet_min_dist` | 400 | Min call distance |
| `npc_bombinlancet_max_dist` | 3000 | Max call distance |
| `npc_bombinlancet_delay` | 5 | Flare → arrival delay |
| `npc_bombinlancet_lifetime` | 40 | Munition lifetime (s) |
| `npc_bombinlancet_speed` | 250 | Orbit speed HU/s |
| `npc_bombinlancet_radius` | 2500 | Orbit radius HU |
| `npc_bombinlancet_height` | 2500 | Altitude HU |
| `npc_bombinlancet_dive_damage` | **150** | Explosion damage |
| `npc_bombinlancet_dive_radius` | **300** | Explosion radius HU |
| `npc_bombinlancet_announce` | 0 | Debug prints |

## Menu

Spawnmenu → **Bombin Support** → **Lancet-3**

Or run `bombin_spawnlancet` in console for a manual test spawn.

## Credits

NachinBombin
