require 'net/http'

class SeedPoster
  attr_reader :url, :fixture_name

  def initialize(url, fixture_name)
    @url = url
    @fixture_name = fixture_name
  end

  def call
    send_payload
  end

  private

  def send_payload
    http.request(request).body
  end

  def http
    Net::HTTP.new(uri.host, uri.port)
  end

  def request
    Net::HTTP::Post.new(uri.request_uri, initheader = { 'X-GitHub-Event' => 'push' }).tap do |req|
      req.set_form_data(payload: read_fixture)
    end
  end

  def uri
    URI.parse(url)
  end

  def read_fixture
    File.open(fixture_filepath).read
  end

  def fixture_filepath
    File.expand_path("../../../db/fixtures/#{fixture_name}", __FILE__)
  end
end

namespace :hook do
  desc "Send test payload to your app running in dev env"
  task :test do |_t|
    url = "http://#{AppConfig.hostname}/payloads/github_hooks"
    fixture = 'payload.json'
    SeedPoster.new(url, fixture).call
  end
end
