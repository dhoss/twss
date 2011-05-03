
require File.expand_path('../../lib/twss', __FILE__)
require File.expand_path('../../lib/twss/trainer', __FILE__)

engine = TWSS::Engine.new
trainer = TWSS::Trainer.new(engine)
trainer.train
