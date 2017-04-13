Snippet.add(:main) do
  def issue
    @issue ||= Pkbot::Issue.for(212)
  end

  def bo_issue
    issue.bo_issue
  end
end
