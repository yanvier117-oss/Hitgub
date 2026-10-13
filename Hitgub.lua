local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

local FOV_RADIUS = 120

local function findClosestPlayer()
    camera = workspace.CurrentCamera
    local center = camera.ViewportSize / 2
    local closestPlayer = nil
    local shortestDistance = FOV_RADIUS

    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer ~= localPlayer then
            local character = otherPlayer.Character
            local humanoid = character
                and character:FindFirstChildOfClass("Humanoid")
            local head = character
                and character:FindFirstChild("Head")

            if humanoid and humanoid.Health > 0 and head then
                local pos, onScreen =
                    camera:WorldToViewportPoint(head.Position)

                if onScreen and pos.Z > 0 then
                    local screenPoint = Vector2.new(pos.X, pos.Y)
                    local distance = (screenPoint - center).Magnitude

                    if distance < shortestDistance then
                        shortestDistance = distance
                        closestPlayer = otherPlayer
                    end
                end
            end
        end
    end

    return closestPlayer
end

-- Ejemplo de uso:
local target = findClosestPlayer()

if target then
    print("Jugador detectado:", target.Name)
end
