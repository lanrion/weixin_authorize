describe WeixinAuthorize::Client do
  describe "#get jsticket" do
    it "return the same jsticket in the same thing twice" do
      js_ticket_1 = $client.get_jsticket
      sleep 5
      js_ticket_2 = $client.get_jsticket
      expect(js_ticket_1).to eq(js_ticket_2)
    end
  end
end
