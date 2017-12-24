require 'crop_pokemori_prof_image/file_operation'

module CreateCropImage
  include FileOperation

  RESIZE_TO                 = '720x1280'
  FACE_CROP_AREA            = '130x130+295+320'
  NAME_CROP_AREA            = '125x40+300+465'
  ID_NUMBER_CROP_AREA       = '225x35+275+505'
  WHOLE_ID_PART_CROP_AREA   = '280x35+220+505'

  def create_crop_image(image_file)
    crop_face
    crop_name
    crop_id_number
    crop_whole_id_part
  end

  def crop_image_initialize(image_file) # image_file is full path
    @image_file             = image_file
    @basename_of_image_file = basename_of_image_file(image_file)
    @extesion_of_basename   = File.extname(image_file)

    make_directory_if_not_exist(@output_directory)
    @normalize_image_file   = normalize_image_file
  end

  def normalize_image_file
    source_image_file     = change_to_fullpath("#{File.dirname(@image_file)}/#{@basename_of_image_file}#{@extesion_of_basename}")
    normalize_image_file  = change_to_fullpath("#{@output_directory}/#{@basename_of_image_file}_normalize#{@extesion_of_basename}")

    command = "convert #{source_image_file} -resize #{RESIZE_TO} #{normalize_image_file}"
    `#{command}`

    normalize_image_file
  end

  def crop_face
    crop_face_file = change_to_fullpath("#{@output_directory}/#{@basename_of_image_file}_face#{@extesion_of_basename}")
    command = "convert #{@normalize_image_file} -crop #{FACE_CROP_AREA} #{crop_face_file}"
    `#{command}`

    crop_face_file
  end

  def crop_name
    crop_name_file = change_to_fullpath("#{@output_directory}/#{@basename_of_image_file}_name#{@extesion_of_basename}")
    command = "convert #{@normalize_image_file} -crop #{NAME_CROP_AREA} #{crop_name_file}"
    `#{command}`

    crop_name_file
  end

  def crop_id_number
    crop_id_number_file = change_to_fullpath("#{@output_directory}/#{@basename_of_image_file}_id_number#{@extesion_of_basename}")
    command = "convert #{@normalize_image_file} -crop #{ID_NUMBER_CROP_AREA} #{crop_id_number_file}"
    `#{command}`

    crop_id_number_file
  end

  def crop_whole_id_part
    crop_whole_id_part_file = change_to_fullpath("#{@output_directory}/#{@basename_of_image_file}_whole_id_part#{@extesion_of_basename}")
    command = "convert #{@normalize_image_file} -crop #{WHOLE_ID_PART_CROP_AREA} #{crop_whole_id_part_file}"
    `#{command}`

    crop_whole_id_part_file
  end
end
