class MlAccount < ActiveRecord::Base
  has_many :ml_archives
  belongs_to :year

  def subject_prefix_to_regexp
    self.subject_prefix.sub('%d', '\d+')
  end

  def fetch
    require 'gmail'
    require 'mail'

    Gmail.new(APP_CONFIG['gmail']['user'], APP_CONFIG['gmail']['pass']) do |gmail|
      label = "ml#{self.year.class_year}"
      mails = gmail.label(label).emails(:unread, { to: self.email }).map { |email| Mail.new(email.raw_source) }

      mails.sort {|a, b| a.subject <=> b.subject}.each do |mail|
      binding.pry
      mail.subject
        if self.subject_prefix
          next if mail.subject !~ %r(#{self.subject_prefix_to_regexp})
        end

        if mail.multipart?
          part = mail.all_parts.select { |p| p.content_type =~ %r(text/plain) }.first
          if part
            body = part.decoded.to_lf
          else
            next
          end
        else
          body = mail.decoded.to_lf
        end

        self.ml_archives.create!(
          from: "#{mail.from[0]}",
          sent_at: "#{mail.date.to_s}",
          subject: "#{mail.subject.gsub('"', '\"')}",
          body: "#{body.gsub('"', '\"')}"
        )
      end
    end
  end
end
