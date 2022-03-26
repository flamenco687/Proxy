local Proxy = require(game.ReplicatedStorage.Proxy)

local Origin = {
    Test = 10,
    Yooo = 20,
}

local Test = Proxy.new(Origin)

local Connection = Test:OnChange(function(Key: string, Value: any, OldValue: any)
    print(Key, Value, OldValue)
end)

Test:OnIndex(function(Key: string, Value: any)
    print(Key, Value)
end)

Test.Test = 50

task.wait(2)

Test:Destroy()

print(Connection(true))