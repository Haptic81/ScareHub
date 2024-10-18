local DiscordLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt"))()

local win = DiscordLib:Window("ScareHub")

local serv = win:Server("S", "")  -- New tab labeled "S"

-- Button to make the player invisible
serv:Channel("Invisible Feature"):Button("Invisible", function()
    loadstring(game:HttpGet('https://pastebin.com/raw/3Rnd9rHf'))()
end)

-- Button to create the teleport UI for scaring players
serv:Channel("Scare Feature"):Button("Scare", function()
    -- Teleport UI script
    local player = game.Players.LocalPlayer

    -- Create ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "TeleportUI"
    screenGui.Parent = player:WaitForChild("PlayerGui")

    -- Create Frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.3, 0, 0.2, 0)
    frame.Position = UDim2.new(0.5, -frame.Size.X.Offset / 2, 0.5, -frame.Size.Y.Offset / 2)
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    frame.Parent = screenGui

    -- Create TextBox for player name input
    local playerNameBox = Instance.new("TextBox")
    playerNameBox.Size = UDim2.new(1, 0, 0.2, 0)
    playerNameBox.Position = UDim2.new(0, 0, 0, 0)
    playerNameBox.PlaceholderText = "Enter Player Name"
    playerNameBox.Parent = frame

    -- Create Teleport Button
    local teleportButton = Instance.new("TextButton")
    teleportButton.Size = UDim2.new(1, 0, 0.3, 0)
    teleportButton.Position = UDim2.new(0, 0, 0.25, 0)
    teleportButton.Text = "Teleport"
    teleportButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    teleportButton.Parent = frame

    -- Create Close Button
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0.3, 0, 0.3, 0)
    closeButton.Position = UDim2.new(0.7, 0, 0.25, 0)
    closeButton.Text = "Close"
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeButton.Parent = frame

    -- Function to teleport the player in front of the target character
    local function teleportToPlayer(targetPlayer)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local character = targetPlayer.Character
            local originalPosition = player.Character.HumanoidRootPart.Position
            
            -- Teleport the player in front of the target character
            local targetPosition = character.HumanoidRootPart.Position + (character.HumanoidRootPart.CFrame.LookVector * 5) -- Adjust the distance as needed
            player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition, character.HumanoidRootPart.Position)

            -- Follow the character for 0.5 seconds
            local duration = 0.5 -- Adjusted duration
            local startTime = tick()

            while tick() - startTime < duration do
                local newPosition = character.HumanoidRootPart.Position + (character.HumanoidRootPart.CFrame.LookVector * 5)
                player.Character.HumanoidRootPart.CFrame = CFrame.new(newPosition, character.HumanoidRootPart.Position)
                wait(0.1)
            end
            
            -- Return to original position
            player.Character.HumanoidRootPart.CFrame = CFrame.new(originalPosition)
        end
    end

    -- Teleport button click event
    teleportButton.MouseButton1Click:Connect(function()
        local targetPlayerName = playerNameBox.Text
        local targetPlayer = nil

        -- Loop through all players to find one whose name starts with the input text
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Name:sub(1, #targetPlayerName):lower() == targetPlayerName:lower() then
                targetPlayer = p
                break -- Stop searching after the first match
            end
        end

        if targetPlayer then
            teleportToPlayer(targetPlayer)
        else
            playerNameBox.Text = "Player not found!" -- Feedback for invalid names
        end
    end)

    -- Close button click event
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy() -- Close the UI by destroying it
    end)

    -- Make the UI movable
    local dragging
    local dragStart
    local startPos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
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

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end)

-- Credits channel
serv:Channel("Credits")
serv:Label("Made by HapticRBLX")  -- Credit line for the creator
