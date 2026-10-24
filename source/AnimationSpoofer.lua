-- went through my old files and found the aniamtion spoofer
-- simple code

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")

local animationTable = {}

local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui

local SpoofFrame = Instance.new("Frame")
SpoofFrame.Size = UDim2.new(0, 260, 0, 200)
SpoofFrame.Position = UDim2.new(0, 10, 0, 10)
SpoofFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SpoofFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
SpoofFrame.BorderSizePixel = 1
SpoofFrame.Active = true
SpoofFrame.BackgroundTransparency = 0
SpoofFrame.Parent = gui

local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    SpoofFrame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

SpoofFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = SpoofFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

SpoofFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

local Topbar = Instance.new("Frame")
Topbar.Size = UDim2.new(1, 0, 0, 34)
Topbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Topbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
Topbar.BorderSizePixel = 1
Topbar.Active = false
Topbar.BackgroundTransparency = 0
Topbar.Parent = SpoofFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title.BorderSizePixel = 1
Title.Text = "Animation Spoofer"
Title.BackgroundTransparency = 0
Title.TextColor3 = Color3.fromRGB(0, 0, 0)
Title.Font = Enum.Font.GothamSemibold
Title.Parent = Topbar
Title.TextSize = 15

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 34, 1, 0)
CloseBtn.Position = UDim2.new(1,  -34, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(170, 170, 170)
CloseBtn.BorderColor3 = Color3.fromRGB(0, 0, 0)
CloseBtn.BorderSizePixel = 1
CloseBtn.Text = "X"
CloseBtn.BackgroundTransparency = 1
CloseBtn.TextColor3 = Color3.fromRGB(1, 1, 1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Topbar
CloseBtn.TextSize = 16

local AnimList = Instance.new("ScrollingFrame")
AnimList.Size = UDim2.new(1, -12, 1, -45)
AnimList.Position = UDim2.new(0, 6, 0, 40)
AnimList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
AnimList.BorderColor3 = Color3.fromRGB(0, 0, 0)
AnimList.BorderSizePixel = 1
AnimList.ScrollBarThickness = 6
AnimList.ScrollingEnabled = true
AnimList.BackgroundTransparency = 0
AnimList.Parent = SpoofFrame

local List = Instance.new("UIListLayout")
List.SortOrder = Enum.SortOrder.LayoutOrder
List.Padding = UDim.new(0, 0)
List.HorizontalAlignment = Enum.HorizontalAlignment.Center
List.VerticalAlignment = Enum.VerticalAlignment.Top
List.Parent = AnimList

List:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    AnimList.CanvasSize = UDim2.new(0, 0, 0, List.AbsoluteContentSize.Y)
end)

local function CloneButton(id)
    local str = string.match(tostring(id), "%d+")
    
    local TemplateFrame = Instance.new("Frame")
	TemplateFrame.Size = UDim2.new(1, 0, 0, 32)
	TemplateFrame.Position = UDim2.new(0, 10, 0, 10)
	TemplateFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TemplateFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TemplateFrame.BorderSizePixel = 1
	TemplateFrame.Active = false
	TemplateFrame.BackgroundTransparency = 0
	TemplateFrame.Draggable = true
	TemplateFrame.Parent = AnimList
	
	local AnimTitle = Instance.new("TextLabel")
	AnimTitle.Size = UDim2.new(1, 0, 0, 20)
	AnimTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	AnimTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
	AnimTitle.BorderSizePixel = 0
	AnimTitle.Active = false
	AnimTitle.BackgroundTransparency = 0
	AnimTitle.TextColor3 = Color3.fromRGB(0, 0, 0)
	AnimTitle.Font = Enum.Font.GothamSemibold
	AnimTitle.Parent = TemplateFrame
	AnimTitle.TextXAlignment = Enum.TextXAlignment.Left
	AnimTitle.TextSize = 13
	local Padding = Instance.new("UIPadding")
	Padding.PaddingLeft = UDim.new(0, 6)
	Padding.Parent = AnimTitle
	
	local AnimId = Instance.new("TextLabel")
	AnimId.Size = UDim2.new(1, 0, 1, -24)
	AnimId.Position = UDim2.new(0, 0, 0, 20)
	AnimId.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	AnimId.BorderColor3 = Color3.fromRGB(0, 0, 0)
	AnimId.BorderSizePixel = 0
	AnimId.Text = "ID: "..str
	AnimId.BackgroundTransparency = 0
	AnimId.TextColor3 = Color3.fromRGB(50,50,50)
	AnimId.Font = Enum.Font.GothamSemibold
	AnimId.Parent = TemplateFrame
	AnimId.TextSize = 10
	AnimId.TextXAlignment = Enum.TextXAlignment.Left
	Padding:Clone().Parent = AnimId
	
	local Copy = Instance.new("TextButton")
	Copy.Size = UDim2.new(0,  30, 1, -10)
	Copy.Position = UDim2.new(1, -35, 0, 5)
	Copy.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Copy.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Copy.BorderSizePixel = 1
	Copy.Text = "Copy"
	Copy.BackgroundTransparency = 0
	Copy.TextColor3 = Color3.fromRGB(1, 1, 1)
	Copy.Font = Enum.Font.Legacy
	Copy.Parent = TemplateFrame

    pcall(function()
        local animInfo = MarketplaceService:GetProductInfo(tonumber(str))
        AnimTitle.Text = animInfo.Name or "No Name Animation"
    end)

    Copy.MouseButton1Click:Connect(function()
	    local animInfo = MarketplaceService:GetProductInfo(tonumber(str))
        setclipboard("Name = " .. (animInfo and animInfo.Name or "Unknown") .. "\nId = " .. str)
        Copy.Text = "Copied!"
        task.delay(.5, function()
            Copy.Text = "Copy"
        end)
    end)

    return TemplateFrame
end

CloseBtn.MouseButton1Click:Connect(function()
	local shardCount = 10
	local shards = {}
	
	local baseX = SpoofFrame.AbsolutePosition.X
	local baseY = SpoofFrame.AbsolutePosition.Y
	local shardWidth = SpoofFrame.AbsoluteSize.X / shardCount
	local shardHeight = SpoofFrame.AbsoluteSize.Y
	
	for i = 1, shardCount do
	    local shard = Instance.new("Frame")
	    shard.Size = UDim2.new(0, shardWidth, 0, shardHeight)
	    shard.Position = UDim2.new(0, baseX + (i - 1) * shardWidth, 0, baseY)
	    shard.BackgroundColor3 = SpoofFrame.BackgroundColor3
	    shard.BorderSizePixel = 0
	    shard.AnchorPoint = Vector2.new(0, 0)
	    shard.Parent = gui
	
	    table.insert(shards, shard)
	end
	
	SpoofFrame.Visible = false
	
	for i, shard in ipairs(shards) do
	    local randomX = (math.random() - 0.5) * 300
	    local randomY = (math.random() - 0.5) * 300
	
	    shard:TweenPosition(UDim2.new(0, shard.Position.X.Offset + randomX, 0, shard.Position.Y.Offset + randomY), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
		shard:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
	
	    spawn(function()
	        for alpha = 0, 1, 0.1 do
	            shard.BackgroundTransparency = alpha
	            wait(0.05)
	        end
	        shard:Destroy()
	    end)
	end	
	wait(0.6)
	gui:Destroy()
end)

local function monitorAnimations()
    while task.wait(.5) do
        local character = Players.LocalPlayer.Character
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                local id = track.Animation.AnimationId
                if id and not table.find(animationTable, id) then
                    table.insert(animationTable, id)
                    CloneButton(id)
                end
            end
        end
    end
end

task.spawn(monitorAnimations)
