class RangesController < ApplicationController
  # def initialize
  #   @the_color_hex = "#888888"
  # end

  def ranges
    # @the_color_hex = "#888888"
    @the_color_as_hex = @the_color_hex
    logger.info @the_color_as_hex
    logger.info @the_color_hex
  end

  def set_color_hex
    @the_color_hex = params[:the_color_hex]

    logger.info @the_color_hex

    render :ranges
  end
end
