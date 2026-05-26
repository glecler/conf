import colorsys
import random

def generate_palette(base_hue=None):
    # If no base hue is given, pick a random one
    if base_hue is None:
        base_hue = random.random()

    def to_hex(rgb):
        return '#{:02x}{:02x}{:02x}'.format(
            int(rgb[0]*255),
            int(rgb[1]*255),
            int(rgb[2]*255)
        )

    palette = {}

    # Base lightness and saturation for colors
    base_s = 0.5
    base_l = 0.4

    # Define color categories with hue offsets (fraction of circle)
    categories = [
        ("black", 0),
        ("red", 0.0),
        ("green", 1/6),
        ("yellow", 2/6),
        ("blue", 3/6),
        ("magenta", 4/6),
        ("cyan", 5/6),
        ("white", 0)  # white is desaturated and lighter
    ]

    for i, (name, hue_offset) in enumerate(categories):
        hue = (base_hue + hue_offset) % 1.0

        # Normal color
        if name == "black":
            rgb = colorsys.hls_to_rgb(hue, 0.1, 0.15)
        elif name == "white":
            rgb = colorsys.hls_to_rgb(hue, 0.9, 0.1)
        else:
            rgb = colorsys.hls_to_rgb(hue, base_l, base_s)

        palette[f"color{i}"] = to_hex(rgb)

        # Bright color (lighter and more saturated)
        if name == "black":
            rgb_bright = colorsys.hls_to_rgb(hue, 0.15, 0.3)
        elif name == "white":
            rgb_bright = colorsys.hls_to_rgb(hue, 0.95, 0.05)
        else:
            rgb_bright = colorsys.hls_to_rgb(hue, min(base_l+0.3, 1.0), min(base_s+0.4, 1.0))

        palette[f"color{i+8}"] = to_hex(rgb_bright)

    return palette

# Example usage:
if __name__ == "__main__":
    palette = generate_palette()
    for key in sorted(palette.keys()):
        print(f"{key}   {palette[key]}")

