describe Purchase do
  describe '#delivery_fee_value' do
    it '送料は5商品ごとに660円追加されること' do
      user = create(:user)
      cart = create(:cart, user:)
      item = create(:item)
      create(:cart_item, cart:, item:)
      purchase = create(:purchase, :skip_validate, user:, delivery_on: 3.business_days.after(Date.today).to_date)
      create(:purchase_item, purchase:, item_id: item.id, item_name: item.name, item_description: item.description, item_price_excluding_tax: item.price_excluding_tax)

      expect(purchase.delivery_fee_value).to eq 660

      item1 = create(:item)
      item2 = create(:item)
      item3 = create(:item)
      item4 = create(:item)
      item5 = create(:item)
      item6 = create(:item)

      items = [item1, item2, item3, item4, item5, item6]
      items.each do |item|
        create(:purchase_item, purchase:, item_id: item.id, item_name: item.name, item_description: item.description, item_price_excluding_tax: item.price_excluding_tax)
      end

      expect(purchase.delivery_fee_value).to eq 1320
    end
  end

  describe '#handling_fee_value' do
    describe '手数料が小計の金額によって変わること' do
      it '1万円未満は330円になること' do
        user = create(:user)
        cart = create(:cart, user:)
        item = create(:item, price_excluding_tax: 5000)
        create(:cart_item, cart:, item:)
        purchase = create(:purchase, :skip_validate, user:, delivery_on: 3.business_days.after(Date.today).to_date)
        create(:purchase_item, purchase:, item_id: item.id, item_name: item.name, item_description: item.description, item_price_excluding_tax: item.price_excluding_tax)

        expect(purchase.handling_fee_value).to eq 330
      end

      it '1万円以上、3万未満は440円になること' do
        user = create(:user)
        cart = create(:cart, user:)
        item = create(:item, price_excluding_tax: 15000)
        create(:cart_item, cart:, item:)
        purchase = create(:purchase, :skip_validate, user:, delivery_on: 3.business_days.after(Date.today).to_date)
        create(:purchase_item, purchase:, item_id: item.id, item_name: item.name, item_description: item.description, item_price_excluding_tax: item.price_excluding_tax)

        expect(purchase.handling_fee_value).to eq 440
      end

      it '3万円以上、10万未満は660円になること' do
        user = create(:user)
        cart = create(:cart, user:)
        item = create(:item, price_excluding_tax: 35000)
        create(:cart_item, cart:, item:)
        purchase = create(:purchase, :skip_validate, user:, delivery_on: 3.business_days.after(Date.today).to_date)
        create(:purchase_item, purchase:, item_id: item.id, item_name: item.name, item_description: item.description, item_price_excluding_tax: item.price_excluding_tax)

        expect(purchase.handling_fee_value).to eq 660
      end

      it '10万円以上は1100円になること' do
        user = create(:user)
        cart = create(:cart, user:)
        item = create(:item, price_excluding_tax: 120000)
        create(:cart_item, cart:, item:)
        purchase = create(:purchase, :skip_validate, user:, delivery_on: 3.business_days.after(Date.today).to_date)
        create(:purchase_item, purchase:, item_id: item.id, item_name: item.name, item_description: item.description, item_price_excluding_tax: item.price_excluding_tax)

        expect(purchase.handling_fee_value).to eq 1100
      end
    end
  end

  describe '#total_value' do
    it '合計金額が表示されること' do
      user = create(:user)
      cart = create(:cart, user:)
      item = create(:item, price_excluding_tax: 100)
      another_item = create(:item, price_excluding_tax: 200)
      cart_item = create(:cart_item, cart:, item:, quantity: 2)
      another_cart_item = create(:cart_item, cart:, item: another_item, quantity: 1)
      purchase = create(:purchase, :skip_validate, user:, delivery_on: 3.business_days.after(Date.today).to_date)
      create(:purchase_item, purchase:, item_id: item.id, item_name: item.name, item_description: item.description, item_price_excluding_tax: item.price_excluding_tax, quantity: cart_item.quantity)
      create(:purchase_item, purchase:, item_id: another_item.id, item_name: another_item.name, item_description: another_item.description, item_price_excluding_tax: another_item.price_excluding_tax, quantity: another_cart_item.quantity)

      expect(purchase.total_value).to eq 1422
    end
  end
end


