class UrlsController < ApplicationController

  def index
    @urls=Url.all
  end

  def show
    @url=Url.find_by_random_id params[:id]

    if @url
      redirect_to @url.original
    else
      flash[:alert]='Shortened url not registered..'
      redirect_to urls_path
    end
  end

  def new
    @url=Url.new
  end

  def create
    @url=Url.new url_params

    letters||=[('a'..'z'), ('A'..'Z'), (0..9)].map {|i| i.to_a}.flatten
    @url.random_id=Url.unique_rand_id letters

    if @url.save
      flash[:notice]='Short Url Created..'

      redirect_to urls_path
    else
      flash[:alert]='Short Url could not be created..'
      render :new
    end
  end


  private
    def url_params
      params.require(:url).permit :original
    end

end
