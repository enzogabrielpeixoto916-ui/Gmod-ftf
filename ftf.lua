-- Script Unificado: G-Mods Panel FTF Tech Edition (v4.6 - Anti-Freeze Edition)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- Estados globais das funções
local customSpeed = 16
local speedActive = false
local speedConnection = nil

local espPlayersActive = false
local espPlayersConnection = nil
local playerCharConnections = {}

local espPcActive = false
local pcHighlights = {}

local invisibleActive = false

-- Estados do Sistema de Voo CLÁSSICO
local flyActive = false
local flySpeed = 50
local flyConnection = nil
local bVelo = nil
local bGyro = nil

-- Estados do NoClip Otimizado
local noclipActive = false
local noclipConnection = nil

-- Configuração de Key Única e Privada
local KEY_PRIVADA = "vip_painelpriv"
local LINK_WHATSAPP = "https://chat.whatsapp.com/DTOSXCmR3S7K4LQ1f7kbBV?s=cl&p=a&mlu=3"

-- Cores do Tema Tech Neon
local COLOR_BG = Color3.fromRGB(13, 14, 18)
local COLOR_PANEL = Color3.fromRGB(20, 22, 27)
local COLOR_NEON = Color3.fromRGB(255, 51, 75)
local COLOR_TEXT = Color3.fromRGB(240, 242, 245)
local COLOR_SUBTEXT = Color3.fromRGB(140, 145, 160)

-- 1. INJEÇÃO DA INTERFACE VISUAL (GUI MODERNA)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PainelFTFTech"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local parentSucesso = false
local targets = { game:GetService("CoreGui"), player:WaitForChild("PlayerGui", 5), workspace }
for _, target in ipairs(targets) do
    if target then
        local ok, _ = pcall(function() ScreenGui.Parent = target end)
        if ok and ScreenGui.Parent == target then parentSucesso = true break end
    end
end
if not parentSucesso then pcall(function() gethui(ScreenGui) end) end

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 140)
MainFrame.Position = UDim2.new(0.5, -160, 0.25, 0)
MainFrame.BackgroundColor3 = COLOR_BG
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.ZIndex = 1
MainFrame.Parent = ScreenGui

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 10)
UICornerMain.Parent = MainFrame

local UIStrokeMain = Instance.new("UIStroke")
UIStrokeMain.Color = COLOR_PANEL
UIStrokeMain.Thickness = 1.5
UIStrokeMain.Parent = MainFrame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 42, 0, 42)
ToggleButton.Position = UDim2.new(0.05, 0, 0.4, 0)
ToggleButton.BackgroundColor3 = COLOR_BG
ToggleButton.TextColor3 = COLOR_NEON
ToggleButton.TextSize = 18
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "Ω"
ToggleButton.Visible = false
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.ZIndex = 10
ToggleButton.Parent = ScreenGui

local UICornerToggle = Instance.new("UICorner")
UICornerToggle.CornerRadius = UDim.new(0, 10)
UICornerToggle.Parent = ToggleButton

local UIStrokeToggle = Instance.new("UIStroke")
UIStrokeToggle.Color = COLOR_NEON
UIStrokeToggle.Thickness = 1
UIStrokeToggle.Parent = ToggleButton

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- INTERFACE DO SISTEMA DE KEY
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 320, 0, 160)
KeyFrame.Position = UDim2.new(0.5, -160, 0.35, 0)
KeyFrame.BackgroundColor3 = COLOR_BG
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.ZIndex = 5
KeyFrame.Parent = ScreenGui

local UICornerKey = Instance.new("UICorner")
UICornerKey.CornerRadius = UDim.new(0, 10)
UICornerKey.Parent = KeyFrame

