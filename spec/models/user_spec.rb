require 'spec_helper'

describe User do
  before { @user = User.new(name: "Example User", email: "user@example.com",
            password: "foobar", password_confirmation: "foobar")}

  subject { @user }

  it { should respond_to :name }
  it { should respond_to :email }
  it { should respond_to :password_digest }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }

  it { should be_valid }

  describe "without a name" do
    before { @user.name = ""}
    it { should_not be_valid }
  end

  describe "without an email" do
    before { @user.email = ""}
    it { should_not be_valid }
  end

  describe "when name is too short" do
    before { @user.name = "a" * 3 }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51}
    it { should_not be_valid }
  end

  describe "when email format is valid" do
    addresses = %w[user@foo.com user.smith@foo.co.uk.b A_user@DomaIn.com ME+cool@foo.bar.baz]
    addresses.each do |valid|
      before { @user.email = valid }
      it { should be_valid }
    end
  end

  describe "when email format is invalid" do
    addresses = %w[user@foo,com user.smith.foo.co.uk.b A_user@DomaIn@com ME+cool@foo+bar.baz]
    addresses.each do |valid|
      before { @user.email = valid }
      it { should_not be_valid }
    end
  end

  describe "when email is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user = User.new(name: "Example User", email: "user@example.com",
            password: "", password_confirmation: "") }
    it { should_not be_valid }
  end

  describe "when password doen't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
end
