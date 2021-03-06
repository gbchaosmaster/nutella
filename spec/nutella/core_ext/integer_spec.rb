require "spec_helper"
require "nutella/core_ext/integer"

describe Integer do
  describe "aliases" do
    test_alias Integer, :divisible_by?, :multiple_of?
    test_alias Integer, :divisible_by_any?, :multiple_of_any?
  end

  describe "#digits" do
    it "returns an array of the digits in the integer" do
      (0..9).each { |n| expect(n.digits).to eq([n]) }
      expect(10.digits).to eq([1, 0])
      expect(349.digits).to eq([3, 4, 9])
      expect(1000.digits).to eq([1, 0, 0, 0])
    end

    it "trims the '-' from negative numbers" do
      expect(-3.digits).to eq([3])
      expect(-20.digits).to eq([2, 0])
    end
  end

  describe "#ordinalize" do
    NUMBER_FORMATS.each do |cardinal, ordinal|
      it "returns the ordinal #{ordinal} for the integer #{cardinal}" do
        expect(cardinal.ordinalize).to eq(ordinal)
      end
    end
  end

  describe "#goes_into?" do
    it "returns true if the number goes evenly into the argument" do
      expect(5.goes_into?(10)).to be_truthy
      expect(3.goes_into?(21)).to be_truthy
      expect(25.goes_into?(100)).to be_truthy
    end

    it "returns false if the number does not go evenly in" do
      expect(3.goes_into?(10)).to be_falsey
      expect(9.goes_into?(40)).to be_falsey
      expect(10.goes_into?(5)).to be_falsey
    end

    context "when passing in zero" do
      it "returns false if one tries to divide by zero" do
        expect(0.goes_into?(20)).to be_falsey
        expect(0.goes_into?(30)).to be_falsey
      end

      it "allows zero to go into zero" do
        expect(0.goes_into?(0)).to be_truthy
      end
    end

    context "with multiple arguments" do
      it "returns true if all arguments succeed" do
        expect(5.goes_into?(10, 15, 50)).to be_truthy
        expect(2.goes_into?(2, 4, 10)).to be_truthy
      end

      it "returns false if only some arguments succeed" do
        expect(5.goes_into?(10, 12, 15)).to be_falsey
        expect(8.goes_into?(4, 16)).to be_falsey
      end

      it "returns false if no arguments succeed" do
        expect(3.goes_into?(8, 16, 20)).to be_falsey
        expect(6.goes_into?(5, 10, 15)).to be_falsey
      end
    end
  end

  describe "#goes_into_any?" do
    it "returns true if all arguments succeed" do
      expect(5.goes_into_any?(10, 15, 50)).to be_truthy
      expect(2.goes_into_any?(2, 4, 10)).to be_truthy
    end

    it "returns true if only some arguments succeed" do
      expect(5.goes_into_any?(10, 12, 15)).to be_truthy
      expect(8.goes_into_any?(4, 16)).to be_truthy
    end

    it "returns false if no arguments succeed" do
      expect(3.goes_into_any?(8, 16, 20)).to be_falsey
      expect(6.goes_into_any?(5, 10, 15)).to be_falsey
    end
  end

  describe "#multiple_of?" do
    it "returns true if the number is evenly divisible" do
      expect(5).to be_multiple_of(5)
      expect(15).to be_multiple_of(5)
      expect(10).to be_multiple_of(2)
      expect(6000).to be_multiple_of(6)
    end

    it "returns false if the number is not evenly divisible" do
      expect(20).not_to be_multiple_of(7)
      expect(4).not_to be_multiple_of(3)
      expect(5).not_to be_multiple_of(15)
      expect(100).not_to be_multiple_of(3)
    end

    context "when passing in zero" do
      it "returns false if one tries to divide by zero" do
        expect(20).not_to be_multiple_of(0)
        expect(30).not_to be_multiple_of(0)
      end

      it "allows zero to go into zero" do
        expect(0).to be_multiple_of(0)
      end
    end

    context "with multiple arguments" do
      it "returns true if evenly divisible by all arguments" do
        expect(15).to be_multiple_of(3, 15)
        expect(100).to be_multiple_of(2, 5, 25)
        expect(0).to be_multiple_of(0, 1, 2)
      end

      it "returns false if evenly divisible by only some arguments" do
        expect(15).not_to be_multiple_of(2, 3)
        expect(12).not_to be_multiple_of(3, 4, 6, 8)
        expect(10).not_to be_multiple_of(0, 5)
      end

      it "returns false if evenly divisible by none of the arguments" do
        expect(6).not_to be_multiple_of(4, 5)
        expect(17).not_to be_multiple_of(2, 4)
      end
    end
  end

  describe "#multiple_of_any?" do
    it "returns true if evenly divisible by all arguments" do
      expect(15).to be_multiple_of_any(3, 15)
      expect(100).to be_multiple_of_any(2, 5, 25)
      expect(0).to be_multiple_of_any(0, 1, 2)
    end

    it "returns true if evenly divisible by only some arguments" do
      expect(15).to be_multiple_of_any(2, 3)
      expect(12).to be_multiple_of_any(3, 4, 6, 8)
      expect(10).to be_multiple_of_any(0, 5)
    end

    it "returns false if evenly divisible by none of the arguments" do
      expect(6).not_to be_multiple_of_any(4, 5)
      expect(17).not_to be_multiple_of_any(2, 4)
    end
  end
end
