INSERT IGNORE INTO `engine4_core_modules` (`name`, `title`, `description`, `version`, `enabled`, `type`) VALUES  ('invoice', 'Invoice', 'Invoice', '5.0.0', 1, 'extra') ;

DROP TABLE IF EXISTS `engine4_invoice_invoices`;
CREATE TABLE `engine4_invoice_invoices` ( 
	`date` DATE NOT NULL ,  
	`invoice_id` INT(40) NOT NULL AUTO_INCREMENT,
	`invoice_number` VARCHAR(128) NOT NULL,  
	`owner_type` varchar(20) NOT NULL,
    `owner_id` int NOT NULL,
	`receiver` VARCHAR(40) NOT NULL , 
	`category_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL, 
	`address` VARCHAR(64) NOT NULL ,  
	`contact_no` INT(13) NOT NULL ,  
	`email` VARCHAR(40) NOT NULL ,  
	`currency` VARCHAR(20) NOT NULL , 
	`IGST` varchar(20) NOT NULL,
 	`CGST` varchar(20) NOT NULL,
  	`SGST` varchar(20) NOT NULL, 
	`sub_total` INT NOT NULL ,  
	`discount` VARCHAR(20) NOT NULL ,  
	`total` INT NOT NULL , 
	`modified_date` varchar(128) NOT NULL, 
	`status` VARCHAR(30) NOT NULL ,    
	PRIMARY KEY  (`invoice_id`),
	KEY `invoice_number` (`invoice_number`) 
	)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



DROP TABLE IF EXISTS `engine4_invoice_products`;
CREATE TABLE `engine4_invoice_products` (
 `invoice_id` VARCHAR(128) NOT NULL ,  
 `sr_no` INT NOT NULL AUTO_INCREMENT ,  
 `description` VARCHAR(100) NOT NULL ,  
 `quantity` INT NOT NULL ,  
 `price` INT NOT NULL ,  
 `amount` INT NOT NULL ,    
 PRIMARY KEY  (`sr_no`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `engine4_invoice_categories`;
CREATE TABLE `engine4_invoice_categories` ( 
	`category_id` int(11) NOT NULL auto_increment,
	`user_id` int(50) NOT NULL, 
	`category_name` varchar(128) NOT NULL, 
	PRIMARY KEY (`category_id`), 
	KEY `user_id` (`user_id`)
	)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `engine4_invoice_categories` (`user_id`, `category_name`) VALUES
(1, 'SE'),
(1, 'SEP'),
(1, 'PM'),
(1, 'PMP'),
(1, 'GSTA'),
(1, 'AHP'),
(1, 'GSTM'),
(1, 'MCP'),
(1, 'OPP'),
(1, 'GSTO');



INSERT IGNORE INTO `engine4_core_menus` (`name`, `type`, `title`) VALUES
('invoice_main', 'standard', 'Invoice Main Navigation Menu')
;

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('core_main_invoice', 'invoice', 'Invoices', '', '{"route":"invoice_general","icon":"fa fa-pencil-alt"}', 'core_main', '', 4),

('invoice_main_manage', 'invoice', 'My Entries', '', '{"route":"invoice_general","action":"manage","icon":"fa fa-user"}', 'invoice_main', '', 1),
('invoice_main_create', 'invoice', 'Write New Entry', '', '{"route":"invoice_general","action":"create","icon":"fa fa-pencil-alt"}', 'invoice_main', '', 2),

('core_admin_main_plugins_invoice', 'invoice', 'Invoices', '', '{"route":"admin_default","module":"invoice","controller":"manage"}', 'core_admin_main_plugins', '', 999),

('invoice_admin_main_manage', 'invoice', 'Member Invoices', '', '{"route":"admin_default","module":"invoice","controller":"manage"}', 'invoice_admin_main', '', 1),
('invoice_admin_main_settings', 'invoice', 'Global Settings', '', '{"route":"admin_default","module":"invoice","controller":"settings"}', 'invoice_admin_main', '', 2),
('invoice_admin_main_level', 'invoice', 'Member Level Settings', '', '{"route":"admin_default","module":"invoice","controller":"level"}', 'invoice_admin_main', '', 3),
('invoice_admin_main_categories', 'invoice', 'Categories', '', '{"route":"admin_default","module":"invoice","controller":"settings", "action":"categories"}', 'invoice_admin_main', '', 4)
;





INSERT INTO engine4_authorization_levels ( title, description, type, flag) 
VALUES ('Creater', 'Invoice Creator', 'user', NULL);



INSERT INTO engine4_authorization_permissions (level_id, type, name, value, params) VALUES
(1, 'invoice', 'create', 1, NULL),
(1, 'invoice', 'delete', 2, NULL),
(1, 'invoice', 'edit', 2, NULL),
(1, 'invoice', 'flood', 5, '[\"0\",\"minute\"]'),
(1, 'invoice', 'max', 3, '50'),
(1, 'invoice', 'view', 2, NULL),
(2, 'invoice', 'create', 1, NULL),
(2, 'invoice', 'delete', 2, NULL),
(2, 'invoice', 'edit', 2, NULL),
(2, 'invoice', 'flood', 5, '[\"0\",\"minute\"]'),
(2, 'invoice', 'max', 3, '50'),
(2, 'invoice', 'view', 2, NULL),
(3, 'invoice', 'create', 0, NULL),
(3, 'invoice', 'delete', 0, NULL),
(3, 'invoice', 'edit', 0, NULL),
(3, 'invoice', 'flood', 5, '[\"0\",\"minute\"]'),
(3, 'invoice', 'max', 3, '50'),
(3, 'invoice', 'view', 0, NULL),
(4, 'invoice', 'create', 0, NULL),
(4, 'invoice', 'delete', 0, NULL),
(4, 'invoice', 'edit', 0, NULL),
(4, 'invoice', 'flood', 5, '[\"0\",\"minute\"]'),
(4, 'invoice', 'max', 3, '50'),
(4, 'invoice', 'view', 0, NULL),
(5, 'invoice', 'view', 0, NULL),
(6, 'invoice', 'create', 1, NULL),
(6, 'invoice', 'delete', 1, NULL),
(6, 'invoice', 'edit', 1, NULL),
(6, 'invoice', 'flood', 5, '[\"0\",\"minute\"]'),
(6, 'invoice', 'max', 3, '50'),
(6, 'invoice', 'view', 1, NULL);