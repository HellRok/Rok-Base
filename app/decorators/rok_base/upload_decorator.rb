module RokBase
  class UploadDecorator < Draper::Decorator
    delegate_all

    def file_name
      file.path.split('/').last
    end
  end
end
