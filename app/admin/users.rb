ActiveAdmin.register User, as: "Utilisateurs" do
  menu priority: 1

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :first_name, :last_name, :sex, :description, :phone, :city, :zip_code, :street, :street_nb, :reset_password_token, :reset_password_sent_at, :remember_created_at, :deleted_at, :confirmation_token, :confirmed_at, :confirmation_sent_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :first_name, :last_name, :sex, :description, :phone, :city, :zip_code, :street, :street_nb, :reset_password_token, :reset_password_sent_at, :remember_created_at, :deleted_at, :confirmation_token, :confirmed_at, :confirmation_sent_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
