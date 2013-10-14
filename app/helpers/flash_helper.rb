module FlashHelper
  def render_flash_messages
    (render_notices_flash +
      render_alerts_flash +
      render_errors_flash).html_safe
  end

  private

  def render_notices_flash
    return "" unless flash[:notice]

    content_tag(:div, class: "notice") do
      flash[:notice]
    end
  end

  def render_alerts_flash
    return "" unless flash[:alert]

    content_tag(:div, class: "alert") do
      flash[:alert]
    end
  end

  def render_errors_flash
    return "" unless flash[:error]

    content_tag(:div, class: "errors") do
      flash[:error]
    end
  end
end
