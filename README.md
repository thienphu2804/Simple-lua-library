# SLL (Simple Lib)

SLL is a Roblox Luau UI library for building script interfaces from reusable
windows, tabs, sections, and controls. The default **SLL** theme uses a light,
minimal layout. Existing Dark and Light themes are also available.

> SLL is derived from WindUI by Footagesus. The source retains attribution to
> the original project.

## Files

- `SLL.lua` — the library ModuleScript.
- `Example.lua` — a LocalScript showcasing controls and common API calls.

## Installation

1. Put `SLL.lua` in Roblox Studio as a **ModuleScript** named `SLL`.
2. Put `Example.lua` beside it as a **LocalScript** where LocalScripts can run,
   for example under `StarterPlayerScripts`.
3. Run the LocalScript. It loads the sibling module with
   `require(script.Parent:WaitForChild("SLL"))`.

The example assumes the ModuleScript and LocalScript share the same parent.
If you place them in different folders, change the `require` path accordingly.

## Quick start

```lua
local SLL = require(path.to.SLL)

local Window = SLL:CreateWindow({
    Title = "My interface",
    Author = "My project",
    ToggleKey = Enum.KeyCode.RightShift,
    HideSearchBar = false,
})

local MainTab = Window:Tab({
    Title = "Main",
    Icon = "lucide:settings",
})

MainTab:Button({
    Title = "Say hello",
    Callback = function()
        SLL:Notify({
            Title = "Hello",
            Content = "The button was clicked.",
        })
    end,
})
```

The library returns a table from the ModuleScript, so load it once with
`require`. Use colon syntax for instance methods, as shown in the examples.

## Features

### Window and navigation

- Create and switch between tabs, including collapsible sidebar sections.
- Search tab and element titles (set `HideSearchBar = false` to show search).
- Move, resize, center, scale, minimize, and toggle fullscreen for the window.
- Set a toggle key with `ToggleKey`; `Window:SetToggleKey(...)` can change it
  later.
- Add window tags, topbar buttons, dialogs, popups, and notifications.
- Customize the window theme, transparency, background, and acrylic effect.

### Elements

Tabs and layout containers support the following element methods:

- `Paragraph`, `Button`, `Toggle`, `Slider`, `ProgressBar`
- `Keybind`, `Input`, `Dropdown`, `Colorpicker`, `Code`
- `Section`, `Divider`, `Space`, `Image`, `Viewport`
- `Group`, `HStack`, `VStack`

Most controls accept a `Callback` and return an element object with methods for
changing or reading its value. For example, a progress bar supports
`progress:Set(value)`, `progress:Get()`, and `progress:SetRange(min, max)`.

### Themes, language, and icons

```lua
SLL:SetTheme("Dark") -- "SLL", "Dark", "Light", and bundled themes
SLL:SetLanguage("en")

SLL.Creator.AddIcons("custom", {
    Home = "rbxassetid://1234567890",
})

local HomeTab = Window:Tab({
    Title = "Home",
    Icon = "custom:Home",
})
```

Register custom icons with `SLL.Creator.AddIcons(packName, icons)`. An icon can
be an asset ID number, an `rbxassetid://...` string, or a sprite-sheet entry
containing `Image`, `ImageRectSize`, and `ImageRectPosition`. Use the icon as
`"packName:iconName"`. Register the pack before creating elements that use its
icons.

Themes can be queried with `SLL:GetThemes()` and `SLL:GetCurrentTheme()`.
`SLL:AddTheme(themeTable)` registers a custom theme. Theme tables use a `Name`
and color properties such as `Background`, `Text`, `Accent`, `Icon`, `Button`,
`Toggle`, and `Slider`.

## Config persistence

Config support is optional and requires a runtime with file-system functions
such as `writefile`, `readfile`, `isfile`, `isfolder`, and `makefolder`.
Config persistence is not available in Roblox Studio. Set `Folder` when
creating the window, and add a `Flag` to controls you want to save:

```lua
local Window = SLL:CreateWindow({
    Title = "My interface",
    Folder = "MyProject",
})

local Enabled = Window:Tab({ Title = "Main" }):Toggle({
    Title = "Enabled",
    Flag = "Enabled",
    Value = false,
})

local Config = Window.ConfigManager:Config("default")
Config:Save()
-- Later:
Window.ConfigManager:CreateConfig("default"):Load()
```

The library's config parser supports `Toggle`, `Slider`, `Dropdown`, `Input`,
`Keybind`, and `Colorpicker`. Config API availability depends on the runtime.

## Scope

The bundled library keeps its core UI elements, themes, localization, search,
notifications, dialogs, and config APIs. The optional third-party key-system
integrations and large unused icon packs were removed to reduce the single-file
bundle. Add other icon packs yourself through `SLL.Creator.AddIcons`.
