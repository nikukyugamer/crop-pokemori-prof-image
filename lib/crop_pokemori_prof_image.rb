require "crop_pokemori_prof_image/version"
require 'crop_pokemori_prof_image/create_crop_image'
require 'crop_pokemori_prof_image/is_pokemori_prof_image'

module CropPokemoriProfImage
  extend self
  extend CreateCropImage
  extend IsPokemoriProfImage

  def crop_single_image(image_file, output_directory='crop_image')
    image_file = change_to_fullpath(image_file)
    @output_directory = output_directory

    crop_image_initialize(image_file)
    create_crop_image(image_file) if pokemori_prof_image?(@normalize_image_file)
    remove_image_file(@normalize_image_file)
  end

  def crop_multiple_image(input_directory='.', output_directory='crop_image')
    image_files = Pathname.glob("#{change_to_fullpath(input_directory)}/*").select do |filename|
       filename.to_s =~ /\A.*(\.jpg|\.png)\z/
    end
    @output_directory = output_directory

    image_files.each do |image_file|
      crop_single_image(image_file.to_s, output_directory)
    end
  end
end
