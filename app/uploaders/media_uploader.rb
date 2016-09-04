# encoding: utf-8
class MediaUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  process :validate_dimensions
  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog


  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def content_type_whitelist
    /image\//
  end

  def extension_white_list
    %w(jpg jpeg png gif)
  end
  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  process :strip

  process quality: 85

  # process :store_dimensions
  #
  # process :resize_to_fit_by_percentage => 0.5

  private

  def validate_dimensions
    manipulate! do |img|
      if img.dimensions.any?{|i| i > 8000 }
        raise CarrierWave::ProcessingError, "dimensions too large"
      end
      img
    end
  end

  # def resize_to_fit_by_percentage(percentage)
  #   resize_to_fit model.width*percentage, nil
  # end
  #
  #
  # def store_dimensions
  #   if file && model
  #     p "******************************************************"
  #     p model[:media]
  #     model.width, model.height = ::MiniMagick::Image.open(file.file)[:dimensions]
  #   end
  # end

  def quality(percentage)
   manipulate! do |img|
     img.quality(percentage.to_s)
     img = yield(img) if block_given?
     img
   end
  end

  def strip
    manipulate! do |img|
      img.stripimg = yield(img) if block_given?
      img
    end
  end

end
