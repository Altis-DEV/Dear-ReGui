-- ============================================================
-- Dear ReGui 1.4.7
-- Altis-DEV / Mobile Full Demo
-- ============================================================

local REPO =
    "https://raw.githubusercontent.com/Altis-DEV/Dear-ReGui/refs/heads/main/"

--============================================================
-- LOAD
--============================================================

local ReGui = loadstring(
    game:HttpGet(REPO .. "ReGui.lua")
)()

local PrefabChunk = loadstring(
    game:HttpGet(REPO .. "Prefabs.lua")
)

local BuildPrefabs = PrefabChunk()

local Root = BuildPrefabs()

assert(typeof(Root) == "Instance")
assert(Root:IsA("ScreenGui"))

ReGui:Init({
    Prefabs = Root
})

print("ReGui:", ReGui:GetVersion())

--============================================================
-- CONFIGURATION
--============================================================

local ConfigWindow = ReGui:Window({
    Title = "Configuration",
    Size = UDim2.fromOffset(320, 260)
})

local SavedIni

local ConfigRow = ConfigWindow:Row()

ConfigRow:Button({
    Text = "Dump",
    Callback = function()
        print(ReGui:DumpIni(true))
    end
})

ConfigRow:Button({
    Text = "Save",
    Callback = function()
        SavedIni = ReGui:DumpIni(true)
        print("Saved")
    end
})

ConfigRow:Button({
    Text = "Load",
    Callback = function()
        if SavedIni then
            ReGui:LoadIni(SavedIni, true)
            print("Loaded")
        end
    end
})

ConfigWindow:Separator()

ConfigWindow:SliderInt({
    IniFlag = "MobileSlider",
    Label = "Slider",
    Value = 5,
    Minimum = 1,
    Maximum = 10
})

ConfigWindow:Checkbox({
    IniFlag = "MobileCheck",
    Label = "Checkbox",
    Value = true
})

ConfigWindow:InputText({
    IniFlag = "MobileInput",
    Label = "Input",
    Value = "Hello"
})

--============================================================
-- TABS WINDOW
--============================================================

local TabsWindow = ReGui:TabsWindow({
    Title = "Tabs",
    Size = UDim2.fromOffset(320, 240)
})

local TabNames = {
    "Home",
    "Basic",
    "Settings",
    "Test",
    "About"
}

for _, Name in ipairs(TabNames) do

    local Tab = TabsWindow:CreateTab({
        Name = Name
    })

    Tab:Label({
        Text = "This is the " .. Name .. " tab"
    })

    Tab:Separator()

    Tab:Button({
        Text = "Test Button",
        Callback = function()
            print(Name, "button clicked")
        end
    })

end

--============================================================
-- WATERMARK
--============================================================

local Watermark = ReGui.Elements:Label({

    Parent = ReGui.Container.Windows,

    Visible = false,

    UiPadding = UDim.new(0, 6),

    CornerRadius = UDim.new(0, 2),

    Position = UDim2.fromOffset(6, 6),

    Size = UDim2.fromOffset(190, 48),

    Border = true,

    BorderThickness = 1,

    BorderColor = ReGui.Accent.Gray,

    BackgroundTransparency = 0.4,

    BackgroundColor3 = ReGui.Accent.Black
})

game:GetService("RunService").RenderStepped:Connect(
    function(Delta)

        local FPS = math.round(1 / Delta)

        Watermark.Text =
            "ReGui " ..
            ReGui:GetVersion() ..
            "\nFPS: " ..
            FPS

    end
)

--============================================================
-- MAIN WINDOW
--============================================================

local Window = ReGui:Window({

    Title = "Dear ReGui Mobile Demo",

    Size = UDim2.fromOffset(
        340,
        500
    ),

    NoScroll = true

}):Center()

--============================================================
-- MENU BAR
--============================================================

local MenuBar = Window:MenuBar()

local Menu = MenuBar:MenuItem({
    Text = "Menu"
})

Menu:Selectable({
    Text = "Toggle Watermark",

    Callback = function()

        Watermark.Visible =
            not Watermark.Visible

    end
})

