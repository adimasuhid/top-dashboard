require 'spec_helper'

describe User do
  describe "validations" do
    it "validates presence of password" do
      expect{User.create!(password: nil, password_confirmation: nil, email: "lala")}.to raise_error
    end

    it "validates presence of email" do
      expect{User.create!(password: "lala", password_confirmation: "lala", email: nil)}.to raise_error
    end

    it "validates uniqueness of email" do
      User.create!(password: "lala", password_confirmation: "lala", email: "wat@example.com",)
      expect{User.create!(password: "lala", password_confirmation: "lala", email: "wat@example.com")}.to raise_error
    end

    it "validates confirmation of password" do
      expect{User.create!(password: "lala", password_confirmation: "la", email: "wat@example.com")}.to raise_error
    end

    it "validates presence of password_confirmation" do
      expect{User.create!(password: "lala", password_confirmation: nil, email: "wat@example.com")}.to raise_error
    end
  end

  describe "class methods" do
    describe "#authenticate" do
      before :each do
        @user = FactoryGirl.create :user
      end

      it "responds to authenticate" do
        User.respond_to?(:authenticate).should be_true
      end

      it "requires two parameters" do
        expect{User.authenticate}.to raise_error
      end

      context "Given a matching email password" do
        it "returns a User object" do
          pending #requires encrypt password
          user = User.authenticate("wat@example.com", "lala")
          user.should be_an_instance_of User
        end
      end

      context "Given a wrong email/password" do
        it "returns nil"
      end
    end
  end

  describe "instance methods" do
    describe "#encrypt_password" do
      before :each do
        @user = FactoryGirl.build :user
      end

      context "Given that a password is present" do
        it "creates values for password_salt" do
          @user.save
          @user.password_salt.should be_an_instance_of String
        end
        it "creates values for password_hash" do
          @user.save
          @user.password_hash.should be_an_instance_of String
        end

      end

      context "Given that no password is present" do
        it "returns nil for password_salt" do
          @user.password = nil
          @user.save
          @user.password_salt.should be_nil
        end

        it "returns nil for password_hash" do
          @user.password = nil
          @user.save
          @user.password_salt.should be_nil
        end

      end
    end
  end
end
