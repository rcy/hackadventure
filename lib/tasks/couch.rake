namespace :couch do
  task :client => :environment do
    @client = HTTPClient.new
    @dburl = CouchPotato.full_url_to_database
  end

  desc "Create the database"
  task :put_db => :client do
    response = @client.put @dburl
    puts response.body.as_json
  end

  desc "Destroy the database"
  task :delete_db => :client do
    response = @client.delete @dburl
    puts response.body.as_json
  end

  desc "Delete design documents"
  task :delete_design => :client do
    ['lesson'].each do |m|
      url = @dburl + '/_design/' + m
      puts "DELETE #{url}"

      # need to fetch document to get the _rev to DELETE
      response = @client.get url
      rev = JSON.parse(response.body.as_json['body'])['_rev']
      response = @client.delete url + "?rev=#{rev}"
      puts response.reason unless response.status_code == 200
    end
  end

end
