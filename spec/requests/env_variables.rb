require 'spec_helper'

describe "loading ENV variables" do
  describe "ENV['SCHOOL_CODE']" do
    subject { ENV['SCHOOL_CODE'] }

    before { @value = load_yaml_from('school_code.yml', 'SCHOOL_CODE') }

    it { should be_present }
    it { should eq @value }
  end

  describe "ENV['FACEBOOK_KEY']" do
    subject { ENV['FACEBOOK_KEY'] }

    before { @value = load_yaml_from('local_env.yml', 'FACEBOOK_KEY')}

    it { should be_present }
    it { should eq @value }
  end

  describe "ENV['FACEBOOK_SECRET']" do
    subject { ENV['FACEBOOK_SECRET'] }

    before { @value = load_yaml_from('local_env.yml', 'FACEBOOK_SECRET')}
    
    it { should be_present }
    it { should eq @value }
  end
end