Player = {
    x = 10,
    y = love.graphics.getHeight() / 2,
    speed = 150,
    img = nil,
    sx = 0.4,
    sy = 0.4,
    r = 0,
    colliderX = 132,
    colliderY = 62,
    damge = 5,
    hp = 10,
    score = 0
}

Background = {
    img = nil,
    speed = 0.2
}
BackgroundStone = {
    img = {},
    speed = 200,
    x = 0,
    y = 0,
    sx = 1,
    sy = 1,
    r = 0
}

canShoot = true
canShootTimerMax = 0.2
canShootTimer = canShootTimerMax

bullets = {img = nil, x = 0, y = 0, speed = 400, s = 2}

createEnemyTimerMax = 1
createEnemyTimer = createEnemyTimerMax

enemie1 = {img = nil, x = 50, y = 50, sx = 0.5, sy = 0.5, speed = 80, hp = 10}

DamageScreentimerMax = 0.02
DamageScreentimer = DamageScreentimerMax

showCollider = false

Backgroundtimer = 0.5

fireparticlesize = {min = -200, max = -700}
