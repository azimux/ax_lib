Array.class_eval do
  def join_and
    case size
    when 0 then return ''
    when 1 then return self[0]
    else
      joiner = Object.new
      joiner.extend(ActionView::Helpers::OutputSafetyHelper)

      all_but_last = self[0..(size - 2)]

      joiner.safe_join(
        [
          joiner.safe_join(all_but_last, ', '.html_safe),
          " and ".html_safe,
          last
        ])
    end
  end
end
