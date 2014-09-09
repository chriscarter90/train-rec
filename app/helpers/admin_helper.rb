module AdminHelper
  def active_link_to name, url
    content_tag :li, class: active_tab?(url) do
      link_to name, url
    end
  end

  private

  def active_tab?(url)
    'active' if current_page?(url)
  end
end
