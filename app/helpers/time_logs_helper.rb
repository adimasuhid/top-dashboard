module TimeLogsHelper
  def display_hours(duration)
    "#{duration} hrs"
  end

  def sortable(column, title)
    title ||= column.titleize
    css_class = column == params[:sort] ? "current #{params[:direction]}" : nil
    direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
    link_to title, {sort: column, direction: direction}, id: column, class: css_class
  end
end
