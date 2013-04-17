class MlAccount < ActiveRecord::Base
  has_many :ml_archives
  belongs_to :year

  def self.fetch_all
    MlAccount.all.each do |a|
      a.fetch
    end
  end

  def fetch
    require 'gmail'
    require 'mail'

    Gmail.new(APP_CONFIG['gmail']['user'], APP_CONFIG['gmail']['pass']) do |gmail|
      label = "ml#{self.year.class_year}"
      mails = gmail.label(label).emails(:unread, { to: self.email }).map { |email| Mail.new(email.raw_source) }

      mails.sort {|a, b| a.subject <=> b.subject}.each do |mail|
        if self.subject_prefix
          next if mail.subject !~ self.subject_prefix_to_regexp
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
        puts "load new mail: #{mail.subject}"
      end
    end
  end

  def subject_prefix_to_regexp
    Regexp.compile(Regexp.escape(self.subject_prefix).sub('%d', '\d+'))
  end
end
