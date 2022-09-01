
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "screens/title"
import "screens/stage"

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
        print("Cant change to unknwon screen: " + targetScreen)
    end
end

initGame()

function playdate.update()
    global.currentScreen.update()
end

