module RokBase
  class SiteAlias < ActiveRecord::Base
    belongs_to :site, class_name: 'RokBase::Site'

    validates_uniqueness_of :host
    validates_length_of :host, maximum: 255

    def to_s
      host
    end
  end
end
