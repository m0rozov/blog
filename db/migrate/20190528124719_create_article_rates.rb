class CreateArticleRates < ActiveRecord::Migration[5.2]
  def change
    create_table :article_rates do |t|
      t.belongs_to :article, index: true, null: false
      t.integer    :rate, null: false
    end
  end
end
