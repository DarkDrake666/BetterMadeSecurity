# BetterMadeSecurity
Idea by synn#8447

## Booting BetterMadeSecurity
```lua
local BMS = loadstring(game:HttpGet("https://raw.githubusercontent.com/DarkDrake666/BetterMadeSecurity/MadeByMe/MainModule.lua"))()
```



## Activating
```lua
local Settings = {
    BlockScriptLogging = true;
    HideUsernameFromScripts = true;
    BlockScriptKicks = true;
    BlockGameKicks = true;
    ConfirmScriptFileMaking = false; -- this could break scripts as it uses a function that yields.
    ConfirmScriptFileDeleting = false; -- this could break scripts as it uses a function that yields.
    ConfirmScriptFileAppending = false; -- this could break scripts as it uses a function that yields.
}

BMS.fire(Settings)
```

## Stopping
```lua
-- In a new script, still booting BetterMadeSecurity
BMS.stop()
```

## Resuming
```lua
-- In a new script, still booting BetterMadeSecurity
BMS.resume()
```

# Thats all!
