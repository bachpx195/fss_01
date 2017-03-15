module ApplicationHelper
  def link_to_remove_fields name, f
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)",
      "btn btn-danger")
  end

  def link_to_add_fields name, f, association
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for association, new_object, child_index: "new_#{association}" do |builder|
      render association.to_s.singularize + "_fields", f: builder
    end
    link_to_function name,
      "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")",
      "btn btn-default"
  end

  def link_to_function name, *args, &block
    html_options = args.extract_options!.symbolize_keys

    function = block_given? ? update_page(&block) : args[0] || ""
    onclick = "#{"#{html_options[:onclick]}; " if html_options[:onclick]}#{function}; return false;"
    href = html_options[:href] || "#"

    content_tag :a, name, html_options.merge(:href => href, :onclick => onclick,
      class: args[1])
  end

  def format_recipe_social like, comment, star
    like_str = "<span class=\"glyphicon glyphicon-eye-open\" aria-hidden=\"true\"></span> #{like} &nbsp"
    comment_str = "<span class=\"glyphicon glyphicon-heart\" aria-hidden=\"true\"></span> #{comment} &nbsp"
    star_str = "<span class=\"glyphicon glyphicon-star\" aria-hidden=\"true\"></span> #{star} "
    str = like_str + comment_str + star_str
  end

  def gravatar_for user, option = {size: 80}
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    size = option[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/
      #{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
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

  def active_steps_form params, step
    if params.nil?
      case step
      when Settings.step.default
        "active"
      else
        ""
      end
    elsif params == Settings.step.confirm_material
      case step
      when Settings.step.confirm_material
        "active"
      when Settings.step.default
        "completed"
      else
        ""
      end
    elsif params == Settings.step.confirm_step
      case step
      when Settings.step.confirm_step
        "active"
      when Settings.step.confirm_category
        ""
      else
        "completed"
      end
    elsif params == Settings.step.confirm_category
      case step
      when Settings.step.confirm_category
        "active"
      else
        "completed"
      end
    else
      "completed"
    end
  end

  def  add_new_categories_recipes f, association, id
    if f.categories_recipes.count == 0
      f.class.reflect_on_association(association).klass.new
    else
      f.categories_recipes.find_by_cate_group id
    end
  end
end