Menu:Selectable({
    Text = "Configuration",

    Callback = function()

        ConfigWindow:ToggleVisibility()

    end
})

Menu:Selectable({
    Text = "Tabs",

    Callback = function()

        TabsWindow:ToggleVisibility()

    end
})

Menu:Selectable({
    Text = "Close",

    Callback = function()

        Window:Close()

    end
})

--============================================================
-- STATIC LABEL
--============================================================

Window:Label({

    Text =
        "Dear ReGui " ..
        ReGui:GetVersion()
})

--============================================================
-- SCROLL CONTENT
--============================================================

local Content = Window:ScrollingCanvas({

    Fill = true,

    UiPadding = UDim.new(0, 0)
})

--============================================================
-- HELP
--============================================================

local Help = Content:CollapsingHeader({

    Title = "Help"
})

Help:Label({
    Text = "Basic information"
})

local HelpIndent = Help:Indent({

    Offset = 20
})

HelpIndent:BulletText({

    Rows = {

        "Buttons",

        "Inputs",

        "Sliders",

        "Trees",

        "Tables",

        "Popups"

    }
})

local HelpIndent2 = HelpIndent:Indent({

    Offset = 20
})

HelpIndent2:Label({
    Text = "Second level indent"
})

--============================================================
-- BACKEND
--============================================================

local Configuration = Content:CollapsingHeader({

    Title = "Configuration"
})

local Backend = Configuration:TreeNode({

    Title = "Backend Flags"
})

Backend:Checkbox({

    Label = "Mobile device",

    Disabled = true,

    Value = ReGui:IsMobileDevice()
})

Backend:Checkbox({

    Label = "Console device",

    Disabled = true,

    Value = ReGui:IsConsoleDevice()
})

-- Nested TreeNode + Indent
local BackendNested = Backend:TreeNode({

    Title = "Nested TreeNode"
})

BackendNested:Label({

    Text = "First nested level"
})

local BackendIndent =
    BackendNested:Indent({
        Offset = 20
    })

BackendIndent:Label({

    Text = "Indented inside TreeNode"
})

local BackendIndent2 =
    BackendIndent:Indent({
        Offset = 20
    })

BackendIndent2:Button({

    Text = "Deep button",

    Callback = function()

        print("Deep button clicked")

    end
})

--============================================================
-- STYLE
--============================================================

local Style = Configuration:TreeNode({

    Title = "Style"
})

Style:Combo({

    Selected = "DarkTheme",

    Label = "Theme",

    Items = ReGui.ThemeConfigs,

    Callback = function(_, Name)

        Window:SetTheme(Name)

    end
})

--============================================================
-- BASIC
--============================================================

local Basic = Content:CollapsingHeader({

    Title = "Basic"
})

Basic:Separator({
    Text = "Buttons"
})

local BasicRow = Basic:Row()

BasicRow:Button({
    Text = "Button 1"
})

BasicRow:Button({
    Text = "Button 2"
})

Basic:Checkbox({
    Label = "Checkbox"
})

Basic:Separator({
    Text = "Radio"
})

local RadioRow = Basic:Row()

RadioRow:Radiobox({
    Label = "A"
})

RadioRow:Radiobox({
    Label = "B"
})

RadioRow:Radiobox({
    Label = "C"
})

--============================================================
-- TOOLTIP
--============================================================

local Tooltips = Content:CollapsingHeader({

    Title = "Tooltips"
})

local TooltipButton =
    Tooltips:Button({
        Text = "Hover me"
    })

ReGui:SetItemTooltip(
    TooltipButton,

    function(Canvas)

        Canvas:Label({
            Text = "I am a tooltip!"
        })

    end
)

--============================================================
-- INPUT
--============================================================

local Inputs = Content:CollapsingHeader({

    Title = "Input"
})

Inputs:InputText({

    Label = "Text",

    Placeholder = "Enter text..."
})

Inputs:InputTextMultiline({

    Label = "Multiline",

    Size = UDim2.new(
        1,
        0,
        0,
        80
    )
})

Inputs:InputInt({

    Label = "Integer",

    Value = 50
})

