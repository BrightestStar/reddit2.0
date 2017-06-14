class LinksController < ApplicationController
  def index
    @links = Link.all
  end

  def show
    @link = Link.find(params[:id])
  end

  def new
    @link = Link.new
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if @link.update(link_params)
      redirect_to links_path
    else
      render :edit
    end

  end

  def create
    @link = Link.new(link_params)
    if @link.save
      redirect_to links_path
    else
      render :new
    end
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    redirect_to links_path, notice: 'Link was successfully destroyed.'
  end

  private

  def link_params
    params.require(:link).permit(:title, :url)
  end

end
