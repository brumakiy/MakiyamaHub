local function checkKey()
    local correctKey = "Lu15#V14d0"  
    local userInput = "" 

    
    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    local screenGui = Instance.new("ScreenGui", playerGui)
    screenGui.Name = "KeyInput"

    local textBox = Instance.new("TextBox", screenGui)
    textBox.Position = UDim2.new(0.5, -100, 0.5, -25)
    textBox.Size = UDim2.new(0, 200, 0, 50)
    textBox.PlaceholderText = "Digite a chave"
    textBox.TextScaled = true
    textBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)

    local submitButton = Instance.new("TextButton", screenGui)
    submitButton.Position = UDim2.new(0.5, -50, 0.5, 35)
    submitButton.Size = UDim2.new(0, 100, 0, 50)
    submitButton.Text = "Submeter"
    submitButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)

    local openLinkButton = Instance.new("TextButton", screenGui)
    openLinkButton.Position = UDim2.new(0.5, -50, 0.5, 95)
    openLinkButton.Size = UDim2.new(0, 100, 0, 50)
    openLinkButton.Text = "Pegar Key"
    openLinkButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
    openLinkButton.TextColor3 = Color3.fromRGB(255, 255, 255)

    openLinkButton.MouseButton1Click:Connect(function()
        
        game:GetService("GuiService"):OpenBrowserWindow("https://direct-link.net/1331628/key-cheat") 
    end)

    submitButton.MouseButton1Click:Connect(function()
        userInput = textBox.Text
        if userInput == correctKey then
            
            screenGui:Destroy() 

            
            local hubCode = game:HttpGet("https://raw.githubusercontent.com/brumakiy/MakiyamaHub/refs/heads/main/(hub%203).lua")
            loadstring(hubCode)() 
        else
            
            local errorMessage = Instance.new("TextLabel", screenGui)
            errorMessage.Text = "Chave incorreta!"
            errorMessage.Size = UDim2.new(0, 200, 0, 50)
            errorMessage.Position = UDim2.new(0.5, -100, 0.5, 95)
            errorMessage.TextColor3 = Color3.fromRGB(255, 0, 0)
            errorMessage.TextScaled = true
        end
    end)
end


checkKey()