local UIStrokeKey = Instance.new("UIStroke")
UIStrokeKey.Color = COLOR_PANEL
UIStrokeKey.Thickness = 1.5
UIStrokeKey.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 35)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "SYSTEM CODES AUTHENTICATION"
KeyTitle.TextColor3 = COLOR_TEXT
KeyTitle.TextSize = 11
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.ZIndex = 6
KeyTitle.Parent = KeyFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(1, -30, 0, 38)
KeyInput.Position = UDim2.new(0, 15, 0, 45)
KeyInput.BackgroundColor3 = COLOR_PANEL
KeyInput.TextColor3 = COLOR_TEXT
KeyInput.TextSize = 13
KeyInput.Font = Enum.Font.Gotham
KeyInput.PlaceholderText = "Enter private decryption key..."
KeyInput.PlaceholderColor3 = COLOR_SUBTEXT
KeyInput.Text = ""
KeyInput.ZIndex = 6
KeyInput.Parent = KeyFrame

local UICornerInput = Instance.new("UICorner")
UICornerInput.CornerRadius = UDim.new(0, 6)
UICornerInput.Parent = KeyInput

local UIStrokeInput = Instance.new("UIStroke")
UIStrokeInput.Color = COLOR_BG
UIStrokeInput.Thickness = 1
UIStrokeInput.Parent = KeyInput

local BtnVerify = Instance.new("TextButton")
BtnVerify.Size = UDim2.new(0, 140, 0, 38)
BtnVerify.Position = UDim2.new(0, 15, 0, 100)
BtnVerify.BackgroundColor3 = COLOR_NEON
BtnVerify.TextColor3 = COLOR_TEXT
BtnVerify.TextSize = 11
BtnVerify.Font = Enum.Font.GothamBold
BtnVerify.Text = "VERIFY ACCESS"
BtnVerify.ZIndex = 6
BtnVerify.Parent = KeyFrame

local UICornerVerify = Instance.new("UICorner")
UICornerVerify.CornerRadius = UDim.new(0, 6)
UICornerVerify.Parent = BtnVerify

local BtnGetKey = Instance.new("TextButton")
BtnGetKey.Size = UDim2.new(0, 140, 0, 38)
BtnGetKey.Position = UDim2.new(1, -155, 0, 100)
BtnGetKey.BackgroundColor3 = COLOR_PANEL
BtnGetKey.TextColor3 = COLOR_SUBTEXT
BtnGetKey.TextSize = 11
BtnGetKey.Font = Enum.Font.GothamBold
BtnGetKey.Text = "GET CREDENTIALS"
BtnGetKey.ZIndex = 6
BtnGetKey.Parent = KeyFrame

local UICornerGetKey = Instance.new("UICorner")
UICornerGetKey.CornerRadius = UDim.new(0, 6)
UICornerGetKey.Parent = BtnGetKey

BtnGetKey.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(LINK_WHATSAPP)
        BtnGetKey.Text = "COPIED TO CLIPBOARD"
        task.wait(2)
        BtnGetKey.Text = "GET CREDENTIALS"
    else
        BtnGetKey.Text = "CLIPBOARD ERROR"
    end
end)

BtnVerify.MouseButton1Click:Connect(function()
    if KeyInput.Text == KEY_PRIVADA then
        KeyFrame:Destroy()
        MainFrame.Visible = true
        ToggleButton.Visible = true
    else
        KeyInput.Text = ""
        KeyInput.PlaceholderText = "ACCESS DENIED!"
        KeyInput.PlaceholderColor3 = COLOR_NEON
        task.wait(1.5)
        KeyInput.PlaceholderText = "Enter private decryption key..."
        KeyInput.PlaceholderColor3 = COLOR_SUBTEXT
    end
end)

