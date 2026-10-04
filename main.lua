-- Custom UI + Cloud-Synced Eternal Predictor
-- Creator: By Nexfarz99

local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")

local request = (syn and syn.request) or (http and http.request) or http_request or request

local BIN_ID = "6ac22b4affd5d160534ba7a4"
local API_KEY = "$2a$10$bfLIuLcjWMfgyAbO7gbGRelYJhs5E9a0NycoDv8AS66ml1/VeXipm"
local DATABASE_URL = "https://api.jsonbin.io/v3/b/" .. BIN_ID

if CoreGui:FindFirstChild("EternalPredictorUI") then
    CoreGui.EternalPredictorUI:Destroy()
end

-- 1. UI SETUP (Ukuran dilebarin ke 420px)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "EternalPredictorUI"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 440)
MainFrame.Position = UDim2.new(0.5, -210, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainUIStroke = Instance.new("UIStroke")
MainUIStroke.Thickness = 2
MainUIStroke.Color = Color3.fromRGB(255, 140, 0)
MainUIStroke.Parent = MainFrame

-- HEADER & CONTROL BUTTONS (Minimize & Close)
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -70, 0, 26)
Title.Position = UDim2.new(0, 12, 0, 6)
Title.BackgroundTransparency = 1
Title.Text = "ETERNAL PREDICTOR (CLOUD)"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextSize = 14
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -70, 0, 16)
Subtitle.Position = UDim2.new(0, 12, 0, 28)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "By Nexfarz99"
Subtitle.TextColor3 = Color3.fromRGB(255, 120, 0)
Subtitle.TextSize = 12
Subtitle.Font = Enum.Font.SourceSansItalic
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = MainFrame

-- Minimize Button (-)
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 24, 0, 24)
MinBtn.Position = UDim2.new(1, -56, 0, 8)
MinBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
MinBtn.TextSize = 16
MinBtn.Font = Enum.Font.SourceSansBold
MinBtn.Parent = MainFrame

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinBtn

-- Close Button (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -28, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

-- Floating Open Button (Saat Minimize)
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 45, 0, 45)
OpenBtn.Position = UDim2.new(0, 15, 0.5, -22)
OpenBtn.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
OpenBtn.Text = "🔮"
OpenBtn.TextSize = 22
OpenBtn.Visible = false
OpenBtn.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1, 0)
OpenCorner.Parent = OpenBtn

local OpenStroke = Instance.new("UIStroke")
OpenStroke.Thickness = 2
OpenStroke.Color = Color3.fromRGB(255, 140, 0)
OpenStroke.Parent = OpenBtn

MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenBtn.Visible = false
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local Disclaimer = Instance.new("TextLabel")
Disclaimer.Size = UDim2.new(0.94, 0, 0, 28)
Disclaimer.Position = UDim2.new(0.03, 0, 0, 46)
Disclaimer.BackgroundTransparency = 1
Disclaimer.Text = "⚠️ There is NO 100% guarantee. Predictions are calculated using historical percentage and average RNG intervals."
Disclaimer.TextColor3 = Color3.fromRGB(160, 160, 160)
Disclaimer.TextSize = 10
Disclaimer.TextWrapped = true
Disclaimer.Font = Enum.Font.SourceSans
Disclaimer.Parent = MainFrame

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(0.94, 0, 0, 24)
StatusLabel.Position = UDim2.new(0.03, 0, 0, 78)
StatusLabel.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
StatusLabel.Text = "STATUS: Connecting Cloud..."
StatusLabel.TextColor3 = Color3.fromRGB(255, 230, 100)
StatusLabel.TextSize = 11
StatusLabel.Font = Enum.Font.SourceSansBold
StatusLabel.Parent = MainFrame

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 6)
StatusCorner.Parent = StatusLabel

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(0.94, 0, 0, 320)
Scroll.Position = UDim2.new(0.03, 0, 0, 108)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 4
Scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 140, 0)
Scroll.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 6)
UIList.Parent = Scroll

-- 2. DATABASE PREDIKSI
local petDatabase = {
    ["Phoenix"]        = {avgInterval = 195, lastSpawnTick = 0, cardObj = nil},
    ["Skeleton Horse"] = {avgInterval = 250, lastSpawnTick = 0, cardObj = nil},
    ["Ice Dragon"]     = {avgInterval = 230, lastSpawnTick = 0, cardObj = nil},
    ["Lava Dragon"]    = {avgInterval = 310, lastSpawnTick = 0, cardObj = nil},
    ["Sun Lion"]       = {avgInterval = 270, lastSpawnTick = 0, cardObj = nil},
    ["Lunar Dragon"]   = {avgInterval = 170, lastSpawnTick = 0, cardObj = nil},
    ["Oni Tiger"]      = {avgInterval = 140, lastSpawnTick = 0, cardObj = nil},
    ["Pegasus"]        = {avgInterval = 330, lastSpawnTick = 0, cardObj = nil}
}

