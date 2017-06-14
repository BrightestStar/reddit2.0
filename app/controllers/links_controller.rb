class LinksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @links = Link.all
  end

  def show
    @link = Link.find(params[:id])
  end

  def new
    @link = current_user.links.build
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
    @link = current_user.links.build(link_params)
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

  def upvote
    @link = Link.find(params[:id])
    @link.upvote_by current_user
    redirect_to request.referer
  end

  def downvote
    @link = Link.find(params[:id])
    @link.downvote_by current_user
    redirect_to request.referer
  end

  private

  def link_params
    params.require(:link).permit(:title, :url)
  end

end
