module Pkbot::BackOffice
  class HtmlPage::Article < HtmlPage
    self.path = "/dept/8/press/187/year/#{Date.today.year}/issue/:issue_id/article/:id"

    self.paths = {
      :page       => '/api/article/:id/props/page/:page',
      :publish    => '/api/article/:id/props/published/:published',
      :category   => '/api/article/:id/rubric/:category_id',
      :save       => '/api/article/:id/content/save',
      :content    => '/api/article/:id/content/get',
      :categories => '/api/press/187/rubrics',
      :typograf   => '/api/article/typograf/3',
      :image      => '/api/upload/image/'
    }

    self.caches = {
      # :content => true
    }
  end
end