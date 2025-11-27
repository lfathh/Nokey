loadstring(game:HttpGet("https://raw.githubusercontent.com/WhatsHisIdentifier/NoKey/refs/heads/main/Discord",true))()
local WindUI = (loadstring(game:HttpGet("https://relzhub.farrghii.com/lib/lib.lua")))();
local Window = WindUI:CreateWindow({
	Title = "Relz Hub",
	Author = "Fish it",
	Folder = "Relz Hub",
	Icon = "rbxassetid://90888007617642",
	Size = UDim2.fromOffset(450, 300),
	MinSize = Vector2.new(520, 330),
	Transparent = false,
	Theme = "Dark",
	SideBarWidth = 160,
	HideSearchBar = true,
	ScrollBarEnabled = false
});
Window:EditOpenButton({
	Icon = "rbxassetid://90888007617642",
	CornerRadius = UDim.new(0, 10),
	Position = UDim2.new(0, 75, 0, 100),
	OnlyMobile = false,
	Enabled = true,
	Draggable = true
});
local Tabs = {
    InfoTab = Window:Tab({
		Title = "Info",
		Icon = "info",
		ShowTabTitle = false
	}),
	MainTab = Window:Tab({
		Title = "Main",
		Icon = "rbxassetid://10723407389"
	}),
	ShopTab = Window:Tab({
		Title = "Shop",
		Icon = "shopping-bag",
		ShowTabTitle = false
	}),
	TeleportTab = Window:Tab({
		Title = "Teleport",
		Icon = "rbxassetid://10734886004"
	}),
	MiscTab = Window:Tab({
		Title = "Misc",
		Icon = "layout-grid"
	}),
	ServerTab = Window:Tab({
		Title = "Server",
		Icon = "server"
	})
};
Window:SelectTab(1);
DiscordServerSection = Tabs.InfoTab:Section({
	Title = "Discord Server",
	TextXAlignment = "Left"
});
local InviteCode = "dGd8gsSqGp";
DiscordLinkButton = DiscordServerSection:Button({
	Title = "Join Discord Server",
	Callback = function()
		setclipboard("https://discord.gg/" .. InviteCode);
	end
});
GameTimeParagraph = Tabs.InfoTab:Paragraph({
	Title = "Game Time",
	Desc = "0",
	Image = "timer",
	ImageSize = 20
});
spawn(function()
	while task.wait() do
		pcall(function()
			local GameTime = math.floor(workspace.DistributedGameTime + 0.5);
			local Hour = math.floor(GameTime / 60 ^ 2) % 24;
			local Minute = math.floor(GameTime / 60 ^ 1) % 60;
			local Second = math.floor(GameTime / 60 ^ 0) % 60;
			GameTimeParagraph:SetDesc(Hour .. " Hours " .. Minute .. " Minute " .. Second .. " Second");
		end);
	end;
end);
FpsParagraph = Tabs.InfoTab:Paragraph({
	Title = "Fps",
	Desc = "0",
	Image = "monitor",
	ImageSize = 20
});
spawn(function()
	while task.wait() do
		pcall(function()
			FpsParagraph:SetDesc(workspace:GetRealPhysicsFPS());
		end);
	end;
end);
PingParagraph = Tabs.InfoTab:Paragraph({
	Title = "Ping",
	Desc = "0",
	Image = "signal",
	ImageSize = 20
});
spawn(function()
	while task.wait() do
		pcall(function()
			PingParagraph:SetDesc((game:GetService("Stats")).Network.ServerStatsItem["Data Ping"]:GetValueString());
		end);
	end;
end);

local TeleportService = game:GetService("TeleportService")
local PlaceId = game.PlaceId
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local net = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net")


task.spawn(function()
	while wait() do
		Players = game:GetService("Players")
		LocalPlayer = Players.LocalPlayer
		Character = LocalPlayer.Character
		Humanoid = Character:WaitForChild("Humanoid")
		HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
		Animator = Humanoid:FindFirstChild("Animator") or Instance.new("Animator", Humanoid)
		RodIdle = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Animations"):WaitForChild("ReelingIdle")
		RodReel = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Animations"):WaitForChild("ReelStart")
		ReelIntermission = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Animations"):WaitForChild("ReelIntermission")
		RodShake = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Animations"):WaitForChild("RodThrow")
		RodShakeAnim = Animator:LoadAnimation(RodShake)
		RodIdleAnim = Animator:LoadAnimation(RodIdle)
		RodReelAnim = Animator:LoadAnimation(RodReel)
		ReelIntermissionAnim = Animator:LoadAnimation(ReelIntermission)
	end
end)

