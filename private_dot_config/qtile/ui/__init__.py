from core.helper import load_module
from options import colorscheme
from ui.screens import screens

colorscheme_module_path = f"themes.{colorscheme}"

colors = load_module(colorscheme_module_path)

__all__ = ("colors", "screens")
