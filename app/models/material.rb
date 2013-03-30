class Material < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user

  validates_inclusion_of :material_type, in: %w(exam quiz note personal_file)

  scope :exams,   -> { where(material_type: 'exam') }
  scope :quizzes, -> { where(material_type: 'quiz') }
  scope :notes,   -> { where(material_type: 'note') }

  def set_page
    last_page = Material.where(file_name: self.file_name).pluck(:page).max
    self.page = last_page.to_i + 1 # if last_page == nil, nil.to_i returns 0.
  end

  def set_file_params(file_params)
    if file_params[:file_name].blank?
      self.file_name = file_params[:file].original_filename.split('.').first
    else
      self.file_name = file_params[:file_name]
    end
    self.file_content_type = file_params[:file].content_type
  end

  def save_file(file)
    File.open(self.file_path, 'wb') do |f|
      f.write(file.read)
    end
  end

  def destroy_file
    File.delete(self.file_path)
  end

  def internal_file_name
    [self.id.to_s, self.file_ext].join('.')
  end

  def display_name
    name = self.file_name
    name << "-#{self.page}" if page > 1
    name << ".#{self.file_ext}"
  end

  def file_path
    Rails.root.join('public', 'uploads', self.internal_file_name)
  end

  def number_to_str
    return self.number unless self.material_type == 'exam'
    case self.number
    when 1..6
      return "第#{self.number}回"
    when 11
      return "中間"
    when 12
      return "期末"
    end
  end

  def file_ext
    case self.file_content_type
    when 'application/pdf'
      return 'pdf'
    when 'image/jpeg'
      return 'jpg'
    when 'image/png'
      return 'png'
    when 'image/gif'
      return 'gif'
    when 'image/tiff'
      return 'tif'
    when 'application/msword'
      return 'doc'
    when 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
      return 'docx'
    when 'application/vnd.ms-excel'
      return 'xls'
    when 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      return 'xlsx'
    when 'application/vnd.ms-excel.sheet.macroEnabled.12'
      return 'xlsm'
    when 'application/vnd.ms-powerpoint'
      return 'ppt'
    when 'application/vnd.openxmlformats-officedocument.presentationml.presentation'
      return 'pptx'
    when 'text/plain'
      return 'txt'
    when 'text/rtf'
      return 'rtf'
    when 'text/html'
      return 'html'
    when 'application/rtf'
      return 'rtf'
    when 'application/x-zip-compressed'
      return 'zip'
    when 'application/x-rar-compressed'
      return 'rar'
    else
      return nil
    end
  end
end
