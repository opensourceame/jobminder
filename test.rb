#!/usr/bin/env ruby

require 'bundler/setup'
require 'pry'
require 'sequel'
require 'mysql2'
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
      data varchar
    );
  SQL
end

# DB = Sequel.connect('sqlite3://test.db')
# DB = Sequel.sqlite('test.db')
#
#
DB = Sequel.connect('mysql2://root@localhost/trading')

require_relative 'lib/job_minder'

Pry.start

my_job = JobMinder::Job.new(:something) do |job|

  puts 'do something'

  job.data.blah = 1
  job.data.something_else = 1

end
