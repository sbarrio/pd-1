import "player"

STAGE_SCREEN = 'StageScreen'

class(STAGE_SCREEN).extends(Screen)

local pd <const> = playdate
local gfx <const> = pd.graphics

-- Screen lifecycle

function StageScreen:init()
	StageScreen.super.init(self)
end

function StageScreen:onAppear()
end

function StageScreen:onDisappear()
end

function StageScreen:update()
--[[     gfx.clear(1)  ]]    
    gfx.drawText("Stage Screen", 140, 100)
    gfx.drawText("Press A to start", 130, 130)
    gfx.sprite.update()
    addPlayer()
end


function addPlayer()
    if playerOnScreen == false and pd.buttonJustPressed(pd.kButtonA) then
        gfx.clear(1)
        Player(200, 120)
        playerOnScreen = true --[[ Temporary solution for avoiding the player to be instantiated several times on the screen ]]
    end    
end

-- Screen-specific
