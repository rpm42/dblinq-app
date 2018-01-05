tables = {}

data = {}

tables.cart = """
CREATE TABLE `cart` (
  `product_id` int(11) unsigned DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  KEY `PRODUCT_ID` (`product_id`),
  CONSTRAINT `PRODUCT_ID` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
"""

tables.products = """
CREATE TABLE `products` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
"""

data.products = """
  INSERT INTO `products` (`id`, `name`, `price`)
  VALUES
    (1, 'Шоколад \"Коммунарка\", 100г', 1.75),
    (2, 'Хлеб \"Крещенский\", 1шт', 0.85),
    (3, 'Слойка с яблоком, 1шт', 0.75),
    (4, 'Мед \"Майский\", 1кг', 18.00),
    (5, 'Печенье \"Халвичное\", 1кг', 7.50),
    (6, 'Каша гречневая, 800г', 1.87);
"""
data.cart = """
    5 NULL  0.200
    2 1 NULL
    3 2 NULL
"""

console.log JSON.stringify(data, null, '  ')
