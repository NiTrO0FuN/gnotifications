util.AddNetworkString("gnotifications")
GNotifications = {}
GNotifications.TYPE_INFORMATION = 0
GNotifications.TYPE_ERROR = 1
GNotifications.TYPE_IMPORTANT = 2
GNotifications.TYPE_VALIDATION = 3
GNotifications.TYPE_NORMAL = 4

GNotifications.sendBroadcastNotification = function(nType, message, playSound )//last argument optional, on by default
    // nType : type of notification : 0:information, 1:error, 2:important, 3;validation, 4:normal
    // message: message to show
    playSound = playSound or 1
    net.Start("gnotifications")
        net.WriteInt(nType, 4)
        net.WriteString(message)
        net.WriteInt(playSound, 2)
    net.Broadcast()
end

GNotifications.sendNotification = function(ply, nType, message, playSound )//last argument optional, on by default)
    // nType : type of notification : 0:information, 1:error, 2:important, 3;validation, 4:normal
    // message: message to show
    playSound = playSound or 1
    net.Start("gnotifications")
        net.WriteInt(nType, 4)
        net.WriteString(message)
        net.WriteInt(playSound, 2)
    net.Send(ply)
end

hook.Add("onNotify", "replaceNotify", function(plys,msgtype,duration,message)

    local correspondance = {GNotifications.TYPE_NORMAL,GNotifications.TYPE_ERROR,GNotifications.TYPE_INFORMATION,
    GNotifications.TYPE_INFORMATION,GNotifications.TYPE_INFORMATION}

    for _,ply in pairs(plys) do
        GNotifications.sendNotification(ply, correspondance[msgtype+1],message)
    end
    
    return true
end)

concommand.Add("sendnotification", function(ply, cmd, args, argStr)
    -- Broadcast notification
    GNotifications.sendBroadcastNotification(args[1],args[2])
end)