local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
VirtualInputManager = game:GetService("VirtualInputManager")
Camera = workspace.CurrentCamera
VariantsModule = require(ReplicatedStorage.Variants)
EnchantsModule = require(ReplicatedStorage.Enchants)
BoatsModule = require(ReplicatedStorage.Boats)
BaitsModule = require(ReplicatedStorage.Baits)
ItemsModule = require(ReplicatedStorage.Items)
TiersModule = require(ReplicatedStorage.Tiers)
Replion = require(ReplicatedStorage.Packages:WaitForChild("Replion"))
ItemUtility = require(ReplicatedStorage.Shared.ItemUtility)

FishingControllerModule = require(ReplicatedStorage.Controllers.FishingController)

function DropBait()
	FishingControllerModule.RequestChargeFishingRod()
	task.wait(0.1)
	if LocalPlayer.PlayerGui.Charge.Enabled then
		local viewport = Camera.ViewportSize
		local x = viewport.X - 1  
		local y = viewport.Y - 1  
		VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 0)
		task.wait(0.05)
		VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 0)
	end
end

function Click()
	FishingControllerModule.FishingMinigameClick()
end

function getTiers()
	local result = {}
	for i, v in pairs(TiersModule) do
		table.insert(result, v)
	end
	return result
end
function getGears()
	local result = {}
	for i, v in pairs(ItemsModule) do
		if v.Data.Type == "Gears" and v.Price then 
			table.insert(result, v)
		end
	end
	return result
end
function getRods()
	local result = {}
	for i, v in pairs(ItemsModule) do
		if v.Data.Type == "Fishing Rods" and v.Price then 
			table.insert(result, v)
		end
	end
	return result
end
function getFish()
	local result = {}
	for i, v in pairs(VariantsModule) do
		if v.Data.Type == "Fishes" then 
			table.insert(result, v)
		end
	end
	return result
end
function getBaits()
	local result = {}
	for i, v in pairs(BaitsModule) do
		if v.Price then 
			table.insert(result, v)
		end
	end
	return result
end
local tierList = {}
task.spawn(function()
	for i, v in pairs(getTiers()) do
		table.insert(tierList, v.Tier .. " - " .. v.Name)
	end
end)
local gearsList = {}
task.spawn(function()
	for i, v in pairs(getGears()) do
		table.insert(gearsList, v.Data.Name .. " ( " .. v.Price .. " )")
	end
end)
local fishList = {}
task.spawn(function()
	for i, v in pairs(getFish()) do
		table.insert(fishList, v.Data.Name)
	end
end)
local rodsList = {}
task.spawn(function()
	for i, v in pairs(getRods()) do
		table.insert(rodsList, v.Data.Name .. " ( " .. v.Price .. " )")
	end
end)
local variantList = {}
task.spawn(function()
	for i, v in pairs(VariantsModule) do
		table.insert(variantList, i)
	end
end)
local enchantsList = {}
task.spawn(function()
	for i, v in pairs(EnchantsModule) do
		table.insert(enchantsList, i)
	end
end)
local baitsList = {}
task.spawn(function()
	for i, v in pairs(getBaits()) do
		table.insert(baitsList, v.Data.Name .. " ( " .. v.Price .. " )")
	end
end)
local boatsList = {}
task.spawn(function()
	for i, v in pairs(BoatsModule) do
		if v.Price then
			table.insert(boatsList, i .. " ( " .. v.Price .. " )")
		end
	end
end)
function getIslandList()
	local result = {}
	local folder = workspace["!!!! ISLAND LOCATIONS !!!!"]
	for i, v in pairs(folder:GetChildren()) do
		table.insert(result, v)
	end
	return result
end

local islandList = {}
task.spawn(function()
	for i, v in pairs(getIslandList()) do
		table.insert(islandList, v.Name)
	end
end)
local playerList = {}
task.spawn(function()
	for i, v in pairs(Players:GetChildren()) do
		table.insert(playerList, v.Name)
	end
end)
function InstantReel()
	net:WaitForChild("RE/FishingCompleted"):FireServer()
