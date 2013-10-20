module DeviseHelper

  def devise_error_messages!
    return '' if resource.errors.empty?

    type = :error

    messages = resource.errors.full_messages.map { |msg| content_tag(:div,content_tag(:button, raw("&times;"), class: "close", "data-dismiss" => "alert") +
        msg.html_safe, class: "alert fade in alert-#{type}") }.join("\n")

    messages.html_safe
  end

end
