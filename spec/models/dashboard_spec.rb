describe Dashboard do
  describe '#check_val' do
    let(:dashboard) { Dashboard.new }

    it 'returns zero when argument is nil' do
      expect(dashboard.check_val(nil)).to eq(0)
    end
  end
end
