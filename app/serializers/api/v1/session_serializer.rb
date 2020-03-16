class Api::V1::SessionSerializer < Api::V1::BaseSerializer
  #just some basic attributes
  attributes :id, :email, :token, :success, :errors, :farm_id, :user_id

  def success
    true
  end

  def errors
    []
  end

  def token
    object.authentication_token
  end

  def farm_id
    self.object.farm.id
  end

  def user_id
    self.object.id
  end
end
