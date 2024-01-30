
local characters = {}


Char = {}

function Char.new(id, name, money)
    local self = {
        id = id,
        name = name,
        money = money,
        eventListeners = {}
    }
    setmetatable(self, { __index = Char })
    return self
end

function Char:displayInfo()
    print(string.format("ID: %d, Name: %s, Money: %d$", self.id, self.name, self.money))
end

function Char:displayInfoById(id)
    local character = characters[id]
    if character then
        character:displayInfo()
    else
        print("Character with ID " .. id .. " not found.")
    end
end

function Char:addEventListener(event, callback)
    if not self.eventListeners[event] then
        self.eventListeners[event] = {}
    end
    table.insert(self.eventListeners[event], callback)
end

function Char:dispatchEvent(event, ...)
    if self.eventListeners[event] then
        for _, callback in ipairs(self.eventListeners[event]) do
            callback(self, ...)
        end
    end
end

function Char:giveMoney(amount)
    self.money = self.money + amount
    self:dispatchEvent("updateMoney", amount)
end


local client = Char.new(1, "client", 350)
characters[client.id] = client


client:addEventListener("updateMoney", function(player, newAmount)
    print(player.name .. " received " .. newAmount .. "$")
end)

-- We are retrieving character information based on the character's ID.
client:displayInfoById(1)


client:giveMoney(41150)


client:displayInfoById(1)
