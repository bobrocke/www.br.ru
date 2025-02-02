class ColorsController < ApplicationController
  # def initialize
  #   @the_color_hex = "#888888"
  # end

  def colors
  end

  def set_color_hex
  end

  def set_color_rgb
  end

  def set_color_hsb
  end
end


# Convert target color to HSB
# Start with HS0 and step to HS.1 through HS1
# Convert HS0 through HS1 into RGB and HEX
# Create an array with  columns (HEX, RGB, HSB) with rows for 0 - 100 brightness in 10 steps
