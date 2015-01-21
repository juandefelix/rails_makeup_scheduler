require 'spec_helper'

describe "User with admin permission" do
# tests not working. Also these test are already implemented 
# in the admin_menu and admin_pages files in this very folder
#   subject { page }
#   # let(:user) { FactoryGirl.create(:user) }
#   let(:cancellation) { FactoryGirl.create(:cancellation) }

#   before do 
#     sign_in
#     @user.add_role :admin
#   end

#   describe "has access to users link" do

#     before do  
#       visit user_path @user
#     end

#     it { should have_content "Users"}  
#   end

#   describe "has access to delete link in cancellation" do
    
#     before do
#       visit edit_cancellation_path cancellation 
#     end

#     it { should have_link 'delete cancellation'}
#   end
# end

# describe "User without admin permission" do

#   subject { page }

#   # let(:user) { FactoryGirl.create(:user) }
#   let(:cancellation) { FactoryGirl.create(:cancellation) }

#   before do 
#     sign_in
#   end

#   describe "does not have access to users link" do

#     before do  
#       visit user_path @user
#     end

#     it { should_not have_content "Users"}  
#   end

#   describe "does not have access to delete link in cancellation" do
    
#     before do
#       visit edit_cancellation_path cancellation 
#     end

#     it { should_not have_link 'delete cancellation'}
#   end
end