require 'spec_helper'

describe Task do
  it "shouldn't be created/edited/deleted by anonymous user"

  it "shouldn't be edited/deleted by non-owner"

  it "should have a title with length 3..30 symbols"

  it "should be depended to project"

  it "couldn't be finished, if deadline already passed"

  it "should have some default priority, priority can't be null"
end
