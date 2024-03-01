# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')
Rails.application.config.assets.paths << Rails.root.join('vendor')
Rails.application.config.assets.paths << Rails.root.join('lib')
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf|otf)\z/
Rails.application.config.assets.precompile += %w( olivia.jpg )
Rails.application.config.assets.precompile += %w( emilyz.jpg )
Rails.application.config.assets.precompile += %w( james.jpg )
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w( logo.png )
Rails.application.config.assets.precompile += %w( emilyz.jpg )
Rails.application.config.assets.precompile += %w( Flip.png )
Rails.application.config.assets.precompile += %w( Arthur.jpg )
Rails.application.config.assets.precompile += %w( lucas.png )
Rails.application.config.assets.precompile += %w( Artboard_1.png )
Rails.application.config.assets.precompile += %w( back_img2.jpg )
Rails.application.config.assets.precompile += %w( back_img3.jpg )
Rails.application.config.assets.precompile += %w( back_img4.jpg )
Rails.application.config.assets.precompile += %w( back_img5.jpg )
Rails.application.config.assets.precompile += %w( back_img6.jpg )
Rails.application.config.assets.precompile += %w( back_img7.jpg )
Rails.application.config.assets.precompile += %w( back_img8.jpg )
Rails.application.config.assets.precompile += %w( back_img9.jpg )
Rails.application.config.assets.precompile += %w( book_back1.jpg )
Rails.application.config.assets.precompile += %w( sharespeare1.png )
Rails.application.config.assets.precompile += %w( sharespeare2.png )
Rails.application.config.assets.precompile += %w( sharespeare3.png )
Rails.application.config.assets.precompile += %w( sharespeare4.png )
Rails.application.config.assets.precompile += %w( sharespeare5.png )
Rails.application.config.assets.precompile += %w( sharespeare6.png )
Rails.application.config.assets.precompile += %w( sharespeare7.png )
Rails.application.config.assets.precompile += %w( sharespeare8.png )
Rails.application.config.assets.precompile += %w( thp.png )
Rails.application.config.assets.precompile += %w( reco.png )
Rails.application.config.assets.precompile += %w( reco2.png )
Rails.application.config.assets.precompile += %w( biblio.png )
Rails.application.config.assets.precompile += %w( gerer.png )
Rails.application.config.assets.precompile += %w( no_picture_found_sk.png )
