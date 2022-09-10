import "CoreLibs/timer"


local pd <const> = playdate
local gfx <const> = pd.graphics

class('Player').extends(gfx.sprite)

playerOnScreen = false --[[ Temporary solution for avoiding the player to be instantiated several times on the screen ]]
lockMode = 0 --[[ 0 = free player movement, 1 = aim locked, 2 = player is shooting ]]



function Player:init(x, y)
    local playerSpritesTable = gfx.imagetable.new('images/player_placeholdertable')

    playerN = playerSpritesTable:getImage(1)
    playerNE = playerSpritesTable:getImage(2)
    playerE = playerSpritesTable:getImage(3)
    playerSE = playerSpritesTable:getImage(4)
    playerS = playerSpritesTable:getImage(5)
    playerSW = playerSpritesTable:getImage(6)
    playerW = playerSpritesTable:getImage(7)
    playerNW = playerSpritesTable:getImage(8)
    
    local playerImage = playerN

    self:setImage(playerImage)
    self:setCenter(0, 0)
    self:moveTo(x, y)
    self:add()

    self.speed = 4
end

function Player:update()

--[[ Player movement with the D-pad ----- CHAIN IF+ELSEIFS ]]
    if pd.buttonIsPressed(pd.kButtonUp) then
        
        if pd.buttonIsPressed(pd.kButtonRight) then
                self:setImage(playerNE)
                self:moveBy(self.speed, -self.speed)

        elseif pd.buttonIsPressed(pd.kButtonLeft) then
                self:setImage(playerNW)
                self:moveBy(-self.speed, -self.speed)

        else
            self:setImage(playerN)
            self:moveBy(0, -self.speed)
        end
    end

    
    if pd.buttonIsPressed(pd.kButtonDown) then

        if pd.buttonIsPressed(pd.kButtonRight) then
                self:setImage(playerSE)
                self:moveBy(self.speed, self.speed)

        elseif pd.buttonIsPressed(pd.kButtonLeft) then
                self:setImage(playerSW)
                self:moveBy(-self.speed, self.speed)

        else
            self:setImage(playerS)
            self:moveBy(0, self.speed)
        end
    end


    if pd.buttonIsPressed(pd.kButtonLeft) then

        if pd.buttonIsPressed(pd.kButtonUp) then
                self:setImage(playerNW)

        elseif pd.buttonIsPressed(pd.kButtonDown) then
                self:setImage(playerSW)

        else
            self:setImage(playerW)
            self:moveBy(-self.speed, 0)
        end
    end


    if pd.buttonIsPressed(pd.kButtonRight) then

        if pd.buttonIsPressed(pd.kButtonUp) then
                self:setImage(playerNE)

        elseif pd.buttonIsPressed(pd.kButtonDown) then
                self:setImage(playerSE)

        else
            self:setImage(playerE)
            self:moveBy(self.speed, 0)
        end
    end

    --[[ Player actions with A and B buttons ]]

    if pd.buttonJustPressed(pd.kButtonA) then
        print("MELEE ATTACK") --[[ Replace with Melee attack code ]]
    end
    if pd.buttonJustPressed(pd.kButtonB) then
        print("GUN TYPE SWITCH") --[[ Replace with Gun Type Switch code ]]
    end

    --[[ Player actions with the Crank ]]

    isCrankDocked = pd.isCrankDocked()
    crankTicks = pd.getCrankTicks(10)

    if isCrankDocked == false then

        if lockMode == 0 and crankTicks < 0 then
            print('Aim locked, ready to shoot')
            lockMode = 1
        end

        if lockMode == 1 and crankTicks > 0 then 
            print('Fire!')
        end

        if lockMode == 1 and pd.buttonJustPressed(pd.kButtonDown) then
            print('Free movement mode')
            lockMode = 0
        end
    end

end

