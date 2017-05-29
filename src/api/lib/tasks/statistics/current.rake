namespace :statistics do
  desc 'Exports the current number of users, projects, packages, etc. to a file'
  task current_numbers: :environment do
    # The context of the file is NOT prepared to be used by R, just a easy way to get useful information
    information = "OBS STATISTICS ON " + Time.zone.today.to_s + "\n\n"
    information += ("Number of users: " + User.count.to_s + "\n")
    information += ("Number of projects: " + Project.count.to_s + "\n")
    information += ("Number of packages: " + Package.count.to_s + "\n")

    elements = HistoryElement::Request
               .where(type: "HistoryElement::RequestAccepted")
               .joins("INNER JOIN bs_requests ON bs_requests.id = history_elements.op_object_id")
               .pluck('bs_requests.created_at', 'history_elements.created_at')
    time = 0 # time in seconds
    elements.each do |e|
      time += (e[1].to_i - e[0].to_i)
    end
    time_in_hours = time / elements.count / 60 / 60
    information += ("Average time to accept a request: " + time_in_hours.to_s + " hours\n")

    out_file = File.new("current.txt", "w")
    out_file.puts(information)
    out_file.close
  end
end
