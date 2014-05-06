require 'spec_helper'

describe Business do
  before { @business = Business.new(name: "Bucktown Music", email: "luis@bucktownmusic.com",
                                    password: "foobar", password_confirmation: "foobar") }
  subject { @business }

  it { should respond_to :name }
  it { should respond_to :email }
  it { should respond_to :password_digest }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }

  it { should be_valid }

  describe "when email is not present" do
    before { @business.email = ""}

    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @business.name = ""}

    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @business.name = "a" * 51 }

    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @business.email = invalid_address
        expect(@business).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @business.email = valid_address
        expect(@business).to be_valid
      end
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

  describe "when password is not present" do
    before do
      @business = Business.new(name: "Example", email: "business@example.com",
                               password: "", password_confirmation: "")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @business.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
end
