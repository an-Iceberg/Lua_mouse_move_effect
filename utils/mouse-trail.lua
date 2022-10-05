local utils = require "utils.utils"
local mouse_trail =
{
  particles = {},
  amount = 1,
  life_span = 15,

  add = function (self, x, y)
    for i = 1, self.amount, 1 do
      local random_angle = math.random(0, 628)
      local speed = math.random(100, 400)

      local new_particle = {
        position = {
          x = x,
          y = y
        },
        velocity = {
          x = speed * math.cos(random_angle / 100),
          y = speed * math.sin(random_angle / 100)
        },
        acceleration = {}, -- TODO: this, some day
        color = {
          red = (math.random(10, 100)) / 100,
          green = (math.random(10, 100)) / 100,
          blue = (math.random(10, 100)) / 100,
        },
        radius = math.random(5, 20)
      }

      table.insert(self.particles, 1, new_particle)
    end

  end,

  update = function (self, delta_time)
    for index, particle in ipairs(self.particles) do
      -- Updates the particle position with the velocity and the elapsed time
      particle.position.x = particle.position.x + particle.velocity.x * delta_time
      particle.position.y = particle.position.y + particle.velocity.y * delta_time

      -- Updates the radius of each particle
      particle.radius = particle.radius - (delta_time * self.life_span)

      if particle.radius <= 0 then
        table.remove(self.particles, index)
      end
    end
  end,

  draw = function (self)
    for _, particle in pairs(self.particles) do
      if particle.radius > 0 then
        love.graphics.setColor(particle.color.red, particle.color.green, particle.color.blue)
        love.graphics.circle("fill", particle.position.x, particle.position.y, particle.radius)
      end
    end
  end,

  modify_amount = function (self, number)
    number = number or 1

    self.amount = self.amount + number

    self.amount = utils.clamp(1, 10, self.amount)
  end
}

return mouse_trail
