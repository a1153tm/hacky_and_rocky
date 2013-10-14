module ApplicationHelper
  def format_time_to_date(time)
    time.strftime('%Y-%m-%d')
  end
end
