class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: {unique: true}
      t.string :name
      t.string :image, null: false
      t.string :iss, null: false, comment: 'JWTの発行者の識別子。Google IDトークンについては、常にhttps://accounts.google.comまたはaccounts.google.comを使用する。'
      t.string :sub, null: false, comment: 'ユーザーの識別子。すべてのGoogleアカウントで一意。'

      t.timestamps
    end
    add_index :users, %i[iss sub], unique: true
  end
end
