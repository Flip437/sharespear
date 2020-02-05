class SearchFriendController < ApplicationController

  def index
      @friend_array_search = User.search(params[:search1])

  end

end
