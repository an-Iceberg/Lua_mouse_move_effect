local gui = {
  draw_text_box = function ()
    local horizontal_padding = 5

    love.graphics.setColor(0.5, 0, 1)
    love.graphics.rectangle("fill", 40 - (horizontal_padding / 2), 40, Sample_text:getWidth() + horizontal_padding, Sample_text:getHeight(), 10, 10, 100)

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(Sample_text, 40, 40)
  end
}

return gui
