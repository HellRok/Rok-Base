module RokBase
  class Site < ActiveRecord::Base
    include SiteExtension
    before_save :compile_scss
    after_save :update_post_paths if RokBlog

    validates_presence_of :host, :name
    validates_uniqueness_of :host, :name
    validates_length_of :host, :name, maximum: 255

    if RokCms
      has_many :layouts, class_name: 'RokCms::Layout', dependent: :restrict_with_error
      has_many :pages, through: :layouts, class_name: 'RokCms::Page', dependent: :restrict_with_error
      has_many :themes, class_name: 'RokCms::Theme', dependent: :restrict_with_error
    end

    if RokBlog
      has_many :posts, through: :layouts, class_name: 'RokBlog::Post', dependent: :restrict_with_error
    end

    has_many :uploads, class_name: 'RokBase::Upload', dependent: :restrict_with_error

    def find_request(url)
      to_return = nil

      if RokBlog && url.starts_with?(blog_base)
        to_return = posts.find_by(slug: url.sub(blog_base, ''), published: true)
      end

      if RokCms
        to_return ||= pages.find_by(slug: url, published: true)
      end

      to_return
    end

    private
      def compile_scss
        # TODO: Proper error handling instead of exploding
        self.compiled_css = self.scss.present? ? Sass.compile(self.scss, style: :compressed) : nil
      end

      def update_post_paths
        posts.each(&:save)
      end
  end
end
