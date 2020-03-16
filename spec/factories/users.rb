# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  email              :string
#  encrypted_password :string
#  role               :enum             not null
#  oldid              :integer
#  created_at         :datetime         not null
#  remember_token     :string           default(""), not null
#  confirmation_token :string
#  state              :enum             default("active"), not null
#
# Indexes
#
#  index_users_on_email           (email)
#  index_users_on_remember_token  (remember_token)
#

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }
  end
end
