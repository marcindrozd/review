module Payloads
  class GithubHooksController < ActionController::Base

    expose(:parser) { GithubHookParser::Main.new params[:payload] }

    def create
      ProjectFromRepositoryParser.new(parser.repository).find_or_create
      CommitsFromCommitParsers.new(parser.commits).create
      render :text => 'ok'
    end
  end
end
