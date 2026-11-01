-- Place this file beside SLL.lua and run it as a LocalScript.
local SLL = require(script.Parent:WaitForChild("SLL"))

SLL.Creator.AddIcons("demo", {
	Badge = "rbxassetid://85262178816537",
	Bell = "rbxassetid://78246583582436",
})

local Window = SLL:CreateWindow({
	Title = "SLL Example",
	Author = "Simple Lib",
	Folder = "SLLExample",
	Size = UDim2.fromOffset(720, 520),
	ToggleKey = Enum.KeyCode.RightShift,
	HideSearchBar = false,
})

Window:Tag({
	Title = "v" .. SLL.Version,
	Icon = "demo:Badge",
})

local Overview = Window:Tab({
	Title = "Overview",
	Icon = "lucide:info",
})

Overview:Section({
	Title = "Welcome",
	Desc = "A compact showcase of SLL's built-in elements and window features.",
})

Overview:Paragraph({
	Title = "Simple Lib",
	Desc = "Use the tabs to explore controls, layout containers, icons, themes, and config examples.",
	Buttons = {
		{
			Title = "Show notification",
			Icon = "demo:Bell",
			Callback = function()
				SLL:Notify({
					Title = "Hello from SLL",
					Content = "Notifications are ready to use.",
					Duration = 4,
				})
			end,
		},
	},
})

Overview:Button({
	Title = "Open dialog",
	Desc = "Demonstrates a modal dialog with a callback.",
	Icon = "demo:Badge",
	Callback = function()
		Window:Dialog({
			Title = "SLL dialog",
			Content = "Dialogs can present information and actions.",
			Buttons = {
				{
					Title = "Close",
					Variant = "Primary",
					Callback = function()
						SLL:Notify({
							Title = "Dialog closed",
							Content = "The dialog button callback ran.",
							Duration = 3,
						})
					end,
				},
			},
		})
	end,
})

Overview:Button({
	Title = "Open popup",
	Icon = "demo:Badge",
	Callback = function()
		SLL:Popup({
			Title = "SLL popup",
			Content = "Popups can include one or more actions.",
			Buttons = {
				{
					Title = "Got it",
					Icon = "lucide:check",
					Variant = "Primary",
					Callback = function()
						print("Popup acknowledged")
					end,
				},
			},
		})
	end,
})

local Components = Window:Section({
	Title = "Components",
})

local Controls = Components:Tab({
	Title = "Controls",
	Icon = "lucide:settings",
})

Controls:Toggle({
	Title = "Example toggle",
	Desc = "A boolean setting that can be saved using its Flag.",
	Flag = "ExampleToggle",
	Value = true,
	Callback = function(enabled)
		print("Toggle:", enabled)
	end,
})

Controls:Slider({
	Title = "Example slider",
	Desc = "Adjust a numeric value.",
	Flag = "ExampleSlider",
	Step = 1,
	Value = {
		Min = 0,
		Max = 100,
		Default = 35,
	},
	Callback = function(value)
		print("Slider:", value)
	end,
})

local Progress = Controls:ProgressBar({
	Title = "Progress",
	Desc = "Update this bar with :Set(value).",
	Value = {
		Min = 0,
		Max = 100,
		Default = 35,
	},
	DisplayMode = "Percent",
})

Controls:Button({
	Title = "Advance progress",
	Icon = "lucide:arrow-right",
	Callback = function()
		Progress:Set(math.min(Progress:Get() + 10, 100))
	end,
})

Controls:Keybind({
	Title = "Example keybind",
	Desc = "Press the assigned key to run its callback.",
	Value = "K",
	Callback = function(key)
		print("Key pressed:", key)
	end,
})

Controls:Input({
	Title = "Example input",
	Desc = "Submit text with Enter or when the field loses focus.",
	Flag = "ExampleInput",
	Placeholder = "Type something...",
	Value = "",
	Callback = function(value)
		print("Input:", value)
	end,
})

Controls:Dropdown({
	Title = "Choose a mode",
	Flag = "ExampleMode",
	Values = { "Simple", "Balanced", "Advanced" },
	Value = "Simple",
	Callback = function(value)
		print("Selected mode:", value)
	end,
})

