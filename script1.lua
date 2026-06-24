ScreenGui
└─ MainFrame
   ├─ TopBar
   │  ├─ Title
   │  └─ CloseButton
   │
   ├─ TabButtons
   │  ├─ Stats
   │  ├─ Shop
   │  ├─ Rebirth
   │  ├─ Settings
   │  └─ Codes
   │
   ├─ ContentFrame
   │  ├─ StatsPage
   │  ├─ ShopPage
   │  ├─ RebirthPage
   │  └─ SettingsPagelocal Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "SpeedEscapeMenu"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 250)
frame.Position = UDim2.new(0.5, -175, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(18,18,30)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,12)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0,10,0,5)
title.BackgroundTransparency = 1
title.Text = "+1 Speed Keyboard Escape"
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Parent = frame

local close = Instance.new("TextButton")
close.Size = UDim2.new(0,30,0,30)
close.Position = UDim2.new(1,-35,0,5)
close.Text = "X"
close.TextColor3 = Color3.new(1,1,1)
close.BackgroundColor3 = Color3.fromRGB(200,50,50)
close.Parent = frame

local function makeButton(text,pos,color)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0,140,0,40)
	b.Position = pos
	b.Text = text
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.BackgroundColor3 = color
	b.Parent = frame

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0,8)
	c.Parent = b

	return b
end

local statsBtn = makeButton("Stats",UDim2.new(0,15,0,60),Color3.fromRGB(70,120,255))
local shopBtn = makeButton("Shop",UDim2.new(0,190,0,60),Color3.fromRGB(255,120,70))
local speedBtn = makeButton("Speed",UDim2.new(0,15,0,115),Color3.fromRGB(70,200,120))
local settingsBtn = makeButton("Settings",UDim2.new(0,190,0,115),Color3.fromRGB(170,100,255))

local info = Instance.new("TextLabel")
info.Size = UDim2.new(1,-20,0,60)
info.Position = UDim2.new(0,10,0,175)
info.BackgroundTransparency = 1
info.TextColor3 = Color3.new(1,1,1)
info.Font = Enum.Font.Gotham
info.TextScaled = true
info.Text = "Welcome to +1 Speed Keyboard Escape!"
info.Parent = frame

statsBtn.MouseButton1Click:Connect(function()
	info.Text = "Stats Page"
end)

shopBtn.MouseButton1Click:Connect(function()
	info.Text = "Shop Page"
end)

speedBtn.MouseButton1Click:Connect(function()
	info.Text = "Speed Training Page"
end)

settingsBtn.MouseButton1Click:Connect(function()
	info.Text = "Settings Page"
end)

close.MouseButton1Click:Connect(function()
	frame.Visible = false
end)local minimized = false

close.MouseButton1Click:Connect(function()
	minimized = not minimized

	if minimized then
		for _,obj in ipairs(frame:GetChildren()) do
			if obj ~= title and obj ~= close then
				obj.Visible = false
			end
		end

		frame.Size = UDim2.new(0,350,0,50)
		close.Text = "+"
	else
		for _,obj in ipairs(frame:GetChildren()) do
			if obj:IsA("GuiObject") then
				obj.Visible = true
			end
		end

		frame.Size = UDim2.new(0,350,0,250)
		close.Text = "X"
	end
end)local UIS = game:GetService("UserInputService")

local dragging = false
local dragInput
local dragStart
local startPos

title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPos = frame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

title.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement
	or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart

		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)
