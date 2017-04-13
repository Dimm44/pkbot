Snippet.add(:main) do
  TEST_ISSUE = 226
  REAL_ISSUE = 55

  def fake_issue
    @fake_issue ||= Pkbot::Issue.for(TEST_ISSUE, issue_path: 'fake')
  end

  def test_issue
    @fake_issue ||= Pkbot::Issue.for(TEST_ISSUE)
  end

  def issue(num = REAL_ISSUE)
    @issues ||= {}
    @issues[num] ||= Pkbot::Issue.for(num)
  end

  def tbo_issue
    test_issue.bo_issue
  end

  def issues
    Pkbot::BackOffice::HtmlPage::Issues.new.issues
  end

  def d(num = REAL_ISSUE)
    issue(num).download
    issue(num).process_xml
  end

  def make(num = REAL_ISSUE)
    issue(num).process
  end

  def make2(num = REAL_ISSUE)
    issue(num).bo_issue.process2
  end

  def test_process
    fake_issue.process
  end

  def fake!(number = nil)
    number ||= issue.number
    issue = Pkbot::Issue.for number

    fake_dir = Pkbot::Folder['issues/fake']

    [fake_dir, test_issue.issue_dir].each do |dir|
      `rm -rf #{dir}`
      `cp -R #{issue.issue_dir} #{dir}`
    end
  end

  def ftp
    Pkbot::Kommersant::Ftp
  end
end
