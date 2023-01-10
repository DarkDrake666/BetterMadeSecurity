--[[
local Settings = {
    BlockScriptLogging = true,
    HideUsernameFromScripts = true,
    BlockScriptKicks = true,
    BlockGameKicks = true,
    BlockScriptChatRequests = true,
    
    -- BROKEN
    
    ConfirmScriptFileMaking = false, -- this could break a little amount of scripts as it uses a function that yields.
    ConfirmScriptFileDeleting = false, -- this could break a little amount of scripts as it uses a function that yields.
    ConfirmScriptFileAppending = false -- this could break a little amount of scripts as it uses a function that yields.
}
]]--

local v1 = {}

local LP = game:GetService("Players").LocalPlayer

local Notification = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

function MakeNotification(title, content, time)
    Notification:MakeNotification({
        Name = title,
        Content = content,
        Time = time
    })
end
local NotSupported = {
    fire = function() MakeNotification("Error", "Executor not supported.", 10) end,
    stop = function() MakeNotification("Error", "Executor not supported.", 10) end,
    resume = function() MakeNotification("Error", "Executor not supported.", 10) end
}

local AlreadyLoaded = {
    fire = function() MakeNotification("Error", "BetterMadeSecurity is already loaded.", 10) end,
    stop = function() MakeNotification("Error", "BetterMadeSecurity is already loaded.", 10) end,
    resume = function() MakeNotification("Error", "BetterMadeSecurity is already loaded.", 10) end
}

if not loadstring or not getgenv() or not hookfunction or not hookmetamethod or not getnamecallmethod or not setreadonly or not isreadonly or not newcclosure then
    return NotSupported
end

if getgenv().LOADED_BETTER_MADE_SECURITY and getgenv().LOADED_BETTER_MADE_SECURITY == true then
    return AlreadyLoaded
end

getgenv().stopped = false
getgenv().LOADED_BETTER_MADE_SECURITY = true

