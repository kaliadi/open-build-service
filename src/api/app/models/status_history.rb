class StatusHistory < ApplicationRecord
  def self.history_by_key_and_hours(key, hours = 24, end_date = '')
    if end_date.empty?
      start_time = Time.now.to_i - hours.to_i * 3600
      where("time >= ? AND \`key\` = ?", start_time, key).
        pluck(:time, :value).
        collect { |time, value| [time.to_i, value.to_f] }
    else
      end_time = Time.strptime(end_date, "%Y%m%d").to_i
      start_time = end_time - hours.to_i * 3600
      where("time >= ? AND time <= ? AND \`key\` = ?", start_time, end_time, key).
        pluck(:time, :value).
        collect { |time, value| [time.to_i, value.to_f] }
    end
  end
end

# == Schema Information
#
# Table name: status_histories
#
#  id    :integer          not null, primary key
#  time  :integer          indexed => [key]
#  key   :string(255)      indexed, indexed => [time]
#  value :float(24)        not null
#
# Indexes
#
#  index_status_histories_on_key           (key)
#  index_status_histories_on_time_and_key  (time,key)
#
