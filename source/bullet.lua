local pd <const> = playdate
local gfx <const> = pd.graphics

class('Bullet').extends(gfx.sprite)





function Bullet:init()
    self.speed = 8
end


function Bullet:update()
    
end