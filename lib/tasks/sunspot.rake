namespace :sunspot do
  task :reset => :environment do
    puts "Restarting Solr..."
    begin
      Rake::Task['sunspot:solr:stop'].execute
    ensure
      Rake::Task['sunspot:solr:start'].execute
      puts "Reindexing Solr..."
      # Sunspot added a 'y/n' confirmation to reindexing in 2.0
      `yes | rake sunspot:reindex`
      puts "Done Reindexing Solr!"
    end
  end

  task :reset_without_reindex => :environment do
    puts "Restarting Solr..."
    begin
      Rake::Task['sunspot:solr:stop'].execute
    rescue => e
    ensure
      Rake::Task['sunspot:solr:start'].execute
    end
    puts "Solr restarted."
  end

end

