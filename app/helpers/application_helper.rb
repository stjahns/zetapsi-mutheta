module ApplicationHelper

  # Returns the full title on a per-page basis.
  # (From ruby.railstutorial.org)
  def full_title(page_title)
    base_title = "Zeta Psi - Mu Theta"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

end
