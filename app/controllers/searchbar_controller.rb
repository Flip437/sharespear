class SearchbarController < ApplicationController

    def index
        @book_copy_array = BookCopy.search(params[:search1],'Lyon')
    end

<<<<<<< HEAD
    # modifier a recherche, la simplifier
    # 1 seule barre de recherche par quartier
    # ping tarrek pour g=hsitoire des controller 
    # responsabilité unique / test unique dans rails  ...
    # vidéo de test de sendimed ? --> pour savoir comment tester qqch 

end
=======
end
>>>>>>> b3cafeaf810354305fe1bafe220414cd1b7320d9
