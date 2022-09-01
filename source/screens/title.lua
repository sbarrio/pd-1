TITLE_SCREEN = 'TitleScreen'

class(TITLE_SCREEN).extends(Screen)

local gfx <const> = playdate.graphics

-- Screen lifecycle

function TitleScreen:init()
	TitleScreen.super.init(self)
    print(onChangeScreen)
end

function TitleScreen:onAppear()
end

function TitleScreen:onDisappear()
end

function TitleScreen:update()
    gfx.clear(1)
    gfx.drawText("Press A button", 145, 100)
    if playdate.buttonJustPressed(playdate.kButtonA) then
        global.onChangeScreen(STAGE_SCREEN)
    end
end

-- Screen-specific