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
  end
end
