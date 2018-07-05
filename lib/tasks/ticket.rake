namespace :ticket do
  desc "Reporting All Tickets at 8pm Colombian Hour"
  task :report_all => :environment do
    tickets = Ticket.where(status: "pendiente")
    puts "Enqueuing report of #{tickets.size} tickets..."
    tickets.each do |ticket|
      DayClosingJob.perform_later(ticket.id)
    end
    # rake task will return when all jobs are _enqueued_ (not done).
  end
end
