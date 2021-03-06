class MlArchive < ActiveRecord::Base
  belongs_to :ml_account

  # FIXME bad performance
  def from_to_str
    return self.from_name if self.from_name

    u = User.find_by("email_official = ? or email_private = ?", self.from, self.from)
    if u
      self.from_name = u.full_name
      self.save!
      return self.from_name
    else
      return self.from.split('@').first
    end
  end

  def strip_subject
    return self.stripped_subject if self.stripped_subject

    regexp = self.ml_account.subject_prefix_to_regexp
    if self.subject.match(regexp)
      self.stripped_subject = self.subject.sub(regexp, '').strip
      self.save!
      return self.stripped_subject
    else
      return self.subject
    end
  end

  def body_to_html
    self.body.gsub("\n", "<br>").html_safe
  end
end
