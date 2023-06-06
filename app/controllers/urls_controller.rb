class UrlsController < ApplicationController
	def new
		@url = Url.new
	end

	def create
		long_url = url_params[:long_url]
		if !valid_url?(long_url)
			flash[:error] = 'Please enter a valid URL.'
			redirect_to root_path
			return
		end
		@url = Url.find_by(:long_url => long_url)

		if @url.present?
			flash[:notice] = 'URL has already been shortened: ' + request.base_url + '/' + @url.short_url
			redirect_to root_path
		elsif is_short_url(long_url) 
			flash[:notice] = 'Short URL cannot be Shortened'
			redirect_to root_path
		else
			@url = Url.new(url_params)
			@url.save!
			flash[:success] = 'Short URL was successfully created: <a href="' + request.base_url + '/' + @url.short_url + '">' + request.base_url + '/' + @url.short_url + '</a>'.html_safe
			redirect_to root_path
		end
	end

	def redirect
		url = Url.find_by(short_url: params[:short_url])
		redirect_to url.long_url if !url.nil?
	end

	private

	def url_params
		params.require(:url).permit(:long_url)
	end

	def is_short_url(url)
		short_url = url.gsub(request.base_url + '/', "")
		url = Url.find_by(short_url: short_url)
		url.present?
	end

	def valid_url?(url)
		uri = URI.parse(url)
		uri.is_a?(URI::HTTP) && !uri.host.nil?
	rescue URI::InvalidURIError
		false
	end
end

