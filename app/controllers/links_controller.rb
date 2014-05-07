class LinksController < ApplicationController
	before_filter :authenticate_user!
	before_filter :load_link, only: [:udpate, :destroy]
	before_filter :authorize_user!, only: [:update, :destroy]

	def create
		@link = current_user.links.new(link_params)

		respond_to do |format|
			if @link.save
				format.html { redirect_to user_path(current_user.id), notice: 'Link Created' }
			else
        format.html { redirect_to @group, alert: 'Link was not created'}
			end
		end
	end

	def update
		if @link.update_attributes(link_params)
			redirect_to user_path(current_user.id), :notice => "Link updated!"
		else
			redirect_to user_path(current_user.id), alert: 'Link was not updated'
		end
	end

	def destroy
		if @link.destroy
			flash[:notice] = "Link destroyed!"
		else
			flash[:alert] = "Link was not destroyed!"
		end
		redirect_to user_path(current_user.id)
	end

	private
		def link_params
			params.require(:link).permit(:name, :content, :url)
		end

		def load_link
			@link = Link.find(params[:id])
		end

		def authorize_user!
			unless current_user.owns?(@link)
				redirect_to '/'
				flash[:alert] = "You are not authorized to do this"
			end
		end
end
