module TimeLogsSpecHelper
  def fill_in_new_time_log(options)
    visit new_time_log_path
    fill_in_time_log(options)
  end

  def edit_time_log(options)
    visit edit_time_log_path(options[:time_log])
    fill_in_time_log(options)
  end

  def fill_in_time_log(options)
    find("#time_log_session_date").click
    find(".day.active").click
    select("#{options[:student_name]}", from: 'time_log[student_id]')
    fill_in("time_log[duration]", with: options[:duration])
    fill_in("time_log[notes]", with: options[:notes])
  end
end
