STAGE_SCREEN = 'StageScreen'

class(STAGE_SCREEN).extends(Screen)

local gfx <const> = playdate.graphics

-- Screen lifecycle

function StageScreen:init()
	StageScreen.super.init(self)
end

function StageScreen:onAppear()
end

function StageScreen:onDisappear()
end

function StageScreen:update()
    gfx.clear(1)
    gfx.drawText("Stage Screen", 140, 100)

end

-- Screen-specific
