from libqtile import bar, widget
from ui import colors

top_bar = bar.Bar(
    [
        widget.CurrentLayout(),
        widget.GroupBox(),
        widget.Prompt(),
        widget.WindowName(),
        widget.Chord(
            chords_colors={
                "launch": ("#ff0000", "#ffffff"),
            },
            name_transform=lambda name: name.upper(),
        ),
        widget.Systray(),
        widget.Clock(format="%I:%M %p"),
    ],
    background=colors.bar["bg"],
    size=24,
)