-- COMPONENTES DO PAINEL PRINCIPAL
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 30)
Title.Position = UDim2.new(0, 12, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "G-MODS PANEL CORE v4.6 | By @gabriel_egsp"
Title.TextColor3 = COLOR_TEXT
Title.TextSize = 11
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

local LineTech = Instance.new("Frame")
LineTech.Size = UDim2.new(1, -24, 0, 1)
LineTech.Position = UDim2.new(0, 12, 0, 32)
LineTech.BackgroundColor3 = COLOR_PANEL
LineTech.BorderSizePixel = 0
LineTech.Parent = MainFrame

local BarraComando = Instance.new("TextBox")
BarraComando.Size = UDim2.new(1, -24, 0, 38)
BarraComando.Position = UDim2.new(0, 12, 0, 42)
BarraComando.BackgroundColor3 = COLOR_PANEL
BarraComando.TextColor3 = COLOR_TEXT
BarraComando.TextSize = 13
BarraComando.Font = Enum.Font.Gotham
BarraComando.PlaceholderText = "Input command line..."
BarraComando.PlaceholderColor3 = COLOR_SUBTEXT
BarraComando.Text = ""
BarraComando.TextXAlignment = Enum.TextXAlignment.Left
BarraComando.Parent = MainFrame

local UICornerBarra = Instance.new("UICorner")
UICornerBarra.CornerRadius = UDim.new(0, 6)
UICornerBarra.Parent = BarraComando

local PaddingBarra = Instance.new("UIPadding")
PaddingBarra.PaddingLeft = UDim.new(0, 10)
PaddingBarra.Parent = BarraComando

local BotaoAjuda = Instance.new("TextButton")
BotaoAjuda.Size = UDim2.new(1, -24, 0, 32)
BotaoAjuda.Position = UDim2.new(0, 12, 0, 92)
BotaoAjuda.BackgroundColor3 = COLOR_BG
BotaoAjuda.TextColor3 = COLOR_NEON
BotaoAjuda.TextSize = 10
BotaoAjuda.Font = Enum.Font.GothamBold
BotaoAjuda.Text = "DISPLAY CONSOLE COMMANDS"
BotaoAjuda.Parent = MainFrame

local UICornerBotao = Instance.new("UICorner")
UICornerBotao.CornerRadius = UDim.new(0, 6)
UICornerBotao.Parent = BotaoAjuda

local UIStrokeBotao = Instance.new("UIStroke")
UIStrokeBotao.Color = COLOR_PANEL
UIStrokeBotao.Thickness = 1
UIStrokeBotao.Parent = BotaoAjuda

-- CONTAINER DOS COMANDOS
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, 0, 0, 150)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 148)
ScrollingFrame.BackgroundColor3 = COLOR_BG
ScrollingFrame.Visible = false
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 220)
ScrollingFrame.ScrollBarThickness = 4
ScrollingFrame.ScrollBarImageColor3 = COLOR_NEON
ScrollingFrame.Parent = MainFrame

local UICornerScroll = Instance.new("UICorner")
UICornerScroll.CornerRadius = UDim.new(0, 8)
UICornerScroll.Parent = ScrollingFrame

local UIStrokeScroll = Instance.new("UIStroke")
UIStrokeScroll.Color = COLOR_PANEL
UIStrokeScroll.Thickness = 1
UIStrokeScroll.Parent = ScrollingFrame

local ListaTexto = Instance.new("TextLabel")
ListaTexto.Size = UDim2.new(1, -20, 1, 0)
ListaTexto.Position = UDim2.new(0, 12, 0, 12)
ListaTexto.BackgroundTransparency = 1
ListaTexto.TextColor3 = COLOR_TEXT
ListaTexto.TextSize = 11
ListaTexto.Font = Enum.Font.Code
ListaTexto.TextXAlignment = Enum.TextXAlignment.Left
ListaTexto.TextYAlignment = Enum.TextYAlignment.Top
ListaTexto.Text = [[
esp           - Track all entities (Perm)
esp pc        - Highlight terminals
speed [val]   - Bypass walkspeed friction
fly [speed]   - Toggle flight engine
unfly         - Deactivate flight engine
noclip        - Pass through solid objects
unnoclip      - Re-enable physical collisions
invisible     - Activate visual cloak
uninvisible   - Deactivate visual cloak
spectate [p]  - Sync camera to subject
unspectate    - Return camera control]]
ListaTexto.Parent = ScrollingFrame

-- 2. ENGENHARIA E MECÂNICAS INTEGRADAS (OTIMIZADAS CONTRA LAG)

