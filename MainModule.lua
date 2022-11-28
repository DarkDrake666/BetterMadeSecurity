local v1 = {}

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

if not loadstring or not getgenv() or not hookfunction or not hookmetamethod or not getnamecallmethod then
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
    if not ChatEvent and (t1.BlockScriptChatRequests and t1.BlockScriptChatRequests == true) then
        MakeNotification("Error", "Chat remotes not found. This most likely means chat is disabled.")
    end
    if t1.BlockScriptLogging and t1.BlockScriptLogging == true then
        local SEND = syn and syn.request or http and http.request or fluxus and fluxus.request or http_request or request
        local Old; Old = hookfunction(SEND, newcclosure(function(...)
            if stopped == true then
                return Old(...)
            end
            if not checkcaller() then
                return Old(...) -- wtf game sending syn.request
            end
            local args = {...}
            if not args.Method then
                return Old(...) -- default is set to "GET"
            end
            if args.Method == "POST" or args.Method == "SEND" then
                print("Your script sent a logging request to: \n"..args.Url.."\nUsing "..args.Method)
                MakeNotification("Logging Attempt", "Your script attempted to log you! URL has been printed.")
                return nil
            end
            return Old(...)
        end))
    end
    if t1.HideUsernameFromScripts and t1.HideUsernameFromScripts == true then
        local Old; Old = hookmetamethod(game, "__index", newcclosure(function(Self, Key)
            if stopped == true then
                return Old(Self, Key)
            end
            if not checkcaller() then
                return Old(Self, Key)
            end
            local LocalPlayer = game:GetService("Players").LocalPlayer
            if Self == LocalPlayer and Key == "Name" then
                MakeNotification("Name Attempt", "Your script attempted to get your Username. Returned nil")
                return "John Doe"
            elseif Self == LocalPlayer and Key == "DisplayName" then
                MakeNotification("DisplayName Attempt", "Your script attempted to get your DisplayName. Returned nil")
                return "John Doe"
            elseif Self == LocalPlayer and Key == "UserId" then
                MakeNotification("UserId Attempt", "Your script attempted to get your UserId. Returned nil")
                return "2"
            elseif Self == LocalPlayer and Key == "Username" then
                MakeNotification("Name Attempt", "Your script attempted to get your Username. Returned nil")
                return "John Doe"
            end
            return Old(Self, Key)
        end))
    end
    local Old; Old = hookmetamethod(game, "__namecall", newcclosure(function(...)
        local args = {...}
        Self = args[1]
        if stopped == true then
            return Old(...)
        end
        local NCM = string.lower(tostring(getnamecallmethod()))
        local LocalPlayer = game:GetService("Players").LocalPlayer
        if checkcaller() and Self == ChatEvent and (t1.BlockScriptChatRequests and t1.BlockScriptChatRequests == true) and NCM == "fireserver" then
            print("Your script sent a logging request to: \n"..args.Url.."\nUsing "..args.Method)
            MakeNotification("Chat Attempt", "Your script attempted to make a chat request. Message has been printed.")
        end
        if Self == LocalPlayer and NCM == "kick" then
            if not checkcaller() and (t1.BlockGameKicks and t1.BlockGameKicks == true) then
                return nil
            end
            if checkcaller() and (t1.BlockScriptKicks and t1.BlockScriptKicks == true) then
                return nil
            end
        elseif Self == game and not checkcaller() and (t1.BlockScriptLogging and t1.BlockScriptLogging == true) == true then
            if NCM == "httppost" or NCM == "httppostasync" or NCM == "request" or NCM == "requestasync" then
                MakeNotification("Logging Attempt", "Your script attempted to log you! Error while printing URL.")
                return nil
            end
        end
        return Old(...)
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
    print("BetterMadeSecurity successfully initialised!")
    print("Your current settings are: \nBlockScriptLogging: "..(t1.BlockScriptLogging and t1.BlockScriptLogging == true)..", \nHideUsernameFromScripts: "..(t1.HideUsernameFromScripts and t1.HideUsernameFromScripts == true)..", \nBlockScriptKicks: "..(t1.BlockScriptKicks and t1.BlockScriptKicks == true)..", \nBlockGameKicks: "..(t1.BlockGameKicks and t1.BlockGameKicks == true)..", \nBlockScriptChatRequests: "..(t1.BlockScriptChatRequests and t1.BlockScriptChatRequests == true)..", \nConfirmScriptFileMaking: "..(t1.ConfirmScriptFileMaking and t1.ConfirmScriptFileMaking == true)..", \nConfirmScriptFileDeleting: "..(t1.ConfirmScriptFileDeleting and t1.ConfirmScriptFileDeleting == true)..", \nConfirmScriptFileAppending: "..(t1.ConfirmScriptFileAppending and t1.ConfirmScriptFileAppending == true).."\n")
end

v1.stop = function()
    getgenv().stopped = true
end

v1.resume = function()
    getgenv().stopped = false
end

print("BetterMadeSecurity successfully loaded!")

return v1
