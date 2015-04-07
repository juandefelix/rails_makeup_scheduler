require 'spec_helper'

describe Business do
  before { @business = Business.new(name: "Bucktown Music",
                                    email: "luis@bucktownmusic.com",
                                    city: "Chicago",
                                    zip: "60657",
                                    phone_number: "3124029850",
                                    website: "www.bucktownmusic.com") }
  subject { @business }

  it { should respond_to :name }
  it { should respond_to :email }
  it { should respond_to :city }
  it { should respond_to :zip }
  it { should respond_to :phone_number }
  it { should respond_to :website }

  it { should be_valid }

  describe "when email is not present" do
    before { @business.email = ""}

    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @business.name = ""}

    it { should_not be_valid }
  end

  describe "when city is not present" do
    before { @business.city = ""}

    it { should_not be_valid }
  end

  describe "when zip is not present" do
    before { @business.zip = ""}

    it { should_not be_valid }
  end

  describe "when phone number is not present" do
    before { @business.phone_number = ""}

    it { should_not be_valid }
  end

  describe "when website is not present" do
    before { @business.website = ""}

    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @business.name = "a" * 51 }

    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[business@foo,com foo@bar..com business_at_foo.org example.business@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @business.email = invalid_address
        expect(@business).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[business@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @business.email = valid_address
        expect(@business).to be_valid
      end
    end
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "FoOBar@ExampE.com" }

    it "should be saved as all lowercase" do
      @business.email = mixed_case_email
      @business.save
      expect(@business.reload.email).to eq(mixed_case_email.downcase)
    end
  end

  describe "when email address is already taken" do
    before do
      business_with_same_email = @business.dup
      business_with_same_email.email = @business.email.upcase
      business_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "users belonging to a business" do
    before do
      @business.save
      @user = @business.users.create(name: "Example User", email: "example@user.com", provider: "Provider", uid: "uid")
    end

    describe "when business is destroyed" do
      it "should be destroyed" do
        expect{@business.destroy}.to change{User.count}.from(1).to(0)
      end
    end
  end

end
