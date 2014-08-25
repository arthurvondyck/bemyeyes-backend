require 'active_support'
require 'active_support/core_ext'

BemyeyesBackend::Admin.controllers :base do
  get :index, :map => "/" do
    render "base/index"
  end
end
