#!/usr/bin/env ruby

require 'bundler/setup'
require 'pry'
require 'sequel'

require "sqlite3"

unless File.exists?('test.db')
  # Open a database
  db = SQLite3::Database.new "test.db"

  # Create a table
  db.execute <<-SQL
    create table jobminder_logs (
      created_at datetime,
      updated_at datetime,
      name varchar(30),
      start_time datetime,
      stop_time  datetime,
      status varchar(20),
      results varchar
    );
  SQL
end

# DB = Sequel.connect('sqlite3://test.db')
DB = Sequel.sqlite('test.db')

require_relative 'lib/job_minder'


my_job = JobMinder.new_job(:something) do |job|

  puts 'do something'

  binding.pry

end

Pry.start
