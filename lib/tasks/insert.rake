namespace :insert do
  task types: :environment do
    return unless Type.all.empty?

    types = %w(青物 赤身 白身 タレ 貝 イカたこ 海老カニ 魚卵 他魚介 鶏卵 魚以外 肉野菜)

    ActiveRecord::Base.transaction do
      types.each do |type|
        record = Type.new(name: type)
        record.save
      end
    rescue => e
      puts e
    end
  end

  task items: :environment do
    return unless Item.all.empty?

    types = Type.all.index_by(&:id)

    File.open(Rails.root.join('db', 'data', 'sushi3.idata'), 'r') do |file|
      ActiveRecord::Base.transaction do
        file.each do |raw|
          data = raw.split(/\t/)

          type = types[data[4].to_i + 1]

          item = Item.new(
            type: type,
            name: data[1],
            gyokai: !data[2].to_i,
            kotteri: data[5].to_f,
            eat_frequency: data[6].to_f,
            price: data[7].to_f,
            sale_frequency: data[8].to_f
          )

          item.save!
        end
      rescue => e
        puts e
      end
    end
  end

  task prefectures: :environment do
    return unless Prefecture.all.empty?

    prefs = [
      '北海道',
      '青森県',
      '岩手県',
      '秋田県',
      '宮城県',
      '山形県',
      '福島県',
      '新潟県',
      '茨城県',
      '栃木県',
      '群馬県',
      '埼玉県',
      '千葉県',
      '東京都',
      '神奈川県',
      '山梨県',
      '静岡県',
      '長野県',
      '愛知県',
      '岐阜県',
      '富山県',
      '石川県',
      '福井県',
      '滋賀県',
      '三重県',
      '京都府',
      '大阪府',
      '奈良県',
      '和歌山県',
      '兵庫県',
      '岡山県',
      '広島県',
      '鳥取県',
      '島根県',
      '山口県',
      '愛媛県',
      '香川県',
      '徳島県',
      '高知県',
      '福岡県',
      '長崎県',
      '佐賀県',
      '熊本県',
      '鹿児島県',
      '宮崎県',
      '大分県',
      '沖縄県',
      '海外'
    ]

    ActiveRecord::Base.transaction do
      prefs.each do |pref|
        prefecture = Prefecture.new(name: pref)
        prefecture.save!
      end
    end
  end

  task regions: :environment do
    return unless Region.all.empty?

    regions = [
      '北海道',
      '東北',
      '北陸',
      '関東',
      '長野',
      '中京',
      '近畿',
      '中国',
      '四国',
      '九州',
      '沖縄',
      '海外'
    ]

    ActiveRecord::Base.transaction do
      regions.each do |region|
        record = Region.new(name: region)
        record.save!
      end
    end
  end

  task users: :environment do
    return unless User.all.empty?

    regions = Region.all.index_by(&:id)
    prefs = Prefecture.all.index_by(&:id)

    File.open(Rails.root.join('db', 'data', 'sushi3.udata'), 'r') do |file|
      ActiveRecord::Base.transaction do
        records = []

        file.each do |raw|
          data = raw.split(/\t/)

          records << User.new(
            uid: data[0].to_i,
            gender: data[1].to_i,
            age: data[2].to_i,
            answer_time: data[3].to_i,
            origin_prefecture: prefs[data[4].to_i + 1],
            origin_region: regions[data[5].to_i + 1],
            origin_ew: data[6].to_i,
            prefecture: prefs[data[7].to_i + 1],
            region: regions[data[8].to_i + 1],
            ew: data[9].to_i,
            permanent: data[10].to_i.zero?
          )
        end
        User.bulk_import!(records)
      rescue => e
        puts e
      end
    end
  end

  task orders: :environment do
    return unless Order.all.empty?

    File.open(Rails.root.join('db', 'data', 'sushi3b.5000.10.order'), 'r') do |file|
      file.each_with_index do |raw, i|
        user_id = i + 1
        records = []
        data = raw.split(/\s/)

        data.each_with_index do |item, i2|
          next if i2 == 0 || i2 == 1

          rank = i2 - 1
          item_id = item.to_i + 1

          records << Order.new(user_id: user_id, item_id: item_id, rank: rank)
        end
        Order.bulk_import!(records)
      end
    end
  end

  task unlikes: :environment do
    return unless Unlike.all.empty?

    File.open(Rails.root.join('db', 'data', 'sushi3b.5000.10.score'), 'r') do |file|
      records = []

      file.each_with_index do |raw, i|
        user_id = i + 1
        data = raw.split(/\s/)

        data.each_with_index do |val, i2|
          next unless val.to_i.zero?

          item_id = i2 + 1

          records << Unlike.new(user_id: user_id, item_id: item_id)
        end
      end

      Unlike.bulk_import!(records)
    end
  end
end
