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
      @pages ||= @site.pages.published.map { |page|
        RokCms::PageDrop.new(page)
      }
    end

    def posts
      @posts ||= @site.posts.published.map { |post|
        RokBlog::PostDrop.new(post)
      }
    end
  end
end

