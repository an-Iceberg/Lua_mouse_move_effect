math.randomseed(os.time())

local utils = require("utils.utils")
local gui = require("gui.gui")

Sample_text = nil

local sample_sprite
local sample_font
local version_number
local delta_mouse_x
local delta_mouse_y
local mouse_trail = {}

-- Init
function love.load()
  -- love.graphics.setDefaultFilter('nearest', 'nearest')

  sample_sprite = love.graphics.newImage("sprites/Lua-Logo.png")
  sample_font = love.graphics.newFont("fonts/ChewieDEMO-Medium.otf", 20)
  Sample_text = love.graphics.newText(sample_font, "Hello World\nNice to meet you")

  local major, minor, revision = love.getVersion()
  version_number = love.graphics.newText(sample_font, major.."."..minor.."."..revision)

  delta_mouse_x = 0
  delta_mouse_y = 0
end

-- Keyboard input
function love.keypressed(key, scancode, is_repeat)
end

function love.keyboard.wasPressed(key)
  return love.keyboard.keysPressed[key]
end

-- Mouse input
function love.mousepressed(x, y, button)
end

function love.mousemoved(x, y, delta_x, delta_y)
  delta_mouse_x = delta_x
  delta_mouse_y = delta_y

  -- TODO: add a movement vector calculated from the difference between the position and the delta position and do something cool with it
  table.insert(mouse_trail, 1, {x = x, y = y, radius = 20})
end

function love.wheelmoved(x, y)
end

-- Update game state
function love.update(delta_time)
  love.keyboard.keysPressed = {}

  for index, ball in ipairs(mouse_trail) do
    ball.radius = ball.radius - (delta_time * 20)

    if ball.radius <= 0 then
      table.remove(mouse_trail, index)
    end
  end
end

-- Draw game to screen
function love.draw()
  love.graphics.clear(0, 0, 0)

  for _, ball in pairs(mouse_trail) do
    if ball.radius > 0 then
      love.graphics.setColor(0, 1, 0)
      love.graphics.circle("fill", ball.x, ball.y, ball.radius)
    end
  end

  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(sample_sprite, love.graphics.getWidth() - (sample_sprite:getWidth() * 0.1), 0, 0, 0.1, 0.1)

  love.graphics.setColor(1, 1, 1)
  love.graphics.setFont(sample_font)
  love.graphics.print("FPS:"..tostring(love.timer.getFPS()), 5 + delta_mouse_x, 5 + delta_mouse_y)

  gui.draw_text_box()

  love.graphics.draw(version_number, love.graphics.getWidth() - (version_number:getWidth() + 4), love.graphics.getHeight() - version_number:getHeight())

  love.graphics.setColor(1, 1, 1)
  love.graphics.print("Length of mouse trail: "..#mouse_trail, 0, love.graphics.getHeight() - 30)
end

function love.quit()
end

-- TODO: partial sprites are known as "quads" in LÖVE
