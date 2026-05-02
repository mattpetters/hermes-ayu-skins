#!/usr/bin/env python3
"""Generate AYU skin banner_logo blocks (ansi_shadow figlet + 3-stop gradient).

Run from repo root:
  python3 scripts/generate_banner.py
Outputs: prints banner_logo blocks for each variant. Used during initial
  authoring; the resulting blocks are baked into skins/*.yaml.
"""
from pyfiglet import Figlet

# 3-stop vertical gradients (top -> bottom) per variant
GRADIENTS = {
    "ayu-light":  ["#FA8D3E", "#F2AE49", "#399EE6"],   # sunrise: orange -> amber -> blue
    "ayu-mirage": ["#FFAD66", "#FFCC66", "#5CCFE6"],   # twilight: peach -> gold -> cyan
    "ayu-dark":   ["#FFB454", "#E6B450", "#59C2FF"],   # midnight: gold -> bronze -> azure
}

def render(text: str, colors):
    f = Figlet(font="ansi_shadow")
    raw = f.renderText(text).rstrip("\n")
    lines = raw.split("\n")
    n = len(lines)
    # Map lines to gradient stops: thirds
    out = []
    for i, line in enumerate(lines):
        third = i * 3 // n
        color = colors[min(third, 2)]
        out.append(f"  [bold {color}]{line}[/]")
    return "\n".join(out)

if __name__ == "__main__":
    for variant, colors in GRADIENTS.items():
        print(f"# === {variant} ===")
        print(render("AYU  AGENT", colors))
        print()