v1.fire = function(t1)
    local ChatEvent = game:GetService("ReplicatedStorage"):FindFirstChild("SayMessageRequest", true)
    if ChatEvent.Parent ~= game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents") then
        ChatEvent = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents"):FindFirstChild("SayMessageRequest")
    end
    if not ChatEvent and ((t1.BlockScriptChatRequests and t1.BlockScriptChatRequests == true) or (t1.BlockGameChatRequests and t1.BlockGameChatRequests == true)) then
        MakeNotification("Error", "Chat remotes not found. This most likely means chat is disabled.")
    end
    
    if t1.BlockScriptLogging and t1.BlockScriptLogging == true then
        local SEND = syn or http or fluxus
        if SEND then
            local Old = syn.request
            
            setreadonly(SEND, false);
            SEND.request = function(data)
                local Url = data.Url
                local Method = data.Method
                
                if stopped == true then
                    return Old(data)
                end
                if not data.Method then
                    return Old(data) -- default is set to "GET"
                end
                
                if Method == "POST" then
                    print("Your script sent a logging request to: \n"..Url.."\nUsing "..Method.."\n")
                    MakeNotification("Logging Attempt", "Your script attempted to log you! URL has been printed.")
                    return nil
                end
                return Old(data)
            end
        else
            MakeNotification("BetterMadeSecurity", "Unfortunately, StopScriptLogging doesn't support your Executor. Error: Request Functions MUST be stored in a table.")
        end
    end
    
    if t1.HideUsernameFromScripts and t1.HideUsernameFromScripts == true then
        local Old; Old = hookmetamethod(game, "__index", newcclosure(function(Self, Key)
            if stopped == true then
                return Old(Self, Key)
            end
            if not checkcaller() then
                return Old(Self, Key)
            end
            if Self == LP and Key == "Name" then
                MakeNotification("Name Attempt", "Your script attempted to get your Username. Returned nil")
                return "John Doe"
            elseif Self == LP and Key == "DisplayName" then
                MakeNotification("DisplayName Attempt", "Your script attempted to get your DisplayName. Returned nil")
                return "John Doe"
            elseif Self == LP and Key == "UserId" then
                MakeNotification("UserId Attempt", "Your script attempted to get your UserId. Returned nil")
                return "2"
            elseif Self == LP and Key == "Username" then
                MakeNotification("Name Attempt", "Your script attempted to get your Username. Returned nil")
                return "John Doe"
            end
            return Old(Self, Key)
        end))
    end
    local Old; Old = hookmetamethod(game, "__namecall", newcclosure(function(Self, ...)
        if stopped == true then
            return Old(Self, ...)
        end
        local CallingScript = getcallingscript() or getfenv(0)["script"]
        local NCM = string.lower(tostring(getnamecallmethod()))
        local args = {...}
        if Self == ChatEvent and ((t1.BlockScriptChatRequests and t1.BlockScriptChatRequests == true) or (t1.BlockGameChatRequests and t1.BlockGameChatRequests == true)) and NCM == "fireserver" then
            if checkcaller() then
                print("Your script sent a chat request with the message: \n"..args[1].."\nTo "..args[2].."\n")
                MakeNotification("Script Chat Attempt", "Your script attempted to make a chat request. Message has been printed.")
                return nil
            end
            return Old(Self, ...)
        end
        if Self == LP and NCM == "kick" then
            if not checkcaller() and (t1.BlockGameKicks and t1.BlockGameKicks == true) then
                print("Your game attempted to make a kick request: \n"..tostring(args[1]).."\n")
                MakeNotification("Game Kick Attempt", "Your game attempted to make a kick request. Message has been printed.")
                return nil
            end
            if checkcaller() and (t1.BlockScriptKicks and t1.BlockScriptKicks == true) then
                print("Your script attempted to make a kick request: \n"..tostring(args[1]).."\n")
                MakeNotification("Script Kick Attempt", "Your script attempted to make a kick request. Message has been printed.")
                return nil
            end
        elseif Self == game and not checkcaller() and (t1.BlockScriptLogging and t1.BlockScriptLogging == true) == true then
            if NCM == "httppost" or NCM == "httppostasync" or NCM == "request" or NCM == "requestasync" then
                MakeNotification("Logging Attempt", "Your script attempted to log you! Error while printing URL.")
                return nil
            end
        end
        return Old(Self, ...)
    end))
    if t1.ConfirmScriptFileMaking and t1.ConfirmScriptFileMaking == true then
        local Old; Old = hookfunction(makefolder, newcclosure(function(...)
            if stopped == true then
                return Old(...)
            end
            if not checkcaller() then
                return Old(...)
            end
            local args = {...}
            local res = messagebox("Folder Creating", "Would you like to create the folder "..args[1].."?", 4)
            if res == 6 then
                return Old(...)
            elseif res == 7 then
                return nil
            end
            return Old(...)
        end))
        local Old; Old = hookfunction(writefile, newcclosure(function(...)
            if stopped == true then
                return Old(...)
            end
            if not checkcaller() then
                return Old(...)
            end
            local args = {...}
            local res = messagebox("File Creating", "Would you like to create the file "..args[1].."?", 4)
            if res == 6 then
                return Old(...)
            elseif res == 7 then
                return nil
            end
            return Old(...)
        end))
    end
    if t1.ConfirmScriptFileDeleting and t1.ConfirmScriptFileDeleting == true then
        local Old; Old = hookfunction(delfolder, newcclosure(function(...)
            if stopped == true then
                return Old(...)
            end
            if not checkcaller() then
                return Old(...)
            end
            local args = {...}
            local res = messagebox("Folder Deleting", "Would you like to delete the folder "..args[1].."?", 4)
            if res == 6 then
                return Old(...)
            elseif res == 7 then
                return nil
            end
            return Old(...)
        end))
        local Old; Old = hookfunction(delfile, newcclosure(function(...)
            if stopped == true then
                return Old(...)
            end
            if not checkcaller() then
                return Old(...)
            end
            local args = {...}
            local res = messagebox("File Deleting", "Would you like to delete the file "..args[1].."?", 4)
            if res == 6 then
                return Old(...)
            elseif res == 7 then
                return nil
            end
            return Old(...)
        end))
    end
    if t1.ConfirmScriptFileAppending and t1.ConfirmScriptFileAppending == true then
        local Old; Old = hookfunction(appendfile, newcclosure(function(...)
            if stopped == true then
                return Old(...)
            end
            if not checkcaller() then
                return Old(...)
            end
            local args = {...}
            local res = messagebox("File Appending", "Would you like to add to the file "..args[1].."?", 4)
            if res == 6 then
                return Old(...)
            elseif res == 7 then
                return nil
            end
            return Old(...)
        end))
    end
    print("BetterMadeSecurity successfully initialised! \n")
    print("Your current settings are: \nBlockScriptLogging: "..tostring(t1.BlockScriptLogging)..", \nHideUsernameFromScripts: "..tostring(t1.HideUsernameFromScripts)..", \nBlockScriptKicks: "..tostring(t1.BlockScriptKicks)..", \nBlockGameKicks: "..tostring(t1.BlockGameKicks)..", \nBlockScriptChatRequests: "..tostring(t1.BlockScriptChatRequests)..", \nConfirmScriptFileMaking: "..tostring(t1.ConfirmScriptFileMaking)..", \nConfirmScriptFileDeleting: "..tostring(t1.ConfirmScriptFileDeleting)..", \nConfirmScriptFileAppending: "..tostring(t1.ConfirmScriptFileAppending).."\n")
end

v1.stop = function()
    getgenv().stopped = true
end

v1.resume = function()
    getgenv().stopped = false
end

return v1;
