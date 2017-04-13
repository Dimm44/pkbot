module Pkbot::BackOffice
  class HtmlPage::Issue < HtmlPage
    self.path = "/api/articles/list/:id"
    self.response_type = :json

    # self.cache = Pkbot::Location.development?
    self.cache = false

    def articles
      @articles ||= json['rows'].map {|row| Pkbot::BackOffice::Article.new(self, row)}
    end

    def article_count
      articles.count
    end
  end
end