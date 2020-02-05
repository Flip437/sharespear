ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }
  content title: proc { I18n.t("active_admin.dashboard") } do
    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end
    column do
         panel "Information sur le site" do
           para "-> Nombre d'utilisateurs totaux : | #{User.count} |"
           para "Nombre de nouveaux utilisateurs ces 7 dernier jours : | #{User.where('created_at BETWEEN ? AND ?', Date.today-7 , Date.today ).count} |"
           para "-> Nombre de livres totaux : | #{BookCopy.count} |"
           para "Nombre de livres ajoutés cette semaine : | #{BookCopy.where('created_at BETWEEN ? AND ?', Date.today-7 , Date.today ).count} |"
           para "-> Nombre d'emprunts totaux : | #{Borrow.count} |"
           para "Nombre d'emprunts cette semaine : | #{Borrow.where('created_at BETWEEN ? AND ?', Date.today-7 , Date.today ).count} |"
         end
      end
     end
  end # content
end