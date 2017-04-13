Snippet.add(:main) do
  TEST_ISSUE = 226
  REAL_ISSUE = 55

  def fake_issue
    @fake_issue ||= Pkbot::Issue.for(TEST_ISSUE, issue_path: 'fake')
  end

  def test_issue
    @fake_issue ||= Pkbot::Issue.for(TEST_ISSUE)
  end

  def issue
    @issue ||= Pkbot::Issue.for REAL_ISSUE
  end

  def tbo_issue
    test_issue.bo_issue
  end

  def issues
    Pkbot::BackOffice::HtmlPage::Issues.new.issues
  end

  def d
    issue.download
    issue.process_xml
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
