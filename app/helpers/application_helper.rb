module ApplicationHelper
    def active_class(link_path)
        "is-active" if current_page?(link_path)
    end
end
