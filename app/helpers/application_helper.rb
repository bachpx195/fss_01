module ApplicationHelper
  def link_to_remove_fields name, f
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields name, f, association
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for association, new_object, child_index: "new_#{association}" do |builder|
      render association.to_s.singularize + "_fields", f: builder
    end
    link_to_function name,
      "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"
  end

  def link_to_function name, *args, &block
    html_options = args.extract_options!.symbolize_keys

    function = block_given? ? update_page(&block) : args[0] || ""
    onclick = "#{"#{html_options[:onclick]}; " if html_options[:onclick]}#{function}; return false;"
    href = html_options[:href] || "#"

    content_tag :a, name, html_options.merge(:href => href, :onclick => onclick)
  end

  def sort_keys
    {
      t("search.sort_by_time") => "time",
      t("search.sort_by_view") => "view",
      t("search.sort_by_like") => "like",
      t("search.sort_by_vote") => "vote"
    }
  end

  def category_keys
    if params.has_key?(:categories)
      keys = params[:categories].values.reject { |c| c.empty? }.map(&:to_i)
      return keys if keys.count > 0
    end
  end

  def search_keyword
    params[:q][:name_or_description_cont]
  end
end
