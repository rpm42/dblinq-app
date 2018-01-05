shops = """
CREATE TABLE `shops` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
"""

products = """
CREATE TABLE `products` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
"""

productsInShops = """
CREATE TABLE `products-in-shops` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) unsigned NOT NULL,
  `product_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `shop_id` (`shop_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `shop_id` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
"""

console.log JSON.stringify {shops, products, productsInShops}, null, '  '
