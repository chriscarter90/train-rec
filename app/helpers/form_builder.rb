class FormBuilder < ActionView::Helpers::FormBuilder

    # <%= f.label :about_me, class: 'field' do %>
    #   <%= f.text_area :about_me %>
    #  <%- end -%>
    # ----------------------------------------------------------------------
    # <label class="field" for="learner_about_me">
    #   <span class="sub-heading">About me</span>
    #   <textarea id="learner_about_me" name="learner[about_me]"></textarea>
    # </label>
  def label(method, content_or_options = nil, options = nil, &block)
    options ||= {}

    content_is_options = content_or_options.is_a?(Hash)
    if content_is_options
      options.merge! content_or_options
      @content = method.to_s.humanize
    else
      @content = content_or_options
    end

    @inside_stuff = @template.content_tag(:span, @content, class: 'sub-heading')
    if block_given?
      @inside_stuff += block.call
    end

    super(method, options) { @inside_stuff }
  end
end