end
function favoriteItem(v)
	net:WaitForChild("RF/FavoriteItem"):FireServer(v)
end
function SellAll()
	net:WaitForChild("RF/SellAllItems"):InvokeServer()
end
function SellHeld(v)
	net:WaitForChild("RF/SellItem"):InvokeServer(v)
end
function PurchaseBait(id)
	net:WaitForChild("RF/PurchaseBait"):InvokeServer(id)
end
function EquipBait(id)
	net:WaitForChild("RE/EquipBait"):FireServer(id)
end
function PurchaseRod(id)
	net:WaitForChild("RF/PurchaseFishingRod"):InvokeServer(id)
end
function PurchaseGear(id)
	net:WaitForChild("RF/PurchaseGear"):InvokeServer(id)
end
function PurchaseBoat(id)
	net:WaitForChild("RF/PurchaseBoat"):InvokeServer(id)
end
function MoveTo(v)
	HumanoidRootPart.CFrame = v
end
function equipRod()
	net:WaitForChild("RE/EquipToolFromHotbar"):FireServer(1)
end

local RodsDelay = {
    ["Ares Rod"] = {custom = 1.12, bypass = 1.45},
    ["Angler Rod"] = {custom = 1.12, bypass = 1.45},
    ["Ghostfinn Rod"] = {custom = 1.12, bypass = 1.45},
    ["Astral Rod"] = {custom = 1.9, bypass = 1.45},
    ["Chrome Rod"] = {custom = 2.3, bypass = 2},
    ["Steampunk Rod"] = {custom = 1.2, bypass = 1.1},
    ["Lucky Rod"] = {custom = 2.2, bypass = 2.1},
    ["Midnight Rod"] = {custom = 3.3, bypass = 3.4},
    ["Demascus Rod"] = {custom = 2.2, bypass = 2.1},
    ["Grass Rod"] = {custom = 2.2, bypass = 2.1},
    ["Luck Rod"] = {custom = 1.8, bypass = 1.7},
    ["Carbon Rod"] = {custom = 2.2, bypass = 2.1},
    ["Lava Rod"] = {custom = 4.2, bypass = 4.1},
    ["Starter Rod"] = {custom = 2.5, bypass = 2.4},
    ["Ice Rod"] = {custom = 2.2, bypass = 2.1},
}

local customDelay = 1
local bypassDelay = 0.5

function getRodName()
    local display = LocalPlayer.PlayerGui:WaitForChild("Backpack"):WaitForChild("Display")
    for _, tile in ipairs(display:GetChildren()) do
        local success, itemNamePath = pcall(function()
            return tile.Inner.Tags.ItemName
        end)
        if success and itemNamePath and itemNamePath:IsA("TextLabel") then
            local name = itemNamePath.Text
            if RodsDelay[name] then
                return name
            end
        end
    end
    return nil
end
function initDelayRod()
    local rodName = getRodName()
    if rodName and RodsDelay[rodName] then
        customDelay = RodsDelay[rodName].custom
        bypassDelay = RodsDelay[rodName].bypass
    else
        customDelay = 5
        bypassDelay = 1
    end
end
function getDelayRod()
	for i, v in pairs(getRods()) do
		local display = LocalPlayer.PlayerGui:WaitForChild("Backpack"):WaitForChild("Display")
		for _, tile in ipairs(display:GetChildren()) do
			local success, itemNamePath = pcall(function()
				return tile.Inner.Tags.ItemName
			end)
			if success and itemNamePath and itemNamePath:IsA("TextLabel") then
				local name = itemNamePath.Text
				if v.Data.Name == name then
					return math.abs(v.Resilience - 6.3)
				end
			end
		end
	end
	return 5
end
net["RE/ReplicateTextEffect"].OnClientEvent:Connect(function(data)
    if _G.AutoFish and _G.ActiveFishing and data then
        local myHead = Character and Character:FindFirstChild("Head")
        if myHead and data.Container == myHead then
            task.spawn(function()
                for i = 1, 3 do
                    task.wait(_G.InstantDelay)
                    InstantReel()
                end
            end)
        end
    end
end)
function StopFish()
	_G.ActiveFishing = false
    net:WaitForChild("RF/CancelFishingInputs"):InvokeServer()
    RodIdleAnim:Stop()
    RodShakeAnim:Stop()
    RodReelAnim:Stop()
