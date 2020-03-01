class Api::V1::BookingSerializer < Api::V1::BaseSerializer
  attributes :id, :first_name, :last_name, :contact_no,
             :altr_contact_no, :email, :check_in, :farm_id
end
