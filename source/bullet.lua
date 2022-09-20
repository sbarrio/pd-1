import "player"
import "enemy"

local pd <const> = playdate
local gfx <const> = pd.graphics

BULLET = 'Bullet'

class(BULLET).extends(gfx.sprite)



function Bullet:init(x, y, speed, direction) 
    bulletImage  = gfx.image.new('images/bullet_placeholder')
    bulletSizeX, bulletSizeY = bulletImage:getSize()

    self:setImage(bulletImage)
    self:setCollideRect(0, 0, bulletSizeX, bulletSizeY)
    self:moveTo(x, y)
    self.speed = speed
    self.direction = direction
    self.damage = 10
    self:add()

end


function Bullet:update()
    
    if self.direction == 1 then
        actualX, actualY, collisions, length = self:moveWithCollisions(self.x, self.y - self.speed)
    end
    if self.direction == 2 then
        actualX, actualY, collisions, length = self:moveWithCollisions(self.x + self.speed, self.y - self.speed)
    end
    if self.direction == 3 then
        actualX, actualY, collisions, length = self:moveWithCollisions(self.x + self.speed, self.y)
    end
    if self.direction == 4 then
        actualX, actualY, collisions, length = self:moveWithCollisions(self.x + self.speed, self.y + self.speed)
    end
    if self.direction == 5 then
        actualX, actualY, collisions, length = self:moveWithCollisions(self.x, self.y + self.speed)
    end
    if self.direction == 6 then
        actualX, actualY, collisions, length = self:moveWithCollisions(self.x - self.speed, self.y + self.speed)
    end
    if self.direction == 7 then
        actualX, actualY, collisions, length = self:moveWithCollisions(self.x - self.speed, self.y)
    end
    if self.direction == 8 then
        actualX, actualY, collisions, length = self:moveWithCollisions(self.x - self.speed, self.y - self.speed)
    end

    if length > 0 then
        for index, collision in pairs(collisions) do --[[ Try to do sth like this but in the Enemy and/or TestEnemy files ]]
            local collidedObject = collision['other']
            if collidedObject:isa(Enemy) then
                --[[ collidedObject:remove() ]]
                collidedObject.health -= self.damage
                print(collidedObject.health)
            end
        end
        self:remove()
    elseif actualX > 400 or actualX < 0 or actualY > 240 or actualY < 0 then
        self:remove()
    end
end

function getBulletDirection()

    if playerImage == playerN then
        bulletDirection = 1
    end
    if playerImage == playerNE then
        bulletDirection = 2
    end
    if playerImage == playerE then
        bulletDirection = 3
    end
    if playerImage == playerSE then
        bulletDirection = 4
    end
    if playerImage == playerS then
        bulletDirection = 5
    end
    if playerImage == playerSW then
        bulletDirection = 6
    end
    if playerImage == playerW then
        bulletDirection = 7
    end
    if playerImage == playerNW then
        bulletDirection = 8
    end
    return bulletDirection
end