end
spawn(function()
	while wait() do
		if _G.AutoFish then
			if  _G.FishingMethod == "Instant" then
				pcall(function()
					_G.ActiveFishing = true
					local timestamp = workspace:GetServerTimeNow()
					equipRod()

					task.wait(0.1)
					net:WaitForChild("RF/ChargeFishingRod"):InvokeServer(timestamp)

					RodShakeAnim:Play()
					local baseX, baseY = -0.7499996423721313, 1
					local x, y
					x = baseX + (math.random(-500, 500) / 10000000)
					y = baseY + (math.random(-500, 500) / 10000000)

					net:WaitForChild("RF/ChargeFishingRod"):InvokeServer(timestamp)
					
					ReelIntermissionAnim:Play()
					net:WaitForChild("RF/RequestFishingMinigameStarted"):InvokeServer(x, y)
					task.wait(0.1)
					_G.ActiveFishing = false
				end)
			elseif _G.FishingMethod == "Click" then
				equipRod()
				task.wait(0.1)
				DropBait()
			end
		end
	end
end)
spawn(function()
	RunService.RenderStepped:Connect(function()
		if _G.AutoFish and _G.FishingMethod == "Click" then
			pcall(function()
				for i = 1, 3 do
					Click();
				end
			end);
		end;
	end);
end);
AutoFishingSection = Tabs.MainTab:Section({
	Title = "Auto Fishing",
	TextXAlignment = "Left",
})
local FishingMethod = {
	"Click",
	"Instant"
}
FishingMethodDropdown = AutoFishingSection:Dropdown({
	Title = "Fishing Method",
	Values = FishingMethod,
	Value = FishingMethod[2],
	Callback = function(value)
		_G.FishingMethod = value
	end
})
DelayInstantSlider = AutoFishingSection:Slider({
	Title = "Instant Delay",
	Step = 0.1,
	Value = {
		Min = 0,
		Max = 5,
		Default = 1,
	},
	Callback = function(value)
		_G.InstantDelay = value
	end
})

