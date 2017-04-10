module Pkbot::BackOffice
  class HtmlPage::Issues < HtmlPage
    self.path = "/api/issue/187/#{Date.today.year}/8"
    # self.cache = false
    self.cache = Pkbot::Location.development?

    def issues
      @issues ||= json['rows'].map {|row| Pkbot::BackOffice::Issue.new(row)}
    end
  end
end
