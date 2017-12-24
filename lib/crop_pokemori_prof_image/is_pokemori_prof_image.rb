require 'rmagick'

module IsPokemoriProfImage
  include Magick

  AREA_START_X = 200
  AREA_START_Y = 1050
  AREA_END_X   = 680
  AREA_END_Y   = 1150

  RGB_COLOR = [
    'red',
    'green',
    'blue',
  ].freeze

  EXPECTED_PIXEL_MIN_BRIGHTNESS = {
    red:    80 * 256,
    green:  180 * 256,
    blue:   160 * 256,
  }.freeze

  EXPECTED_PIXEL_MAX_BRIGHTNESS = {
    red:    100 * 256,
    green:  200 * 256,
    blue:   180 * 256,
  }.freeze

  # HACK: image_file must be halfHD size
  def pokemori_prof_image?(image_file)
    image_object = ImageList.new(image_file)

    # HACK: NOT DRY
    result = []
    result << image_size_invalid?(image_object)
    result << init_pixel_brightness_valid?(image_object)
    result << judge_area_pixel_brightness_valid?(image_object)

    !(result.include?(false)) # HACK: double negative
  end

  private
  def image_object(image_file)
    ImageList.new(image_file)
  end

  def image_size_invalid?(image_object)
    unless image_object.columns == 720 || image_object.rows == 1280 # HACK: must be half HD size
      return false
    end
    true
  end

  def pixel_brightness(image_object, x, y)
    {
      red:    image_object.pixel_color(x, y).red,
      green:  image_object.pixel_color(x, y).green,
      blue:   image_object.pixel_color(x, y).blue,
    }
  end

  # if 'the color of all pixels in search area' is equal to 'the color of initial position pixel', it is true
  def judge_area_pixel_brightness_valid?(image_object)
    for x in AREA_START_X...AREA_END_X
      for y in AREA_START_Y...AREA_END_Y
        RGB_COLOR.each do |color|
          unless pixel_brightness(image_object, x, y)[color] == init_pixel_brightness(image_object)[color]
            return false
          end
        end
      end
    end
    true
  end

  # if 'the color of initial position pixel' is within the range of specified, it is true
  def init_pixel_brightness_valid?(image_object)
    init_pixel_brightness(image_object).each do |origin_color, brightness|
      if brightness < EXPECTED_PIXEL_MIN_BRIGHTNESS[origin_color] || EXPECTED_PIXEL_MAX_BRIGHTNESS[origin_color] < brightness
        return false
      end
    end
    true
  end

  def init_pixel_brightness(image_object)
    {
      red:    image_object.pixel_color(AREA_START_X, AREA_START_Y).red,
      green:  image_object.pixel_color(AREA_START_X, AREA_START_Y).green,
      blue:   image_object.pixel_color(AREA_START_X, AREA_START_Y).blue,
    }
  end
end
