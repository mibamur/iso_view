$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/lib')

# config.ru
require "./lib/iso_view"

run IsoView::Server



