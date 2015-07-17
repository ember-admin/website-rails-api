module Globalize
  mattr_accessor :available_locales

  def self.valid_locale?(loc)
    return false unless loc
    available_locales.include?(loc.to_sym)
  end
end
Globalize::ActiveRecord::ClassMethods.module_eval do
  def define_translations_reader_with_locale_suffix(name)
    define_translations_reader_without_locale_suffix(name)

    Globalize.available_locales.each do |locale|
      define_method :"#{name}_#{locale}" do
        read_attribute(name, {locale: locale})
      end
    end
  end
  alias_method_chain :define_translations_reader, :locale_suffix

  def define_translations_writer_with_locale_suffix(name)
    define_translations_writer_without_locale_suffix(name)

    Globalize.available_locales.each do |locale|
      define_method :"#{name}_#{locale}=" do |value|
        # changed_attributes[:"#{name}_#{locale}"] = value unless value == read_attribute(name, {locale: locale})
        write_attribute(name, value, {locale: locale})
      end
    end
  end
  alias_method_chain :define_translations_writer, :locale_suffix
end


I18n.available_locales = Globalize.available_locales = [:ru, :en, :de, :fr]

Globalize::ActiveRecord::ClassMethods.module_exec do
  def relation
    super
  end
end