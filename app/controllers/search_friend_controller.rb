class SearchFriendController < ApplicationController

  def index
      if params[:search1]==""

        @friend_array_search = []
      else
        @friend_array_search =User.search(params[:search1])
      end


  end

end
