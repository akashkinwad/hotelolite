module PaymentDetailsHelper

  def years_select_list
    (Date.today.year..Date.today.year+10).to_a
  end

  def last_digits(number)
    number.to_s.length <= 4 ? number : number.to_s.slice(-4..-1)
  end

  def mask(number)
   "XXXX-XXXX-XXXX-#{last_digits(number)}"
  end

end
