class Api::V1::FarmSerializer < Api::V1::BaseSerializer
  include Rails.application.routes.url_helpers

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
             :user_id,
             :facebook_url,
             :instagram_url,
             :whatsapp_no,
             :district_id,
             :map_iframe,
             :banner,
             :gallery,
             :latitude,
             :longitude

  def gallery
    return unless object.images.attachments
    image_urls = object.images.map do |image|
      rails_blob_path(image, only_path: true)
    end
    image_urls
  end

  def banner
    rails_blob_path(object.banner, only_path: true) if object.banner.attached?
  end
end
