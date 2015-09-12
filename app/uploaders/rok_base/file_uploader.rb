# encoding: utf-8

module RokBase
  class FileUploader < CarrierWave::Uploader::Base
    include CarrierWave::MimeTypes
    include CarrierWave::RMagick

    process :set_content_type

    # Choose what kind of storage to use for this uploader:
    storage :file
    # storage :fog

    # Override the directory where uploaded files will be stored.
    # This is a sensible default for uploaders that are meant to be mounted:
    def store_dir
      "uploads/#{model.site_id}/#{model.id}"
    end

    # Create different versions of your uploaded files:
    version :thumb, if: :image? do
      process :resize_to_fit => [512, 512]
    end

    version :preview, if: :image? do
      process :resize_to_fit => [1024, 1024]
    end

    protected

    def image?(new_file)
      new_file.content_type.start_with? 'image'
    end
  end
end
