require 'spec_helper'
require_relative '../core_extensions'

describe Array do
  context "#all_empty?" do
    it "returns true if all elements of the Array are empty" do
      expect(["", "", ""].all_empty?).to be true
    end
    
    it "returns false if some of the Array elements are not empty" do
      expect(["", 1, "", Object.new, :a].all_empty?).to be false
    end
    
    it "returns true for an empty Array" do
      expect([].all_empty?).to be true
    end
  end
  
  context "#all_same" do
    it "returns true if all elements of the Array are the same" do
      expect(["A", "A", "A"].all_same?).to be true
    end
    
    it "returns false if some of the Array elements are not the same" do
      expect(["", 1, "", Object.new, :a].all_same?).to be false
    end
    
    it "returns true for an empty Array" do
      expect([].all_same?).to be true
    end
  end
end