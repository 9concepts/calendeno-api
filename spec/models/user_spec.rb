require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    let(:user) { build(:user) }

    subject { user.valid? }

    context 'email' do
      it 'should not be blank' do
        user.email = nil
        subject

        expect(user.errors.full_messages).to eq ["Email can't be blank"]
      end

      it 'should be unique' do
        another_user = create(:user, email: 'abcd@calendeno.com')
        user.email = another_user.email
        subject

        expect(user.errors.full_messages).to eq ['Email has already been taken']
      end
    end

    context 'image' do
      it 'should not be blank' do
        user.image = nil
        subject

        expect(user.errors.full_messages).to eq ["Image can't be blank"]
      end
    end

    context 'iss' do
      it 'should be valid' do
        user.iss = 'https://accounts.google.com'
        subject

        expect(user.errors.full_messages).to eq []

        user.iss = 'accounts.google.com'
        subject

        expect(user.errors.full_messages).to eq []
      end

      it 'should not be blank' do
        user.iss = nil
        subject

        expect(user.errors.full_messages).to eq ["Iss can't be blank", 'Iss is not included in the list']
      end

      it 'Google の識別子ではない場合 invalid である' do
        user.iss = 'foobar'
        subject

        expect(user.errors.full_messages).to eq ['Iss is not included in the list']
      end
    end

    context 'sub' do
      it 'should not be blank' do
        user.sub = nil
        subject

        expect(user.errors.full_messages).to eq ["Sub can't be blank"]
      end

      it '既存ユーザーと同じ iss だが、sub が異なる場合 valid である' do
        another_user = create(:user, email: 'abcd@calendeno.com', iss: 'https://accounts.google.com')
        user.iss = another_user.iss
        user.sub = SecureRandom.uuid
        subject

        expect(user.errors.full_messages).to eq []
      end

      it '既存ユーザーとユーザーが異なる Google の識別子をもち、sub が異なる場合 valid である' do
        create(:user, email: 'abcd@calendeno.com', iss: 'https://accounts.google.com')
        user.iss = 'accounts.google.com'
        user.sub = SecureRandom.uuid
        subject

        expect(user.errors.full_messages).to eq []
      end

      it '既存ユーザーとユーザーが異なる Google の識別子をもち、sub が同じ場合 invalid である' do
        another_user = create(:user, email: 'abcd@calendeno.com', iss: 'https://accounts.google.com')
        user.iss = 'accounts.google.com'
        user.sub = another_user.sub
        subject

        expect(user.errors.full_messages).to eq ['Sub should be unique in the same issuers']
      end

      it 'iss と sub の組み合わせが一意でない場合、invalid である' do
        another_user = create(:user, email: 'abcd@calendeno.com', iss: 'https://accounts.google.com')
        user.iss = another_user.iss
        user.sub = another_user.sub
        subject

        expect(user.errors.full_messages).to eq ['Sub should be unique in the same issuers']
      end
    end
  end
end
