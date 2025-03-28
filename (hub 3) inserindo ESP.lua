-- Codigo do ESP
local Players = game:GetService("Players")
local espColor = Color3.fromRGB(255, 0, 0)  -- Cor padrão (vermelho)

local function addESP(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        if player.Character:FindFirstChild("ESP_Highlight") then return end
        
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESP_Highlight"
        highlight.FillColor = espColor  -- Aplica a cor escolhida
        highlight.FillTransparency = 0.5
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)  -- Borda branca
        highlight.OutlineTransparency = 0
        highlight.Adornee = player.Character
        highlight.Parent = player.Character
    end
end

local function removeESP(player)
    if player.Character and player.Character:FindFirstChild("ESP_Highlight") then
        player.Character:FindFirstChild("ESP_Highlight"):Destroy()
    end
end

local function toggleESP(state)
    if state then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer then
                addESP(player)
            end
        end
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function()
                addESP(player)
            end)
        end)
    else
        for _, player in ipairs(Players:GetPlayers()) do
            removeESP(player)
        end
    end
end

-- Codigo do fly
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local flying = false
local flySpeed = 50 -- Velocidade inicial
local flyDirection = Vector3.new(0, 0, 0)
local bodyVelocity

local function startFly()
    if flying or not HumanoidRootPart then return end
    flying = true

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVelocity.Parent = HumanoidRootPart

    RunService.RenderStepped:Connect(function()
        if not flying then return end
        bodyVelocity.Velocity = (workspace.CurrentCamera.CFrame.LookVector * flyDirection.Z + 
                                workspace.CurrentCamera.CFrame.RightVector * flyDirection.X + 
                                Vector3.new(0, flyDirection.Y, 0)) * flySpeed
    end)
end

local function stopFly()
    flying = false
    if bodyVelocity then 
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.W then
        flyDirection = flyDirection + Vector3.new(0, 0, 1)
    elseif input.KeyCode == Enum.KeyCode.S then
        flyDirection = flyDirection + Vector3.new(0, 0, -1)
    elseif input.KeyCode == Enum.KeyCode.A then
        flyDirection = flyDirection + Vector3.new(-1, 0, 0)
    elseif input.KeyCode == Enum.KeyCode.D then
        flyDirection = flyDirection + Vector3.new(1, 0, 0)
    elseif input.KeyCode == Enum.KeyCode.Space then
        flyDirection = flyDirection + Vector3.new(0, 1, 0)
    elseif input.KeyCode == Enum.KeyCode.LeftControl then
        flyDirection = flyDirection + Vector3.new(0, -1, 0)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W then
        flyDirection = flyDirection - Vector3.new(0, 0, -1)
    elseif input.KeyCode == Enum.KeyCode.S then
        flyDirection = flyDirection - Vector3.new(0, 0, 1)
    elseif input.KeyCode == Enum.KeyCode.A then
        flyDirection = flyDirection - Vector3.new(-1, 0, 0)
    elseif input.KeyCode == Enum.KeyCode.D then
        flyDirection = flyDirection - Vector3.new(1, 0, 0)
    elseif input.KeyCode == Enum.KeyCode.Space then
        flyDirection = flyDirection - Vector3.new(0, 1, 0)
    elseif input.KeyCode == Enum.KeyCode.LeftControl then
        flyDirection = flyDirection - Vector3.new(0, -1, 0)
    end
end)



local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/7yhx/kwargs_Ui_Library/main/source.lua"))()

local UI = Lib:Create{
   Theme = "Dark", 
   Size = UDim2.new(0, 555, 0, 400) 
}

local JogadorTab = UI:Tab{
   Name = "Jogador"
}

local JogadorDivider = JogadorTab:Divider{
   Name = "Movimentação"
}

local MatarTodos = JogadorDivider:Button{
    Name = "Matar todos",
    Description = "Mata todos os jogadores dentro do jogo!",
    Callback = function()
        print("Todos os jogadores foram mortos.")
    end
}

local PlayerTeleport = JogadorDivider:Dropdown{
    Name = "Teleporte para um player",
    Options = {"Player1", "Player2", "Player3", "Player4", "Player5"},
    Callback = function(Value)
        print(Value)
    end
}

local FlyToggle = JogadorDivider:Toggle{
    Name = "Fly",
    Description = "Voe por aí...",
    Callback = function(State)
        if State then
            startFly()
        else
            stopFly()
        end
    end
}

JogadorDivider:Box{
    Name = "Velocidade do Fly",
    ClearText = true, 
    Callback = function(Value)
        local num = tonumber(Value)
        if num then
            flySpeed = num
        end
    end
}


JogadorDivider:Box{
    Name = "Velocidade",
    ClearText = true, 
    Callback = function(Value)
        print(Value)
    end
}

JogadorDivider:Box{
    Name = "Pulo",
    ClearText = true, 
    Callback = function(Value)
        print(Value)
    end
}


local VisualTab = UI:Tab{
    Name = "Visual"
}
 
local VisualDivider = VisualTab:Divider{
    Name = "Visual"
}

local Esp = VisualDivider:Toggle{
    Name = "Ativar ESP",
    Description = "Descubra onde os jogadores estão!",
    Callback = function(State)
        toggleESP(State)
    end
}

VisualDivider:ColorPicker{
    Name = "Cor do ESP",
    Default = Color3.fromRGB(255, 0, 0),  -- Cor inicial (vermelho)
    Callback = function(Value)
        espColor = Value  -- Atualiza a cor do ESP
        -- Atualiza a cor de todos os ESPs já criados
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("ESP_Highlight") then
                player.Character:FindFirstChild("ESP_Highlight").FillColor = espColor
            end
        end
    end
}

local CombateTab = UI:Tab{
    Name = "Combate"
}

local CombateDivider = CombateTab:Divider{
    Name = "Combate"
}

local Aimbot = CombateDivider:Toggle{
    Name = "Ativar Aimbot",
    Description = "Gruda a mira nos jogadores.",
    Callback = function(State)
        print("Aimbot state: ", State)
    end
}

local FecharTab = UI:Tab{
   Name = "Sair"
}

local FecharDivider = FecharTab:Divider{
    Name = "Fechar"
}

local FecharUI = FecharDivider:Button{
    Name = "Fechar UI",
    Callback = function()
        UI:Quit{
            Message = "Até a próxima...", 
            Length = 1 
        }
    end
}