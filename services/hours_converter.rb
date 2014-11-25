class HoursConverter
  EXTRANEOUS_DATA = ['Session Time', 'Session Start Date', 'Session End Date', 'Session Notes']
  attr_reader :file, :new_csv

  class << self
    def perform(file_path)
      new(file_path).generate_hours_report
    end
  end

  def initialize(file_path)
    @file = File.read(file_path)
  end

  def generate_hours_report
    generate_csv
    download_file
  end


  private

  def download_file
    File.write "./reports/#{Date.today}_hours_report.csv", new_csv
  end

  def generate_csv(options={})
    @new_csv = CSV.generate(options) do |csv|
      generate_csv_headers csv
      generate_csv_body csv
    end
  end

  def generate_csv_headers(csv)
    csv << sorted_tasks.first.keys
  end

  def generate_csv_body(csv)
    sorted_tasks.each { |t| csv << t.values }
    csv
  end

  def sorted_tasks
    @sorted_tasks ||= formatted_tasks.sort_by { |h| h['Task Name'] }
  end

  def formatted_tasks
    formatted_tasks = unique_tasks.map { |t| t.reject { |k,v| EXTRANEOUS_DATA.include? k } }
    formatted_tasks.map { |t| t['Task Time'] = convert_time(t['Task Time']) }
    formatted_tasks
  end

  def unique_tasks
    grouped_tasks = tasks_csv.map { |row| row.to_hash }.group_by { |t| t['Task Name'] }
    grouped_tasks.map { |k,v| v.first } # Only get task time. Don't bother with start/end.
  end

  def tasks_csv
    CSV.parse(file, headers: true)
  end

  def convert_time(time_string)
    time = Time.parse(time_string) - Time.parse("0h 0m")
    (time/3600.to_i).round(2)
  end
end
