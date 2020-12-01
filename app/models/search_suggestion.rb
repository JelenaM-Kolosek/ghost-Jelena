class SearchSuggestion
  def self.seed
    Story.find_each do |story|
      title = story.title
      1.upto(title.length - 1) do |n|
        prefix = title[0, n]
        $redis.zadd 'search-suggestions:#{prefix.downcase}', 1, title.downcase
      end
    end
  end

  def self.terms_for(_prefix)
    $redis.zrevrange 'search-suggestions:#{prefix.downcase}', 0, 9
  end
end
