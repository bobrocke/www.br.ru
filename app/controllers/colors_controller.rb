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

    @hsb_range = [ 0 .. 10 ]
    for i in 0..10 do
      @hsb_range[i] = [ @color_h, @color_s, ((i.to_f/10)*10) ]
    end
    # logger.debug "The rgb range: " + @hsb_range.inspect

    @hex_range = [ 0 .. 10 ]
    for i in 0 .. 10 do
      @hex_range[i] = hsb_to_hex(@hsb_range[i])
    end
    # logger.debug "The hex range: " + @hex_range.inspect

    @rgb_range = [ 0 .. 10 ]
    for i in 0 .. 10 do
      @rgb_range[i] = hsb_to_rgb(@hsb_range[i])
    end
  end

  def set_color_hex
  end

  def set_color_rgb
  end

  def set_color_hsb
  end

  private

  # https://gist.github.com/makevoid/3918299

  def hsb_to_rgb(color_hsb)
    # expects an instance variable as an array returns an array
    h = color_hsb[0]
    s = color_hsb[1]
    b = color_hsb[2]

    # h, s, b = h.to_f/360, s.to_f/100, b.to_f/100
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

  def hsb_to_hex(color_hsb)
    # expects an instance variable as an array
    # logger.debug "hsb input: " + color_hsb.inspect
    @this_rgb = hsb_to_rgb(color_hsb)
    # logger.debug "hsb to rgb, rbg output: " + @this_rgb.inspect
    color_hex = rgb_to_hex(@this_rgb)
  end

  def rgb_to_hsb(color_rgb)
    # expects an instance variable as an array, returns an array
    r = color_rgb[0]
    g = color_rgb[1]
    b = color_rgb[2]

    r = r / 255.0
    g = g / 255.0
    b = b / 255.0
    max = [ r, g, b ].max
    min = [ r, g, b ].min
    delta = max - min
    b = max * 100

    if max != 0.0
      s = delta / max * 100
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

  def rgb_to_hex (color_rgb)
    # expects an instance variable as an array returns an array

    red_component = color_rgb[0].to_s(16).upcase
    if red_component.size < 2
      red_component = "0" + red_component
    end

    green_component = color_rgb[0].to_s(16).upcase
    if green_component.size < 2
      green_component = "0" + green_component
    end

    blue_component = color_rgb[0].to_s(16).upcase
    if blue_component.size < 2
      blue_component = "0" + blue_component
    end
    # logger.debug color_rgb[0].inspect
    # logger.debug color_rgb[1].inspect
    # logger.debug color_rgb[2].inspect

    # logger.debug hex_string.inspect
    hex_string = "#" + red_component + green_component + blue_component
  end

  def hex_to_rgb (color_hex)
    # expects an instance variable as hex returns an array
    # #AB67CD
    hex_symbol = color_hex[0]
    r_part = color_hex[1, 2]
    g_part = color_hex[3, 2]
    b_part = color_hex[5, 2]

    # logger.debug hex.inspect
    # logger.debug hex_symbol.inspect
    # logger.debug r_part.inspect
    # logger.debug g_part.inspect
    # logger.debug b_part.inspect
    [ r_part.to_i(16), g_part.to_i(16), b_part.to_i(16) ]
  end
end

# Individual conversion tests
#
# @color_rgb = hsb_to_rgb(@color_hsb)
# logger.debug "hsb to rgb, rbg output: " + @color_rgb.inspect
# passed

# @color_hsb = rgb_to_hsb(@color_rgb)
# logger.debug "rgb to hsb, hsb output: " + @color_hsb.inspect
# passed

# @color_hex = rgb_to_hex([ 10, 10, 10 ])
# logger.debug "rgb to hex, hex output: " + @color_hex.inspect
# passed

# @color_rgb = hex_to_rgb(@color_hex)
# logger.debug "hex to rgb, rgb output: " + @color_rgb.inspect
# passed

# @color_hex = hsb_to_hex(@color_hsb)
# logger.debug "hsb to hex, hex output: " + @color_hex.inspect
# passed with round off 'error'

# Convert target color to HSB
# Start with HS0 and step to HS.1 through HS1
# Convert HS0 through HS1 into RGB and HEX
# Create an array with  columns (HEX, RGB, HSB) with rows for 0 - 100 brightness in 10 steps
