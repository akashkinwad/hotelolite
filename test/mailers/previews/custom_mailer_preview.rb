class CustomMailerPreview < ActionMailer::Preview

  def confirmation_instructions
    CustomMailer.confirmation_instructions(User.first, "faketoken", {})
  end

  def reset_password_instructions
    CustomMailer.reset_password_instructions(User.first, "faketoken", {})
  end

  def unlock_instructions
    CustomMailer.unlock_instructions(User.first, "faketoken", {})
  end
end
