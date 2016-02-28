module ProductsHelper
  def get_price_range(product)
    # puts product
    # <script>
    #   var variant_map = <%= raw(variant_map_local(product)) %>;
    #   console.log(variant_map);
    #   var lowest = 0;
    #   var highest = 0;
    #   for(var key in variant_map) {
    #     var price = variant_map[key].raw_price;
    #     console.log(price+' - '+lowest+'/'+highest);
    #     if((!lowest) || (price < lowest)) lowest = price;
    #     if((!highest) || (price > highest)) { highest = price; }
    #   }
    # </script>
    lowest=nil;
    highest=nil;
    map = variant_map_local(product);
    map.each do |key, value|
      price = map[key][:raw_price]
      if((!lowest) or (price < lowest))
        lowest = price
      end
      if((!highest) or (price > highest))
        highest = price
      end
    end

    return "$"+lowest.to_s + ((lowest == highest)? "" : " - $"+highest.to_s);
  end
  def variant_map_local(object)
    map = {}
    object.variants.includes(:piggybak_sellable).available.each do |variant|
      map[variant.option_values.hash_ordered.map { |ov| ov.id }.join('_')] = {
        :id => variant.piggybak_sellable.id,
        :price => number_to_currency(variant.piggybak_sellable.price),
        :raw_price => variant.piggybak_sellable.price
      }
    end
    return map
  end
end
