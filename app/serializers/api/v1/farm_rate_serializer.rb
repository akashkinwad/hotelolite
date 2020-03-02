class Api::V1::FarmRateSerializer < Api::V1::BaseSerializer
  attributes :id,
             :title,
             :amount,
             :farm_id
end
