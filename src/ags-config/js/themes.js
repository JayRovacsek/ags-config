import { Utils } from "./imports.js";
const WP = `/home/${Utils.USER}/Pictures/Wallpapers/`;

const charm = {
  red: "#e55f86",
  green: "#00D787",
  yellow: "#EBFF71",
  blue: "#51a4e7",
  magenta: "#9077e7",
  teal: "#51e6e6",
  orange: "#E79E64",
};

const dark = {
  color_scheme: "dark",
  bg_color: "#171717",
  fg_color: "#eee",
  hover_fg: "#f1f1f1",
  ...charm,
};

const misc = {
  wm_gaps: 10,
  radii: 10,
  spacing: 10,
  shadow: "rgba(0, 0, 0, .6)",
  drop_shadow: true,
  transition: 200,
  screen_corners: true,
  bar_style: "normal",
  layout: "topbar",
  desktop_clock: "center center",
  font: "Hack Nerd Font Regular",
  mono_font: "Hack Nerd Font Mono Regular",
  font_size: 12,
};

const colors = {
  wallpaper_fg: "white",
  hypr_active_border: "rgba(3f3f3fFF)",
  hypr_inactive_border: "rgba(3f3f3fDD)",
  accent: "$blue",
  accent_fg: "#141414",
  widget_bg: "$fg_color",
  widget_opacity: 90,
  active_gradient: "to right, $accent, lighten($accent, 6%)",
  border_color: "$fg_color",
  border_opacity: 90,
  border_width: 1,
};

// themes
const kitty_dark = {
  wallpaper: WP + "kitty.jpeg",
  name: "kitty_dark",
  icon: "󰄛",
  ...dark,
  ...misc,
  ...colors,
};

const tomorrowNightBlue = {
  red: "#e55f86",
  green: "#00D787",
  yellow: "#EBFF71",
  blue: "#51a4e7",
  magenta: "#9077e7",
  teal: "#51e6e6",
  orange: "#E79E64",
  color_scheme: "dark",
  bg_color: "#002451",
  fg_color: "#eee",
  hover_fg: "#f1f1f1",
  wm_gaps: 10,
  radii: 10,
  spacing: 10,
  shadow: "rgba(002451, 0.9)",
  drop_shadow: true,
  transition: 200,
  screen_corners: true,
  bar_style: "normal",
  layout: "topbar",
  desktop_clock: "",
  font: "Hack Nerd Font Regular",
  mono_font: "Hack Nerd Font Mono Regular",
  font_size: 12,
  wallpaper_fg: "white",
  hypr_active_border: "rgba(ffeeadff)",
  hypr_inactive_border: "rgba(7285b7)",
  accent: "$blue",
  accent_fg: "#141414",
  widget_bg: "$fg_color",
  widget_opacity: 90,
  active_gradient: "to right, $accent, lighten($accent, 6%)",
  border_color: "$fg_color",
  border_opacity: 90,
  border_width: 1,
  wallpaper: WP + "leaves.jpg",
  name: "tomorrow_night_blue",
  icon: "",
};

const leaves_dark = {
  ...kitty_dark,
  wallpaper: WP + "leaves.jpg",
  name: "leaves_dark",
  icon: "󰌪",
  accent: "$green",
  widget_opacity: 92,
  active_gradient: "to right, $accent, darken($accent, 14%)",
  border_opacity: 86,
  bg_color: "transparentize(#171717, 0.3)",
  hypr_active_border: "rgba(57e389FF)",
  bar_style: "floating",
  radii: 0,
  wallpaper_fg: "white",
  additional_scss: `
        window#quicksettings .quicksettings {
            margin-right: $wm_gaps;
        }
    `,
};

const cutefish = {
  ...dark,
  wallpaper: WP + "cutefish.jpeg",
  name: "cutefish",
  icon: "󰈺",
  accent: "lighten($blue, 20%)",
  active_gradient: "to right, $accent, lighten(mix($orange, $blue, 70%), 20%)",
  border_opacity: 94,
  brorder_width: 2,
  radii: 9,
  desktop_clock: "end end",
  hypr_active_border: "rgba(3f3f3fFF)",
  bg_color: "transparentize(#171717, 0.3)",
};

const cherry = {
  ...kitty_dark,
  wallpaper: WP + "cherry.png",
  name: "cherry",
  icon: "",
  accent: "$blue",
  active_gradient: "to right, $accent, lighten(mix($magenta, $blue, 70%), 18%)",
  brorder_width: 2,
  radii: 13,
  bg_color: "transparentize(#171717, 0.3)",
};

export default [tomorrowNightBlue, leaves_dark, kitty_dark, cutefish, cherry];
