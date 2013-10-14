class CustomBreadcrumbsBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder
  def render
    @context.render "/admin/breadcrumbs", elements: @elements
  end
end
