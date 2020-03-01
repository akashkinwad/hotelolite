class Api::V1::FarmSerializer < Api::V1::BaseSerializer
  attributes :id,
             :title,
             :description,
             :contact_no,
             :altr_contact_no,
             :address,
             :no_of_rooms,
             :area,
             :food_type,
             :time_to_visit,
             :email,
             :owner_name,
             :user_id
end
