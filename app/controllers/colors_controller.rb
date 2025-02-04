class ColorsController < ApplicationController
  def colors
    @color = Color.first
    @color_hex = @color.hex
    @color_r = @color.r
    @color_g = @color.g
    @color_b = @color.b
    @color_h = @color.h
    @color_s = @color.s
    @color_l = @color.l

    @color_hsb = [ @color_h, @color_s, @color_l ]
    @color_rgb = [ @color_r, @color_g, @color_b ]
    # @color_rgb = hex_to_rgb [ @color_hex ]

    # @color_hsb = rgb_to_hsb(@color_r, @color_g, @color_b)
    # @color_rgb = hsb_to_rgb(@color_h, @color_s, @color_l)
    # @color_hex = hsb_to_hex(@color_h, @color_s, @color_l)

    # logger.debug @color_hex.inspect

    @hsb_range = [ 0 .. 10 ]
    for i in 0..10 do
      @hsb_range[i] = [ @color_h, @color_s, ((i.to_f)/10) ]
    end

    @hex_range = [ 0 .. 10 ]
    for i in 0 .. 10 do
      @hex_range[i] = hsb_to_hex(@hsb_range[i])
    end

    logger.debug @hex_range.inspect
  end

  def set_color_hex
  end

  def set_color_rgb
  end

  def set_color_hsb
  end

  private

  # https://gist.github.com/makevoid/3918299

  def hsb_to_rgb(h, s, b)
    h, s, b = h.to_f/360, s.to_f/100, b.to_f/100
    h_i = (h*6).to_i
    f = h*6 - h_i
    p = b * (1 - s)
    q = b * (1 - f*s)
    t = b * (1 - (1 - f) * s)
    r, g, b = b, t, p if h_i==0
    r, g, b = q, b, p if h_i==1
    r, g, b = p, b, t if h_i==2
    r, g, b = p, q, b if h_i==3
    r, g, b = t, p, b if h_i==4
    r, g, b = b, p, q if h_i==5
    [ (r*255).to_i, (g*255).to_i, (b*255).to_i ]
  end

  def hsb_to_hex(h, s, b)
    color_rgb = hsb_to_rgb(h, s, b)
    color_hex = rgb_to_hex(color_rgb[1], color_rgb[2], color_rgb[2])
  end

  def rgb_to_hsb(r, g, b)
    r = r / 255.0
    g = g / 255.0
    b = b / 255.0
    max = [ r, g, b ].max
    min = [ r, g, b ].min
    delta = max - min
    b = max * 100

    if max != 0.0
      s = delta / max *100
    else
      s = 0.0
    end

    if s == 0.0
      h = 0.0
    else
      if r == max
        h = (g - b) / delta
      elsif g == max
        h = 2 + (b - r) / delta
      elsif b == max
        h = 4 + (r - g) / delta
      end

      h *= 60.0

      if h < 0
        h += 360.0
      end
    end

    [ h.to_i, s.to_i, b.to_i ]
  end

  def rgb_to_hex (r, g, b)
    hex_string = "#" + r.to_s(16).upcase + g.to_s(16).upcase + b.to_s(16).upcase
  end

  def hex_to_rgb (hex)
    # #AB67CD
    hex = hex[0]
    first_char = hex[0]
    r_part = hex[1, 2]
    g_part = hex[3, 2]
    b_part = hex[5, 2]

    # logger.debug hex.inspect
    # logger.debug first_char.inspect
    # logger.debug r_part.inspect
    # logger.debug g_part.inspect
    # logger.debug b_part.inspect
    [ r_part.to_i(16), g_part.to_i(16), b_part.to_i(16) ]
  end
end


# Convert target color to HSB
# Start with HS0 and step to HS.1 through HS1
# Convert HS0 through HS1 into RGB and HEX
# Create an array with  columns (HEX, RGB, HSB) with rows for 0 - 100 brightness in 10 steps
