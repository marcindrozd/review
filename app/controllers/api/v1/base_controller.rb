class Api::V1::BaseController < ApplicationController
  skip_before_filter :authentication_check
  respond_to :json
end