AutoFishToggle = AutoFishingSection:Toggle({
	Title = "Auto Fish",
	Default = false,
	Callback = function(state)
		_G.AutoFish = state;
		if state then
			StopFish()
		end
	end
})
AutoSellSection = Tabs.MainTab:Section({
	Title = "Auto Sell",
	TextXAlignment = "Left",
})
AutoSellDelaySlider = AutoSellSection:Slider({
	Title = "Sell Delay /s",
	Step = 1,
	Value = {
		Min = 1,
		Max = 60,
		Default = 20,
	},
	Callback = function(value)
		_G.SellDelay = value
	end
})
AutoSellToggle = AutoSellSection:Toggle({
	Title = "Auto Sell",
	Default = false,
	Callback = function(state)
		_G.AutoSell = state;
	end
})
spawn(function()
	while wait() do
		if _G.AutoSell then
			pcall(function()
				SellAll()
				task.wait(_G.SellDelay)
			end)
		end
	end
end)
FavoritSection = Tabs.MainTab:Section({
	Title = "Favorit",
	TextXAlignment = "Left",
})
SelectedFavoriteTiersDropdown = FavoritSection:Dropdown({
	Title = "Select Favorite Tier",
	Values = tierList,
	Value = {},
	Multi = true,
	Callback = function(value)
		_G.SelectedFavoriteTier = value
	end
})
AutoFavoriteToggle = FavoritSection:Toggle({
	Title = "Auto Favorite",
	Default = false,
	Callback = function(state)
		_G.AutoFavorite = state;
	end
})
spawn(function()
	while wait() do
		if _G.AutoFavorite then
			pcall(function()
				if not Replion or not ItemUtility then return end
                local DataReplion = Replion.Client:WaitReplion("Data")
                local items = DataReplion and DataReplion:Get({"Inventory","Items"})
                if type(items) ~= "table" then return end
                for _, item in ipairs(items) do
                    local base = ItemUtility:GetItemData(item.Id)
                    if base and base.Data and item.Favorited ~= nil and not item.Favorited then
						for i, v in pairs(_G.SelectedFavoriteTier) do
							if string.find(v, base.Data.Tier) then
								print(item.UUID)
                        		favoriteItem(item.UUID)
							end 
						end
                    end
                end
			end)
		end
	end
end)
RodShopSection = Tabs.ShopTab:Section({
	Title = "Rods Shop",
	TextXAlignment = "Left"
})
SelectedRodShopDropdown = RodShopSection:Dropdown({
	Title = "Select Rod",
	Values = rodsList,
	Value = nil,
	Callback = function(value)
		_G.SelectedRodShop = value
	end
})
BuySelectedRodButton = RodShopSection:Button({
	Title = "Buy Rod",
	Callback = function()
		for i, v in pairs(getRods()) do
			if string.find(_G.SelectedRodShop, v.Data.Name) then
				PurchaseRod(v.Data.Id)
			end
		end
	end
})
BaitShopSection = Tabs.ShopTab:Section({
	Title = "Baits Shop",
	TextXAlignment = "Left"
})
SelectedBaitShopDropdown = BaitShopSection:Dropdown({
	Title = "Select Bait",
	Values = baitsList,
	Value = nil,
	Callback = function(value)
		_G.SelectedBaitShop = value
	end
})
BuySelectedBaitButton = BaitShopSection:Button({
	Title = "Buy Bait",
	Callback = function()
		for i, v in pairs(getBaits()) do
			if string.find(_G.SelectedBaitShop, v.Data.Name) then
				PurchaseBait(v.Data.Id)
			end
		end
	end
})
GearShopSection = Tabs.ShopTab:Section({
	Title = "Gears Shop",
	TextXAlignment = "Left"
})
SelectedGearShopDropdown = GearShopSection:Dropdown({
	Title = "Select Gear",
	Values = gearsList,
	Value = nil,
	Callback = function(value)
		_G.SelectedGearShop = value
	end
})
BuySelectedGearButton = GearShopSection:Button({
	Title = "Buy Gear",
	Callback = function()
		for i, v in pairs(getGears()) do
			if string.find(_G.SelectedGearShop, v.Data.Name) then
				PurchaseGear(v.Data.Id)
			end
		end
	end
})
BoatShopSection = Tabs.ShopTab:Section({
	Title = "Boats Shop",
	TextXAlignment = "Left"
})
SelectedBoatShopDropdown = BoatShopSection:Dropdown({
	Title = "Select Boat",
	Values = boatsList,
	Value = nil,
	Callback = function(value)
		_G.SelectedBoatShop = value
	end
})
BuySelectedBoatButton = BoatShopSection:Button({
	Title = "Buy Boat",
	Callback = function()
		for i, v in pairs(BoatsModule) do
			if string.find(_G.SelectedBoatShop, i) then
				PurchaseBoat(i)
			end
		end
	end
})
TeleportIslandSection = Tabs.TeleportTab:Section({
	Title = "Teleport Island",
	TextXAlignment = "Left"
});
SelectedIslandDropdown = TeleportIslandSection:Dropdown({
	Title = "Select Island",
	Values = islandList,
	Value = nil,
	Callback = function(value)
		_G.SelectedIsland = value
	end
});
TeleportToIslandButton = TeleportIslandSection:Button({
	Title = "Teleport to Island",
	Callback = function()
		for i, v in pairs(getIslandList()) do
			if v.Name == _G.SelectedIsland then
				MoveTo(v.CFrame)
			end
		end
	end
});
TeleportPlaceSection = Tabs.TeleportTab:Section({
	Title = "Teleport Place",
	TextXAlignment = "Left"
});
local PlaceList = {
	["Acient Jungle"] = CFrame.new(1221.084228515625, 6.624999523162842, -544.1521606445312),
	["Coral Reefs"] = CFrame.new(-3262.536376953125, 2.499969244003296, 2216.586181640625),
	["Crater Island"] = CFrame.new(986.1575317382812, 3.1964468955993652, 5146.69970703125),
	["Esoteric Depths"] = CFrame.new(983311.6767578125, -1302.8548583984375, 1394.7261962890625),
	["Kohana"] = CFrame.new(-656.1355590820312, 17.250059127807617, 448.951171875),
	["Kohana Volcano"] = CFrame.new(-554.2496948242188, 18.236753463745117, 117.22779846191406),
	["Sisyphus Statue"] = CFrame.new(-3731.935546875, -135.0744171142578, -1014.7938232421875),
	["Treasure Room"] = CFrame.new(-3560.293212890625, -279.07421875, -1605.2633056640625),
	["Mount Hallow"] = CFrame.new(2144.46728515625, 80.88066864013672, 3269.4921875),
	["Tropical Grove"] = CFrame.new(-2091.44580078125, 6.268016815185547, 3699.8486328125),
	["Crystal Cavern"] = CFrame.new(-1723.7686767578125, -450.00048828125, 7205.43701171875),
	["Crystal Falls"] = CFrame.new(-1955.166748046875, -447.50048828125, 7419.4140625),
}
SelectedPlaceDropdown = TeleportPlaceSection:Dropdown({
	Title = "Select Place",
	Values = (function()
		local places = {}
		for placeName, _ in pairs(PlaceList) do
			table.insert(places, placeName)
		end
		return places
	end)(),
	Value = nil,
	Callback = function(value)
		_G.SelectedPlace = value
	end
});
TeleportToPlaceButton = TeleportPlaceSection:Button({
	Title = "Teleport to Place",
	Callback = function()
		local targetCFrame = PlaceList[_G.SelectedPlace]
		if targetCFrame then
			MoveTo(targetCFrame)
		end
	end
});
TeleportPlayerSection = Tabs.TeleportTab:Section({
	Title = "Teleport Player",
	TextXAlignment = "Left"
});
SelectedPlayerDropdown = TeleportPlayerSection:Dropdown({
	Title = "Select Player",
	Values = playerList,
	Value = nil,
	Callback = function(value)
		_G.SelectedPlayer = value
	end
});
TeleportToPlayerButton = TeleportPlayerSection:Button({
	Title = "Teleport to Player",
	Callback = function()
		for i, v in pairs(Players:GetPlayers()) do
			if v.Name == _G.SelectedPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
				MoveTo(v.Character.HumanoidRootPart.CFrame)
			end
		end
	end
});
task.spawn(function()
    while task.wait(5) do
        if not LocalPlayer or not LocalPlayer:IsDescendantOf(game) then
            TeleportService:Teleport(game.PlaceId)
        end
    end
end)
TeleportService.TeleportInitFailed:Connect(function(player, teleportResult)
    if teleportResult == Enum.TeleportResult.Failure then
        TeleportService:Teleport(game.PlaceId)
    end
end)

