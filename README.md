# Billable Hours Reports
A ruby application for generating billable hours reports from TicToc data http://www.overcommitted.com/tictoc/

## Getting Started
Make sure you have Ruby and Ruby Gems installed.

Bundler is the only Ruby dependency:

`gem install bundler`

From the project directory, run:

`bundle install`

## How To Use
1. Export tasks csv file from TicToc into the `tasks` directory, or use the sample csv file included in the project.
2. From the project directory, execute the ruby script for generating a report `$ ruby generate_hours_report.rb`
3. A new report will be generated in the `reports` directory.

Made with love by @gwmccubbin.