--============================================================
-- SLIDERS
--============================================================

local Sliders = Content:CollapsingHeader({

    Title = "Sliders"
})

Sliders:DragInt({

    Label = "Drag Int",

    Minimum = 0,

    Maximum = 100,

    Value = 50
})

Sliders:DragFloat({

    Label = "Drag Float",

    Minimum = 0,

    Maximum = 1,

    Value = 0.5
})

Sliders:SliderInt({

    Label = "Slider Int",

    Minimum = 0,

    Maximum = 100,

    Value = 25
})

Sliders:SliderFloat({

    Label = "Slider Float",

    Minimum = 0,

    Maximum = 1,

    Value = 0.5
})

Sliders:SliderEnum({

    Label = "Enum",

    Value = 1,

    Items = {
        "Fire",
        "Water",
        "Earth",
        "Air"
    }
})

Sliders:SliderProgress({

    Label = "Progress",

    Value = 50,

    Minimum = 0,

    Maximum = 100
})

--============================================================
-- PICKERS
--============================================================

local Pickers = Content:CollapsingHeader({

    Title = "Pickers"
})

Pickers:InputColor3({

    Label = "Input Color",

    Value = ReGui.Accent.Light
})

Pickers:SliderColor3({

    Label = "Slider Color",

    Value = ReGui.Accent.Red
})

Pickers:DragColor3({

    Label = "Drag Color",

    Value = ReGui.Accent.Green
})

Pickers:InputCFrame({

    Label = "Input CFrame",

    Value = CFrame.new(1, 1, 1),

    Minimum = CFrame.new(),

    Maximum = CFrame.new(
        20,
        20,
        20
    )
})

--============================================================
-- COMBO
--============================================================

local Combos = Content:CollapsingHeader({

    Title = "Combo"
})

Combos:Combo({

    Label = "Fruits",

    Selected = 1,

    Items = {

        "Apple",

        "Banana",

        "Orange",

        "Mango"
    }
})

Combos:Combo({

    Label = "Dictionary",

    Selected = "A",

    Items = {

        A = "Apple",

        B = "Banana",

        C = "Orange"
    },

    Callback = print
})

--============================================================
-- TREE NODES
--============================================================

local Trees = Content:CollapsingHeader({

    Title = "Tree Nodes"
})

for I = 1, 3 do

    local Tree = Trees:TreeNode({

        Title = "Tree Node " .. I,

        Collapsed = I ~= 1
    })

    Tree:Label({

        Text =
            "Content of node " ..
            I
    })

    local Level1 =
        Tree:Indent({
            Offset = 20
        })

    Level1:Label({

        Text = "Indented level 1"
    })

    local Level2 =
        Level1:Indent({
            Offset = 20
        })

    Level2:Button({

        Text = "Indented button",

        Callback = function()

            print(
                "Button from Tree Node",
                I
            )

        end
    })

end

--============================================================
-- COLLAPSING HEADERS
--============================================================

local Headers = Content:CollapsingHeader({

    Title = "Nested Headers"
})

local First =
    Headers:CollapsingHeader({

        Title = "First Header"
    })

First:Label({
    Text = "First header content"
})

local FirstIndent =
    First:Indent({
        Offset = 20
    })

FirstIndent:Label({
    Text = "Indented content"
})

local Nested =
    FirstIndent:CollapsingHeader({

        Title = "Nested Header"
    })

Nested:Label({

    Text =
        "Header inside an indented container"
})

--============================================================
-- BULLETS
--============================================================

local Bullets = Content:CollapsingHeader({

    Title = "Bullets"
})

Bullets:BulletText({

    Rows = {

        "Bullet 1",

        "Bullet 2",

        "Bullet 3"
    }
})

local BulletTree =
    Bullets:TreeNode({

        Title = "Bullet Tree"
    })

BulletTree:Bullet():Label({

    Text = "Nested bullet"
})

--============================================================
-- TABS / TABSELECTOR
--============================================================

local TabDemo = Content:CollapsingHeader({

    Title = "TabSelector"
})

local BasicTabTree =
    TabDemo:TreeNode({

        Title = "Basic Tabs"
    })

