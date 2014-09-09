class ApplicationDecorator < Draper::Decorator

  def focus_name
    if focus
      focus.name
    else
      Focus::UNDEFINED_NAME
    end
  end

  def focus_css_class
    focus_name.cssify
  end
  
  def subject_name
    if subject
      subject.name
    else
      Subject::UNDEFINED_NAME
    end
  end

  def subject_element
    if subject
      "<span class='subject'>#{ERB::Util::html_escape(subject.name)}</span>".html_safe
    end
  end
end
