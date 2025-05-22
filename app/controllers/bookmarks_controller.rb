class BookmarksController < ApplicationController
  before_action :set_list, only: %i[new create]

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list.id
    if @bookmark.save
      redirect_to @list, notice: "Bookmark was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy!
  end

private
    def set_list
      @list = List.find(params[:list_id])
    end

    def bookmark_params
      params.require(:bookmark).permit(:comment)
    end
end
