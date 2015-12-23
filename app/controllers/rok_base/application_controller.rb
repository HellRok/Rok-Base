module RokBase
  class ApplicationController < RokExtensionController
    layout "admin"
    add_crumb 'Admin', '/admin/'
    before_filter :load_editor_settings

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
        @child = instance_variable_get("@#{params[:controller].split('/').last.
          singularize}")
        @site ||= @child.site if @child.respond_to?(:site)
        @site = RokBase::Site.find_by(host: request.host) unless @site.present?
      end

      def stamp
        if @child.respond_to?(:creator_id) && self.action_name == 'create'
          @child.creator_id = self.
            public_send("current_#{RokBase.user_class.downcase}").id
        end

        if @child.respond_to?(:updater_id) && %w(create update).include?(self.action_name)
          @child.updater_id = self.
            public_send("current_#{RokBase.user_class.downcase}").id
        end
      end

      def load_editor_settings
        user = self.public_send("current_#{RokBase.user_class.downcase}")
        @editor_settings = {}

        @editor_settings[:theme] = user.respond_to?('editor_theme') ?
          user.editor_theme : 'solarized'
        @editor_settings[:keymap] = user.respond_to?('editor_keymap') ?
          user.editor_keymap : 'default'
      end
  end
end
