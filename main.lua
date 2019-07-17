
function love.load()
    -- define global variables
    GS = require("games_state")
    Button = {
        x = 100,
        y= 100,
        size = 50,
    }
    Score = 0
    TotalTime = 3
    Timer = TotalTime
    MyFont = love.graphics.newFont(20)
    WindowWidth = 720
    WindowHeight = 480

    -- define window size and title
    love.window.setTitle("Button Click Game")
    love.window.setMode(WindowWidth, WindowHeight, {})
end

function love.update(dt)
    --- LOVE runs at 60 fps by default

    if GS.currentState == GS.running then
        Timer = Timer - dt;
        if Timer < 0 then
            Timer = TotalTime
            GS.currentState = GS.gameOver
        end
    end
end

function love.draw()
    -- also runs at every frame, should only do rendering stuff

    -- draw the button if the game is not over
    if GS.currentState == GS.running then
        love.graphics.setColor(1, 1, 0, 1)
        love.graphics.circle("fill", Button.x, Button.y, Button.size)
    end

    -- draw the help text if the game is over
    if GS.currentState == GS.gameOver then
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print("Press R to restart the game", 200, 300)
    end

    -- draw the info text
    love.graphics.setFont(MyFont)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Score: " .. Score)
    love.graphics.print("Time Remain: " .. string.format("%.1f", Timer), 100)
    love.graphics.print("GameState: " .. GS.currentState, 400)
end

function love.mousepressed(x, y, btn, isTouch)
    if btn == 1 and GS.currentState == GS.running then
        if DistanceBetween(x, y, Button.x, Button.y) < Button.size then
            Score = Score + 1
            Timer = TotalTime
            Respawn()
        end
    end
end

function love.keypressed(key, code, isrepeat)
    -- restart the game
    if GS.currentState == GS.gameOver and key == "r" then
        Score = 0
        Respawn()
        GS.currentState = GS.running
    end
end

function DistanceBetween(x1, y1, x2, y2)
    local distance_sqr = (x1 - x2) ^ 2 + (y1 - y2) ^ 2
    return math.sqrt(distance_sqr)
end

function Respawn()
    local w, h = love.window.getMode()
    Button.x = math.random(Button.size, w - Button.size)
    Button.y = math.random(Button.size, h - Button.size)
end