OxygenSection = Tabs.MiscTab:Section({
	Title = "Oxygen",
	TextXAlignment = "Left"
});
BypassOxygenButton = OxygenSection:Button({
	Title = "Bypass Oxygen",
	Callback = function()
		net["URE/UpdateOxygen"]:Destroy()
	end
});
ServerSection = Tabs.ServerTab:Section({
	Title = "Server",
	TextXAlignment = "Left"
});
RejoinServerButton = ServerSection:Button({
	Title = "Rejoin Server",
	Callback = function()
		TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId);
	end
});
HopServerButton = ServerSection:Button({
	Title = "Hop Server",
	Callback = function()
		local module = (loadstring(game:HttpGet("https://raw.githubusercontent.com/raw-scriptpastebin/FE/main/Server_Hop_Settings")))();
		module:Teleport(game.PlaceId);
	end
});
JobIdSection = Tabs.ServerTab:Section({
	Title = "Job ID",
	TextXAlignment = "Left"
});
JobIdParagraph = JobIdSection:Paragraph({
	Title = "Job ID",
	Desc = game.JobId
});
CopyJobIdButton = JobIdSection:Button({
	Title = "Copy Job ID",
	Callback = function()
		setclipboard(game.JobId);
	end
});
JobIdInput = JobIdSection:Input({
	Title = "Job ID",
	Placeholder = "Enter Job ID",
	Type = "Input",
	Callback = function(value)
		_G.JobId = value;
	end
});
JoinJobIdServerButton = JobIdSection:Button({
	Title = "Join Job ID",
	Callback = function()
		TeleportService:TeleportToPlaceInstance(game.PlaceId, _G.JobId);
	end
});
