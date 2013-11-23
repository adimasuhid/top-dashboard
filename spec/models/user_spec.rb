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

    it "does not validate password on update" do
      user = User.create!(password: "lala", password_confirmation: "lala", email: "wat@example.com")
      expect{user.update_attributes!(password: nil)}.to_not raise_error
    end

    it "does not validate password confirmation on update" do
      user = User.create!(password: "lala", password_confirmation: "lala", email: "wat@example.com")
      expect{user.update_attributes!(password_confirmation: nil)}.to_not raise_error
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
          user = User.authenticate("wat@example.com", "lala")
          user.should be_an_instance_of User
        end
      end

      context "Given a wrong email/password" do
        it "returns nil" do
          user = User.authenticate("wat@example.com", "l")
          user.should be_nil
        end
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

    describe "#admin?" do
      before :each do
        @user = FactoryGirl.build :user
      end

      it "returns true if the user's role is an admin" do
        @user.role = "admin"
        @user.save
        expect(@user.admin?).to be_true
      end

      it "returns false if the user's role is tutor" do
        @user.save
        expect(@user.admin?).to be_false
      end
    end

    describe "#promote!" do
      before :each do
        @user = FactoryGirl.build :user
      end

      context "Given the user is a tutor" do

        it "changes tutor's role to admin" do
          @user.save
          expect{@user.promote!}.to change(@user, :role).to("admin")
        end
      end

      context "Given the user is an admin" do
        it "does not change any role" do
          @user.role = "admin"
          @user.save
          expect{@user.promote!}.to_not change(@user, :role)
        end
      end

    end
  end
end
