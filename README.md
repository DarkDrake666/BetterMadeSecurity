# BetterMadeSecurity
Currently in **v1.1.0**.

## Updates

https://github.com/DarkDrake666/BetterSecurity/commits/MadeByMe/MainModule.lua

## Booting BetterMadeSecurity
```lua
local BMS = loadstring(game:HttpGet("https://raw.githubusercontent.com/DarkDrake666/BetterSecurity/MadeByMe/MainModule.lua"))()
```



## Activating
```lua
local Settings = {
    BlockScriptLogging = true,
    HideUsernameFromScripts = true,
    BlockScriptKicks = true,
    BlockGameKicks = true,
    BlockScriptChatRequests = true,
    
    -- BROKEN: 
    
    ConfirmScriptFileMaking = false, -- this could break a little amount of scripts as it uses a function that yields.
    ConfirmScriptFileDeleting = false, -- this could break a little amount of scripts as it uses a function that yields.
    ConfirmScriptFileAppending = false -- this could break a little amount of scripts as it uses a function that yields.
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

# Testing

You can test the script by using 

```lua
local TestType = "MakeFile"

--[[
Types:
    Username
    Log
    ScriptKick
    Chat
    MakeFile
    MakeFolder
    DeleteFile
    DeleteFolder
    AppendFile
]]

if TestType == "Username" then
    local Values = {
        ["Name"] = tostring(game:GetService("Players").LocalPlayer.Name);
        ["Username"] = tostring(game:GetService("Players").LocalPlayer.Username);
        ["DisplayName"] = tostring(game:GetService("Players").LocalPlayer.DisplayName);
        ["UserId"] = tostring(game:GetService("Players").LocalPlayer.UserId);
    }
    if (Values["Name"] ~= "John Doe" or Values["Username"] ~= "John Doe" or Values["DisplayName"] ~= "John Doe" or (Values["UserId"] ~= "2" or Values["UserId"] ~= 2)) then
        for i,v in pairs(Values) do
            print(i..": "..v)
        end
        print()
    else
        print("Error while substituting Player Identifiers with fake.")
    end
elseif TestType == "Log" then
    local url = "Discord Webhook URL"
    syn.request({
        Url = url,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService("HttpService"):JSONEncode({content = "i vas testing"})
    })
elseif TestType == "ScriptKick" then
    game:GetService("Players").LocalPlayer:Kick("i vas testing")
elseif TestType == "Chat" then
    local ChatRemote = game:GetService("ReplicatedStorage"):FindFirstChild("SayMessageRequest", true)
    ChatRemote:FireServer("Hello!", "All")
elseif TestType == "MakeFile" then
    writefile("test123.txt", "hi guys welcome to my minecraft let's play")
elseif TestType == "MakeFolder" then
    makefolder("test123 not txt")
elseif TestType == "DeleteFile" then
    writefile("test123fordelete.txt", "hi guys welcome to my minecraft let's play")
    wait()
    delfile("test123fordelete.txt")
elseif TestType == "DeleteFolder" then
    makefolder("test123 not txt for delete")
    wait()
    delfolder("test123 not txt for delete")
elseif TestType == "AppendFile" then
    writefile("test123forappend.txt", "hi guys welcome to my minecraft let's play. The three rules are: ")
    wait()
    appendfile("test123forappend.txt", "no mining, no killing my dog, no getting more stacked than me")
else
    print("Unsupported Test Type.")
end
```

Messy, I know.
