require 'rails_helper'

describe "Visiting profiles" do

  include TestFactories

  before do
    @user = authenticated_user
    @post = associated_post(user: @user)
    @comment = Comment.create(user: @user, post:@post, body: "A Comment")
  end

  describe "not signed in" do

    it "shows profile" do
      visit user_path(@user)
      expect(current_path).to eq(user_path(@user))

      expect( page ).to have_content(@user.name)
      expect( page ).to have_content(@post.title)
      expect( page ).to have_content(@comment.body)
      expect( page ).to have_content("Sign In")
    end

  end

  describe "signed in" do

    it "shows profile" do
      @user.confirmed_at = Time.now
      @user.save
      login_as(@user, :scope => :user)
      
      visit user_path(@user)
      #expect(current_user).not_to be_nil
      expect(current_path).to eq(user_path(@user))

      expect( page ).to have_content(@user.name)
      expect( page ).to have_content(@post.title)
      expect( page ).to have_content(@comment.body)
      expect( page ).not_to have_content("Sign In")
    end

  end
end