local Selector =
    BasicTabTree:TabSelector()

for _, Name in {

    "Apple",

    "Banana",

    "Orange"

} do

    Selector:CreateTab({

        Name = Name

    }):Label({

        Text =
            "This is the " ..
            Name ..
            " tab!"

    })

end

local AdvancedTabTree =
    TabDemo:TreeNode({

        Title = "Closeable Tabs"
    })

local AdvancedSelector =
    AdvancedTabTree:TabSelector()

for _, Name in {

    "One",

    "Two",

    "Three",

    "Four"

} do

    AdvancedSelector:CreateTab({

        Name = Name,

        Closeable = true

    }):Label({

        Text =
            "Closeable: " ..
            Name

    })

end

AdvancedTabTree:Button({

    Text = "Add Tab",

    Callback = function()

        AdvancedSelector:CreateTab({

            Closeable = true

        }):Label({

            Text = "Dynamic tab"

        })

    end
})

--============================================================
-- PLOT
--============================================================

local Plot = Content:CollapsingHeader({

    Title = "Plot"
})

local Graph =
    Plot:PlotHistogram({

        Points = {
            0.2,
            0.7,
            0.4,
            1,
            0.3
        }
    })

Plot:Button({

    Text = "Generate",

    Callback = function()

        local Points = {}

        for I = 1, 6 do

            Points[I] =
                math.random()

        end

        Graph:PlotGraph(Points)

    end
})

--============================================================
-- MULTI COMPONENT
--============================================================

local Multi = Content:CollapsingHeader({

    Title = "Multi Component"
})

Multi:InputInt2()

Multi:SliderInt2()

Multi:SliderFloat2()

Multi:DragInt2()

Multi:DragFloat2()

Multi:Separator({
    Text = "3-wide"
})

Multi:InputInt3()

Multi:SliderInt3()

Multi:SliderFloat3()

--============================================================
-- PROGRESS
--============================================================

local Progress =
    Content:CollapsingHeader({

        Title = "Progress Bars"
    })

local Bar =
    Progress:ProgressBar({

        Label = "Loading...",

        Value = 0
    })

task.spawn(function()

    local Value = 0

    while true do

        task.wait(0.05)

        Value =
            (Value + 1) % 101

        Bar:SetPercentage(Value)

    end

end)

--============================================================
-- CODE EDITOR
--============================================================

local Code =
    Content:CollapsingHeader({

        Title = "Code Editor"
    })

Code:CodeEditor({

    Text =
        [[print("Hello from ReGui!")]],

    Editable = true
})

--============================================================
-- CONSOLE
--============================================================

local ConsoleHeader =
    Content:CollapsingHeader({

        Title = "Console"
    })

local Console =
    ConsoleHeader:Console({

        ReadOnly = true,

        AutoScroll = true,

        MaxLines = 30
    })

Console:AppendText(
    "[Console] Hello world!"
)

Console:AppendText(
    "[Console] Testing..."
)

--============================================================
-- INDENT
--============================================================

local IndentHeader =
    Content:CollapsingHeader({

        Title = "Indent Demo"
    })

IndentHeader:Label({

    Text = "Level 0"
})

local L1 =
    IndentHeader:Indent({

        Offset = 20
    })

L1:Label({

    Text = "Level 1"
})

local L2 =
    L1:Indent({

        Offset = 20
    })

L2:Label({

    Text = "Level 2"
})

local L3 =
    L2:Indent({

        Offset = 20
    })

L3:Button({

    Text = "Level 3 Button"
})

--============================================================
-- KEYBINDS
--============================================================

local Keybinds =
    Content:CollapsingHeader({

        Title = "Keybinds"
    })

local Toggle =
    Keybinds:Checkbox({

        Label = "Toggle me",

        Value = true
    })

Keybinds:Keybind({

    Label = "Toggle checkbox",

    Callback = function(_, Key)

        print("Pressed:", Key)

        Toggle:Toggle()

    end
})

Keybinds:Keybind({

    Label = "Toggle UI",

    Value = Enum.KeyCode.E,

    Callback = function()

        Window:ToggleVisibility()

    end
})

