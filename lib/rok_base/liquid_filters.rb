module RokBase
  module LiquidFilters
    def self.set_site(site)
      @@site = site
    end

    def upload(name, version='original')
      upload = @@site.uploads.find_by(name: name)

      if upload
        if %w(thumb preview).include?(version) && upload.file.image?(upload.file)
          upload.file.try(:url, version)
        else
          upload.file.url
        end
      end
    end
  end
end

