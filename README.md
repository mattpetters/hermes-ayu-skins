# hermes-ayu-skins

Three [Hermes Agent](https://github.com/NousResearch/hermes-agent) themes
inspired by the [`ayu`](https://github.com/ayu-theme/ayu-colors) /
[`ayu-vim`](https://github.com/Shatur/neovim-ayu) colorschemes — covering
the **CLI skin** (banner, prompt, status bar), the **web dashboard theme**
(palette, fonts, accents), and matching **Warp custom themes** so the
terminal and browser look like the same product.

Sibling project to [`hermes-kanagawa-skins`](https://github.com/mattpetters/hermes-kanagawa-skins) —
same install pattern, different vibe.

- **`ayu-light`** — bright theme. Paper-bright background (`#FCFCFC`),
  `orange` (`#FA8D3E`) primary accent, ink-toned text. The most readable
  daytime variant.
- **`ayu-mirage`** — dim theme. Twilight slate-blue background (`#1F2430`),
  warm peach (`#FFAD66`) accent, soft cyan highlights. The "in-between"
  variant — easier on the eyes than full dark, less harsh than full light.
- **`ayu-dark`** — deep theme. Near-black background (`#0B0E14`), gold
  (`#FFB454`) primary accent, azure (`#59C2FF`) highlights. The classic
  night-coding variant.

The web dashboard themes also ship Geist + Geist Mono via Google Fonts,
overriding the Nous DS's display fonts (Mondwest / Rules Expanded) for a
cleaner reading experience.

Each CLI skin ships with two pieces of custom ASCII art:

1. **`banner_logo`** — block-letter banner reading **AYU AGENT** with a
   3-stop vertical sunrise gradient.
2. **`banner_hero`** — stylized sunrise over water with kanji caption
   *鮎* (ayu, the sweetfish that gives the colorscheme its name).

Both art pieces share the same gradient stops as the sunrise hero, so the
logo and hero feel unified.

## Install

```bash
git clone https://github.com/mattpetters/hermes-ayu-skins.git
cd hermes-ayu-skins
./scripts/install.sh        # installs CLI skins, dashboard themes, and Warp themes
```

The script copies:
- `skins/*.yaml` -> `$HERMES_HOME/skins/` (CLI)
- `dashboard-themes/*.yaml` -> `$HERMES_HOME/dashboard-themes/` (web UI)
- `warp-themes/*.yaml` -> `$HOME/.warp/themes/` (Warp terminal)

Then activate:

```text
/skin ayu-dark              # in the Hermes CLI
```

Or set as the default in `~/.hermes/config.yaml`:

```yaml
display:
  skin: ayu-dark
dashboard:
  theme: ayu-dark
```

In Warp, open **Settings** > **Appearance** > **Themes** and pick
`Ayu Light`, `Ayu Mirage`, or `Ayu Dark`.

If you enable **Sync with OS**, set:

- light mode -> `Ayu Light`
- dark mode  -> `Ayu Dark` (or `Ayu Mirage` for a dimmer variant)

## Pair with Ghostty

The Ayu palette ships in Ghostty as built-in themes:

```text
# ~/.config/ghostty/config
theme = dark:ayu,light:ayu_light
```

For Mirage:

```text
theme = ayu_mirage
```

## Variants at a glance

| Variant      | Background  | Primary accent | Vibe                      |
|--------------|-------------|----------------|---------------------------|
| `ayu-light`  | `#FCFCFC`   | `#FA8D3E` orange | Daytime / paper           |
| `ayu-mirage` | `#1F2430`   | `#FFAD66` peach  | Twilight / dim            |
| `ayu-dark`   | `#0B0E14`   | `#FFB454` gold   | Night / deep              |

## Regenerating the banner

The `banner_logo` blocks are produced by `scripts/generate_banner.py`
(figlet `ansi_shadow` font + 3-stop vertical gradient). Run:

```bash
pip install pyfiglet
python3 scripts/generate_banner.py
```

then paste the output into the `banner_logo:` field of each skin yaml.
The `banner_hero` (sunrise + 鮎) is hand-authored — edit
`skins/*.yaml` directly to tweak it.

## License

MIT — see `LICENSE`.
