local notifications = {}
local NDerma = {}
local actualHeight = 0
local notificationTime = 5 -- in sec

local function RespX(x)
    return x/1920 * ScrW()
end
local function RespY(y)
    return y/1080 * ScrH()
end

--Information, error, important, validation, normal
local Colors = {Color(48, 99, 201,200),Color(189, 36, 38,200),Color(199, 175, 16,200),Color(0, 204, 7,200),Color(30,30,30,200)}
local NSound = {"buttons/lightswitch2.wav","buttons/combine_button_locked.wav","garrysmod/save_load3.wav","garrysmod/balloon_pop_cute.wav","buttons/lightswitch2.wav"}

surface.CreateFont( "GNotifications", {
	font		= "Roboto",
	size		= RespY(23),
	weight		= 300,
	antialias = true,
	extended = true
} )

function redrawAll()
    local Y = RespY(10)
    for k,v in ipairs(NDerma) do
        v:SetPos(RespX(20),Y+RespY(10)*k)
        Y = Y + notifications[k].lH
    end
end


function drawNotification(index)
    draw.NoTexture()
    local Y = RespY(10)+actualHeight+RespY(10)*#notifications
    local Frame = vgui.Create( "DFrame" )
    Frame:SetPos(RespX(20),Y)
    local md = markup.Parse("<font=GNotifications>"..notifications[index].message.."</font>", RespX(280))
    local lH = md:GetHeight()
    notifications[index].lH = lH
    Frame:SetSize( RespX(300), lH+RespY(6)) 
    Frame:SetVisible(true) 
    Frame:SetDraggable(false)
    Frame:SetTitle('') 
    Frame:ShowCloseButton(false) 
    
    local nType = notifications[index].nType
    local c = Colors[nType+1]
    Frame.Paint = function(self, w, h)
        local mX,mY = 0, 0
        if nType == 2 then
            surface.SetDrawColor(168, 149, 20)
            surface.DrawRect(0, 0, RespX(300), lH+RespY(6))
            mX,mY=6,6
        end
        surface.SetDrawColor(c.r,c.g,c.b,c.a)
        surface.DrawRect(0+RespX(mX/2), RespY(mY/2), RespX(300-mX), lH+RespY(6-mY))
        md:Draw(RespX(10),3)
    end
    table.insert(NDerma,Frame)

    actualHeight = actualHeight + lH

    timer.Simple(notificationTime, function()
        Frame:SizeTo(0, RespY(lH+6), 1, 0, -1, function()
            actualHeight = actualHeight - lH
            table.remove(notifications, 1)
            Frame:Close()
            table.remove(NDerma, 1)
            redrawAll()
        end)
    end)
end

net.Receive("gnotifications", function()
    local t = net.ReadInt(4)
    local m = net.ReadString()
    local s = net.ReadInt(2)
    if s==1 then surface.PlaySound(NSound[t+1]) end
    table.insert(notifications, 
    {nType=t,
    message=m,
    })
    drawNotification(#notifications)
    MsgC(Color(60,60,250), "[NOTIFICATION] ")
    MsgC(Color(255,255,255,255), m .."\n")
end)