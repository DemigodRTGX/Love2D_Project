Player = {
    x = 10,
    y = love.graphics.getHeight() / 2,
    speed = 150,
    img = nil,
    sx = 0.4,
    sy = 0.4,
    r = 0,
    colliderX = 500,
    colliderY = 62,
    damge = 5,
    hp = 10,
    score = 0
}

Background = {
    img = nil,
    speed = 0.1
}
BackgroundStone = {
    img = {},
    speed = 150,
    x = 0,
    y = 0,
    sx = 1,
    sy = 1,
    r = 0
}

canShoot = true
canShootTimerMax = 0.2
canShootTimer = canShootTimerMax

enemycanShoot = true
enemyShootTimerMax = 0.2
enemyShootTimer = canShootTimerMax

bullets = {img = nil, x = 0, y = 0, speed = 400, s = 2}

createEnemyTimerMax = 1
createEnemyTimer = createEnemyTimerMax

createEnemyTimerMax1 = 2
createEnemyTimer1 = createEnemyTimerMax1

createEnemyTimerMax2 = 5
createEnemyTimer2 = createEnemyTimerMax2

enemie1 = {
    img = nil,
    x = 50,
    y = 50,
    sx = 0.5,
    sy = 0.5,
    speedX = 80,
    speedY = 0,
    hp = 10,
    damage = 1,
    px = 21,
    py = 7.5,
    ps = 0.6,
    id = 1
}
enemie2 = {
    img = nil,
    x = 50,
    y = 50,
    sx = 0.4,
    sy = 0.4,
    speedX = 60,
    speedY = 0,
    hp = 40,
    damage = 2,
    px = 40,
    py = 11,
    ps = 0.6,
    id = 2,
    enemycanShoot = true,
    enemyShootTimerMax = 1,
    enemyShootTimer = canShootTimerMax,
    ammo = 2
}
enemie3 = {
    img = nil,
    x = 50,
    y = 50,
    sx = 0.3,
    sy = 0.3,
    speedX = 40,
    speedY = 0,
    hp = 100,
    damage = 5,
    px = 42,
    py = 29,
    ps = 1,
    id = 3,
    enemycanShoot = true,
    enemyShootTimerMax = 0.2,
    enemyShootTimer = canShootTimerMax,
    ammo = 10
}
enemybullets = {
    img = nil,
    x = 50,
    y = 50,
    sx = 1,
    sy = 1,
    speedX = 0.5,
    speedY = 0.5,
    hp = 1,
    damage = 1,
    id = 4
}

DamageScreentimerMax = 0.02
DamageScreentimer = DamageScreentimerMax

showCollider = false

Backgroundtimer = 0.5

fireparticlesize = {min = -200, max = -700}
