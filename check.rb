require 'net/http'
require 'json'

#script for easily checking the review process

raise "usage: REVIEW_API=review.api.url/path REVIEW_TOKEN=review_token ruby check.rb" unless ENV['REVIEW_API'] && ENV["REVIEW_TOKEN"]

url = URI.parse(ENV['REVIEW_API'])
token = ENV["REVIEW_TOKEN"]
req = Net::HTTP::Get.new(url.path + "?token=" + token)
sock = Net::HTTP.new(url.host, url.port)
sock.use_ssl = (url.scheme == 'https')

begin
  standup_response = JSON.parse(sock.start { |http| http.request(req) }.body)
  commits_by_state = standup_response.fetch('commits_by_state'){ {} }
  commits_by_state.default = 0
rescue => e
  puts "[review] Review process was not setup properly - #{e}"
  abort
end

if commits_by_state['rejected'].to_i > 0
  project_url = standup_response['project']['url']
  puts "[review] Computer says no! - There are #{commits_by_state['rejected']} rejected commits - #{project_url}"
  abort
else
  puts "[review] Pending #{commits_by_state['pending']}, passed #{commits_by_state['passed']}"
end
