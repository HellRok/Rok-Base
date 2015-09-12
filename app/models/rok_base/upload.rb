module RokBase
  class Upload < ActiveRecord::Base
    include UploadExtension
    belongs_to :site, class_name: 'RokBase::Site'

    mount_uploader :file, FileUploader

    validates_presence_of :file, :name
    validates_length_of :name, maximum: 255
    validates_uniqueness_of :name, scope: :site

    before_validation :populate_name

    private
      def populate_name
        if file.present? && name.blank?
          self.name = File.basename(self.file.path)
        end
      end
  end
end
