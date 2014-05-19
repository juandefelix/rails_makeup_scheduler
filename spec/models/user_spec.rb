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
  it { should respond_to :remember_token }
  it { should respond_to :authenticate }

  it { should be_valid }

  describe "without a name" do
    before { @user.name = ""}
    it { should_not be_valid }
  end

  describe "without an email" do
    before { @user.email = ""}
    it { should_not be_valid }
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
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

  describe "when password is too short" do
    before { @user.password = @user.password_confirmation = "1" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "when password is valid" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "when password is invalid" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password). to be_false }
    end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
end
