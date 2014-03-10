module Payloads
  class GithubHooksController < ActionController::Base

    before_filter :hook_is_valid?, only: :create
    expose(:parser) { GithubHookParser::Main.new params[:payload] }

    def create
      ProjectFromRepositoryParser.new(parser.repository).find_or_create
      CommitsFromCommitParsers.new(parser.commits).create
      render :text => 'ok'
    end

    private
    def hook_is_valid?
      render :text => 'wrong arguments' unless parser.is_valid?
    end
  end
end