Controls:Colorpicker({
	Title = "Accent color",
	Flag = "ExampleColor",
	Default = Color3.fromRGB(32, 168, 121),
	Callback = function(color)
		print("Selected color:", color)
	end,
})

local Layout = Components:Tab({
	Title = "Layout",
	Icon = "lucide:table-of-contents",
})

Layout:Section({
	Title = "Text and code",
	Desc = "Paragraphs, code blocks, and grouped controls.",
})

Layout:Code({
	Title = "Luau snippet",
	Code = 'local message = "Hello, SLL!"\nprint(message)',
	CodeSize = 15,
	CanCopied = false,
})

local ButtonGroup = Layout:Group({})
ButtonGroup:Button({
	Title = "Group button",
	Icon = "lucide:check",
	Callback = function()
		print("Group button clicked")
	end,
})
ButtonGroup:Toggle({
	Title = "Group toggle",
	Value = false,
	Callback = function(value)
		print("Group toggle:", value)
	end,
})

local VerticalStack = Layout:VStack({})
VerticalStack:Section({
	Title = "Vertical stack",
	Desc = "VStack arranges its child elements vertically.",
})
VerticalStack:Divider({})
VerticalStack:Space({})

local HorizontalStack = Layout:HStack({})
HorizontalStack:Button({
	Title = "Horizontal stack",
	Icon = "lucide:arrow-right",
	Callback = function()
		print("HStack button clicked")
	end,
})
HorizontalStack:Paragraph({
	Title = "HStack",
	Desc = "HStack places its child elements side by side.",
})

Layout:Image({
	Image = "rbxassetid://85262178816537",
	AspectRatio = "16:9",
	Radius = 8,
})

local PreviewPart = Instance.new("Part")
PreviewPart.Name = "SLLViewportPreview"
PreviewPart.Size = Vector3.new(2, 2, 2)
PreviewPart.Anchored = true
PreviewPart.Color = Color3.fromRGB(32, 168, 121)

local PreviewCamera = Instance.new("Camera")
PreviewCamera.CFrame = CFrame.lookAt(Vector3.new(0, 0, 6), Vector3.zero)

Layout:Viewport({
	Object = PreviewPart,
	Camera = PreviewCamera,
	Height = 180,
})

local Settings = Window:Tab({
	Title = "Settings",
	Icon = "lucide:sliders-horizontal",
})

Settings:Dropdown({
	Title = "Theme",
	Values = { "SLL", "Dark", "Light" },
	Value = SLL:GetCurrentTheme(),
	Callback = function(themeName)
		SLL:SetTheme(themeName)
	end,
})

Settings:Button({
	Title = "Show current theme",
	Icon = "lucide:palette",
	Callback = function()
		SLL:Notify({
			Title = "Current theme",
			Content = SLL:GetCurrentTheme(),
			Duration = 3,
		})
	end,
})

Settings:Button({
	Title = "Center window",
	Icon = "lucide:move",
	Callback = function()
		Window:SetToTheCenter()
	end,
})

Settings:Button({
	Title = "Set UI scale to 90%",
	Icon = "lucide:expand",
	Callback = function()
		Window:SetUIScale(0.9)
	end,
})

local ConfigManager = Window.ConfigManager
if ConfigManager then
	Settings:Section({
		Title = "Config example",
		Desc = "Config files require a supported file API and do not work in Roblox Studio.",
	})

	Settings:Button({
		Title = "Save example config",
		Icon = "lucide:save",
		Callback = function()
			local config = ConfigManager:Config("example")
			local result = config:Save()
			SLL:Notify({
				Title = result and "Config saved" or "Config save failed",
				Content = "Config name: example",
				Duration = 4,
			})
		end,
	})

	Settings:Button({
		Title = "Load example config",
		Icon = "lucide:refresh-cw",
		Callback = function()
			local config = ConfigManager:CreateConfig("example")
			local result, message = config:Load()
			SLL:Notify({
				Title = result and "Config loaded" or "Config load failed",
				Content = tostring(message or "Config name: example"),
				Duration = 4,
			})
		end,
	})
else
	Settings:Paragraph({
		Title = "Config manager unavailable",
		Desc = "Config persistence needs a supported file API and is disabled in Roblox Studio.",
	})
end
