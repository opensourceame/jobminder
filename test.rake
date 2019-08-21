task test: :environment do

  JobMinder.configure(
      lock_prefix: 'YYYYY'
  )

  JobMinder::Job.unlock('blah')

  j = JobMinder.new_job('blah', process_lock: true) do |job|

    puts "DO SOMETHING"

    job.results = {
        this: 1,
        that: 2
    }

    # blah

  end

  binding.pry

end
