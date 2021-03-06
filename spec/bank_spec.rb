require_relative '../lib/bank'
require_relative '../lib/account'

describe Bank, '#initialize' do
  before do
    name = 'Bank of RubyVillage'
    assets = 1000.0

    @bank = Bank.new(name, assets)
  end

  it "has a name" do
    expect(@bank.name).to eql('Bank of RubyVillage')
  end

  it "has initial assets" do
    expect(@bank.assets).to eql(1000.0)
  end

  it "has no accounts" do
    expect(@bank.accounts.size).to eql(0)
  end

  it "does not have a liability" do
    expect(@bank.liability).to eql(0.0)
  end
end 

describe Bank, '#open_an_account' do
  it "creates an additional account" do
    bank = Bank.new('BoRV')
    account = Account.new('Peter', 'RV001A')
    bank.open_an_account(account)
    expect(bank.accounts.count).to eql(1)
  end
end

describe Bank, '#deposit' do
  before do
    @bank = Bank.new('BoRV')
    @account = Account.new('Peter', 'RV001A') 
    @bank.open_an_account(@account)
    @bank.deposit(@account, 100.0)
  end

  it "increases the bank's liability" do
    expect(@bank.liability).to eql(100.0)
  end

  it "credits the account holder" do
   expect(@account.balance).to eql(100.0)
  end
end

describe Bank, '#withdraw' do
  before do
    @bank = Bank.new('BoRV')
    @account = Account.new('Peter','RV001A')
    @bank.open_an_account(@account)
    @bank.deposit(@account, 100.0)
  end

  context "with sufficient funds" do
    it "debits the account holder" do
      @bank.withdraw(@account, 50.0)
      expect(@account.balance).to eql(50.0)
    end

    it "descreases the bank's liability" do
      @bank.withdraw(@account, 50.0)
      expect(@bank.liability).to eql(50.0)
    end
  end

  context "without sufficient funds" do
    it "doesn't decrease the bank's liability" do
      @bank.withdraw(@account, 200.0)
      expect(@bank.liability).to eql(100.0)
    end

    it "doesn't debit the account holder" do
      @bank.withdraw(@account, 200.0)
      expect(@account.balance).to eql(100.0)
    end
  end
end