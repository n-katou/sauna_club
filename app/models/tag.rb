class Tag < ApplicationRecord
  has_many :taggings

  #タグ検索
  def self.tags_search(keyword)
    Tag.where(["tag_name like?", "%#{keyword}%"])
  end

end