-- RECALCULATE & FORMAT PREDICTION TIME
local function RecalculatePredictions()
    for name, data in pairs(petDatabase) do
        local lastTimeText = "Unknown"
        local estTimeText = "Calculating..."
        local chance = 5
        local statusText = "💤 COOLDOWN"
        
        if data.lastSpawnTick > 0 then
            local elapsedSec = os.time() - data.lastSpawnTick
            local elapsedMin = elapsedSec / 60
            local avgMin = data.avgInterval
            
            local estSpawnUnix = data.lastSpawnTick + (avgMin * 60)
            lastTimeText = os.date("%H:%M", data.lastSpawnTick)
            estTimeText = os.date("%H:%M", estSpawnUnix)
            
            local ratio = elapsedMin / avgMin
            chance = math.clamp(math.floor(ratio * 70), 5, 98)
            
            if ratio >= 1.2 then
                chance = 95
                statusText = "🔥 CRITICAL OVERDUE!"
            elseif ratio >= 0.9 then
                statusText = "⚠️ SPAWN WINDOW"
            end
        end
        
        if data.cardObj then
            local desc = data.cardObj:FindFirstChild("Details")
            if desc then
                desc.Text = "Last: " .. lastTimeText .. " | Est: " .. estTimeText .. " | " .. statusText .. " (" .. chance .. "%)"
            end
        end
    end
end

-- FETCH CLOUD DATA
local function FetchCloudData()
    if not request then return end
    pcall(function()
        local response = request({
            Url = DATABASE_URL .. "/latest",
            Method = "GET",
            Headers = { ["X-Master-Key"] = API_KEY }
        })
        if response and response.Body then
            local decoded = HttpService:JSONDecode(response.Body)
            local cloudData = decoded.record
            for petName, lastTick in pairs(cloudData) do
                if petDatabase[petName] and type(lastTick) == "number" then
                    petDatabase[petName].lastSpawnTick = lastTick
                end
            end
            StatusLabel.Text = "STATUS: Synced with Cloud!"
            StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
            RecalculatePredictions()
        end
    end)
end

-- UPLOAD DATA TO CLOUD
local function UploadSpawnToCloud(petName, spawnTick)
    if not request then return end
    
    if petDatabase[petName] then
        petDatabase[petName].lastSpawnTick = spawnTick
    end
    
    local currentRecord = {}
    for name, data in pairs(petDatabase) do
        currentRecord[name] = data.lastSpawnTick
    end
    
    pcall(function()
        request({
            Url = DATABASE_URL,
            Method = "PUT",
            Headers = {
                ["Content-Type"] = "application/json",
                ["X-Master-Key"] = API_KEY
            },
            Body = HttpService:JSONEncode(currentRecord)
        })
    end)
end

-- RENDER CARDS
for name, _ in pairs(petDatabase) do
    local Card = Instance.new("Frame")
    Card.Name = name
    Card.Size = UDim2.new(1, -10, 0, 50)
    Card.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Card.Parent = Scroll

    local CardCorner = Instance.new("UICorner")
    CardCorner.CornerRadius = UDim.new(0, 6)
    CardCorner.Parent = Card

    local PetTitle = Instance.new("TextLabel")
    PetTitle.Size = UDim2.new(1, -10, 0, 18)
    PetTitle.Position = UDim2.new(0, 8, 0, 4)
    PetTitle.BackgroundTransparency = 1
    PetTitle.Text = "🐉 " .. name
    PetTitle.TextColor3 = Color3.fromRGB(255, 165, 0)
    PetTitle.TextSize = 13
    PetTitle.Font = Enum.Font.SourceSansBold
    PetTitle.TextXAlignment = Enum.TextXAlignment.Left
    PetTitle.Parent = Card

    local Details = Instance.new("TextLabel")
    Details.Name = "Details"
    Details.Size = UDim2.new(1, -10, 0, 22)
    Details.Position = UDim2.new(0, 8, 0, 22)
    Details.BackgroundTransparency = 1
    Details.Text = "Syncing cloud data..."
    Details.TextColor3 = Color3.fromRGB(220, 220, 220)
    Details.TextSize = 11
    Details.Font = Enum.Font.SourceSans
    Details.TextXAlignment = Enum.TextXAlignment.Left
    Details.Parent = Card

    petDatabase[name].cardObj = Card
end

Scroll.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 15)

-- AUTO DETECT & BROADCAST
local function OnPetSpawned(petName)
    local currentUnixTime = os.time()
    UploadSpawnToCloud(petName, currentUnixTime)
    
    StatusLabel.Text = "🚨 DETECTED: " .. petName .. " (Cloud Updated)!"
    StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
    
    RecalculatePredictions()
end

Workspace.ChildAdded:Connect(function(obj)
    for name, _ in pairs(petDatabase) do
        if string.find(string.lower(obj.Name), string.lower(name)) then
            OnPetSpawned(name)
        end
    end
end)

-- AUTO REFRESH LOOP
task.spawn(function()
    FetchCloudData()
    while task.wait(15) do
        FetchCloudData()
    end
end)
