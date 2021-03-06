class JobTitle < ActiveRecord::Base
validates :name ,:presence => true ,:uniqueness => true
 attr_accessible :name 
  def self.tag_in_news(news)
    job_title_ids = Thunderbolt::Pattern.instance.search(news.headline)
    job_title_ids.each do |job_title_id|
      JobTitlesInNews.find_or_create_by_news_id_and_job_title_id(news.id, job_title_id)
    end
  end
end
