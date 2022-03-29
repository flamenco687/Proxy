local Proxy = require(game.ReplicatedStorage.Proxy)

local Origin = {
    Test = 10,
    Yooo = 20,
}

local Test = Proxy.new(Origin, {TrackChildrenMutations = true})

local Connection = Test:OnChange(function(Key: string, Value: any, OldValue: any)
    print(Key, Value, OldValue)
end)

Test.Test = 50
Test.Yooo = {
    Boom = "Boom"
}

Test.Yooo = Proxy.new(Test.Yooo)