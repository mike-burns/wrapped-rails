Feature: NOT NULL ... DEFAULT toggles the wrapped value

  Scenario: An app with a model with some fields that require presence of
    When I successfully run `bundle exec rails new testapp`
    And I cd to "testapp"
    And I add the "capybara" gem
    And I add the "database_cleaner" gem
    And I add the "diesel" gem
    And I add the "wrapped-rails" gem from this project
    And I run `bundle install --local`

    When I write to "app/controllers/users_controller.rb" with:
    """
    class UsersController < ApplicationController
      def index
        @users = User.all
      end
    end
    """
    When I write to "db/migrate/1_create_users.rb" with:
    """
    class CreateUsers < ActiveRecord::Migration
      def self.up
        create_table :users do |t|
          t.string :first_name, :last_name, :null => false, :default => ''
          t.string :middle_name
        end
      end
    end
    """
    When I write to "app/models/user.rb" with:
    """
    class User < ActiveRecord::Base
    end
    """
    When I write to "app/views/users/index.html.erb" with:
    """
    <% @users.each do |user| %>
      <%= user.first_name %> <%= user.middle_name.unwrap_or('') {|mn| "#{mn.first}." } %> <%= user.last_name %>
    <% end %>
    """
    When I write to "test/integration/the_test.rb" with:
    """
    require 'test_helper'
    class TheTest < ActionController::IntegrationTest
      def test_the_app
        User.create!(:first_name => 'Roy', :middle_name => 'Grace', :last_name => 'Biv')
        User.create!(:first_name => 'The', :last_name => 'Pope')

        get users_path

        assert_match /Roy G\. Biv/m, @response.body
        assert_match /The  Pope/m, @response.body
      end
    end
    """
    When I write to "config/routes.rb" with:
    """
    Testapp::Application.routes.draw do
      resources :users
    end    
    """

    When I successfully run `bundle exec rake db:migrate --trace`
    Then I successfully run `bundle exec rake --trace`

