$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/lib')

# config.ru
run IsoView::Server
