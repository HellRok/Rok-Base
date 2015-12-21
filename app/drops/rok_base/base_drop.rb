module RokBase
  class BaseDrop < Liquid::Drop
    include Rails.application.routes.url_helpers
    include ActionView::Helpers::AssetTagHelper


    def stylesheet_tag
      stylesheet_link_tag cms_assets_path(theme_id: @object.theme.id,
        t: @object.assets_updated_at.to_i), media: 'all'
    end

    def javascript_tag
      javascript_include_tag cms_assets_path(theme_id: @object.theme.id,
        t: @object.assets_updated_at.to_i)
    end

    def created_by
      @object.created_by.to_s
    end

    def created_by_email
      @object.created_by.email
    end

    def updated_by
      @object.updated_by.to_s
    end

    def updated_by_email
      @object.updated_by.email
    end
  end
end
