namespace :statistics do
  desc 'Exports the number of bs requests per month to a file'
  task number_bs_requests: :environment do
    # The context of the file is prepared to be used by R
    information = "date, bs_requests, bs_requests_increase\n"
    # we want the bs_request at the last day of every period
    date = Date.new(2008,4,1)
    old_bs_requests = 0
    while date < Date.today
      num_bs_requests = BsRequest.where('created_at < ?', date).count
      information += (date.to_s + ", " + num_bs_requests.to_s + ", " + (num_bs_requests - old_bs_requests).to_s + "\n")
      # granularity, currently it is one month. Adjust it as needed
      date += 1.month
      old_bs_requests = num_bs_requests
    end
    out_file = File.new("number_bs_requests.txt", "w")
    out_file.puts(information)
    out_file.close
  end
end