ActiveAdmin.register Employee do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :father_name, :mother_name, :age, :phone_number, :address, :trainer_id, :destination, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :image
  #
  # or
  #
  permit_params do
     permitted = [:name, :father_name, :mother_name, :age, :phone_number, :address, :trainer_id, :destination, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :image, :leave_count]
     permitted << :other if params[:action] == 'create' && current_user.admin?
     permitted
  end
  
end
