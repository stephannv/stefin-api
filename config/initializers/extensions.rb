Dir[Rails.root.join('lib', 'extensions', '*.rb')].each { |file| require file }

Money.include Extensions::Money
