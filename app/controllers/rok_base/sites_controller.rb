require_dependency "rok_base/application_controller"

module RokBase
  class SitesController < ApplicationController
    load_and_authorize_resource class: 'RokBase::Site'
    decorates_assigned :sites, :site
    before_filter :site_crumbs

    def index
      @title = 'Sites'
      @sites = @sites.page(params[:page])
    end

    def create
      if @site.save
        flash[:success] = "#{@site.name} site is now live!"
        redirect_to site_path(@site)
      else
        render :new
      end
    end

    def update
      if @site.update_attributes(site_params)
        flash[:success] = "#{@site.name} has been updated."
        redirect_to site_path(@site)
      else
        render :edit
      end
    end

    def destroy
      if @site.destroy
        flash[:success] = "#{@site.name} has been deleted."
        redirect_to sites_path
      else
        flash[:error] = @site.errors.full_messages.to_sentence
        redirect_to sites_path
      end
    end

    private

    def site_params
      params.require(:site).permit(:name, :host, :scss, :javascript, :blog_base)
    end

    def site_crumbs
      add_crumb 'Sites', sites_path

      if @site.present?
        if @site.persisted?
          add_crumb @site.name
          @title = @site.name
        else
          add_crumb 'New'
          @title = 'Site'
        end
      end
    end
  end
end
