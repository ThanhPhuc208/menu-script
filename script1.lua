local Player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

local Gui = Instance.new("ScreenGui")
Gui.Name = "SpeedEscape"
Gui.ResetOnSpawn = false
Gui.Parent = Player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0,350,0,240)
Frame.Position = UDim2.new(0.5,-175,0.5,-120)
Frame.BackgroundColor3 = Color3.fromRGB(20,20,30)
Frame.BorderSizePixel = 0
Frame.Parent = Gui

Instance.new("UICorner",Frame).CornerRadius = UDim.new(0,12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-40,0,40)
Title.Position = UDim2.new(0,10,0,5)
Title.BackgroundTransparency = 1
Title.Text = "+1 Speed Keyboard Escape"
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.new(1,1,1)
Title.Parent = Frame

local Toggle = Instance.new("TextButton")
Toggle.Size = UDim2.new(0,30,0,30)
Toggle.Position = UDim2.new(1,-35,0,5)
Toggle.Text = "X"
Toggle.TextColor3 = Color3.new(1,1,1)
Toggle.BackgroundColor3 = Color3.fromRGB(220,70,70)
Toggle.Parent = Frame

Instance.new("UICorner",Toggle).CornerRadius = UDim.new(0,8)

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1,0,1,-50)
Content.Position = UDim2.new(0,0,0,50)
Content.BackgroundTransparency = 1
Content.Parent = Frame

local function CreateButton(Text,X,Y)
	local B = Instance.new("TextButton")
	B.Size = UDim2.new(0,150,0,40)
	B.Position = UDim2.new(0,X,0,Y)
	B.Text = Text
	B.TextColor3 = Color3.new(1,1,1)
	B.Font = Enum.Font.GothamBold
	B.BackgroundColor3 = Color3.fromRGB(80,120,255)
	B.Parent = Content

	Instance.new("UICorner",B).CornerRadius = UDim.new(0,8)

	B.MouseButton1Click:Connect(function()
		print(Text.." clicked")
	end)

	return B
end

CreateButton("Stats",15,10)
CreateButton("Shop",180,10)
CreateButton("Speed",15,65)
CreateButton("Settings",180,65)

local Info = Instance.new("TextLabel")
Info.Size = UDim2.new(1,-20,0,60)
Info.Position = UDim2.new(0,10,0,130)
Info.BackgroundTransparency = 1
Info.Text = "Welcome!"
Info.TextScaled = true
Info.TextColor3 = Color3.new(1,1,1)
Info.Font = Enum.Font.Gotham
Info.Parent = Content

local Minimized = false

Toggle.MouseButton1Click:Connect(function()
	Minimized = not Minimized

	if Minimized then
		Content.Visible = false
		Frame.Size = UDim2.new(0,350,0,50)
		Toggle.Text = "+"
	else
		Content.Visible = true
		Frame.Size = UDim2.new(0,350,0,240)
		Toggle.Text = "X"
	end
end)

local Dragging = false
local DragInput
local DragStart
local StartPos

Title.InputBegan:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton1
	or Input.UserInputType == Enum.UserInputType.Touch then

		Dragging = true
		DragStart = Input.Position
		StartPos = Frame.Position

		Input.Changed:Connect(function()
			if Input.UserInputState == Enum.UserInputState.End then
				Dragging = false
			end
		end)
	end
end)

Title.InputChanged:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseMovement
	or Input.UserInputType == Enum.UserInputType.Touch then
		DragInput = Input
	end
end)

UIS.InputChanged:Connect(function(Input)
	if Input == DragInput and Dragging then
		local Delta = Input.Position - DragStart

		Frame.Position = UDim2.new(
			StartPos.X.Scale,
			StartPos.X.Offset + Delta.X,
			StartPos.Y.Scale,
			StartPos.Y.Offset + Delta.Y
		)
	end
end)
