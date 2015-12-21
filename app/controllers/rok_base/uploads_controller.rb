require_dependency "rok_base/application_controller"

module RokBase
  class UploadsController < ApplicationController
    load_and_authorize_resource :site, class: 'RokBase::Site'
    load_and_authorize_resource class: 'RokBase::Upload', through: :site, shallow: true
    decorates_assigned :uploads, :upload, :site
    before_filter :set_site, :upload_crumbs, :stamp

    def index
      @uploads = @uploads.page(params[:page])
      @title = 'Uploads'
    end

    def create
      if @upload.save
        flash[:success] = "#{upload.name} file is now live!"
        redirect_to site_uploads_path(@upload.site)
      else
        render :new
      end
    end

    def update
      if @upload.update_attributes(upload_params)
        flash[:success] = "#{upload.name} has been updated."
        redirect_to site_uploads_path(@upload.site)
      else
        render :edit
      end
    end

    def destroy
      if @upload.destroy
        flash[:success] = "#{@upload.name} has been deleted."
        redirect_to site_uploads_path(@site)
      else
        flash[:error] = @upload.errors.full_messages.to_sentence
        redirect_to site_uploads_path(@site)
      end
    end

    private

      def upload_params
        params.require(:upload).permit(:file, :name)
      end

      def upload_crumbs
        add_crumb 'Uploads', site_uploads_path(@site)

        if @upload.present?
          if @upload.persisted?
            add_crumb upload.name
            @title = upload.name
          else
            add_crumb 'New'
            @title = 'Upload'
          end
        end
      end
  end
end