local function obterJogador(nomeParcial)
    if not nomeParcial or nomeParcial == "" then return nil end
    for _, p in ipairs(Players:GetPlayers()) do
        if string.sub(string.lower(p.Name), 1, string.len(nomeParcial)) == string.lower(nomeParcial) or 
           (p.DisplayName and string.sub(string.lower(p.DisplayName), 1, string.len(nomeParcial)) == string.lower(nomeParcial)) then
            return p
        end
    end
    return nil
end

local function gerenciarVelocidade()
    if speedConnection then speedConnection:Disconnect() end
    speedConnection = RunService.RenderStepped:Connect(function()
        if speedActive and player.Character then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid.WalkSpeed = customSpeed end
        end
    end)
end

-- SISTEMA DE VOO ANTIGO INTEGRADO (Leve e Sem Crash)
local function desativarVoo()
    flyActive = false
    if flyConnection then flyConnection:Disconnect() flyConnection = nil end
    if bVelo then bVelo:Destroy() bVelo = nil end
    if bGyro then bGyro:Destroy() bGyro = nil end
    
    if player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then 
            humanoid.PlatformStand = false
            humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end
end

local function ativarVoo()
    desativarVoo()
    local character = player.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    
    if not rootPart or not humanoid then return end
    flyActive = true
    
    bGyro = Instance.new("BodyGyro")
    bGyro.P = 9e4
    bGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bGyro.cframe = rootPart.CFrame
    bGyro.Parent = rootPart
    
    bVelo = Instance.new("BodyVelocity")
    bVelo.velocity = Vector3.new(0, 0, 0)
    bVelo.maxForce = Vector3.new(9e9, 9e9, 9e9)
    bVelo.Parent = rootPart
    
    local camera = Workspace.CurrentCamera
    
    flyConnection = RunService.RenderStepped:Connect(function()
        if not flyActive or not player.Character or not rootPart.Parent then 
            desativarVoo()
            return 
        end
        
        humanoid.PlatformStand = true
        humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        bGyro.cframe = camera.CFrame
        
        local direcaoVetor = Vector3.new(0, 0, 0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then direcaoVetor = direcaoVetor + camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then direcaoVetor = direcaoVetor - camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then direcaoVetor = direcaoVetor - camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then direcaoVetor = direcaoVetor + camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direcaoVetor = direcaoVetor + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then direcaoVetor = direcaoVetor - Vector3.new(0, 1, 0) end
        
        if direcaoVetor.Magnitude > 0 then
            bVelo.velocity = direcaoVetor.Unit * flySpeed
        else
            bVelo.velocity = Vector3.new(0, 0, 0)
        end
    end)
end

-- MECÂNICA DE NOCLIP ANTI-CONGELAMENTO (Event-driven em vez de Loops pesados)
local function desativarNoclip()
    noclipActive = false
    if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
    if player.Character then
        for _, part in ipairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
end

local function ativarNoclip()
    desativarNoclip()
    noclipActive = true
    
    noclipConnection = RunService.Stepped:Connect(function()
        if not noclipActive or not player.Character then 
            desativarNoclip()
            return 
        end
        -- Desativa colisão apenas de partes fundamentais para evitar loops massivos na CPU
        for _, part in ipairs(player.Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end)
end

-- ESP DE JOGADORES (Sem memory leak)
local function aplicarEspPlayer(p)
    if p == player then return end
    local function criarHighlight(char)
        if not espPlayersActive then return end
        task.wait(0.5)
        local antigo = char:FindFirstChild("FTF_ESP")
        if antigo then antigo:Destroy() end
        
        local hl = Instance.new("Highlight")
        hl.Name = "FTF_ESP"
        hl.FillTransparency = 0.4
        hl.OutlineTransparency = 0
        hl.Adornee = char
        hl.Parent = char
        
        if char:FindFirstChild("Hammer") or char:FindFirstChild("Gem") then
            hl.FillColor = Color3.fromRGB(255, 50, 50)
        else
            hl.FillColor = Color3.fromRGB(50, 255, 120)
        end
    end

    if p.Character then task.spawn(criarHighlight, p.Character) end
    if playerCharConnections[p] then playerCharConnections[p]:Disconnect() end
    playerCharConnections[p] = p.CharacterAdded:Connect(criarHighlight)
end

-- ESP DE COMPUTADORES (Limpo, não causa lag)
local function atualizarEspPc()
    for _, antigo in pairs(pcHighlights) do if antigo then antigo:Destroy() end end
    table.clear(pcHighlights)
    
    if not espPcActive then return end
    
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj.Name == "ComputerTable" then
            local hl = Instance.new("Highlight")
            hl.Name = "PC_ESP"
            hl.FillColor = Color3.fromRGB(0, 180, 255)
            hl.FillTransparency = 0.5
            hl.Adornee = obj
            hl.Parent = obj
            table.insert(pcHighlights, hl)
        end
    end
end

-- INVISIBILIDADE ULTRA LEVE (Sem loops infinitos)
local function atualizarInvisibilidade(estado)
    invisibleActive = estado
    if not player.Character then return end
    for _, v in ipairs(player.Character:GetDescendants()) do
        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
            v.Transparency = estado and 1 or 0
        elseif v:IsA("Decal") then
            v.Transparency = estado and 1 or 0
        end
    end
end

-- 3. INTERPRETADOR CENTRAL DE COMANDOS
BotaoAjuda.MouseButton1Click:Connect(function()
    ScrollingFrame.Visible = not ScrollingFrame.Visible
    BotaoAjuda.Text = ScrollingFrame.Visible and "COLLAPSE CONSOLE LIST" or "DISPLAY CONSOLE COMMANDS"
end)

BarraComando.FocusLost:Connect(function(enterPressed)
    if not enterPressed then return end
    local texto = BarraComando.Text
    BarraComando.Text = ""
    
    local args = string.split(texto, " ")
    local comando = string.lower(args[1])
    local subComando = args[2] and string.lower(args[2]) or ""
    
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    
    if comando == "speed" then
        local valor = tonumber(args[2])
        if valor then
            customSpeed = valor
            speedActive = true
            gerenciarVelocidade()
        else
            speedActive = false
            if speedConnection then speedConnection:Disconnect() speedConnection = nil end
            if humanoid then humanoid.WalkSpeed = 16 end
        end
    elseif comando == "fly" then
        local valorVel = tonumber(args[2])
        flySpeed = valorVel or 50
        ativarVoo()
    elseif comando == "unfly" then
        desativarVoo()
    elseif comando == "noclip" then
        ativarNoclip()
    elseif comando == "unnoclip" then
        desativarNoclip()
    elseif comando == "esp" then
        if subComando == "pc" then
            espPcActive = not espPcActive
            atualizarEspPc()
        else
            espPlayersActive = not espPlayersActive
            if espPlayersActive then
                for _, p in ipairs(Players:GetPlayers()) do aplicarEspPlayer(p) end
                espPlayersConnection = Players.PlayerAdded:Connect(aplicarEspPlayer)
            else
                if espPlayersConnection then espPlayersConnection:Disconnect() espPlayersConnection = nil end
                for p, conn in pairs(playerCharConnections) do conn:Disconnect() end
                table.clear(playerCharConnections)
                for _, p in ipairs(Players:GetPlayers()) do
                    if p.Character then
                        local hl = p.Character:FindFirstChild("FTF_ESP")
                        if hl then hl:Destroy() end
                    end
                end
            end
        end
    elseif comando == "invisible" then
        atualizarInvisibilidade(true)
    elseif comando == "uninvisible" then
        atualizarInvisibilidade(false)
    elseif comando == "spectate" then
        local targetPlayer = obterJogador(args[2])
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChildOfClass("Humanoid") then
            Workspace.CurrentCamera.CameraSubject = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
        end
    elseif comando == "unspectate" then
        if humanoid then Workspace.CurrentCamera.CameraSubject = humanoid end
    end
end)

player.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    if speedActive then gerenciarVelocidade() end
    if invisibleActive then atualizarInvisibilidade(true) end
    if flyActive then ativarVoo() end
    if noclipActive then ativarNoclip() end
end)
d)
