math.randomseed(os.time())

local utils = require("utils.utils")
local gui = require("gui.gui")
local mouse_trail = require("utils.mouse-trail")

Sample_text = nil

local sample_sprite
local sample_font
local version_number
local delta_mouse_x
local delta_mouse_y

-- Init
function love.load()
  -- love.graphics.setDefaultFilter('nearest', 'nearest')

  sample_sprite = love.graphics.newImage("sprites/Lua-Logo.png")
  sample_font = love.graphics.newFont("fonts/ChewieDEMO-Medium.otf", 20)
  Sample_text = love.graphics.newText(sample_font, "Hello World\nNice to meet you")

  local major, minor, revision = love.getVersion()
  version_number = love.graphics.newText(sample_font, major.."."..minor.."."..revision)

  -- The mouse delta movement from one frame to the next
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
  mouse_trail:add(x, y)
end

function love.mousemoved(x, y, delta_x, delta_y)
  delta_mouse_x = delta_x
  delta_mouse_y = delta_y

  mouse_trail:add(x, y)
end

function love.wheelmoved(x, y)
  mouse_trail:modify_amount(y)
end

-- Update game state
function love.update(delta_time)
  love.keyboard.keysPressed = {}

  mouse_trail:update(delta_time)
end

-- Draw game to screen
function love.draw()
  love.graphics.clear(0, 0, 0)

  mouse_trail:draw()

  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(sample_sprite, love.graphics.getWidth() - (sample_sprite:getWidth() * 0.1), 0, 0, 0.1, 0.1)

  love.graphics.setColor(1, 1, 1)
  love.graphics.setFont(sample_font)
  love.graphics.print("FPS:"..tostring(love.timer.getFPS()), 5 + delta_mouse_x, 5 + delta_mouse_y)

  gui.draw_text_box()

  love.graphics.draw(version_number, love.graphics.getWidth() - (version_number:getWidth() + 4), love.graphics.getHeight() - version_number:getHeight())

  love.graphics.setColor(1, 1, 1)
  love.graphics.print("Amount of particles on screen"..#mouse_trail.particles.."\nAdd: "..mouse_trail.amount, 0, love.graphics.getHeight() - 60)
end

function love.quit()
end

-- TODO: partial sprites are known as "quads" in LÖVE
