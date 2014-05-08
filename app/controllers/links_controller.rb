class LinksController < ApplicationController
	before_filter :authenticate_user!
	before_filter :load_link, only: [:destroy]

	def create
		@link = current_user.links.new(link_params)
		if @link.save
			@links = current_user.links
		else
      render :error
		end
	end

	def new
		@link = current_user.links.new
	end

	def destroy
		if current_user.owns?(@link) && @link.destroy 
			@links = current_user.links
		else
			render :error
		end
	end

	private
		def link_params
			params.require(:link).permit(:name, :content, :url)
		end

		def load_link
			@link = Link.find(params[:id])
		end
end
