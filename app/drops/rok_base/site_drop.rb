module RokBase
  class SiteDrop < Liquid::Drop
    def initialize(site)
      @site = site
    end

    def name
      @site.name
    end

    def host
      @site.host
    end

    def pages
      @pages ||= @site.pages.published.in_order.map { |page|
        RokCms::PageDrop.new(page)
      }
    end

    def posts
      @posts ||= @site.posts.published.in_order.map { |post|
        RokBlog::PostDrop.new(post)
      }
    end
  end
end

