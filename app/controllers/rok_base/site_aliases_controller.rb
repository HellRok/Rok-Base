require_dependency "rok_base/application_controller"

module RokBase
  class SiteAliasesController < ApplicationController
    load_and_authorize_resource :site, class: 'RokBase::Site'
    load_and_authorize_resource class: 'RokBase::SiteAlias', through: :site,
      shallow: true, through_association: :aliases
    decorates_assigned :site_alias, :site
    before_filter :set_site, :upload_crumbs, :stamp

    def create
      if @site_alias.save
        flash[:success] = "#{site_alias} is now live!"
        redirect_to site_path(@site)
      else
        render :new
      end
    end

    def destroy
      if @site_alias.destroy
        flash[:success] = "#{site_alias} has been deleted."
      else
        flash[:error] = @site_alias.errors.full_messages.to_sentence
      end
      redirect_to site_path(@site)
    end

    private

      def site_alias_params
        params.require(:site_alias).permit(:host)
      end

      def upload_crumbs
        add_crumb 'Site', site_path(@site)
        add_crumb 'New'
        @title = 'Hostname'
      end
  end
end
