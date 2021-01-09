module Avo
  module ApplicationHelper
    include ::Webpacker::Helper

    def current_webpacker_instance
      Avo.webpacker
    end

    def render_logo
      render partial: 'vendor/avo/partials/logo' rescue render partial: 'avo/partials/logo'
    end

    def render_header
      render partial: 'vendor/avo/partials/header' rescue render partial: 'avo/partials/header'
    end

    def render_footer
      render partial: 'vendor/avo/partials/footer' rescue render partial: 'avo/partials/footer'
    end

    def render_scripts
      render partial: 'vendor/avo/partials/scripts' rescue ''
    end

    def render_resource_navigation
      render partial: 'avo/sidebar/resources_navigation', locals: {resources: Avo::App.get_available_resources(_current_user)}
    end

    def sidebar_link(label, link, **options)
      active = options[:active].present? ? options[:active] : :inclusive

      render partial: 'avo/sidebar/sidebar_link', locals: {
        label: label,
        link: link,
        active: active,
        options: options
      }
    end

    def render_license_warnings
      render partial: 'avo/sidebar/license_warnings', locals: {
        license: Avo::App.license.properties,
      }
    end

    def render_license_warning(title: '', message: '', icon: 'exclamation')
      render partial: 'avo/sidebar/license_warning', locals: {
        title: title,
        message: message,
        icon: icon,
      }
    end

    def panel(&block)
      render layout: 'layouts/avo/panel' do
        capture(&block)
      end
    end

    def modal(&block)
      render layout: 'layouts/avo/modal' do
        capture(&block)
      end
    end

    def a_button(label, color: nil, variant: nil, **args, &block)
      args[:class] = "#{button_classes} #{args[:class]}"
      # @todo: color variant options
      if block.present?
        url = label
      end

      # @todo: rename this to something else (helper, method)

      locals = {
        label: label,
        args: args,
      }

      if block_given?
        render layout: 'layouts/avo/a_button', locals: locals do
          capture(&block)
        end
      else
        render partial: 'layouts/avo/a_button', locals: locals
      end
    end

    def a_link(label, url = nil, color: nil, variant: nil, **args, &block)
      args[:class] = "#{button_classes} #{args[:class]}"
      # @todo: color variant options
      if block_given?
        # abort [url, label].inspect/
        url = label
      end

      # @todo: rename this to something else (helper, method)
      # element = button ? 'button_tag' : 'link_to'

      locals = {
        label: label,
        url: url,
        args: args,
      }

      if block_given?
        render layout: 'layouts/avo/a_link', locals: locals do
          capture(&block)
        end
      else
        render partial: 'layouts/avo/a_link', locals: locals
      end
    end

    def button_classes
      'inline-flex flex-grow-0 items-center text-sm font-bold leading-none fill-current whitespace-no-wrap transition duration-100 rounded-lg shadow-xl transform transition duration-100 active:translate-x-px active:translate-y-px cursor-pointer bg-blue-500 hover:bg-blue-600 p-4 text-white justify-center'
    end

    def svg(path, **args)
      classes = args[:class].present? ? args[:class] : 'h-4 mr-1'
      classes += args[:extra_class].present? ? " #{args[:extra_class]}" : ''

      inline_svg_pack_tag path, **args, class: classes
    end

    def input_classes(extra_classes = '', has_error: false)
      classes = 'appearance-none inline-flex bg-gray-200 disabled:bg-gray-400 disabled:cursor-not-allowed focus:bg-white text-gray-700 disabled:text-gray-600 rounded-md py-3 px-3 leading-tight border border-gray-300 outline-none focus:border-gray-400 outline'

      if has_error
        classes += ' border-red-600'
      end

      classes += " #{extra_classes}"

      classes
    end
  end
end
