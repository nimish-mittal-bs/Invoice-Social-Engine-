INSERT IGNORE INTO `engine4_core_modules` (`name`, `title`, `description`, `version`, `enabled`, `type`) VALUES  ('invoice', 'Invoice', 'Invoice', '5.0.0', 1, 'extra') ;


CREATE TABLE `setwe`.`engine4_invoice_invoices` ( 
	`date` DATE NOT NULL ,  
	`invoice_id` VARCHAR(40) NOT NULL ,  
	`creater` VARCHAR(25) NOT NULL ,  
	`receiver` VARCHAR(40) NOT NULL ,  
	`address` VARCHAR(64) NOT NULL ,  
	`contact_no.` INT(13) NOT NULL ,  
	`email` VARCHAR(40) NOT NULL ,  
	`currency` VARCHAR(20) NOT NULL ,  
	`sub_total` INT NOT NULL ,  
	`discount` VARCHAR(20) NOT NULL ,  
	`total` INT NOT NULL ,  
	`status` VARCHAR(30) NOT NULL ,    
	PRIMARY KEY  (`invoice_id`)
	);


CREATE TABLE `setwe`.`engine4_invoice_currency` ( 
	`invoice_id` VARCHAR(40) NOT NULL ,  
	`currency` VARCHAR(30) NOT NULL ,  
	`subtotal` INT(20) NOT NULL ,  
	`discount` VARCHAR(20) NOT NULL ,  
	`CGST` VARCHAR(20) NOT NULL ,  
	`SGST` VARCHAR(20) NOT NULL ,  
	`IGST` VARCHAR(20) NOT NULL ,  
	`total` INT NOT NULL 
	);

CREATE TABLE `setwe`.`engine4_invoice_create` (
 `invoice_id` VARCHAR(20) NOT NULL ,  
 `sr_no` INT NOT NULL AUTO_INCREMENT ,  
 `description` VARCHAR(100) NOT NULL ,  
 `quantity` INT NOT NULL ,  
 `price` INT NOT NULL ,  
 `amount` INT NOT NULL ,    
 PRIMARY KEY  (`sr_no`)
 );

CREATE TABLE `engine4_invoice_categories` ( 
	`category_id` int(11) NOT NULL auto_increment,
	`invoice_id` int(50) unsigned NOT NULL, 
	`creator_name` varchar(128) NOT NULL, PRIMARY KEY (`category_id`), 
	KEY `invoice_id` (`invoice_id`), 
	KEY `category_id` (`category_id`, `creator_name`), 
	KEY `creator_name` (`creator_name`) 
	)

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
