module ApplicationHelper
  def formatted_date(date)
    date.strftime('%B %d, %Y at %I:%M %p')
  end
  
end
