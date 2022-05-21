class UserResource < ApplicationResource
  root_key :user

  attributes :id, :name, :image, :iss, :sub
end
