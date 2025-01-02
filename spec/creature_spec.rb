require 'spec_helper'
require 'creature'

RSpec.describe Creature do
  it { expect(Creature.new).to be_truthy }
end