--============================================================
-- VIEWPORT
--============================================================

local ViewportHeader =
    Content:CollapsingHeader({

        Title = "Viewport"
    })

local Rig =
    ReGui:InsertPrefab("R15 Rig")

local Viewport =
    ViewportHeader:Viewport({

        Size = UDim2.new(
            1,
            0,
            0,
            160
        ),

        Clone = true,

        Model = Rig
    })

local Model = Viewport.Model

Model:PivotTo(
    CFrame.new(
        0,
        -2.5,
        -5
    )
)

game:GetService("RunService")
    .RenderStepped
    :Connect(function(Delta)

        Model:PivotTo(
            Model:GetPivot()
                * CFrame.Angles(
                    0,
                    math.rad(
                        30 * Delta
                    ),
                    0
                )
        )

    end)

--============================================================
-- LIST
--============================================================

local ListHeader =
    Content:CollapsingHeader({

        Title = "List"
    })

local List =
    ListHeader:List({

        Border = true
    })

for I = 1, 8 do

    List:Button({

        Text =
            "List Button " ..
            I
    })

end

--============================================================
-- POPUP
--============================================================

local PopupHeader =
    Content:CollapsingHeader({

        Title = "Popup"
    })

local PopupTree =
    PopupHeader:TreeNode({

        Title = "Selection Popup"
    })

local Selected =
    PopupTree:Label({

        Text = "<None>"
    })

PopupTree:Button({

    Text = "Select...",

    Callback = function(self)

        local Popup =
            PopupTree:PopupCanvas({

                RelativeTo = self,

                MaxSizeX = 180
            })

        for _, Name in {

            "Bream",

            "Haddock",

            "Mackerel",

            "Pollock"

        } do

            Popup:Selectable({

                Text = Name,

                Callback = function()

                    Selected.Text =
                        Name

                    Popup:ClosePopup()

                end
            })

        end

    end
})

--============================================================
-- CHILD WINDOW
--============================================================

local ChildSection =
    PopupHeader:TreeNode({

        Title = "Child Window"
    })

local Child =
    ChildSection:Window({

        Size =
            UDim2.fromOffset(
                260,
                180
            ),

        NoMove = true,

        NoClose = true,

        NoCollapse = true,

        NoResize = true
    })

Child:Label({

    Text = "Child Window"
})

Child:Button({
    Text = "Save"
})

Child:InputText({
    Label = "Text"
})

Child:SliderFloat({

    Label = "Float",

    Minimum = 0,

    Maximum = 1
})

--============================================================
-- MODAL
--============================================================

local ModalSection =
    PopupHeader:TreeNode({

        Title = "Modal"
    })

ModalSection:Button({

    Text = "Open Modal",

    Callback = function()

        local Modal =
            ModalSection:PopupModal({

                Title = "Modal Test"
            })

        Modal:Label({

            Text =
                "This is a modal window.",

            TextWrapped = true
        })

        Modal:Separator()

        local Row =
            Modal:Row({

                Expanded = true
            })

        Row:Button({

            Text = "OK",

            Callback = function()

                Modal:ClosePopup()

            end
        })

        Row:Button({

            Text = "Cancel",

            Callback = function()

                Modal:ClosePopup()

            end
        })

    end
})

--============================================================
-- TABLE
--============================================================

local Tables =
    Content:CollapsingHeader({

        Title = "Tables"
    })

local TableTree =
    Tables:TreeNode({

        Title = "Basic Table"
    })

local Table =
    TableTree:Table({

        Border = true,

        RowBackground = true,

        MaxColumns = 3
    })

for RowNumber = 1, 4 do

    local Row =
        Table:NextRow()

    for ColumnNumber = 1, 3 do

        local Column =
            Row:NextColumn()

        Column:Label({

            Text =
                RowNumber ..
                "," ..
                ColumnNumber
        })

    end

end

--============================================================
-- FINAL
--============================================================

print("================================")
print("DEAR REGUI MOBILE DEMO LOADED")
print("Version:", ReGui:GetVersion())
print("================================")
