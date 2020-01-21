module UsersHelper

  def sign_in_at_date_formatter(date_attr)
    date_attr.nil? ? 'Not Yet' : date_attr.strftime("%d %b %Y at %I:%M %P")
  end

end
