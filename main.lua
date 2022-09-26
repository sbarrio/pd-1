import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/crank"
import "CoreLibs/animator"
import "screens/title"
import "screens/stage"

local pd <const> = playdate
local gfx <const> = pd.graphics

global = {
    currentScreen = nil
}

function initGame()
    global.currentScreen = TitleScreen()
end


function global.onChangeScreen(targetScreen)
    print("on change screen ")
    print(targetScreen)
    global.currentScreen.onDisappear()
    if targetScreen == TITLE_SCREEN then
        global.currentScreen = TitleScreen()
    elseif targetScreen == STAGE_SCREEN then
        global.currentScreen = StageScreen()
    else
        print("Can't change to unknown screen: " + targetScreen)
    end

    global.currentScreen.onAppear()
end


initGame()


function pd.update()
    global.currentScreen.update()
	pd.timer.updateTimers()
    gfx.sprite.update()
end

