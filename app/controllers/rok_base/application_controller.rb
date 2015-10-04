module RokBase
  class ApplicationController < RokExtensionController
    layout "admin"
    add_crumb 'Admin', '/admin/'

    def index
    end

    def show
    end

    def new
      @title = "New #{@title}"
    end

    def edit
      @title = "Edit #{@title}"
    end

    private

    def set_site
      @child = instance_variable_get("@#{params[:controller].split('/').last.singularize}")
      @site ||= @child.site if @child.respond_to?(:site)
      @site = RokBase::Site.find_by(host: request.host) unless @site.present?
    end
  end
end
