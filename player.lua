import "CoreLibs/timer"
import "bullet"
import "enemy"

PLAYER = "Player"

local pd <const> = playdate
local gfx <const> = pd.graphics

class(PLAYER).extends(gfx.sprite)

playerOnScreen = false --[[ Temporary solution for avoiding the player to be instantiated several times on the screen ]]
lockMode = 0 --[[ 0 = free player movement, 1 = aim locked/fixed shot ]]
invincibleMode = false

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

    playerImage = playerN

    self:setImage(playerImage)
    self:setCollideRect(0, 0, playerImage:getSize())
    self:setCenter(0.5, 0.5)
    self:moveTo(x, y)
    self:setGroups({1})
    self:setCollidesWithGroups({2})
    self.speed = 4
    self.lives = 5
    self:add()
end

function Player:update()

    playerX, playerY = self:getPosition()

    --[[ Player movement with the D-pad ----- CHAIN IF+ELSEIFS ]]

    if lockMode == 0 then
        if pd.buttonIsPressed(pd.kButtonUp) then
            if pd.buttonIsPressed(pd.kButtonRight) then
                    self:setImage(playerNE)
                    self:moveBy(self.speed, -self.speed)
                    playerImage = playerNE
            elseif pd.buttonIsPressed(pd.kButtonLeft) then
                    self:setImage(playerNW)
                    self:moveBy(-self.speed, -self.speed)
                    playerImage = playerNW
            else
                self:setImage(playerN)
                self:moveBy(0, -self.speed)
                playerImage = playerN
            end
        end

        if pd.buttonIsPressed(pd.kButtonDown) then
            if pd.buttonIsPressed(pd.kButtonRight) then
                    self:setImage(playerSE)
                    self:moveBy(self.speed, self.speed)
                    playerImage = playerSE
            elseif pd.buttonIsPressed(pd.kButtonLeft) then
                    self:setImage(playerSW)
                    self:moveBy(-self.speed, self.speed)
                    playerImage = playerSW
            else
                self:setImage(playerS)
                self:moveBy(0, self.speed)
                playerImage = playerS
            end
        end


        if pd.buttonIsPressed(pd.kButtonLeft) then
            if pd.buttonIsPressed(pd.kButtonUp) then
                    self:setImage(playerNW)
                    playerImage = playerNW
            elseif pd.buttonIsPressed(pd.kButtonDown) then
                    self:setImage(playerSW)
                    playerImage = playerSW
            else
                self:setImage(playerW)
                self:moveBy(-self.speed, 0)
                playerImage = playerW
            end
        end


        if pd.buttonIsPressed(pd.kButtonRight) then
            if pd.buttonIsPressed(pd.kButtonUp) then
                    self:setImage(playerNE)
                    playerImage = playerNE
            elseif pd.buttonIsPressed(pd.kButtonDown) then
                    self:setImage(playerSE)
                    playerImage = playerSE
            else
                self:setImage(playerE)
                self:moveBy(self.speed, 0)
                playerImage = playerE
            end
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
    crankChange, crankAccelChange = pd.getCrankChange()

    if isCrankDocked == false then
        if lockMode == 0 and crankTicks < 0 then
            print('Aim locked, ready to shoot')
            lockMode = 1
        end
        if lockMode == 1 and crankTicks > 0 and crankAccelChange > 1 then
            Bullet(self.x, self.y, getBulletDirection())
            print('Fire!')
            print(crankChange, crankAccelChange)
        end
        if pd.buttonIsPressed(pd.kButtonUp) or pd.buttonIsPressed(pd.kButtonDown) or pd.buttonIsPressed(pd.kButtonLeft) or pd.buttonIsPressed(pd.kButtonRight) then
            lockMode = 0
        end
    end

    local function playerRespawn()
        local function invincibleModeFalse()
            invincibleMode = false
        end

        self.lives -= 1
        invincibleMode = true
        self:moveTo(200, 120)
        pd.timer.new(2000, invincibleModeFalse)
    end

    local actualX, actualY, collisions, length = self:checkCollisions(playerX, playerY)
    for index, collision in pairs(collisions) do
        local collidedObject = collision['other']
        if collidedObject:isa(Enemy) then
            collidedObject:remove()
            playerRespawn()
            print('REMAINING LIVES:' .. self.lives)
        end
    end
end

function Player:collisionResponse()
    return "overlap"
end

