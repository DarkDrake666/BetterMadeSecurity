--[[
Please read https://github.com/DarkDrake666/BetterMadeSecurity/blob/MadeByMe/README.md for how to use.
]]

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
    fire = function() MakeNotification("Error", "Executor not supported.", 10) end
    stop = function() MakeNotification("Error", "Executor not supported.", 10) end
    resume = function() MakeNotification("Error", "Executor not supported.", 10) end
}

local AlreadyLoaded = {
    fire = function() MakeNotification("Error", "BetterMadeSecurity is already loaded.", 10) end
    stop = function() MakeNotification("Error", "BetterMadeSecurity is already loaded.", 10) end
    resume = function() MakeNotification("Error", "BetterMadeSecurity is already loaded.", 10) end
}

if not loadstring or not getgenv() or not hookfunction or not hookmetamethod or not getnamecallmethod then
    return NotSupported
end

if getgenv().LOADED_BETTER_MADE_SECURITY and getgenv().LOADED_BETTER_MADE_SECURITY == true then
    MakeNotification("Security", "BetterMadeSecurity is already loaded!")
    return AlreadyLoaded
end

getgenv().stopped = false
getgenv().LOADED_BETTER_MADE_SECURITY = true

v1.fire = function(t1)
    if t1[1] == true then
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
    if t1[2] == true then
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
            elseif Self == LocalPlayer = Key == "UserId" then
                MakeNotification("UserId Attempt", "Your script attempted to get your UserId. Returned nil")
                return "2"
            elseif Self == LocalPlayer and Key == "Username" then
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
        if not checkcaller() and not t1[4] == true then
            return Old(Self, ...)
        end
        if checkcaller() and not t1[3] == true then
            return Old(Self, ...)
        end
        local NCM = string.lower(tostring(getnamecallmethod()))
        local LocalPlayer = game:GetService("Players").LocalPlayer
        local args = {...}
        if Self == LocalPlayer and NCM == "kick" then
           return nil
        end
        return Old(Self, ...)
    end))
    if t1[5] == true then
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
    if t1[6] == true then
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
    if t1[7] == true then
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
end

v1.stop = function()
    getgenv().stopped = true
end

v1.resume = function()
    getgenv().stopped = false
end

return v1
